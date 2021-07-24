{include file="Public/meta" /}
<title>修改银行信息</title>

</head>
<body>
<article class="page-container">
    <form action="{:U('clientedit')}" method="post" class="form form-horizontal" enctype="multipart/form-data">
        <input name="id" type="hidden" value="{$info['id']}">

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>客户端：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="{$info.platform}" readonly placeholder="客户端" >
            </div>
        </div>

        {if condition="$info.platform eq 'android' || $info.platform eq 'ios'"}
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>二维码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                {if condition="$info.qrcode neq ''"}
                <img src="{$info.qrcode}" width="48" alt=""><br/>
                {/if}
                <input type="file" name="qrcode" >
            </div>
        </div>
        {/if}

<!--        <div class="row cl">-->
<!--            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>版本号：</label>-->
<!--            <div class="formControls col-xs-8 col-sm-9">-->
<!--                <input type="text" class="input-text" value="{$info.v_no}" placeholder="版本号" name="v_no">-->
<!--            </div>-->
<!--        </div>-->

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>是否显示：</label>
            <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                <div class="radio-box">
                    <input {if condition="$info['state'] eq 1"}checked{/if} name="state" type="radio"  value="1">
                    <label for="state-0">显示</label>
                </div>
                <div class="radio-box">
                    <input {if condition="$info['state'] eq 0"}checked{/if} name="state" type="radio" value="0">
                    <label for="state-1">隐藏</label>
                </div>
            </div>
        </div>


        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>

{include file="Public/footer" /}

</body>
</html>


