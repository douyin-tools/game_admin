{include file="Public/meta" /}
<title>返水记录</title>
</head>
<body>

<div class="page-container">
    <span class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
</span>
    <form method="get" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" class="text-c">
        <input type="hidden" name="uid" value="{$info.id}">
        用户名：<input class="input-text" type="text" style="width:100px;" value="{$username}" name="username">
        时间:<input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" name="sDate" value="{$_sDate}"> - <input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" value="{$_eDate}" name="eDate">
        <input class="btn btn-default-outline radius" type="submit" value="查询">
    </form>
    <div class="mt-5">
        <form method="post" action="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="70">ID</th>
                    <th width="60">用户名</th>
                    <th width="60">返水金额</th>
                    <th width="60">有效投注金额</th>
                    <th width="60">返水比例</th>
                    <th width="60">返水日期</th>
                    <th width="60">时间</th>
                </tr>
                </thead>
                <tbody>
                {php}$yemiantotal = 0;{/php}
                {volist name="list" id="vo"}
                <tr class="text-c">
                    <td>{$vo.id}</td>
                    <td>{$vo.username}</td>
                    <td><span style="color:grey">{$vo.amount}</span></td>
                    <td><span style="color:green">{$vo.valid_bet_amount}</span></td>
                    <td>{$vo.water_rate}</td>
                    <td>{$vo.date}</td>
                    <td>{php}echo date("Y-m-d H:i:s", $vo['created_at']);{/php}</td>
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