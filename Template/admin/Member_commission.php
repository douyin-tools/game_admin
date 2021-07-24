{include file="Public/meta" /}
<title>代理佣金</title>
</head>
<body>
<?php
$_states = [
    '0'=>'冻结中',
    '1'=>'已发放到余额',
];

?>
<div class="page-container">
    <span class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
</span>
    <form method="get" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" class="text-c">
        <?php $fuddetailtypes = C('fuddetailtypes');?>
        <span class="select-box" style="width:80px"><select class="select" name="state">
<option value="">全部</option>
{foreach name="_states" item="ft" key="fk"}
<option value="{$fk}" {if condition="($fk eq $status) and ($status neq '')"}selected{/if}>{$ft}</option>
                {/foreach}

</select></span>

        <input type="hidden" name="uid" value="{$info.id}">
        时间:<input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" name="sDate" value="{$_sDate}"> - <input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" value="{$_eDate}" name="eDate">

        用户名：<input class="input-text" type="text" style="width:100px;" value="{$username}" name="username">
        <input class="btn btn-default-outline radius" type="submit" value="查询">
    </form>
    <div class="mt-5">
        <form method="post" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}">
            <table class="table table-border table-bordered table-hover table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="20">用户ID</th>
                    <th width="60">用户名</th>
                    <th width="70">佣金</th>
                    <th width="60">合营比例</th>
                    <th width="60">直属会员前一天总余额</th>
                    <th width="60">当天会员总余额</th>
                    <th width="60">总充值</th>
                    <th width="60">总提现</th>
                    <th width="60">日期</th>
                    <th width="60">结算时间</th>
                    <th width="50">状态</th>
                </tr>
                </thead>
                <tbody>
                {php}$yemiantotal = 0;{/php}
                {volist name="list" id="vo"}
                {php}
                if($vo['state']==1)$yemiantotal += $vo['commission'];
                {/php}
                <tr class="text-c">
                    <td><input type="checkbox" class="checkids" value="{$vo.id}" name="ids[{$vo.id}]"></td>
                    <td>{$vo.uid}</td>
                    <td>{$vo.username}</td>
                    <td>{$vo.commission}</td>
                    <td>{$vo.share_rate}%</td>
                    <td>{$vo.yesterday_balance}</td>
                    <td>{$vo.balance}</td>
                    <td>{$vo.recharge}</td>
                    <td>{$vo.withdraw}</td>
                    <td>{$vo.date}</td>
                    <td>{php}echo date('Y-m-d H:i:s', $vo['created_at']);{/php}</td>
                    <td>
                        {if condition="$vo['status'] eq 0"}
                        <u style="cursor:pointer" class="text-primary" layer-url="{:U('rechargstate',['id'=>$vo['id']])}" title="编辑订单-{$vo.trano}状态">
                            <span style="color:red">冻结中</span>
                        </u>
                        {elseif condition="$vo['status'] eq 1"/}
                        <span style="color:green">已发放到余额</span>
                        {/if}
                        |
                        <a style="text-decoration:none" class="ml-5" layer-del-url="{:U('rechargedelete',array('id'=>$vo['id']))}" href="javascript:;" title="删除">删除</a>
                    </td>
                </tr>
                {/volist}
                </tbody>
            </table>

            <div class="cl pd-5 bg-1 bk-gray mt-20 text-c">
                <div class="l" style="padding:0">页面成功：<strong style="color:#f60">{$yemiantotal}</strong>元</div>
                <div class="r">
                    <div class="pageNav l" style="padding:0">{$page}</div>
                    <div class="r">共有数据：<strong>{$totalcount}</strong> 条 </div>
                </div>
            </div>
        </form>
    </div>
</div>
{include file="Public/footer" /}

<script type="text/javascript" src="__ROOT__/Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="__ROOT__/Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modal.js"></script>

</body>
</html>