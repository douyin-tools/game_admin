{include file="Public/meta" /}
<title>后台IP白名单</title>
</head>
<body>
<nav class="breadcrumb">
    <a href="javascript:;" layer-url="{:U('adminipadd')}" title="添加IP/IP段" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加IP/IP段</a>&nbsp;&nbsp;&nbsp;
</nav>
<div class="page-container">
    <div class="mt-5">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="60">ID</th>
                <th >IP/IP段</th>
                <th >备注</th>
                <th width="300">添加时间</th>
                <th >操作</th>
            </tr>
            </thead>
            <tbody>
            {volist name="list" id="vo"}
            <tr class="text-c">
                <td>{$vo.id}</td>
                <td>{$vo.ip}</td>
                <td>{$vo.remarks}</td>
                <td>{$vo.created_at}</td>
                <td class="td-manage">
                    <a style="text-decoration:none" class="ml-5" data-id="{$vo['id']}" onclick="deleteIP(this)" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
                </td>
            </tr>
            {/volist}
            </tbody>
        </table>
    </div>
</div>
{include file="Public/footer" /}
<script>
    function deleteIP(obj) {
        layer.confirm('您确定需要删除吗？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            layer.close(index);
            $.ajax({
                url:"{:U('iplimit')}",
                type:'POST',
                dataType: "json",
                data: {"id":$(obj).data('id'),"action":"del"},
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
    }
</script>
</body>
</html>