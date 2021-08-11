<?php

namespace Home\Controller;

use Think\Controller;

/**
 * 计划任务
 * Class ScheduledController
 * @package Kjapi\Controller
 */
class ScheduledController extends Controller
{
    /**
     * 会员游戏返水
     */
    public function gameReturnWater()
    {
        $yesterday = date("Y-m-d", strtotime("-1 day"));
        $map = [];
        $map['proxy'] = 0;
        $map['return_water_date'] = array('lt', $yesterday);
        $members = M('Member')->where($map)->select();

        $rate = M("Setting")->where(['name' => 'user_water_rate'])->getField('value');
        $waterRate = $rate / 100;

        foreach ($members as $m) {
            if ($m['return_water_date'] == $yesterday) {
                //已返水
                continue;
            }

            $map = [];
//            $map['bet_status'] = 1; //注单状态
            $where['player_name'] = $m['username'];
            $where['nick_name']   = $m['username'];
            $where['_logic']      = 'or';
            $map['_complex']      = $where;
            $map['create_at'] = ['between', [strtotime($yesterday) * 1000, (strtotime($yesterday) + 86400 -1) * 1000]];

            $betAmount = 0;
            $betAmount +=  M("zr_game_order")->where($map)->getField('sum(valid_bet_amount)');
//            $betAmount +=  M("cp_game_order")->where($map)->getField('sum(valid_bet_amount)');  //彩票不返水
            $betAmount +=  M("dj_game_order")->where($map)->getField('sum(valid_bet_amount)');
            $betAmount +=  M("ty_game_order")->where($map)->getField('sum(valid_bet_amount)');
            $betAmount +=  M("qp_game_order")->where($map)->getField('sum(valid_bet_amount)');
            $betAmount +=  M("dy_game_order")->where($map)->getField('sum(valid_bet_amount)');

            $waterAmount = round($betAmount * $waterRate, 2);

            //修改用户最新返水日期
            M('Member')->where(['id' => $m['id']])->setField(['return_water_date' => $yesterday]);

            if ($waterAmount <= 0) {
                continue;
            }

            M('Member')->where(['id' => $m['id']])->setInc('xiaoxi', 1); //未读通知消息 +1
            if ($waterAmount > 0) {
                M('Member')->where(['id' => $m['id']])->setInc('balance', $waterAmount);
            }

            //返水记录
            $log = [
                'uid' => $m['id'],
                'username' => $m['username'],
                'amount' => $waterAmount,
                'valid_bet_amount' => $betAmount,
                'water_rate' => $rate,
                'date' => date("Y-m-d",strtotime("-1 day")),
                'created_at' => time()
            ];
            M('Waterlog')->data($log)->add();

            //账变
            $fuddetailData = [];
            $fuddetailData['trano'] = '-';
            $fuddetaildata['uid'] = $m['id'];
            $fuddetaildata['username'] = $m['username'];
            $fuddetaildata['type'] = 'return_Water';
            $fuddetaildata['typename'] = '游戏返水';
            $fuddetaildata['amount'] = $waterAmount;
            $fuddetaildata['amountbefor'] = $m['balance'];
            $fuddetaildata['amountafter'] = round($m['balance'] + $waterAmount, 2);
            $fuddetaildata['oddtime'] = time();
            $fuddetaildata['remark'] = "游戏返水:{$waterAmount},有效投注金额:{$betAmount},返水比例{$waterRate}%";
            M('Fuddetail')->data($fuddetaildata)->add();

            //通知
            $yesterday = date("Y-m-d",strtotime("-1 day"));
            $message = [
                'sentid'    => 0,
                'sentname' => '系统',
                'senttitle' => '返水到账',
                'sentcontext' => "尊敬的用户您好，{$yesterday} 有效投注金额为：<span style='color:#008e49'>{$betAmount}</span>， 返水奖励：<span style='color:#d4a85e'>{$waterAmount}</span>，奖励已经发放，请注意查收。如对返水奖励有疑问请联系客服。",
                'receid' => $m['id'],
                'recename' => $m['username'],
                'senttime' => time()
            ];
            M('Message')->data($message)->add();
        }
        echo 'game return water success';
    }

