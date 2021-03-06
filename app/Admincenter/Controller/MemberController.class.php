<?php
namespace Admincenter\Controller;
use Think\Controller;
class MemberController extends CommonController {
	public function __construct(){
		parent::__construct();
		$this->_db = D('Member');
		$this->_pk = $this->_db->getPk();
	}

	function memlog(){
		$username = I('username');
		$loginip = I('loginip');

		$map        = [];
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		if($loginip){
			$map['ip']    = ['eq',$loginip];
			$this->assign('loginip',$loginip);
		}
		if($_REQUEST['sDate']){
			$map['time'][]    = ['egt',strtotime($_REQUEST['sDate'])];
			$this->assign('_sDate',urldecode($_REQUEST['sDate']));
		}
		if($_REQUEST['eDate']){
			$map['time'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
			$this->assign('_eDate',urldecode($_REQUEST['eDate']));
		}
		$this->_db  = M('memberlog');
		$_pagasize  = 10;
		$count      = $this->_db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $this->_db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order('id desc')->select();
		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);
		$this->display();
	}
	function memlogdelete(){
		$this->_db = M('memberlog');
		parent::_deletealldo();
	}

	function manage(){
		$groupid = I('groupid');
		$proxy = I('proxy',999);
		$isnb = I('isnb',999);
		$username = I('username');
		$nickname = I('nickname');
		$userbankname = I('userbankname');
		$loginip = I('loginip');
		$qq = I('qq');
		$parentid = I('parentid');
		$isonline = I('isonline');
		$tonline = 30;

		$map        = [];
		$_t = time();
		if($isonline){
			$map['onlinetime']    = ['EGT',$_t-$tonline];
			$this->assign('isonline',$isonline);
		}
		if($userbankname){
			$map['userbankname']    = ['eq',$userbankname];
			$this->assign('userbankname',$userbankname);
		}
		if($proxy!=999){
			$map['proxy']    = ['eq',$proxy];
		}
		$this->assign('proxy',$proxy);
		if($isnb!=999){
			$map['isnb']    = ['eq',$isnb];
		}
		$this->assign('isnb',$isnb);
		if($qq){
			$map['qq']    = ['eq',$qq];
			$this->assign('qq',$qq);
		}
		if($parentid){
			$map['parentid']    = ['eq',$parentid];
			$this->assign('parentid',$parentid);
		}
		if($groupid){
			$map['groupid']    = ['eq',$groupid];
			$this->assign('groupid',$groupid);
		}
		if($username){
			$map['username']    = ['like',"%".$username."%"];
			$this->assign('username',urldecode($username));
		}
		if($nickname){
			$map['nickname']    = ['eq',$nickname];
			$this->assign('nickname',$nickname);
		}
		if($loginip){
			$map['loginip']    = ['eq',$loginip];
			$this->assign('loginip',$loginip);
		}
		if($_REQUEST['sDate']){
			$map['regtime'][]    = ['egt',strtotime($_REQUEST['sDate'])];
			$this->assign('_sDate',urldecode($_REQUEST['sDate']));
		}
		if($_REQUEST['eDate']){
			$map['regtime'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
			$this->assign('_eDate',urldecode($_REQUEST['eDate']));
		}
		if($_REQUEST['sAmount']){
			$map['balance'][]    = ['egt',$_REQUEST['sAmount']];
			$this->assign('_sAmount',$_REQUEST['sAmount']);
		}
		if($_REQUEST['eAmount']){
			$map['balance'][]    = ['elt',$_REQUEST['eAmount']];
			$this->assign('_eAmount',$_REQUEST['eAmount']);
		}
		//??????
		$ordertype = I('ordertype');
		switch($ordertype){
			case"1":
				$order = "regtime asc";break;
			case"2":
				$order = "fandian desc";break;
			case"3":
				$order = "fandian asc";break;
			case"4":
				$order = "balance desc";break;
			case"5":
				$order = "balance asc";break;
			case"6":
				$order = "point desc";break;
			case"7":
				$order = "point asc";break;
			case"16":
				$order = "logintime desc";break;
			case"17":
				$order = "logintime asc";break;
			case"18":
				$order = "onlinetime desc";break;
			case"19":
				$order = "onlinetime asc";break;
			default:
				$order = "id desc";
		}
		$this->ordertype = $ordertype;
		$_pagasize  = 10;
		$count      = $this->_db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $this->_db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order($order)->select();
		foreach($list as $k=>$v){
			$v['shangji'] = $this->_db->where(['id'=>$v['parentid']])->getField('username');
			if($_t-$v['onlinetime']<$tonline){
				$v['isonline'] = 1;
			}else{
				$v['isonline'] = 0;
			}

            $totalAmount = M('Recharge')->where(['uid' => $v['id'], 'state' => 1, 'dama_state' => 0])->where(['sdtype' => ['neq', -1]])->sum('amount');
            $totalXima = M('Recharge')->where(['uid' => $v['id'], 'state' => 1, 'dama_state' => 0])->where(['sdtype' => ['neq', -1]])->sum('dama_amount');
            $v['xima'] = $totalAmount * 2 - $totalXima;

            //???????????????
            $v['balance'] = $v['balance'] + $v['ob_balance'];

            $list[$k] = $v;
		}
		$_grouplist = M('membergroup')->select();
		foreach($_grouplist as $gk=>$gv){
			$grouplist[$gv['groupid']] = $gv;
		}
		$this->assign('grouplist',$grouplist);
		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);

		$this->display();
	}
	function rechargedelall(){
		parent::_rechargedelall();

	}
	function withdrawdelall(){
		parent::_withdrawdelall();

	}
	function useradd(){
		$_grouplist = M('membergroup')->select();
		foreach($_grouplist as $gk=>$gv){
			$grouplist[$gv['groupid']] = $gv;
		}
		$this->assign('grouplist',$grouplist);
		if(IS_POST){
			if($_POST['groupid']==0 && $_POST['proxy'] ==1)$_POST['groupid']=10;
			if($_POST['groupid']==0 && $_POST['proxy'] ==0)$_POST['groupid']=1;
			$username = I('username');
			$proxy = I('proxy');
			$isnb = I('isnb');
			$password = I('password');
			$tradepassword = I('tradepassword');
            $shareRate = I('share_rate');
			//$fandian = I('fandian');
			if(!in_array($isnb,[0,1])){
				$this->error('?????????????????????');
			}
			if(!$username){
				$this->error('??????????????????');
			}
			$_paten = "/\/|\~|\!|\@|\#|\\$|\%|\^|\&|\*|\(|\)|\_|\+|\{|\}|\:|\<|\>|\?|\[|\]|\,|\.|\/|\;|\'|\`|\-|\=|\\\|\|/";
			if(!$username || preg_match($_paten,$username)){
				$this->error('????????????4-12????????????????????????????????????!');
			}
			/*if($fandian>13.5){
				$this->error('???????????????????????????13%???');
			}*/
			if(strlen($password)<6 || strlen($password)>16){
				$this->error('??????6~16????????????');
			}else{
				$_POST['password'] = sys_md5($password);
			}
			if(strlen($tradepassword)<6 || strlen($tradepassword)>16){
				$this->error('????????????6~16????????????');
			}else{
				$_POST['tradepassword'] = sys_md5($tradepassword);
			}
			if(!in_array($isnb,[0,1])){
				$this->error('???????????????????????????');
			}
			if($username && $payinfo = $this->_db->where(['username'=>$username])->find()){
				$this->error('????????????????????????');
			}
            if ($shareRate < 0 || $shareRate > 99) {
                $this->error('????????????????????????0~99!');
            }
            $_POST['share_rate'] = intval($shareRate);
			$_POST['regtime'] = time();
			$_POST['face'] = "/resources/images/face/".rand(1,25).".jpg";
			$lastID = M("member")->getLastInsID();
            $_POST['agent_code'] = createAgentCode($lastID + 1);
			parent::_adddosimp();
		}
		$this->display();
	}
	function useredit(){
		$_grouplist = M('membergroup')->select();
		foreach($_grouplist as $gk=>$gv){
			$grouplist[$gv['groupid']] = $gv;
		}
		$this->assign('grouplist',$grouplist);
		$id = I('id');
		$info = $this->_db->where([$this->_pk=>$id])->find();
		if(!$info){
			$this->error('??????????????????????????????');
		}else{
			$this->assign('info',$info);
		}
		if($info['proxy'] == 0){
		    if($info['parentid']){
                $parent = $this->_db->where([$this->_pk=>$info['parentid']])->find();
            }else{
		        $parent = array();
            }
            $this->assign('parent',$parent);
        }
		if(IS_POST){
			if($_POST['groupid']==0){
				$this->error('??????????????????');
			}
			$username = I('username');
			$proxy = I('proxy');
			$isnb  = I('isnb');
			$password = I('password');
			$tradepassword = I('tradepassword');
            $userbankname  = I('userbankname');
            $shareRate  = I('share_rate');
			$parent = I('parent');
			//$fandian = I('fandian');
			if(!in_array($proxy,[0,1])){
				$this->error('?????????????????????');
			}
			if(!$username){
				$this->error('??????????????????');
			}
			/*if($fandian>13.5){
				$this->error('???????????????????????????13%???');
			}*/

			if($password && (strlen($password)<6 || strlen($password)>16)){
				$this->error('??????6~16????????????');
			}
			if($tradepassword && (strlen($tradepassword)<6 || strlen($tradepassword)>16)){
				$this->error('????????????6~16????????????');
			}
			if($password==''){
				unset($_POST['password']);
			}else{
				$_POST['password'] = sys_md5($password);
			}
			if($tradepassword==''){
				unset($_POST['tradepassword']);
			}else{
				$_POST['tradepassword'] = sys_md5($tradepassword);
			}
			if(!in_array($isnb,[0,1])){
				$this->error('???????????????????????????');
			}
			if($username && $payinfo = $this->_db->where("username='{$username}' and id!={$id}")->find()){
				$this->error('????????????????????????');
			}

			if($parent){
			    if ($proxy == 1) {
                    $this->error('???????????????????????????');
                }
                $parentInfo = $this->_db->where(['username'=>$parent])->find();
                if(!$parentInfo){
                    $this->error('?????????????????????!');
                }
                if($parentInfo['proxy'] != 1){
                    $this->error('????????????????????????!');
                }
                $_POST['parentid'] = $parentInfo['id'];
                if($info['fandian'] > $parentInfo['fandian']){
                    $_POST['fandian'] = $parentInfo['fandian'];
                }
            }
			if ($shareRate < 0 || $shareRate > 99) {
                $this->error('????????????????????????0~99!');
            }
            $_POST['share_rate'] = intval($shareRate);
			parent::_editdosimp();
		}
		$this->display('useredit');

	}
	function userdelete(){
		$admininfo = $this->admininfo;
		if($admininfo['groupid']!=1){
			//echo'?????????????????????????????????';exit;
		}
		//$this->error('?????????????????????????????????????????????');exit;
		$id     = I('id');
		if(!$id)$this->error('???????????????');
		$info = $this->_db->find($id);
		$_pk = $this->_db->getPk();
		if(!$info)$this->error('??????????????????????????????????????????');
		$int = $this->_db->where([$_pk=>$id])->delete();
		//$int?$this->success('???????????????'):$this->error('???????????????');
		if($int){
			//??????????????????
			$logdata = [];
			$logdata['userid']   = $this->admininfo['id'];
			$logdata['username'] = $this->admininfo['username'];
			$logdata['type']     = 'clear';
			$logdata['info']     = "????????????ID???".$id;
			$logdata['time']     = NOW_TIME;
			$logdata['ip']       = get_client_ip();
			$iparea = IParea(get_client_ip());
			$logdata['iparea']   = $iparea;
			M('adminlog')->data($logdata)->add();
			$this->success('???????????????');
		}else{
			$this->error('???????????????');
		}
		parent::_deletedosimp();
	}
	function deleteall(){
		$admininfo = $this->admininfo;
		if($admininfo['groupid']!=1){
			//echo'?????????????????????????????????';exit;
		}
		//$this->error('?????????????????????????????????????????????');exit;
		self::_deletealldo();
	}
	function unline(){
		$id  = I('id');
		$int = M('membersession')->where(['userid'=>$id])->delete();
		$int?$this->success():$this->error();
	}
	function lock(){
		$id  = I('id');
		$info = M('member')->where(['id'=>$id])->find();
		if(!$id || !$info){
			$this->error('?????????????????????');
		}
		if($info['islock']==1){
			$islock = 0;
		}else{
			$islock = 1;
		}
		$int = M('member')->where(['id'=>$id])->setField(['islock'=>$islock]);
		$int?$this->success():$this->error();
	}
	function rebate(){
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$fandian = I('fandian');
			if(!is_numeric($fandian)){
				$this->error('?????????????????????');
			}
			if($fandian>13.5 || $fandian<6.5){
				$this->error('????????????6.5~13.5%??????');
			}
			$_int = M('member')->where(['id'=>$id])->setField(['fandian'=>$fandian]);
			//??????????????????
			$logdata = [];
			$logdata['userid']   = $this->admininfo['id'];
			$logdata['username'] = $this->admininfo['username'];
			$logdata['type']     = 'rebate';
			$logdata['info']     = "????????????,??????{$info['fandian']}->{$fandian},?????????".$info['username'];
			$logdata['time']     = NOW_TIME;
			$logdata['ip']       = get_client_ip();
			$iparea = IParea(get_client_ip());
			$logdata['iparea']   = $iparea;
			M('adminlog')->data($logdata)->add();
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
	function balance(){
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$balance = I('balance',0,'floatval');
			$type    = I('type');
			$remark    = I('remark');
			if($type!=1 && $type!=-1 && $type!=-2){
				$this->error('??????????????????');
			}
            $obamount = curlGetOBBalance($info['id']);
			if($type==1){
				if(floatval($balance)<=0){
					$this->error('???????????????0');
				}
				$oldbalance = $this->_db->where(['id'=>$id])->getField('balance');
				$_int = $this->_db->where(['id'=>$id])->setInc('balance',abs($balance));
				$this->_db->where(['id'=>$id])->setInc('point',abs($balance));
				//$this->_db->where(['id'=>$id])->setInc('xima',abs($balance));
				$newbalance = $oldbalance+abs($balance);
				$pointchongzhi    = abs(GetVar('pointchongzhi'));
				$pointchongzhiadd = abs(GetVar('pointchongzhiadd'));
				$_addpoint = number_format(abs($balance)*($pointchongzhiadd/$pointchongzhi),2,".","");
				//???????????????
				changeusergroup($id);
				//????????????????????????
				$trano= gettrano(4);
				$rechargedata = [];
				$rechargedata['trano']      = $trano;
				$rechargedata['uid'] = $info['id'];
				$rechargedata['username'] = $info['username'];
				$rechargedata['amount'] = abs($balance);
				$rechargedata['oddtime']    = time();
				$rechargedata['isauto']    = 2;
				$rechargedata['state']    = 1;
				$rechargedata['stateadmin']    = $this->admininfo['username'];
				$rechargedata['remark']    = $remark?:'??????????????????';
				$rechargedata['sdtype']    = 1;
				$rechargedata['oldaccountmoney']    = $oldbalance;
                $rechargedata['newaccountmoney']    = $newbalance;
                $rechargedata['obamount']    = $obamount;
				$intid = M('recharge')->data($rechargedata)->add();
				$rechargedata['id'] = $intid;

//				//????????????
//				if(abs(GetVar('damaliang'))){
//					$xima = ((abs(GetVar('damaliang'))/100) * abs($balance));
//					$xima = number_format($xima,2,".","");
//					M('member')->where(['id'=>$info['id']])->setInc('xima',$xima);
//					$fuddetaildata = [];
//					$fuddetaildata['trano'] = $trano;
//					$fuddetaildata['uid'] = $info['id'];
//					$fuddetaildata['username'] = $info['username'];
//					$fuddetaildata['type'] = 'xima';
//					$fuddetaildata['typename'] = C('fuddetailtypes.xima');
//					$fuddetaildata['amount'] = $xima;
//					$fuddetaildata['amountbefor'] = $info['xima'];
//					$fuddetaildata['amountafter'] = $info['xima']+$xima;
//					$fuddetaildata['remark'] = '??????????????????????????????';
//					$fuddetaildata['oddtime'] = time();
//					M('fuddetail')->data($fuddetaildata)->add();
//				}
				//??????????????????
				$fuddetaildata = [];
				$fuddetaildata['trano'] = $trano;
				$fuddetaildata['uid'] = $info['id'];
				$fuddetaildata['username'] = $info['username'];
				$fuddetaildata['type'] = 'adminadd';
				$fuddetaildata['typename'] = C('fuddetailtypes.adminadd');
				$fuddetaildata['amount'] = abs($balance);
				$fuddetaildata['amountbefor'] = $oldbalance;
				$fuddetaildata['amountafter'] = $oldbalance + abs($balance);
				$fuddetaildata['remark'] = '??????????????????';
				$fuddetaildata['oddtime'] = time();
                $fuddetaildata['obamount'] = $obamount;
				M('fuddetail')->data($fuddetaildata)->add();

				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'rechargstate';
				$logdata['info']     = "??????????????????????????????".$info['trano'].",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
				$this->success('????????????');exit;

			}elseif($type==-1){
				if(floatval($balance)<=0){
					$this->error('???????????????0');
				}

				$oldbalance = $this->_db->where(['id'=>$info['id']])->getField('balance');
				$_int = $this->_db->where(['id'=>$info['id']])->setDec('balance',abs($balance));
				//$this->_db->where(['id'=>$info['id']])->setDec('xima',abs($balance));
				$newbalance = $oldbalance-abs($balance);

				$pointchongzhi    = abs(GetVar('pointchongzhi'));
				$pointchongzhiadd = abs(GetVar('pointchongzhiadd'));
				$_addpoint = number_format(abs($balance)*$pointchongzhiadd/$pointchongzhi,4,".","");
				//$this->_db->where(['id'=>$info['id']])->setDec('point',$_addpoint);\
				//???????????????
				if($_int){
					$user = $this->_db->field('point')->where(['id'=>$id])->find();
					if($user['point'] <= abs($balance)){
						$point = 0;
					}else{
						$point = ($user['point']-$balance);
					}
					$this->_db->where(['id'=>$id])->setField('point',$point);
					changeusergroup($id);
				}


				//????????????????????????
				$trano= gettrano(4);
				$rechargedata = [];
				$rechargedata['trano']      = $trano;
				$rechargedata['uid'] = $info['id'];
				$rechargedata['username'] = $info['username'];
				$rechargedata['amount'] = abs($balance);
				$rechargedata['oddtime']    = time();
				$rechargedata['isauto']    = 2;
				$rechargedata['state']    = 1;
				$rechargedata['stateadmin']    = $this->admininfo['username'];
				$rechargedata['remark']    = $remark?:'??????????????????';
				$rechargedata['sdtype']    = -1;
				$rechargedata['oldaccountmoney']    = $oldbalance;
				$rechargedata['newaccountmoney']    = $newbalance;
                $rechargedata['obamount']    = $obamount;
				$intid = M('recharge')->data($rechargedata)->add();


				//??????????????????
				$fuddetaildata = [];
				$fuddetaildata['trano'] = $trano;
				$fuddetaildata['uid'] = $info['id'];
				$fuddetaildata['username'] = $info['username'];
				$fuddetaildata['type'] = 'adminjian';
				$fuddetaildata['typename'] = C('fuddetailtypes.adminjian');
				$fuddetaildata['amount'] = abs($balance);
				$fuddetaildata['amountbefor'] = $oldbalance;
				$fuddetaildata['amountafter'] = $oldbalance - abs($balance);
				$fuddetaildata['remark'] = '??????????????????';
				$fuddetaildata['oddtime'] = time();
                $fuddetaildata['obamount'] = $obamount;
				M('fuddetail')->data($fuddetaildata)->add();
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'rechargstate';
				$logdata['info']     = "????????????????????????????????????".$info['trano'].",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();


			}elseif($type==-2){
				$balance = floatval($balance);
				if($balance==0){
					$this->error('?????????????????????0');
				}
				$fuddetailtypes = C('fuddetailtypes');
				$zengsongtype = I('zengsongtype');
				if(!$fuddetailtypes[$zengsongtype]){
					$this->error('??????????????????');
				}
				if($balance>0){
					$oldbalance = $this->_db->where(['id'=>$id])->getField('balance');
					$_int = 0;
					$_int = $this->_db->where(['id'=>$id])->setInc('balance',abs($balance));
					//$this->_db->where(['id'=>$id])->setInc('xima',abs($balance));
					$newbalance = $oldbalance+abs($balance);

					$trano= gettrano(4);

					//??????????????????
					$fuddetaildata = [];
					$fuddetaildata['trano'] = gettrano(4);
					$fuddetaildata['uid'] = $info['id'];
					$fuddetaildata['username'] = $info['username'];
					$fuddetaildata['type'] = $zengsongtype;
					$fuddetaildata['typename'] = $fuddetailtypes[$zengsongtype];
					$fuddetaildata['amount'] = abs($balance);
					$fuddetaildata['amountbefor'] = $oldbalance;
					$fuddetaildata['amountafter'] = $oldbalance + abs($balance);
					$fuddetaildata['remark'] = $remark?:'????????????';
					$fuddetaildata['oddtime'] = time();
                    $fuddetaildata['obamount'] = $obamount;
					if($_int)M('fuddetail')->data($fuddetaildata)->add();

					//??????????????????
					$logdata = [];
					$logdata['userid']   = $this->admininfo['id'];
					$logdata['username'] = $this->admininfo['username'];
					$logdata['type']     = $zengsongtype;
					$logdata['info']     = "????????????????????????".$trano.",?????????".$info['username'];
					$logdata['time']     = NOW_TIME;
					$logdata['ip']       = get_client_ip();
					$iparea = IParea(get_client_ip());
					$logdata['iparea']   = $iparea;
					if($_int)M('adminlog')->data($logdata)->add();
					$this->success('????????????');exit;
				}elseif($balance<0){
					$oldbalance = $this->_db->where(['id'=>$id])->getField('balance');
					$_int = 0;
					$_int = $this->_db->where(['id'=>$id])->setDec('balance',abs($balance));
					//$this->_db->where(['id'=>$id])->setInc('xima',abs($balance));
					$newbalance = $oldbalance - abs($balance);

					$trano= gettrano(4);

					//??????????????????
					$fuddetaildata = [];
					$fuddetaildata['trano'] = gettrano(4);
					$fuddetaildata['uid'] = $info['id'];
					$fuddetaildata['username'] = $info['username'];
					$fuddetaildata['type'] = $zengsongtype;
					$fuddetaildata['typename'] = $fuddetailtypes[$zengsongtype];
					$fuddetaildata['amount'] = -abs($balance);
					$fuddetaildata['amountbefor'] = $oldbalance;
					$fuddetaildata['amountafter'] = $oldbalance - abs($balance);
					$fuddetaildata['remark'] = $remark?:'????????????';
					$fuddetaildata['oddtime'] = time();
                    $fuddetaildata['obamount'] = $obamount;
					if($_int)M('fuddetail')->data($fuddetaildata)->add();

					//??????????????????
					$logdata = [];
					$logdata['userid']   = $this->admininfo['id'];
					$logdata['username'] = $this->admininfo['username'];
					$logdata['type']     = $zengsongtype;
					$logdata['info']     = "????????????????????????".$trano.",?????????".$info['username'];
					$logdata['time']     = NOW_TIME;
					$logdata['ip']       = get_client_ip();
					$iparea = IParea(get_client_ip());
					$logdata['iparea']   = $iparea;
					if($_int)M('adminlog')->data($logdata)->add();
					$this->success('????????????');exit;
				}

			}
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
	function point(){
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$point = I('point',0,'intval');
			$type    = I('type');
			if(!preg_match("/^[1-9][0-9]*$/",$point) || $point<=0){
				$this->error('????????????');
			}
			if($type!=1 && $type!=-1){
				$this->error('??????????????????');
			}
			if($type==1){
				$_int = $this->_db->where(['id'=>$id])->setInc('point',abs($point));
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'dividend';
				$logdata['info']     = "?????????????????????".abs($point).",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
			}elseif($type==-1){
				$_int = $this->_db->where(['id'=>$id])->setDec('point',abs($point));
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'dividend';
				$logdata['info']     = "?????????????????????".-abs($point).",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
			}
 		    changeusergroup($id);
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
	function xima(){
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$xima = I('xima',0,'intval');
			$type    = I('type');
			if(!preg_match("/^[1-9][0-9]*$/",$xima) || $xima<=0){
				$this->error('??????????????????');
			}
			if($type!=1 && $type!=-1){
				$this->error('????????????????????????');
			}
			if($type==1){
				$_int = $this->_db->where(['id'=>$id])->setInc('xima',abs($xima));
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'damayue';
				$logdata['info']     = "???????????????????????????".abs($xima).",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
			}elseif($type==-1){
				$_int = $this->_db->where(['id'=>$id])->setDec('xima',abs($xima));
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'damayue';
				$logdata['info']     = "???????????????????????????".abs($xima).",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
			}
			$_int?$this->success("????????????????????????"):$this->error('????????????????????????');
			exit;
		}
		$this->display();
	}
	function ziliao(){
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);

		$this->display();
	}
	function fuddetail(){
		$type = I('type');
		$uid = I('uid');
		$trano = I('trano');
		$username = I('username');

		$db = M('fuddetail');
		$_pagasize  = 10;
		$map        = [];
		if($type){
			$map['type']    = ['eq',$type];
			$this->assign('type',$type);
		}
		if($trano){
			$map['trano']    = ['eq',$trano];
			$this->assign('trano',$trano);
		}
		if($uid){
			$map['uid']    = ['eq',$uid];
			$this->assign('uid',$uid);
		}
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		if($_REQUEST['sDate']){
			$map['oddtime'][]    = ['egt',strtotime($_REQUEST['sDate'])];
			$this->assign('_sDate',urldecode($_REQUEST['sDate']));
		}
		if($_REQUEST['eDate']){
			$map['oddtime'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
			$this->assign('_eDate',urldecode($_REQUEST['eDate']));
		}
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);
		$this->display();
	}
	function banklist(){
		$username = I('username');
		$accountname = I('accountname');
		$state    = I('state');
		$db = M('banklist');
		$_pagasize  = 10;
		$map        = [];
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		if($accountname){
			$map['accountname']    = ['eq',$accountname];
			$this->assign('accountname',$accountname);
		}
		if($state!=''){
			$map['state']    = ['eq',$state];
			$this->assign('state',$state);
		}
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);
		$this->display();
	}
	function bankedit(){
		$id = I('id');
		$info = M('banklist')->where(['id'=>$id])->find();
		if(!$id || !$info){
			$this->error('?????????????????????');
		}
		$_bankaddress = explode('-',$info['bankaddress']);
		$info['sheng'] = $_bankaddress[0];
		$info['city'] = $_bankaddress[1];
		$this->assign('info',$info);
		if(IS_POST){
			$data['bankname'] = I('bankname');
			$data['bankbranch'] = I('bankbranch');
			$data['banknumber'] = I('banknumber');
			$data['isdefault'] = I('isdefault');
			$data['state'] = I('state');
			$sheng = I('sheng');
			$city = I('city');
			if(!$data['bankname'] || !$data['bankbranch'] || !$data['banknumber'] || !$sheng || !$city){
				$this->error('???????????????????????????');
			}
			$bindcardamount = abs(trim(GetVar('bindcardamount')));
			if($data['state']==1 && $bindcardamount>0){
				$cardcount = M('banklist')->where(['uid'=>$info['uid'],'state'=>1])->count();
				if(!$cardcount){
					$balance = $bindcardamount;
					$amountbefor = M('member')->where(['id'=>$info['uid']])->getField('balance');
					M('member')->where(['id'=>$info['uid']])->setInc('balance',$balance);
					$fuddetaildata = [];
					$fuddetaildata['trano'] = gettrano(4);
					$fuddetaildata['uid'] = $info['uid'];
					$fuddetaildata['username'] = $info['username'];
					$fuddetaildata['type'] = 'activity_bindcard';
					$fuddetaildata['typename'] = C('fuddetailtypes.activity_bindcard');
					$fuddetaildata['amount'] = abs($balance);
					$fuddetaildata['amountbefor'] = $amountbefor;
					$fuddetaildata['amountafter'] = $amountbefor + abs($balance);
					$fuddetaildata['remark'] = '??????????????????';
					$fuddetaildata['oddtime'] = time();
                    $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
					M('fuddetail')->data($fuddetaildata)->add();
				}
			}
			$data['bankaddress'] = $sheng.'-'.$city;
			$_int = M('banklist')->where(['id'=>$id])->setField($data);
			$_int?$this->success("????????????????????????"):$this->error('????????????????????????');
			exit;
		}
		$this->display();
	}
	function bankdelete(){
		$id = I('id');
		$info = M('banklist')->where(['id'=>$id])->find();
		if(!$id || !$info){
			$this->error('?????????????????????');
		}
		$_int = M('banklist')->where(['id'=>$id])->delete();
		$_int?$this->success("????????????????????????"):$this->error('????????????????????????');
		exit;
	}
	function payset(){
		$this->_db = D('Payset');
		$this->_pk = $this->_db->getPk();
		parent::_manage();
		$this->display();
	}
	function paysetadd(){
		$this->_db = D('Payset');
		$this->_pk = $this->_db->getPk();
		if(IS_POST){
			$paytype = I('paytype');
			if($paytype && $payinfo = $this->_db->where(['paytype'=>$paytype])->find()){
				$this->error('???????????????????????????');
			}
			$configs_o = $_POST['configs'];
			unset($_POST['configs']);
			$_POST['configs'] = serialize($configs_o);
			parent::_adddosimp();
		}
		$this->display();
	}
	function paysetedit(){
		$this->_db = D('Payset');
		$id = I('id');
		$info = $this->_db->where([$this->_pk=>$id])->find();
		$configs = unserialize($info['configs']);
		$this->assign('configs',$configs);
		if(!$info){
			$this->error('??????????????????????????????');
		}else{
			$this->assign('info',$info);
		}
		if(IS_POST){
			$paytype = I('paytype');
			if($paytype!=$info['paytype']){
				$this->error('???????????????????????????????????????????????????');exit;
			}
			if($paytype && $payinfo = $this->_db->where("paytype='{$paytype}' and id!={$id}")->find()){
				$this->error('???????????????????????????');
			}
			$configs_o = $_POST['configs'];
			unset($_POST['configs']);
			$_POST['configs'] = serialize($configs_o);
			parent::_editdosimp();
		}
		$this->display('paysetadd');
	}

