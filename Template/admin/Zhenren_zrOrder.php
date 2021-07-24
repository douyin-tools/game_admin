{include file="Public/meta"/}
<title>额度转换管理</title>
</head>
<body>
<nav class="breadcrumb">



<span class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新"><i class="Hui-iconfont">&#xe68f;</i></a>
</span>
</nav>
<div class="page-container">
    <form method="get" action="" class="text-c">

        下注时间:&nbsp;&nbsp;&nbsp;
        <input class="input-text" type="text" style="width:180px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="start_time" value="{$start_time}"> -
        <input class="input-text" type="text" style="width:180px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="end_time" value="{$end_time}" >&nbsp;&nbsp;

        用户名：<input class="input-text" type="text" value="{$username}" name="username" style="width:180px">

        <a class="btn btn-default-outline radius" href="{:U('zrOrder')}">重置</a>

        <input class="btn btn-primary-outline radius" type="submit" value="查询">

    </form>
    <div class="mt-5">
        <form method="post" action="">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">


                    <th>订单号</th>
                    <th>玩家名称</th>
                    <th>游戏名称</th>
                    <th>玩法</th>
                    <th>投注金额</th>
                    <th>输赢金额</th>
                    <th>有效投注</th>
                    <th>投注时间</th>

                </tr>
                </thead>
                <tbody>
                {volist name="list" id="vo" key='index'}
                <tr class="text-c">


                    <td>{$vo.id}</u></td>
                    <td>{$vo.player_name}</td>
                    <td>{$vo.game_type_name}</td>
                    <td>{$vo.play_name}</td>
                    <td>{$vo.bet_amount}</td>
                    <td>{$vo.pay_amount}</td>
                    <td>{$vo.valid_bet_amount}</td>

                    <td>{$vo.create_at}</td>


                </tr>
                {/volist}
                </tbody>
            </table>
            <div class="cl pd-5 bg-1 bk-gray mt-20 text-c">
                <div class="l" style="padding:0">
                </div>
                <div class="r">
                    <div class="pageNav l" style="padding:0">{$page}</div>
                    <div class="r">共有数据：<strong>{$totalcount}</strong> 条</div>
                </div>
            </div>
        </form>
    </div>
</div>
<style>
    table tr td, th {
        font-size: 12px;
    }
</style>
{include file="Public/footer" /}
<script>
    $(document).on("click" , "[lock-url]" , function ()
    {
        var obj = $(this);
        var url = $(this).attr('lock-url');
        var title = obj.attr('title') ? $(this).attr('title') : '您确认操作吗？';
        var issuccess = obj.hasClass('label-success');
        layer.confirm(title , function (index)
        {
            $.getJSON(url , function (json)
            {
                if (json.status == 1) {
                    if (obj.text() == '锁定') {
                        obj.removeClass('c-999').addClass('c-green').text('解锁');
                    }
                    else {
                        obj.removeClass('c-green').addClass('c-999').text('锁定');
                    }

                    layer.msg('操作成功' , {icon: 1 , time: 1000});
                }
                else {
                    layer.msg(json.info , {icon: 2 , time: 2000});
                }
                ;
            });
        });
    });

</script>
</body>
</html>