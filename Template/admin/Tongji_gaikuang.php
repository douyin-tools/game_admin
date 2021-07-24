<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   <meta name="renderer" content="webkit">
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
   <meta name="apple-mobile-web-app-status-bar-style" content="black">
   <meta name="apple-mobile-web-app-capable" content="yes">
   <meta name="format-detection" content="telephone=no">
   <link rel="stylesheet" href="../css/oksub.css" media="all"/>
    <link rel="stylesheet" href="/lib/layui/css/layui.css">
    <script src="/lib/layui/layui.all.js"></script>
    <script src="/lib/echarts/echarts.min.js"></script>
    <script type="text/javascript" src="../Template/admin/resources/ui/lib/jquery/1.9.1/jquery.min.js"></script>
    <style>
        h3 {
            font-size: 20px;
            margin-top: 20px;
            color: #436aff;
        }
        .por-txt, .stat-text {
            color: #436aff !important;
        }
    </style>
</head>
<body class="console console1 ok-body-scroll">
<div class="ok-body home">
   <div class="layui-row layui-col-space15">
      <div class="layui-col-xs6 layui-col-md3">
         <div class="ok-card layui-card">
            <div class="ok-card-body p0 clearfix cart-data">
               <div class="data-body">
                  <div class="media-cont">
                     <p class="tit">会员(不含代理)账户总金额</p>
                     <h3 class="">{$userBalanceTotal}</h3>
                  </div>
                  <div class="w-img" ok-pc-in-show>
                     <img src="../images/home-01.png" alt="账户可用"/>
                  </div>
               </div>
               <div id="echIncome" class="line-home-a"></div>
            </div>
         </div>
      </div>

      <div class="layui-col-xs6 layui-col-md3">
         <div class="ok-card layui-card">
            <div class="ok-card-body p0 clearfix cart-data">
               <div class="data-body">
                  <div class="media-cont">
                     <p class="tit">投注盈亏</p>
                     <h3 class="">{$betWinAmount}</h3>
                  </div>
                  <div class="w-img" ok-pc-in-show>
                     <img src="../images/home-02.png" alt="投注盈亏"/>
                  </div>
               </div>
               <div id="echGoods" class="line-home-a"></div>
            </div>
         </div>
      </div>

      <div class="layui-col-xs6 layui-col-md3">
         <div class="ok-card layui-card">
            <div class="ok-card-body p0 clearfix cart-data">
               <div class="data-body">
                  <div class="media-cont">
                     <p class="tit">充提盈亏</p>
                     <h3 class="">{$rechargeWinTotal}</h3>
                  </div>
                  <div class="w-img" ok-pc-in-show>
                     <img src="../images/home-03.png" alt="充提盈亏"/>
                  </div>
               </div>
               <div id="echBlogs" class="line-home-a"></div>
            </div>
         </div>
      </div>

      <div class="layui-col-xs6 layui-col-md3">
         <div class="ok-card layui-card">
            <div class="ok-card-body p0 clearfix cart-data">
               <div class="data-body">
                  <div class="media-cont">
                     <p class="tit">当前在线</p>
                     <h3 class="">{$memberOnLine}</h3>
                  </div>
                  <div class="w-img" ok-pc-in-show>
                     <img src="../images/home-04.png" alt="当前在线"/>
                  </div>
               </div>
               <div id="echUser" class="line-home-a"></div>
            </div>
         </div>
      </div>
   </div>

   <div class="layui-row layui-col-space15">
      <div class="layui-col-md8">
         <div class="layui-card">
            <div class="layui-card-header">
               <div class="ok-card-title">有效投注金额</div>
            </div>
            <div class="ok-card-body map-body">
            <div id="bet_statistical" style="width:100%;height:100%;"></div>
            </div>
         </div>
      </div>

      <div class="layui-col-md4">
			<div class="layui-card">
				<div class="layui-card-header">
					<div class="ok-card-title">用户统计</div>
				</div>
				<div class="ok-card-body map-body">
					<div class="progress-box ">
						<div class="pro-head">
							<img src="../images/home-04.png" alt="none"/>
						</div>
						<div class="pro-data">
							<h4 class="por-title">用户总数</h4>
							<div class="por-txt pro-a">{$userTotal}</div>
							<div class="layui-progress" lay-filter="pro-a">
								<div class="layui-progress-bar per-bg-a" lay-percent="{$userTotalLine}"></div>
							</div>
						</div>
					</div>

					<div class="progress-box ">
						<div class="pro-head">
							<img src="../images/home-04.png" alt="none"/>
						</div>
						<div class="pro-data">
							<h4 class="por-title">代理人数</h4>
							<div class="por-txt pro-a">{$agentTotal}</div>
                            <div class="layui-progress">
                                <div class="layui-progress-bar per-bg-a" lay-percent="{$agentTotalLine}"></div>
                            </div>
						</div>
					</div>

					<div class="progress-box ">
						<div class="pro-head">
							<img src="../images/home-04.png" alt="none"/>
						</div>
						<div class="pro-data">
							<h4 class="por-title">会员人数</h4>
							<div class="por-txt pro-c">{$memberTotal}</div>
							<div class="layui-progress" lay-filter="pro-c">
								<div class="layui-progress-bar per-bg-c" lay-percent="{$memberTotalLine}"></div>
							</div>
						</div>
					</div>

					<div class="progress-box ">
						<div class="pro-head">
							<img src="../images/home-04.png" alt="none"/>
						</div>
						<div class="pro-data">
							<h4 class="por-title">当前在线</h4>
							<div class="por-txt pro-d">{$memberOnLine}</div>
							<div class="layui-progress" lay-filter="pro-d">
								<div class="layui-progress-bar per-bg-d" lay-percent="{$memberOnLineLine}"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
   </div>

   <div class="layui-row layui-col-space15">
		<div class="layui-col-xs6 layui-col-md3">
			<div class="layui-card">
				<div class="ok-card-body">
					<div class="img-box" ok-pc-in-show>
						<img src="../images/home-01.png" alt="none"/>
					</div>
					<div class="cart-r">
						<div class="stat-text fans-num">{$rechargeTotal}</div>
						<div class="stat-heading">总充值</div>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-xs6 layui-col-md3">
			<div class="layui-card">
				<div class="ok-card-body">
					<div class="img-box" ok-pc-in-show>
						<img src="../images/home-01.png" alt="none"/>
					</div>
					<div class="cart-r">
						<div class="stat-text incomes-num">{$withdrawTotal}</div>
						<div class="stat-heading">总提款</div>
					</div>
				</div>
			</div>
		</div>
       <div class="layui-col-xs6 layui-col-md3">
           <div class="layui-card">
               <div class="ok-card-body">
                   <div class="img-box" ok-pc-in-show>
                       <img src="../images/home-01.png" alt="none"/>
                   </div>
                   <div class="cart-r">
                       <div class="stat-text incomes-num">{$validBetAmountTotal}</div>
                       <div class="stat-heading">总投注</div>
                   </div>
               </div>
           </div>
       </div>
		<div class="layui-col-xs6 layui-col-md3">
			<div class="layui-card">
				<div class="ok-card-body">
					<div class="img-box" ok-pc-in-show>
						<img src="../images/home-01.png" alt="none"/>
					</div>
					<div class="cart-r">
						<div class="stat-text incomes-num">{$returnWaterTotal}</div>
						<div class="stat-heading">活动/返水</div>
					</div>
				</div>
			</div>
		</div>
       <div class="layui-col-xs6 layui-col-md3">
           <div class="layui-card">
               <div class="ok-card-body">
                   <div class="img-box" ok-pc-in-show>
                       <img src="../images/home-01.png" alt="none"/>
                   </div>
                   <div class="cart-r">
                       <div class="stat-text incomes-num">{$winAmount}</div>
                       <div class="stat-heading">总派奖金额</div>
                   </div>
               </div>
           </div>
       </div>
       <div class="layui-col-xs6 layui-col-md3">
           <div class="layui-card">
               <div class="ok-card-body">
                   <div class="img-box" ok-pc-in-show>
                       <img src="../images/home-01.png" alt="none"/>
                   </div>
                   <div class="cart-r">
                       <div class="stat-text incomes-num">{$agentCommissionTotal}</div>
                       <div class="stat-heading">代理总佣金</div>
                   </div>
               </div>
           </div>
       </div>
       <div class="layui-col-xs6 layui-col-md3">
           <div class="layui-card">
               <div class="ok-card-body">
                   <div class="img-box" ok-pc-in-show>
                       <img src="../images/home-01.png" alt="none"/>
                   </div>
                   <div class="cart-r">
                       <div class="stat-text incomes-num">{$commissionFreezeTotal}</div>
                       <div class="stat-heading">代理冻结佣金</div>
                   </div>
               </div>
           </div>
       </div>
       <div class="layui-col-xs6 layui-col-md3">
           <div class="layui-card">
               <div class="ok-card-body">
                   <div class="img-box" ok-pc-in-show>
                       <img src="../images/home-01.png" alt="none"/>
                   </div>
                   <div class="cart-r">
                       <div class="stat-text incomes-num">{$agentWinTotal}</div>
                       <div class="stat-heading">代理总盈亏</div>
                   </div>
               </div>
           </div>
       </div>
	</div>
</div>
<script type="text/javascript" src="../lib/layui/layui.js"></script>
<script>
    layui.use('element', function(){
        var element = layui.element;
    });

    var chartDom = document.getElementById('bet_statistical');
    var myChart = echarts.init(chartDom);
    var option;

    $.ajax({
        url: "{:U('Tongji/getBetStatistical')}",
        type: "get",
        dataType: "json",
        success: function (res) {
            option = {
                title: {
                    text: ''
                },
                color: ['#23bbf6'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        boundaryGap: false,
                        data: res.date
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '金额',
                        type: 'line',
                        stack: '总量',
                        areaStyle: {},
                        emphasis: {
                            focus: 'series'
                        },
                        data: res.amount
                    }
                ]
            };
            myChart.setOption(option);
        },
        error: function (data) {
            alert('投注统计数据请求失败，请稍候重试！');
        }
    });
</script>
</body>
</html>