	function paysetstatus(){
		$this->_db = D('Payset');
		$this->_pk = $this->_db->getPk();
		$name   = I('name');
		if($name!='state')$this->error('???????????????');
		parent::_setstatus();
	}
	function paysetdelete(){
		$this->_db = D('Payset');
		$this->_pk = $this->_db->getPk();
		parent::_deletedosimp();
	}
	function paysetlistorder(){
		$this->_db = D('Payset');
		$this->_pk = $this->_db->getPk();
		parent::_listorder();
	}
//????????????
	function fanshui()
	{
		$db = M('fanshui');
		$_pagasize  = 10;
		$map        = [];
		if(I('username')) $map['username'] = I('username');
		if(I('shenhe')!='') $map['shenhe'] = I('shenhe');
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$fanshui      = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();
		$this->assign('fanshui',$fanshui);
		$this->assign('totalcount',$count);
		$this->assign('page',$show);
		$this->display();
	}
	function fanshuidelete()
	{
		$this->_db = D('fanshui');
		$this->_pk = $this->_db->getPk();
		parent::_deletedosimp();
	}

//????????????
	function fanshuishenhe()
	{
		$this->_db = M('fanshui');
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('????????????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$shenhe     = I('shenhe');
			$remark    = I('remark');
			if(!in_array($shenhe,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['shenhe']!=0){
				$this->error('?????????????????????');
			}
			//dump($info);exit;
			$_int = $this->_db->where(['id'=>$id])->setField(['shenhe'=>$shenhe]);

			if($_int){
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'fanshui';
				$logdata['info']     = "????????????,?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				switch($shenhe){
					case"1":
						$logdata['info']     = "????????????-??????,?????????".$info['username'];
						$amountbefor = M('Member')->where("id='{$info['uid']}'")->getField('balance');
						M('member')->where("id='{$info['uid']}'")->setInc('balance',$info['amount']);
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']      = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'fanshui';
						$fuddetaildata['typename']     = '??????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'??????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = $info['amount'];
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor + $info['amount'];
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
					case"-1":
						$logdata['info']     = "?????????????????????,?????????".$info['username'];
						$amountbefor = M('member')->where("id='{$info['uid']}'")->getField('balance');
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']    = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'fanshui';
						$fuddetaildata['typename']     = '?????????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'?????????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = "0";
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor;
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
				}
				M('adminlog')->data($logdata)->add();

			}
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}


//????????????
	function jinjijiangli()
	{
		$db = M('jinjijiangli');
		$_pagasize  = 10;
		$map        = [];
		if(I('username')) $map['username'] = I('username');
		if(I('shenhe')!='') $map['shenhe'] = I('shenhe');
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$jiangli       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();
		$this->assign('jiangli',$jiangli);
		$this->assign('totalcount',$count);
		$this->assign('page',$show);
		$this->display();
	}
	function jinjijianglidelete()
	{
		$this->_db = D('jinjijiangli');
		$this->_pk = $this->_db->getPk();
		parent::_deletedosimp();
	}
//????????????
	function jinjishenhe()
	{
		$this->_db = M('jinjijiangli');
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('????????????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$shenhe     = I('shenhe');
			$remark    = I('remark');
			if(!in_array($shenhe,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['shenhe']!=0){
				$this->error('?????????????????????');
			}
			//dump($info);exit;
			$_int = $this->_db->where(['id'=>$id])->setField(['shenhe'=>$shenhe]);

			if($_int){
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'jinjishenhe';
				$logdata['info']     = "????????????,?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				switch($shenhe){
					case"1":
						$logdata['info']     = "????????????-??????,?????????".$info['username'];
						$amountbefor = M('Member')->where("id='{$info['uid']}'")->getField('balance');
						M('member')->where("id='{$info['uid']}'")->setInc('balance',$info['jlje']);
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']      = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'jinjishenhe';
						$fuddetaildata['typename']     = '??????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'??????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = $info['jlje'];
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor + $info['jlje'];
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						$jinjijilu = M('Member')->where("id='{$info['uid']}'")->getField('jinjijilu');
						$userdata['jinjijilu'] = $jinjijilu >= $info['groupid']?$jinjijilu:$info['groupid'];
						M('Member')->where("id='{$info['uid']}'")->setField($userdata);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
					case"-1":
						$logdata['info']     = "?????????????????????,?????????".$info['username'];
						$amountbefor = M('member')->where("id='{$info['uid']}'")->getField('balance');
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']    = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'jinjishenhe';
						$fuddetaildata['typename']     = '?????????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'?????????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = "0";
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor;
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
				}
				M('adminlog')->data($logdata)->add();

			}
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
//????????????
	function dailiyongjin()
	{
		$get = I('get.');

		$db = M('dailifandian');
		$_pagasize  = 10;
		$map        = [];
		if(!empty($get['shenhe']) or $get['shenhe']=='0')$map['shenhe'] = $get['shenhe'];
		if($get['trano'])$map['trano'] = $get['trano'];
		if($get['username'])$map['username'] = $get['username'];
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$dailiinfo       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();
		$this->assign('dailiinfo',$dailiinfo);
		$this->assign('totalcount',$count);
		$this->assign('page',$show);
		$this->display();
	}
//????????????
	function yongjinshehe()
	{
		$this->_db = M('dailifandian');
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$shenhe     = I('shenhe');
			$remark    = I('remark');
			if(!in_array($shenhe,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['shenhe']!=0){
				$this->error('?????????????????????');
			}
			//dump($info);exit;
			$_int = $this->_db->where(['id'=>$id])->setField(['shenhe'=>$shenhe]);

			if($_int){
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'jinjishenhe';
				$logdata['info']     = "????????????,?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				switch($shenhe){
					case"1":
						$logdata['info']     = "????????????-??????,?????????".$info['username'];
						$amountbefor = M('Member')->where("id='{$info['uid']}'")->getField('balance');
						M('member')->where("id='{$info['uid']}'")->setInc('balance',$info['amount']);
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']      = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'yongjinshenhe';
						$fuddetaildata['typename']     = '??????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'??????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = $info['amount'];
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor + $info['amount'];
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
					case"-1":
						$logdata['info']     = "?????????????????????,?????????".$info['username'];
						$amountbefor = M('member')->where("id='{$info['uid']}'")->getField('balance');
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']    = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'yongjinshenhe';
						$fuddetaildata['typename']     = '?????????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'?????????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = "0";
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor;
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
				}
				M('adminlog')->data($logdata)->add();

			}
			$_int?$this->success("????????????????????????"):$this->error('????????????????????????');
			exit;
		}
		$this->display();
	}
//????????????
	function yongjindelete()
	{
		$this->_db = D('dailifandian');
		$this->_pk = $this->_db->getPk();
		parent::_deletedosimp();
	}
//??????????????????
	function yongjinshehes()
	{
		$this->_db = M('dailifandian');
		$ids = I('ids');
		if(!$ids){
			$this->error('????????????');
		}
		$map['id'] = array('in',$_POST['ids']);
		$map['shenhe'] = '0';
		$info = $this->_db->where($map)->select();
		if(!$info){
			$this->error('????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$shenhe     = 1;
			if(!in_array($shenhe,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['shenhe']!=0){
				$this->error('?????????????????????');
			}
			//dump($info);exit;
			foreach($info as $k=>$v){
				$_int = $this->_db->where(['id'=>$v['id']])->setField(['shenhe'=>$shenhe]);
				if($_int){
					//??????????????????
					$logdata = [];
					$logdata['userid']   = $this->admininfo['id'];
					$logdata['username'] = $this->admininfo['username'];
					$logdata['type']     = 'jinjishenhe';
					$logdata['info']     = "????????????,?????????".$v['username'];
					$logdata['time']     = NOW_TIME;
					$logdata['ip']       = get_client_ip();
					$iparea = IParea(get_client_ip());
					$logdata['iparea']   = $iparea;
					$logdata['info']     = "????????????-??????,?????????".$v['username'];
					$amountbefor = M('Member')->where("id='{$v['uid']}'")->getField('balance');
					M('member')->where("id='{$v['uid']}'")->setInc('balance',$v['amount']);
					//????????????????????????
					$fuddetaildata = [];
					$fuddetaildata['trano']      = $v['trano'];
					$fuddetaildata['uid']      = $v['uid'];
					$fuddetaildata['username'] = $v['username'];
					$fuddetaildata['type']     = 'yongjinshenhe';
					$fuddetaildata['typename']     = '??????????????????';
					$fuddetaildata['remark']       = $remark?$remark:'??????????????????';
					$fuddetaildata['oddtime']     = NOW_TIME;
					$fuddetaildata['amount']   = $v['amount'];
					$fuddetaildata['amountbefor']   = $amountbefor;
					$fuddetaildata['amountafter']   = $amountbefor + $v['amount'];
                    $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
					M('fuddetail')->data($fuddetaildata)->add();
					M('adminlog')->data($logdata)->add();

				}
			}
			$_int?$this->success("??????????????????????????????"):$this->error('??????????????????????????????');
		}
		$this->display();
	}
//????????????????????????
	function yongjindeleteall(){
		$admininfo = $this->admininfo;
		if($admininfo['groupid']!=1){
			echo'?????????????????????????????????';exit;
		}
		$this->_db = M('dailifandian');
		self::_deletealldo();
	}
	function recharge(){
		$state = I('state');
		$uid = I('uid');
		$trano = I('trano');
		$username = I('username');

		$db = M('recharge');
		$_pagasize  = 10;
		$map        = [];
		if($state!=''){
			$map['state']    = ['eq',$state];
			$this->assign('state',$state);
		}
		if($trano){
			$map['trano']    = ['eq',$trano];
			$this->assign('trano',$trano);
		}
		if($uid){
			$map['uid']    = ['eq',$uid];
			$this->assign('uid',$uid);
		}
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		if($_REQUEST['sDate']){
			$map['oddtime'][]    = ['egt',strtotime($_REQUEST['sDate'])];
			$this->assign('_sDate',urldecode($_REQUEST['sDate']));
		}
		if($_REQUEST['eDate']){
			$map['oddtime'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
			$this->assign('_eDate',urldecode($_REQUEST['eDate']));
		}
		if($_REQUEST['sAmout']){
			$map['amount'][]    = ['egt',strtotime($_REQUEST['sAmout'])];
			$this->assign('_sAmout',urldecode($_REQUEST['sAmout']));
		}
		if($_REQUEST['eAmout']){
			$map['amount'][]    = ['elt',strtotime($_REQUEST['eAmout'])];
			$this->assign('_eAmout',urldecode($_REQUEST['eAmout']));
		}
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();
        foreach ($list as &$v) {
            $v['oldaccountmoney'] += $v['obamount'];
            $v['newaccountmoney'] += $v['obamount'];
        }

		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);

		//????????????
		$rechalltotal   = $db->where(['state'=>1])->sum('amount');
		$rechalltotal_count   = $db->where(['state'=>1])->count();
		$rechtotal_aotu = $db->where(['state'=>1,'isauto'=>1])->sum('amount');
		$rechtotal_aotu_count   = $db->where(['state'=>1,'isauto'=>1])->count();
		$rechtotal_shou = $db->where(['state'=>1,'isauto'=>2])->sum('amount');
		$rechtotal_shou_count   = $db->where(['state'=>1,'isauto'=>2])->count();
		$this->assign('rechalltotal',$rechalltotal);
		$this->assign('rechtotal_aotu',$rechtotal_aotu);
		$this->assign('rechtotal_shou',$rechtotal_shou);
		$this->assign('rechalltotal_count',$rechalltotal_count);
		$this->assign('rechtotal_aotu_count',$rechtotal_aotu_count);
		$this->assign('rechtotal_shou_count',$rechtotal_shou_count);
		$this->display();
	}
	function rechargstate(){
		$this->_db = M('recharge');
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();
		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$state     = I('state');
			$remark    = I('remark');
			if(!in_array($state,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['state']!=0){
				$this->error('???????????????????????????');
			}
			if($state==1){
				$returnint = userrechargepay($info);
				if($returnint==0){
					$this->error('??????????????????');exit;
				}elseif($returnint==1){
					$this->_db->where(['id'=>$id])->setField(['remark'=>$remark?$remark:$info['remark'],'stateadmin'=>$this->admininfo['username']]);
					//??????????????????
					$logdata = [];
					$logdata['userid']   = $this->admininfo['id'];
					$logdata['username'] = $this->admininfo['username'];
					$logdata['type']     = 'rechargstate';
					$logdata['info']     = "????????????????????????????????????".$info['trano'].",?????????".$info['username'];
					$logdata['time']     = NOW_TIME;
					$logdata['ip']       = get_client_ip();
					$iparea = IParea(get_client_ip());
					$logdata['iparea']   = $iparea;
					M('adminlog')->data($logdata)->add();
					$_int = 1;
					$this->success('ok????????????ok');exit;
				}elseif($returnint==-1){
					$this->error('????????????????????????');exit;
				}else{
					$this->error('????????????');exit;
				}
			}elseif($state==-1){
				$_int = $this->_db->where(['id'=>$id])->setField(['state'=>-1,'remark'=>$remark,'stateadmin'=>$this->admininfo['username']]);
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'rechargstate';
				$logdata['info']     = "??????????????????????????????".$info['trano'].",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				M('adminlog')->data($logdata)->add();
			}
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
	function rechargedelete(){
		$this->_db = M('recharge');
		parent::_deletedosimp();
	}
	function withdrawdelete(){
		$this->_db = M('withdraw');
		parent::_deletedosimp();
	}
	function withdraw(){
		$state = I('state');
		$uid = I('uid');
		$trano = I('trano');
		$username = I('username');

		$db = M('withdraw');
		$_pagasize  = 10;
		$map        = [];
		if($state!=''){
			$map['state']    = ['eq',$state];
			$this->assign('state',$state);
		}
		if($trano){
			$map['trano']    = ['eq',$trano];
			$this->assign('trano',$trano);
		}
		if($uid){
			$map['uid']    = ['eq',$uid];
			$this->assign('uid',$uid);
		}
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		if($_REQUEST['sDate']){
			$map['oddtime'][]    = ['egt',strtotime($_REQUEST['sDate'])];
			$this->assign('_sDate',urldecode($_REQUEST['sDate']));
		}
		if($_REQUEST['eDate']){
			$map['oddtime'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
			$this->assign('_eDate',urldecode($_REQUEST['eDate']));
		}
		if($_REQUEST['sAmout']){
			$map['amount'][]    = ['egt',strtotime($_REQUEST['sAmout'])];
			$this->assign('_sAmout',urldecode($_REQUEST['sAmout']));
		}
		if($_REQUEST['eAmout']){
			$map['amount'][]    = ['elt',strtotime($_REQUEST['eAmout'])];
			$this->assign('_eAmout',urldecode($_REQUEST['eAmout']));
		}
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

        foreach ($list as &$v) {
            $v['oldaccountmoney'] += $v['obamount'];
            $v['newaccountmoney'] += $v['obamount'];
        }


        $this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);

		//????????????
		$withdrawtotal   = $db->where(['state'=>1])->sum('amount');
		$this->assign('withdrawtotal',$withdrawtotal);
		$withdrawtotal_count   = $db->where(['state'=>1])->count();
		$this->assign('withdrawtotal_count',$withdrawtotal_count);
		$this->display();
	}
	function withdrawstate(){
		$this->_db = M('withdraw');
		$id = I('id');
		if(!$id){
			$this->error('????????????');
		}
		$info = $this->_db->where(['id'=>$id])->find();

		if(!$info){
			$this->error('??????????????????');
		}
		$this->assign('info',$info);
		if(IS_POST){
			$state     = I('state');
			$remark    = I('remark');
			if(!in_array($state,[0,1,-1])){
				$this->error('????????????');
			}
			if($info['state']!=0){
				$this->error('???????????????????????????');
			}
			//dump($info);exit;
			$_int = $this->_db->where(['id'=>$id])->setField(['state'=>$state,'remark'=>$remark,'stateadmin'=>$this->admininfo['username']]);
			if($_int){
				//??????????????????
				$logdata = [];
				$logdata['userid']   = $this->admininfo['id'];
				$logdata['username'] = $this->admininfo['username'];
				$logdata['type']     = 'withdrawstate';
				$logdata['info']     = "??????????????????????????????".$info['trano'].",?????????".$info['username'];
				$logdata['time']     = NOW_TIME;
				$logdata['ip']       = get_client_ip();
				$iparea = IParea(get_client_ip());
				$logdata['iparea']   = $iparea;
				switch($state){
					case"1":
						$logdata['info']     = "??????????????????-??????????????????".$info['trano'].",?????????".$info['username'];
						//$amountbefor = M('member')->where(['uid'=>$info['uid']])->getField('balance');
						//M('member')->where(['id'=>$info['uid']])->setDec('balance',$info['amount']);
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']      = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'withdraw';
						$fuddetaildata['typename']     = '??????????????????';
						$fuddetaildata['remark']       = $remark?$remark:'??????????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = $info['amount'];
						$fuddetaildata['amountbefor']   = $info['oldaccountmoney'];
						$fuddetaildata['amountafter']   = $info['newaccountmoney'];
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
					case"-1":
						$logdata['info']     = "??????????????????-??????????????????".$info['trano'].",?????????".$info['username'];

						$amountbefor = M('member')->where(['id'=>$info['uid']])->getField('balance');
						M('member')->where(['id'=>$info['uid']])->setInc('balance',$info['amount']);
					//	M('member')->where(['id'=>$info['uid']])->setInc('point',$info['amount']);
						//????????????????????????
						$fuddetaildata = [];
						$fuddetaildata['trano']      = $info['trano'];
						$fuddetaildata['uid']      = $info['uid'];
						$fuddetaildata['username'] = $info['username'];
						$fuddetaildata['type']     = 'withdraw';
						$fuddetaildata['typename']     = '????????????';
						$fuddetaildata['remark']       = $remark?$remark:'????????????';
						$fuddetaildata['oddtime']     = NOW_TIME;
						$fuddetaildata['amount']   = $info['amount'];
						$fuddetaildata['amountbefor']   = $amountbefor;
						$fuddetaildata['amountafter']   = $amountbefor + $info['amount'];
                        $fuddetaildata['obamount'] = curlGetOBBalance($info['uid']);
						M('fuddetail')->data($fuddetaildata)->add();
						break;
				}
				M('adminlog')->data($logdata)->add();

			}
			$_int?$this->success("??????????????????"):$this->error('??????????????????');
			exit;
		}
		$this->display();
	}
	function agentlink(){
		$username = I('username');

		$db = M('agentlink');
		$_pagasize  = 10;
		$map        = [];
		if($username){
			$map['username']    = ['eq',$username];
			$this->assign('username',$username);
		}
		$count      = $db->where($map)->count();
		$Page       = new \Think\Page($count,$_pagasize);
		$show       = $Page->show();
		$list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

		$this->assign('totalcount',$count);
		$this->assign('list',$list);
		$this->assign('page',$show);

		$this->display();
	}
	function agentlinkdelete(){
		$this->_db = M('agentlink');
		$this->_pk = $this->_db->getPk();
		parent::_deletedosimp();
	}
	function sameipuser(){
        $sql = "SELECT `ip`,count(*) count_id FROM `caipiao_memberlog` GROUP BY ip HAVING count_id > 1";
        $data = M()->query($sql);
        $_pagasize  = 10;

        $count      = count($data);

        $Page       = new \Think\Page($count, $_pagasize);
        $limit = $Page->firstRow.','.$Page->listRows;
        $sql .= " limit {$limit}";
        $list = M()->query($sql);

        foreach ($list as $k => $v) {
            $members = M('Memberlog')->where(['ip' => $v['ip']])->getField('username', true);
            $members = array_unique($members);
            $members = array_values($members);
            $list[$k]['members'] = implode(', ', $members);
        }

        $show       = $Page->show();
        $list       = $list;

        $this->assign('totalcount',$count);
        $this->assign('list',$list);
        $this->assign('page',$show);

        $this->display();
	}

    /**
     * ????????????
     */
	public function waterlog()
    {
        $username = I('username');
        $db = M('waterlog');
        $_pagasize  = 10;
        $map        = [];
        if($username){
            $map['username']    = ['eq',$username];
            $this->assign('username',$username);
        }
        if($_REQUEST['sDate']){
            $map['created_at'][]    = ['egt',strtotime($_REQUEST['sDate'])];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
        }
        if($_REQUEST['eDate']){
            $map['created_at'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }
        $count      = $db->where($map)->count();
        $Page       = new \Think\Page($count,$_pagasize);
        $show       = $Page->show();
        $list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

        $this->assign('totalcount',$count);
        $this->assign('list',$list);
        $this->assign('page',$show);
        $this->display();
    }

    /*
     * ???????????????
     */
    public function message()
    {
        $username = I('username');
        $db = M('Message');
        $_pagasize  = 10;
        $map        = [];
        if($username){
            $map['recename']    = ['eq',$username];
            $this->assign('username',$username);
        }
        if($_REQUEST['sDate']){
            $map['senttime'][]    = ['egt',strtotime($_REQUEST['sDate'])];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
        }
        if($_REQUEST['eDate']){
            $map['senttime'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }
        $count      = $db->where($map)->count();
        $Page       = new \Think\Page($count,$_pagasize);
        $show       = $Page->show();
        $list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

        $this->assign('totalcount',$count);
        $this->assign('list',$list);
        $this->assign('page',$show);
        $this->display();
    }


    /**
     * ????????????
     */
    function commission(){
        $status = I('status');
        $uid = I('uid');
        $username = I('username');

        $db = M('Commission');
        $_pagasize  = 10;
        $map        = [];
        if($status!=''){
            $map['status']    = ['eq',$status];
            $this->assign('status',$status);
        }
        if($uid){
            $map['uid']    = ['eq',$uid];
            $this->assign('uid',$uid);
        }
        if($username){
            $map['username']    = ['eq',$username];
            $this->assign('username',$username);
        }
        if($_REQUEST['sDate']){
            $map['created_at'][]    = ['egt',strtotime($_REQUEST['sDate'])];
            $this->assign('_sDate',urldecode($_REQUEST['sDate']));
        }
        if($_REQUEST['eDate']){
            $map['created_at'][]    = ['elt',strtotime($_REQUEST['eDate'])+86400];
            $this->assign('_eDate',urldecode($_REQUEST['eDate']));
        }
        $count      = $db->where($map)->count();
        $Page       = new \Think\Page($count,$_pagasize);
        $show       = $Page->show();
        $list       = $db->where($map)->limit($Page->firstRow.','.$Page->listRows)->order("id desc")->select();

        $this->assign('totalcount',$count);
        $this->assign('list',$list);
        $this->assign('page',$show);

        $this->display();
    }
}