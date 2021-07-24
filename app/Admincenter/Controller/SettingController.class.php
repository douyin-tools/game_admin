<?php

namespace Admincenter\Controller;

use Admincenter\Model\SettingModel;
use Think\Controller;

class SettingController extends CommonController
{
    protected $model;

    public function __construct()
    {
        parent::__construct();
        $this->_db = D('Setting');
        $this->_pk = $this->_db->getPk();
        $this->model = new SettingModel();
    }

    public function index()
    {
        $this->initConf();
        $keys = [
            0 => 'user_water_rate',
            1 => 'cooperation_rate',
            2 => 'agent_withdraw_days',
        ];
        $where['name'] = ['in', $keys];
        $list = M('Setting')->where($where)->getField('name,value');
        $this->assign('user_water_rate', $list['user_water_rate']);
        $this->assign('cooperation_rate', $list['cooperation_rate']);
        $this->assign('agent_withdraw_days', $list['agent_withdraw_days']);

        $this->display();
    }

    public function edit()
    {
        $params = I('post.');
        foreach ($params as $p) {
            if ($p < 0 || $p > 99) {
                $this->error('不合法的值，取值范围0~99');
            }
        }
        if (!$this->checkValue($params['user_water_rate'])) {
            $this->error('用户返水配置错误，取值范围0~99');
        }
        if (!$this->checkValue($params['cooperation_rate'])) {
            $this->error('合营比例配置错误，取值范围0~99');
        }
        if (!$this->checkValue($params['agent_withdraw_days'])) {
            $this->error('佣金冻结期限配置错误，取值范围0~99');
        }

        $this->model->updateByName('user_water_rate', $params['user_water_rate']);
        $this->model->updateByName('cooperation_rate', $params['cooperation_rate']);
        $this->model->updateByName('agent_withdraw_days', $params['agent_withdraw_days']);

        $this->success('保存成功');
    }

    /**
     * 初始化配置
     */
    public function initConf()
    {
        $confs = [
            'user_water_rate' => 0.7,  //用户返水
            'cooperation_rate' => 50,  //合营计划
            'agent_withdraw_days' => 15,  //代理可提现金额固定时间
        ];

        $this->_db = M('Setting');
        foreach ($confs as $k => $v) {
            $isExist = $this->_db->where(['name' => $k])->find();
            if (!$isExist) {
                $this->_db->data(['name' => $k, 'value' => $v])->add();
            }
        }
    }

    /**
     * @param $value
     * @return bool
     */
    protected
    function checkValue($value)
    {
        if (!is_numeric($value)) {
            return false;
        }
        return $value > 0 && $value < 99;
    }

}