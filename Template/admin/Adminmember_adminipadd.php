{include file="Public/meta" /}
<title>添加IP白名单</title>
</head>
<body>
<article class="page-container">
    <form action="{:U('iplimit')}" method="post" class="form form-horizontal validate-form" id="adminipaddForm">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>IP/IP段：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" id="ip" value="{$info.ip}" placeholder="IP/IP段" name="ip">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>备注：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" id="remarks" value="{$info.remarks}" placeholder="备注" name="ip">
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
<script>
    $("#adminipaddForm,.adminipaddForm").submit(function(){
        var $this    = $(this);
        layer.confirm('您确定需要操作吗？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            layer.close(index);
            $("#adminipaddForm,.adminipaddForm").find("[type='submit']").val('正在提交...').attr("disabled","disabled");
            $.ajax({
                url:$this.attr('action'),
                type:'POST',
                dataType: "json",
                data: {"ip":$('#ip').val(),"remarks":$('#remarks').val(),"action":"add"},
                success: function(res) {
                    if(res.status == 1){
                        layer.msg(res.info,{icon:1,time:2000});
                        setTimeout("parentrefresh()", 2000);
                    } else {
                        layer.msg(res.info,{icon:2,time:3000});
                    }
                }
            });
        }, function(index){
            layer.close(index);
        });

        return false;
    });
</script>
</html>