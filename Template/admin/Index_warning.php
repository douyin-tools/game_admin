{include file="Public/meta" /}
<title>告警信息</title>
</head>
<body>

<div class="page-container">
    <span class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
</span>
    <div class="mt-5">
        <form method="post" action="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="40">ID</th>
                    <th width="40">用户</th>
                    <th width="60">内容</th>
                    <th width="60">状态</th>
                    <th width="50">信息读取时间</th>
                    <th width="50">记录时间</th>
                </tr>
                </thead>
                <tbody>
                {php}$yemiantotal = 0;{/php}
                {volist name="list" id="vo"}
                <tr class="text-c">
                    <td>{$vo.id}</td>
                    <td>{$vo.username}</td>
                    <td>{$vo.content}</td>
                    <td>
                        <?php
                        if ($vo['state'] != 0) {
                            echo '已读';
                        } else {
                            echo '<a href="javascript:" data-id="'.$vo['id'].'" onclick="isRead(this)" style="color:#2D8CF0">点击标记为已读</a>';
                        }
                        ?>
                    </td>
                    <td>{$vo.read_at}</td>
                    <td>{$vo.created_at}</td>
                </tr>
                {/volist}
                </tbody>
            </table>

            <div class="cl pd-5 bg-1 bk-gray mt-20 text-c">
                <div class="r">
                    <div class="pageNav l" style="padding:0">{$page}</div>
                    <div class="r">共有数据：<strong>{$totalcount}</strong> 条 </div>
                </div>
            </div>
        </form>
    </div>
</div>
{include file="Public/footer" /}
</body>
<script>
    function isRead(obj) {
        $.ajax({
            url:"{:U('warningRead')}",
            type:'POST',
            dataType: "json",
            data:{"id":$(obj).data('id')},
            success: function(res) {
                if (res.state == 1) {
                    $(obj).parent().append('已读');
                    $(obj).parent().next().text(res.read_at);
                    $(obj).remove();
                } else {
                    alert('操作失败');
                }
            }
        });
    }
</script>
</html>