    /**
     * 代理佣金结算
     */
    public function agentCommission()
    {
        $date = date("Y-m-d", strtotime('-1 day'));
        $systemRate = M('Setting')->where(['name' => 'cooperation_rate'])->getField('value');
        $agents = M('Member')->where(['proxy' => 1])->field('id,username')->select();
        $yesterday = $this->getStartTimeAndEndTime();

        foreach ($agents as $agent) {
            if (M('Commission')->where(['uid' => $agent['id'], 'date' => $date])->find()) {
                continue;
            }

            if (!$agent['share_rate'] && !$systemRate) {
                continue;
            }

            $rate = $agent['share_rate'] > 0 ? $agent['share_rate'] / 100 : $systemRate / 100;
            $members = M('Member')->where(['proxy' => 0, 'parentid' => $agent['id']])->select();

            $yesterdayBalanceTotal = 0;
            $rechargeTotal = 0;
            $withdrawTotal = 0;
            $balanceTotal = 0;

            foreach ($members as $member) {
                //充值
                $map = [];
                $map['uid'] = $member['id'];
                $map['state'] = 1;
                $map['paytype'] = ['neq', ''];
                $map['oddtime'] = ['between', [$yesterday['start_time'], $yesterday['end_time']]];
                $rechargeTotal += M('Recharge')->where($map)->getField('amount');
                $withdrawTotal += M('Withdraw')->where($map)->getField('amount');

                $yesterdayBalanceTotal += $member['yesterday_balance'];
                $balanceTotal += $member['balance'];
                $balanceTotal += round($member['ob_balance'], 2);

                //更新余额快照
                M('Member')->where(['id' => $member['id']])->setField(['yesterday_balance' => round($member['balance'] + $member['ob_balance'], 2)]);
            }

            //代理盈亏计算方式为：所有直属用户前一天结算留存余额+所有直属用户当天充值-所有直属用户当天提现-所有直属用户当天余额x合营比例
            $totalCommission = $yesterdayBalanceTotal + $rechargeTotal - $withdrawTotal - $balanceTotal;
            $totalCommission = round($totalCommission * $rate, 2);

            //代理佣金记录
            $commissionData = [
                'uid' => $agent['id'],
                'username' => $agent['username'],
                'share_rate' => $rate * 100,
                'yesterday_balance' => $yesterdayBalanceTotal,
                'balance' => $balanceTotal,
                'recharge' => $rechargeTotal,
                'withdraw' => $withdrawTotal,
                'commission' => $totalCommission,
                'status' => 0,
                'date' => $date,
                'created_at' => time()
            ];
            M('Commission')->data($commissionData)->add();
        }
        echo 'agent commission success';
    }

    /**
     * 代理佣金入账
     * 计划任务时间应设置在佣金结算之后
     */
    public function issueCommission()
    {
        //冻结时间
        $limitDays = M('Setting')->where(['name' => 'agent_withdraw_days'])->getField('value');
        $limitTime = time() - $limitDays * 86400;
        $map = [
            'status' => 0,
            'created_at' => ['lt', $limitTime]
        ];
        $commissions = M('Commission')->where($map)->select();
        foreach ($commissions as $c) {

            if ($c['commission'] != 0) {
                $userinfo = M('member')->where(['id'=>$c['uid']])->find();
                $fuddetaildata = [];
                $fuddetaildata['trano'] = '';
                $fuddetaildata['uid'] = $c['uid'];
                $fuddetaildata['username'] = $c['username'];
                $fuddetaildata['type'] = 'commission';
                $fuddetaildata['typename'] = '代理合营资金';
                $fuddetaildata['amount'] = $c['commission'];
                $fuddetaildata['amountbefor'] = $userinfo['balance'];
                $fuddetaildata['amountafter'] = $userinfo['balance']+$c['commission'];
                $fuddetaildata['remark'] = '代理合营资金入账';
                $fuddetaildata['oddtime'] = time();
                M('fuddetail')->data($fuddetaildata)->add();

                M('member')->where(['id'=>$c['uid']])->setInc('balance', $c['commission']);
            }

            M('Commission')->where(['id' => $c['id']])->setField(['status' => 1]);
        }
        echo 'agent issue commission success';
    }


    /**
     * 获取一天的起始时间和结束时间
     * @return array
     */
    protected function getStartTimeAndEndTime()
    {
        $start_time = date("Y-m-d", strtotime('-1 day')) . " 00:00:00";
        $start_time = strtotime($start_time);
        $end_time = $start_time + 60 * 60 * 24;
        return [
            'start_time' => $start_time,
            'end_time' => $end_time - 1,
        ];
    }
}