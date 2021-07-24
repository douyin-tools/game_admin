{include file="Public/meta" /}
<title>会员添加/修改</title>
</head>
<body>
<article class="page-container">
	<form action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" method="post" class="form form-horizontal validate-form" id="AjaxPostForm">
		{present name="info"}
        <input name="id" type="hidden" value="{$info[$_pk]}">
        {/present}
        
        
                
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>会员组：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<span class="select-box" style="width:auto"><select class="select" name="groupid">
<option value="0">无分组</option>
{volist name="grouplist" id="gvo"}
<option value="0" {if condition="$gvo['groupid'] eq $info['groupid']"}selected{/if}>{$gvo.groupname}({$gvo.touhan})</option>
{/volist}
</select></span>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>类型：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal">
				<div class="radio-box">
					<input name="proxy" type="radio" id="proxy-1" value="1" {if condition="$info['proxy'] eq 1"}checked{/if}>
					<label for="proxy-1">代理</label>
				</div>
				<div class="radio-box">
					<input type="radio" id="proxy-0" name="proxy" value="0" {if condition="$info['proxy'] eq 0"}checked{/if}>
					<label for="proxy-0">会员</label>
				</div>
			</div>
		</div>
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.username}" placeholder="用户名" name="username">
			</div>
		</div>
<!--		<div class="row cl">-->
<!--			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>返点：</label>-->
<!--			<div class="formControls col-xs-8 col-sm-9">-->
<!--				<input type="text" class="input-text" value="" placeholder="代理默认返点9.5%,员默认返点9.0%,最大返点{:GetVar('fanDianMax')}%" name="fandian">-->
<!--			</div>-->
<!--		</div>-->
		<script>
			$(function(){
               $('#proxy-1').click(function(){
				   alert('');
			   });
			})
		</script>
        {present name="info"}
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">银行真实姓名：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.userbankname}" placeholder="银行真实姓名" name="userbankname">
			</div>
		</div>
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" style="width:120px;" value="" placeholder="密码" name="password">不修改留空
			</div>
		</div>
        
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3">资金密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" style="width:120px;" value="" placeholder="密码" name="tradepassword">不修改留空
			</div>
		</div>
        {else /}
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.password}" placeholder="密码" name="password">
			</div>
		</div>
        
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>资金密码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.tradepassword}" placeholder="密码" name="tradepassword">
			</div>
		</div>
        {/present}
        
        <!--<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>彩票返点%：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.fandian}" placeholder="彩票返点" name="fandian">
			</div>
		</div>
        
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>六合彩返点%：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="{$info.lhcrebate}" placeholder="六合彩返点" name="lhcrebate">
			</div>
		</div>-->
                
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>内部帐号：</label>
			<div class="formControls col-xs-8 col-sm-9 skin-minimal">
				<div class="radio-box">
					<input name="isnb" type="radio" id="isnb-1" value="1" {if condition="$info['isnb'] eq 1"}checked{/if}>
					<label for="isnb-1">是</label>
				</div>
				<div class="radio-box">
					<input type="radio" id="isnb-0" name="isnb" value="0" {if condition="$info['isnb'] eq 0"}checked{/if}>
					<label for="isnb-0">否</label>
				</div>
			</div>
		</div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>合营比例：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="number" class="input-number" value="0" placeholder="为0则默认启用系统通用设置,取值范围0~99" name="share_rate">% (为0则默认启用系统通用设置,取值范围0~99)
            </div>
        </div>
        
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;确定&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

{include file="Public/footer" /}

</body>
</html>