{include file="Public/meta" /}
<title>客户端管理</title>
</head>
<body>

<div class="page-container">
    <div class="mt-5">
        <form method="post" action="">
            <table id="client-tab" class="table  table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="60">平台</th>
                    <th width="60">二维码</th>
                    <th width="200">安装包</th>
                    <th width="200">下载地址</th>
                    <th width="40">状态</th>
                    <th width="80">上传时间</th>
                    <th width="40">操作</th>
                </tr>
                </thead>
                <tbody>
                {volist name="list" id="vo"}
                <tr class="text-c">
                    <td>{$vo.platform}</td>
                    <td><img src="{$vo.qr_code}" id="{$vo.platform}_qr_code" width="48" alt=""></td>
                    <td style="text-align: left;"><a style="text-decoration:none;color:#4a91af;" class="ml-5" layer-url="{:U('clientupload',['id'=>$vo['id']])}">上传</a>&emsp;
                        <span id="{$vo.platform}_package">{$vo.package}</span>
                    </td>
                    <td id="{$vo.platform}_download_link">{$vo.download_link}</td>
                    <td id="{$vo.platform}_state">
                        {if condition="$vo.state eq 0"}隐藏{/if}
                        {if condition="$vo.state eq 1"}显示{/if}
                    </td>
                    <td>{$vo.updated_at}</td>
                    <td>
<!--                        <a href="{$vo.download_link}" target="_blank" style="color:#4a91af;">下载</a>-->
                        <a style="text-decoration:none;color:#4a91af;" class="ml-5" layer-url="{:U('clientedit',['id'=>$vo['id']])}">编辑</a>
                    </td>
                </tr>
                {/volist}
                </tbody>
            </table>
        </form>
    </div>
</div>
{include file="Public/footer" /}
</body>
<script>
    setInterval(function () {
        $.ajax({
            url: "{:U('updateClientInfo')}", //path to external menu file
            error:function(res){
                console.log('client info 更新失败')
            },
            success:function(res){
                for (let i in res) {
                    $('#' + res[i].platform + '_package').text(res[i].package);
                    $('#' + res[i].platform + '_qr_code').attr('src', res[i].qr_code);
                    $('#' + res[i].platform + '_updated_at').text(res[i].updated_at);
                    $('#' + res[i].platform + '_state').text(res[i].state);
                    $('#' + res[i].platform + '_download_link').text(res[i].download_link);
                }
            }
        })
    }, 3000);

</script>
</html>