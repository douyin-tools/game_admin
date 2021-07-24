<?php

namespace Admincenter\Controller;

use Think\Controller;
use Think\Db;

class ZhenrenController extends Controller
{
    static $commonWhere = [];
    var    $username    = '';
    var    $dateTime    = '';
    
    public function __construct()
    {
        parent::__construct();
        $this->username  = I('username');
        $this->startTime = strtotime(I('start_time')) * 1000;
        $this->endTime   = strtotime(I('end_time')+"23:59:59") * 1000;
        if( ! empty($this->username)) {
            self::$commonWhere['player_name'] = $this->username;
        }
        if( ! empty($this->startTime) && ! empty($this->endTime) ) {
            self::$commonWhere['create_at'] = [
                'between' ,
                [
                    $this->startTime ,
                    $this->endTime ,
                ] ,
            ];
            $this->startTime = I('start_time');
            $this->endTime = I('end_time');
        }else{
            self::$commonWhere['create_at'] = [
                'between' ,
                [
                    strtotime(date('Y-m-d H:i:s',time())) ,
                    strtotime(date('Y-m-d 23:59:59',time())) ,
                ] ,
            ];
            $this->startTime = date('Y-m-d',time());
            $this->endTime = date('Y-m-d',time());
        }

        $this->assign('username' , $this->username);
        $this->assign('start_time' , $this->startTime);
        $this->assign('end_time' , $this->endTime);
    }
    
    function zrOrder()
    {
        $model = M('zr_game_order');
        $model->where(self::$commonWhere);
        $result = $model->select();
        foreach($result as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $result);
        $this->display();
    }
    
    function cpOrder()
    {
        $model = M('cp_game_order');
        $model->where(self::$commonWhere);
        $count      = $model->where(self::$commonWhere)->count();
        $Page       = new \Think\Page($count,10);
        $show       = $Page->show();
        $list       = $model->where(self::$commonWhere)
                            ->limit($Page->firstRow.','.$Page->listRows)
                            ->select();
    
        foreach($list as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $list);
        $this->assign('page',$show);
        $this->assign('totalcount',$count);

        $this->display();
    }
    
    function tyOrder()
    {
        $model = M('ty_game_order');
        $model->where(self::$commonWhere);
        
        $result = $model->select();
        foreach($result as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $result);
        $this->display();
    }
    
    function djOrder()
    {
        $model = M('dj_game_order');
        $model->where(self::$commonWhere);
        
        $result = $model->select();
        foreach($result as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $result);
        $this->display();
    }
    
    function dyOrder()
    {
        $model = M('dy_game_order');
        $model->where(self::$commonWhere);
        
        $result = $model->select();
        foreach($result as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $result);
        $this->display();
    }
    
    function qpOrder()
    {
        $model = M('ty_game_order');
        $model->where(self::$commonWhere);
        
        $result = $model->select();
        foreach($result as $k => $v) {
            $result[$k]['create_at'] = date('Y-m-d H:i:s' , $v['create_at'] / 1000);
        }
        $this->assign('list' , $result);
        $this->display();
    }
}