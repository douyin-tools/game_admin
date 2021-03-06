{include file="Public/meta" /}
<link rel="stylesheet" type="text/css" href="../Template/admin/resources/ui/lib/bootstrap-Switch/bootstrapSwitch.css" />
<title>充提款统计</title>
</head>
<body>
<nav class="breadcrumb">
<div class="l">
<form method="get" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" class="text-c">
    	时间:<input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" name="sDate" value="{$_sDate}"> - <input class="input-text" type="text" style="width:100px;" onFocus="WdatePicker({dateFmt:'yyyyMMdd'})" value="{$_eDate}" name="eDate">
        用户名：<input class="input-text" type="text" style="width:100px;" value="{$username}" name="username">
<input class="btn btn-default-outline radius" type="submit" value="查询">
</form>
</div>
<div class="r">
<a class="btn btn-success radius r btn-refresh" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a>
</div>
</nav>
<div class="page-container">
  
    	<div id="pincharts3d"></div>
  
    


  
  
  
</div>
{include file="Public/footer" /}
<script type="text/javascript" src="../Template/admin/resources/ui/lib/Highcharts1/4.1.7/js/highcharts.js"></script>
<script type="text/javascript" src="../Template/admin/resources/ui/lib/Highcharts1/4.1.7/js/highcharts-3d.js"></script>
<script type="text/javascript">
$(function () {
    $('#pincharts3d').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '{$title}'
        },
        subtitle: {
            text: '{$subtitle}'
        },
        xAxis: {
            categories: [
                {$dates}
            ]
        },
        yAxis: {
            min: 0,
            title: {
                text: '单位 (元)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} 元</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: '充值',
            data: [
			{$chongzhis}
			]

        }, {
            name: '提款',
            data: [
			{$tikuans}
			]

        }]
    });
});
</script>
</body>
</html>