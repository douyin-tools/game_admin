{include file="Public/meta" /}
<title>站内信通知</title>
</head>
<body>

<div class="page-container">
    <span class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
</span>
    <form method="get" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" class="text-c">
        <input type="hidden" name="uid" value="{$info.id}">
        收件人用户名：<input class="input-text" type="text" style="width:100px;" value="{$username}" name="username">
        发送时间:<input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" name="sDate" value="{$_sDate}"> - <input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" value="{$_eDate}" name="eDate">
        <input class="btn btn-default-outline radius" type="submit" value="查询">
    </form>
    <div class="mt-5">
        <form method="post" action="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="70">ID</th>
                    <th width="60">收件人</th>
                    <th width="60">发件人</th>
                    <th width="60">标题</th>
                    <th width="60">内容</th>
                    <th width="60">发送时间</th>
                    <th width="60">会员读取时间</th>
                </tr>
                </thead>
                <tbody>
                {php}$yemiantotal = 0;{/php}
                {volist name="list" id="vo"}
                <tr class="text-c">
                    <td>{$vo.id}</td>
                    <td>{$vo.recename}</td>
                    <td>{$vo.sentname}</td>
                    <td>{$vo.senttitle}</td>
                    <td>{$vo.sentcontext}</td>
                    <td>{php}echo date("Y-m-d H:i:s", $vo['senttime']);{/php}</td>
                    <td>{php}echo date("Y-m-d H:i:s", $vo['readtime']);{/php}</td>
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
</html>