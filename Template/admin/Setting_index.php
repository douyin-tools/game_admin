{include file="Public/meta" /}
<title>基本设置</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 资金管理 <span class="c-gray en">&gt;</span> 资金管理设置 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <form class="form form-horizontal" id="AjaxPostForm" method="post" action="{:url('Setting/edit')}" confirm="确定吗修改配置吗？">
        <div id="tab-system" class="HuiTab">
            <div class="tabBar cl"><span>资金管理设置</span></div>
            <div class="tabCon">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">用户游戏返水：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="width:300px;" type="text" name="user_water_rate" placeholder="请输入0~99" value="{$user_water_rate}" class="input-text">%
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">合营比例：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="width:300px;" type="number" name="cooperation_rate" placeholder="请输入0~99" value="{$cooperation_rate}" class="input-number">%
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-2">代理佣金冻结期限：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input style="width:300px;" type="number" name="agent_withdraw_days" placeholder="请输入0~99" value="{$agent_withdraw_days}" class="input-number">天
                    </div>
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
<script>
    setTimeout(function(){
        $('.tabBar span').eq(0).click();
    })
</script>
</body>
</html>