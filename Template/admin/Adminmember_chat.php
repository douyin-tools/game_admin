{include file="Public/meta" /}
<title>基本设置</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 聊天室管理 <span class="c-gray en">&gt;</span> 基本设置 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<span id="is_chat" style="display: none;">{$is_chat}</span>
	<span id="is_video" style="display: none;">{$is_video}</span>
	<span id="chat_filter" style="display: none;">{$chat_filter}</span>
	<form class="form form-horizontal" id="AjaxPostForm" method="post" action="{:url('System/settingdo')}" confirm="确定吗修改系统配置吗？">
		<div id="tab-system" class="HuiTab">
			<div class="tabBar cl"><span>基本设置</span></div>
			<div class="tabCon">
				
			
                
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">聊天室开关：</label>
					<div class="formControls col-xs-8 col-sm-9">
                        <label><input id="one" type="radio" name="info[is_chat]" value="1">开 </label>&nbsp;&nbsp;
                        <label><input id="two" type="radio" name="info[is_chat]" value="0">关 </label>
					</div>
				</div>
				<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">动画开关：</label>
					<div class="formControls col-xs-8 col-sm-9">
                        <label><input id="video_one" type="radio" name="info[is_video]" value="1">开 </label>&nbsp;&nbsp;
                        <label><input id="video_two" type="radio" name="info[is_video]" value="0">关 </label>
					</div>
				</div>
      			<div class="row cl">
					<label class="form-label col-xs-4 col-sm-2">过滤关键字：（用英文的逗号,隔开）</label>
					<div class="formControls col-xs-8 col-sm-9">
						<input id="chat_filter_in" type="text" name="info[chat_filter]" placeholder="输入要过滤的关键字例如：黑平台,草,骗人" class="input-text">
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
<script>
	setTimeout(function(){
		$('.tabBar span').eq(0).click();
	}) 
	console.log($('#is_chat').html());
	if($('#is_chat').html() == "1"){
		$('#one').attr('checked','true');
	}else{

		$('#two').attr('checked','true');
	}
	if($('#is_video').html() == "1"){
		$('#video_one').attr('checked','true');
	}else{

		$('#video_two').attr('checked','true');
	}
	$('#chat_filter_in').val($('#chat_filter').html());
</script>
</body>
</html>