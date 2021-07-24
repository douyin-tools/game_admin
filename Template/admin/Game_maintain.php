{include file="Public/meta" /}
<title>游戏维护设置</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 游戏维护设置 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<form class="form form-horizontal"  method="post" action="{:url('Game/maintain')}" confirm="确定吗修改系统配置吗？" >
		<div id="tab-system" class="HuiTab">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">彩票：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[cp][start_time]" value="{$configs['cp']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.cp.end_time}" name="input[cp][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">体育：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[ty][start_time]" value="{$configs['ty']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.ty.end_time}" name="input[ty][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">电竞：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[dj][start_time]" value="{$configs['dj']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.dj.end_time}" name="input[dj][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">捕鱼：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[fish][start_time]" value="{$configs['fish']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.fish.end_time}" name="input[fish][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">老虎机：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[lhj][start_time]" value="{$configs['lhj']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.lhj.end_time}" name="input[lhj][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">棋牌：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[qp][start_time]" value="{$configs['qp']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.qp.end_time}" name="input[qp][end_time]">&nbsp;&nbsp;
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">真人：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="input[zr][start_time]" value="{$configs['zr']['start_time']}"> - <input class="input-text" type="text" style="width:200px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="{$configs.zr.end_time}" name="input[zr][end_time]">&nbsp;&nbsp;
                </div>
            </div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
{include file="Public/footer" /}
</body>
</html>