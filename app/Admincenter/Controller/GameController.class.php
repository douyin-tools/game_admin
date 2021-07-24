<?php
namespace Admincenter\Controller;
use Think\Controller;
class GameController extends CommonController {
	public function __construct(){
		parent::__construct();
		$this->_db = D('touzhu');
		$this->_pk = $this->_db->getPk();
	}
	function manage(){
		$refert = I('refert',0,'intval');
		$this->assign('refert',$refert);
		$username = I('username');
		$id = I('id');
		$listorder = I('listorder');
		$status = I('status', 5);
        $_pagasize = I('page_num', 500);
        $this->assign('page_num', $_pagasize);

		$map        = [];
		if($status!=999 && $status!=''){
		    if ($status == 5) {
                $map['bet_status']    = ['neq', 0];
            } elseif ($status == -2) {
                $map['cancel_status']    = ['eq', 1];
            } else {
                $map['bet_status']    = ['eq', $status];
            }
			$this->assign('status',$status);
		}

		if($id){
			$map['id']    = ['eq',$id];
			$this->assign('id',$id);
		}

		if($username){
            $where['player_name'] = $username;
            $where['nick_name']   = $username;
            $where['_logic']      = 'or';
            $map['_complex']      = $where;
			$this->assign('username',$username);
		}

        if($_REQUEST['sDate'] && empty($_REQUEST['eDate'])){
            $map['create_at']    = ['egt', strtotime($_REQUEST['sDate'])  * 1000];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
        }
        if($_REQUEST['eDate'] && empty($_REQUEST['sDate'])){
            $map['create_at']    = ['elt', strtotime($_REQUEST['eDate']) * 1000];
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }
        if($_REQUEST['eDate'] && $_REQUEST['sDate']){
            $map['create_at'] = ['between', [strtotime($_REQUEST['sDate']) * 1000, strtotime($_REQUEST['eDate']) * 1000]];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }

		switch($listorder){
			case'1':
				$order = 'create_at desc';
				break;
			case'2':
				$order = 'create_at asc';
				break;
			case'3':
				$order = 'amount desc';
				break;
			case'4':
				$order = 'amount asc';
				break;
			default:
				$order = 'create_at desc';
		}

		$count      = M('cp_game_order')->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = M('cp_game_order')->where($map)->limit($Page->firstRow.','.$Page->listRows)->order($order)->select();

        foreach ($list as &$v) {
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at'] / 1000);
            $v['net_at'] = $v['net_at'] == 0 ? '-' : date('Y-m-d H:i:s', $v['net_at'] / 1000);
            if (!empty($v['player_name'])) {
                $v['username'] = $v['player_name'];
            }
            if (!empty($v['nick_name'])) {
                $v['username'] = $v['nick_name'];
            }
            $v['distribute_amount'] = 0;
            if ($v['bet_status'] == 0) {
                $v['status_text'] = '<span style="color:#FC2;">未开奖</span>';
                $v['net_amount'] = '-';
            } else {
                if ($v['net_amount'] > 0) {
                    $v['status_text'] = '<span style="color:red;">已中奖</span>';
                    $v['distribute_amount'] = round($v['net_amount'] + $v['valid_bet_amount'], 2);
                }
                if ($v['net_amount'] < 0) {
                    $v['status_text'] = '<span style="color:blue;">未中奖</span>';
                }
                $v['net_amount'] = round($v['net_amount'], 2);
            }
            $v['valid_bet_amount'] = round($v['valid_bet_amount'], 2);

            if ($v['cancel_status'] == 1) {
                $v['status_text'] = '<span style="color:#343434;">已撤单</span>';
            }
        }

		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);
		$this->display();
	}

    /**
     * 注单列表
     */
    function betorders(){
        $refert = I('refert',0,'intval');
        $this->assign('refert',$refert);
        $gameCode = I('game_code', 'qp');
        $username = I('username');
        $id = I('id');
        $betStatus = I('bet_status', -1);
        $listorder = I('listorder');
        $_pagasize = I('page_num', 500);
        $map        = [];

        $this->assign('page_num', $_pagasize);

        if(!empty($id)) {
            $map['id'] = $id;
            $this->assign('id', $id);
        }

        if($betStatus >= 0){
            if ($betStatus == 0) {
                $map['bet_status'] = 0;
            }
            if ($betStatus == 1) {
                $map['net_amount']    = ['gt', 0];
            }
            if ($betStatus == 2) {
                $map['net_amount']    = ['lt', 0];
            }
        }
        $this->assign('betStatus', $betStatus);

        $gameName = '';
        if(!empty($gameCode)){
            switch ($gameCode){
                case 'cp':
                    $db = M('cp_game_order');
                    $gameName = '棋牌';
                    break;
                case 'ty':
                    $db = M('ty_game_order');
                    $gameName = '体育';
                    break;
                case 'dy':
                    $db = M('dy_game_order');
                    $gameName = '电子';
                    break;
                case 'qp':
                    $db = M('qp_game_order');
                    $gameName = '棋牌';
                    break;
                case 'zr':
                    $db = M('zr_game_order');
                    $gameName = '真人';
                    break;
                case 'dj':
                    $db = M('dj_game_order');
                    $gameName = '电竞';
                    break;
            }
        }

        $this->assign('gameCode',$gameCode);

        if(!empty($username)){
            $map['username']    = ['eq', $username];
            $where['player_name'] = $username;
            $where['nick_name']   = $username;
            $where['_logic']      = 'or';
            $map['_complex']      = $where;
            $this->assign('username', $username);
        }

        if($_REQUEST['sDate'] && empty($_REQUEST['eDate'])){
            $map['create_at']    = ['egt', strtotime($_REQUEST['sDate'])  * 1000];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
        }
        if($_REQUEST['eDate'] && empty($_REQUEST['sDate'])){
            $map['create_at']    = ['elt', strtotime($_REQUEST['eDate']) * 1000];
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }
        if($_REQUEST['eDate'] && $_REQUEST['sDate']){
            $map['create_at'] = ['between', [strtotime($_REQUEST['sDate']) * 1000, strtotime($_REQUEST['eDate']) * 1000]];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }

        switch($listorder){
            case'1':
                $order = 'id desc';
                break;
            case'2':
                $order = 'id asc';
                break;
            case'3':
                $order = 'amount desc';
                break;
            case'4':
                $order = 'amount asc';
                break;
            default:
                $order = 'id desc';
        }

        $count      = $db->where($map)->count();
        $Page       = new \Think\Page($count,$_pagasize);
        $show       = $Page->show();
        $list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order($order)->select();
        foreach ($list as &$v) {
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at'] / 1000);
            $v['net_at'] = $v['net_at'] == 0 ? '-' : date('Y-m-d H:i:s', $v['net_at'] / 1000);
            if (!empty($v['player_name'])) {
                $v['username'] = $v['player_name'];
            }
            if (!empty($v['nick_name'])) {
                $v['username'] = $v['nick_name'];
            }
            $v['distribute_amount'] = 0;
            if ($v['bet_status'] == 0) {
                $v['status_text'] = '<span style="color:#FC2;">未开奖</span>';
                $v['net_amount'] = '-';
            } else {
                if ($v['net_amount'] > 0) {
                    $v['status_text'] = '<span style="color:red;">已中奖</span>';
                    $v['distribute_amount'] = round($v['net_amount'] + $v['valid_bet_amount'], 2);
                }
                if ($v['net_amount'] < 0) {
                    $v['status_text'] = '<span style="color:blue;">未中奖</span>';
                }
                if ($v['net_amount'] == 0) {
                    $v['status_text'] = '<span style="color:green;">和局</span>';
                }
                $v['net_amount'] = round($v['net_amount'], 2);
            }
            $v['valid_bet_amount'] = round($v['valid_bet_amount'], 2);
            $v['pumping_amount'] = round($v['pumping_amount'], 2);

            if ($gameCode == 'dj' || $gameCode == 'ty') {
                $v['game_type_name'] = $v['details'];
            }

            if ($gameCode == 'zr') {
                $info = '<div style="text-align:left;"><span style="color:#ff8b00">游戏:</span>' . $v['game_type_name'] . '&emsp;' .  $v['table_name'] . '<br/>';
                $info .= '<span style="color:#ff8b00">注单:</span>' . $v['play_option_name'] . '<br>';
                $info .= '<span style="color:#ff8b00">结果:</span>' . $v['judge_result1'] . '&emsp;' . $v['judge_result_cn'] .  '</div>';
                $v['game_type_name'] = $info;
            }

            $v['game_name'] = $gameName;
        }


        $this->assign('totalcount',$count);
        $this->assign('list',$list);
        $this->assign('page',$show);
        $this->display();
    }


    function chedan(){
		$id = I('id',0,'intval');
		$info = $this->_db->where([$this->_pk=>$id])->find();
		if(!$info){
			$this->error('您修改的数据不存在！');
		}
		if($info['isdraw']!=0){
			$this->error('状态不允许操作！');
		}
		$_int1 = $this->_db->where(['id'=>$id])->setField(['isdraw'=>'-2']);
		$userinfo = M('member')->where(['id'=>$info['uid']])->find();
		if($_int1){
			$_t = time();
			$trano = $info['trano'];
			//撤单账变
			M('member')->where(['id'=>$info['uid']])->setInc('balance',$info['amount']);
			$fuddetail_data = array();
			$fuddetail_data['trano'] = $trano;
			$fuddetail_data['uid'] = $userinfo['id'];
			$fuddetail_data['username'] = $userinfo['username'];
			$fuddetail_data['amount'] = abs($info['amount']);
			$fuddetail_data['amountbefor'] = $userinfo['balance'];
			$fuddetail_data['amountafter'] = $userinfo['balance']+abs($info['amount']);
			$fuddetail_data['oddtime'] = $_t;
			$fuddetail_data['remark'] = "撤单退回";
			$fuddetail_data['type'] = 'cancel';
			$fuddetail_data['typename'] = C('fuddetailtypes.cancel');
			M('fuddetail')->data($fuddetail_data)->add();
 			//撤单洗码
			M('member')->where(['id'=>$info['uid']])->setInc('xima',$info['amount']);
			$fuddetail_data = array();
			$fuddetail_data['trano'] = $trano;
			$fuddetail_data['uid'] = $userinfo['id'];
			$fuddetail_data['username'] = $userinfo['username'];
			$fuddetail_data['amount'] = abs($info['amount']);
			$fuddetail_data['amountbefor'] = $userinfo['xima'];
			$fuddetail_data['amountafter'] = $userinfo['xima']+abs($info['amount']);
			$fuddetail_data['oddtime'] = $_t;
			$fuddetail_data['remark'] = "撤单退回洗码账户";
			$fuddetail_data['type'] = 'xima';
			$fuddetail_data['typename'] = C('fuddetailtypes.xima');
			M('fuddetail')->data($fuddetail_data)->add(); 
			//撤单积分
			$pointtouzhu    = abs(intval(GetVar('pointtouzhu')));
			$pointtouzhuadd = abs(intval(GetVar('pointtouzhuadd')));
			if($pointtouzhu && $pointtouzhuadd){
				$_addpoint = number_format(abs($info['amount'])*$pointtouzhuadd/$pointtouzhu,4,".","");
				if($_addpoint>0){
					M('member')->where(['id'=>$info['uid']])->setDec('point',$_addpoint);
					$fuddetail_data = array();
					$fuddetail_data['trano'] = $trano;
					$fuddetail_data['uid'] = $userinfo['id'];
					$fuddetail_data['username'] = $userinfo['username'];
					$fuddetail_data['amount'] = abs($_addpoint);
					$fuddetail_data['amountbefor'] = $userinfo['point'];
					$fuddetail_data['amountafter'] = $userinfo['point']-abs($_addpoint);
					$fuddetail_data['oddtime'] = $_t;
					$fuddetail_data['remark'] = "撤单扣回赠送积分";
					$fuddetail_data['type'] = 'point';
					$fuddetail_data['typename'] = C('fuddetailtypes.point');
					M('fuddetail')->data($fuddetail_data)->add();
				}
			}
			//撤单代理佣金
			$dlyj = M("dailifandian")->where("trano='{$trano}' AND uid <> '{$info['uid']}'")->select();
			foreach($dlyj as $k=>$v){
				$user  = M('member')->where("id='{$v['uid']}'")->find();
				if($user){
					M('member')->where("id='{$v['uid']}'")->setDec('balance',$v['amount']);
					$fuddetail_data = array();
					$fuddetail_data['trano'] = $trano;
					$fuddetail_data['uid'] = $user['id'];
					$fuddetail_data['username'] = $user['username'];
					$fuddetail_data['amount'] = abs($v['amount']);
					$fuddetail_data['amountbefor'] = $user['balance'];
					$fuddetail_data['amountafter'] = $user['balance']-abs($v['amount']);
					$fuddetail_data['oddtime'] = $_t;
					$fuddetail_data['remark'] = "撤单扣回代理佣金";
					$fuddetail_data['type'] = 'yongjinshenhe';
					$fuddetail_data['typename'] = C('fuddetailtypes.yongjinshenhe');
					M('fuddetail')->data($fuddetail_data)->add();
				}
			}			
			//增加管理日志
			$logdata = [];
			$logdata['userid']   = $this->admininfo['id'];
			$logdata['username'] = $this->admininfo['username'];
			$logdata['type']     = 'chendan';
			$logdata['info']     = "投注撤单，单号：".$trano;
			$logdata['time']     = NOW_TIME;
			$logdata['ip']       = get_client_ip();
			$iparea = IParea(get_client_ip());
			$logdata['iparea']   = $iparea;
			M('adminlog')->data($logdata)->add();
			$this->success('撤单成功');
		}else{
			$this->error('撤单失败');
		}
		exit;
		//账变记录
		
	}
	function touzhuedit(){
		$id = I('id');
		$info = $this->_db->where([$this->_pk=>$id])->find();
		if(!$info){
			$this->error('您修改的数据不存在！');
		}else{
			$this->assign('info',$info);	
		}
		if(IS_POST){
			parent::_editdosimp();
		}
		$this->display('bankadd');
	}
	
	function delete(){
		$this->error('删除功能已关闭');
		exit;
		parent::_deleteone();
		/*$id     = I('id');
		if(!$id)$this->error('非法操作！');
		$info = $this->_db->find($id);
		if(!$info)$this->error('您操作的数据不存在或已删除！');
		$int = $this->_db->where([$this->_pk=>$id])->delete();
		$int?$this->success('操作成功！'):$this->error('操作失败！');*/
	}
	function deleteall(){
		parent::_deletealldo();
	}
	//异常注单检测
	function checkerrorder(){
		$cpname = I('cpname');
		$username = I('username');
		$shijiancha = I('shijiancha',130,'intval');
		
		$where = '';
		$_t = time();
		if($cpname){
			$where .= " and a.cpname='{$cpname}' ";
			$this->assign('cpname',$cpname);
		}
		if($username){
			$where .= " and a.username='{$username}' ";
			$this->assign('username',$username);
		}
		if($shijiancha){
			$where .= " and b.opentime-a.oddtime<={$shijiancha} ";
			$this->assign('shijiancha',$shijiancha);
		}
		$_pagasize  = $shownum;
		$DB_PREFIX = C('DB_PREFIX');
		
		$sql = "select a.*,b.name as bname,b.opentime,b.expect as bexpect,c.ftime,c.issys,c.name as cname from {$DB_PREFIX}touzhu as a left join {$DB_PREFIX}kaijiang as b on a.cpname = b.name and a.expect = b.expect left join {$DB_PREFIX}caipiao as c on a.cpname = c.name where b.name!='' {$where} order by a.id desc";
		$list = M()->query($sql);
		$this->assign('list',$list);
		$this->display();
	}

	//修改游戏记录
    function touzhuupdate(){
        if(!IS_POST){
            $this->error('非法操作');exit;
        }
        $trano = I("trano");
        $tzcode = I("tzcode");
        if(!$trano || !$tzcode){
            $this->error('参数错误');exit;
        }

        //获取之前的投注号码
        $touzhu = M("touzhu")->where(['trano' => $trano])->find();
        if(strlen($touzhu['tzcode']) != strlen($tzcode)){
            $this->error('修改后的记录号和修改前的记录号长度应保持一致');exit;
        }

        $int = M("touzhu")->where(['trano' => $trano])->setField('tzcode',$tzcode);
        $int?$this->success('操作成功'):$this->error('操作失败');
    }


    /**
     * 游戏维护设置
     */
    public function maintain()
    {
        $conf = M('Setting')->where(['name' => 'game_maintain'])->find();
        if (IS_POST) {
            $params = I('input');
            if ($conf) {
                $result = M('Setting')->where(['name' => 'game_maintain'])->data(['value' => json_encode($params)])->save();
            } else {
                $result = M('Setting')->data(['name' => 'game_maintain', 'value' => json_encode($params)])->add();
            }

            if ($result) {
                $this->success('保存成功');
            } else {
                $this->error('保存失败');
            }
        }
        $this->assign('configs', json_decode($conf['value'], true));
        $this->display();
    }

    public function client()
    {
        $list = M('Client')->select();
        foreach ($list as $k => $v) {
            $list[$k]['download_link'] = C('DOWNLOAD_DOMAIN') . '/client/' . $v['package'];
        }
        $this->assign('list', $list);
        $this->display();
    }

    public function clientedit()
    {
        if (!IS_POST) {
            $info = M('Client')->where(['id' => I('id')])->find();
            $this->assign('info', $info);
            $this->display();
            return;
        }

        $saveData = [];
        if (count($_FILES) > 0) {
            foreach ($_FILES as $file) {
                if ($file['error'] != 0) {
                    continue;
                }
                if($fp = fopen($file['tmp_name'],"rb", 0)) {
                    $gambar = fread($fp, filesize($file['tmp_name']));
                    fclose($fp);
                    $value = chunk_split(base64_encode($gambar));
                    $saveData['qr_code'] = 'data:image/jpg/png/gif;base64,' . $value;
                }
            }
        }

        $saveData['state'] = I('state');
        $res = M('Client')->where(['id' => I('id')])->data($saveData)->save();
        if (!$res) {
            $this->error('保存失败');
        }
        $this->success('保存成功');
    }

    public function clientupload()
    {
        $this->assign('id', I('id'));
        $this->display();
    }

    /**
     * 上传文件
     * @return array
     */
    public function upload($id){

        $res = false;
        $fileName = '';
        if (count($_FILES) > 0) {
            foreach ($_FILES as $file) {
                $fileName = $file["name"];
                $res = move_uploaded_file($file["tmp_name"], UPLOAD_PATH . $fileName);
            }
        }

        if (!$res) {
            $content = $GLOBALS['HTTP_RAW_POST_DATA'];  // 需要php.ini设置
            if(empty($content)){
                $content = file_get_contents('php://input');    // 不需要php.ini设置，内存压力小
            }

            preg_match('/filename="(.*?)"/', $content, $matches);
            $fileName = $matches[1];

            $res = file_put_contents(UPLOAD_PATH . $fileName, $content, true);
        }


        if (!$res) {
            $this->error('上传失败');
        }
        $res = M('Client')->where(['id' => $id])
            ->data(['package' => $fileName, 'updated_at' => date('Y-m-d H:i:s'), 'download_link' => UPLOAD_PATH_DIR . $fileName])
            ->save();
        if (!$res) {
            $this->error('保存失败');
        }
        $this->success();
    }

    public function updateClientInfo()
    {
        $list = M('Client')->select();
        foreach ($list as $k => $v) {
            if ($v['state'] == 1) {
                $list[$k]['state'] = '显示';
            } else{
                $list[$k]['state'] = '隐藏';
            }
            $list[$k]['download_link'] = C('DOWNLOAD_DOMAIN') . '/client/' . $v['package'];
        }
        $this->ajaxReturn($list);
    }

}