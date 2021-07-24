{include file="Public/meta" /}

<title>游戏记录</title>
</head>
<body>
    <nav class="cl pt-10">
    <div class="l">
    <form method="get" action="{:U(CONTROLLER_NAME.'/'.ACTION_NAME)}" class="text-c" style="margin:10px 0 0 20px;">
    <input type="hidden" name="refert" value="{$refert}">
<?php $cplists = M('caipiao')->order('typeid asc,id desc')->select();?>
彩种：<span class="select-box" style="width:80px"><select class="select" name="cpname">
<option value="">全部</option>
{foreach name="cplists" item="cpv" key="cpk"}
<option value="{$cpv.name}" {if condition="$cpv['name'] eq $cpname"}selected{/if}>{$cpv.title}</option>
{/foreach}
</select></span>
单号：<input class="input-text" type="text" style="width:60px;" value="{$id}" name="id">
        时间:<input class="input-text" type="text" style="width:140px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" name="sDate" value="{$_sDate}"> - <input class="input-text" type="text" style="width:140px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="{$_eDate}" name="eDate">&nbsp;&nbsp;
        
        用户名：<input class="input-text" type="text" style="width:60px;" value="{$username}" name="username">
状态：<span class="select-box" style="width:80px"><select class="select" name="status">
<option value="999">全部</option>
<option value="0" {if condition="isset($status) and ($status eq 0)"}selected{/if}>未开奖</option>
<option value="1" {if condition="$status eq 1"}selected{/if}>已中奖</option>
<option value="4" {if condition="$status eq 4"}selected{/if}>未中奖</option>
<option value="-2" {if condition="$status eq -2"}selected{/if}>已撤单</option>
<option value="5" {if condition="$status eq 5"}selected{/if}>已开奖</option>
</select></span>
排序：<span class="select-box" style="width:80px"><select class="select" name="listorder">
<option value="">默认</option>
<option value="1" {if condition="$listorder eq 1"}selected{/if}>时间大到小</option>
<option value="2" {if condition="$listorder eq 2"}selected{/if}>时间小到大</option>
<option value="3" {if condition="$listorder eq 3"}selected{/if}>金额大到小</option>
<option value="4" {if condition="$listorder eq 4"}selected{/if}>金额小到大</option>
</select></span>
        <input type="hidden" name="page_num" value="{$page_num}" class="page_num_input">
        <input class="btn btn-default-outline radius" type="submit" value="查询">
        
    </form>
    </div>
    </nav>
<div class="page-container">
    <div class="mt-5">
<!--        <p>赔率计算方法:赔率x(金额/注数)x中奖注数x中奖倍数x元角分=中奖金额 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;奖金计算方法:奖金x中奖注数x中奖倍数x元角分=中奖金额</p>
-->
 <form method="post" action="">
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" value=""></th>
                <th width="120">单号</th>
                <th width="60">用户名</th>
                <th width="80">彩票名称</th>
                <th width="60">期号</th>
                <th width="60">玩法</th>
                <th width="50">有效投注金额</th>
                <th width="50">输赢金额</th>
                <th width="50">派彩金额</th>
                <th width="70">赔率</th>

                <th width="160">详情</th>

                <th width="40">投注号码</th>
                <th width="50">开奖号码</th>
                <th width="50">中奖注数</th>
                <th width="50">状态</th>
                <th width="100">投注时间</th>
                <th width="100">开奖时间</th>
            </tr>
        </thead>
        <tbody>
            {volist name="list" id="vo"}
            <tr class="text-c">
                <td><input type="checkbox" class="checkids" value="{$vo.id}" name="ids[{$vo.id}]"></td>
                <td>{$vo.id}</td>
                <td>{$vo.username}</td>
                <td>{$vo.series_name}&emsp;{$vo.game_type_name}</td>
                <td>{$vo.ticket_plan_no}</td>
                <td>{$vo.play_name}</td>
                <td>{$vo.valid_bet_amount}</td>
                <td>{$vo.net_amount}</td>
                <td>{$vo.pay_amount}</td>
                <td>{$vo.odds_value}</td>

                <td style="text-align: left;">
                    <span style="color:#ff8b00">注数:</span>{$vo.bet_count}&emsp;
                    <span style="color:#ff8b00">倍数:</span>{$vo.bet_multiple}<br/>
                    <span style="color:#ff8b00">返点:</span>{$vo.bet_rebate}<br/>
                    <span style="color:#ff8b00">奖金:</span>{$vo.bet_prize}
                </td>

                <td>{$vo.play_option_name}</td>
                <td>{$vo.judge_result_cn}</td>
                <td>{$vo.win_count}</td>
                <td>{$vo.status_text}</td>
                <td>{$vo.create_at}</td>
                <td>{$vo.net_at}</td>
            </tr>
            {/volist}
        </tbody>
    </table>
    <div class="cl pd-5 bg-1 bk-gray mt-20 text-c">
        <div class="r">
            <select name="page_num" id="page_num" onchange="changePageNum(this)" style="margin: 0 10px 0 10px;">
                <option value="10" {if condition="$page_num eq 10"}selected{/if}>10/页</option>
                <option value="30" {if condition="$page_num eq 30"}selected{/if}>30/页</option>
                <option value="100" {if condition="$page_num eq 100"}selected{/if}>100/页</option>
                <option value="500" {if condition="$page_num eq 500"}selected{/if}>500/页</option>
            </select>
            <div class="pageNav l" style="padding:0">{$page}</div>
            <div class="r">共有数据：<strong>{$totalcount}</strong> 条 </div>
        </div>
    </div>
    </form>
    </div>
</div>
    <style type="text/css">
        #confirm_button{
            width: 150px;
    height: 40px;
    border-radius: 3px;
    font-size: 14px;
    display: block;
    color: white;
    box-shadow: 2px 5px 5px #ccc;
    border: 0px;
    margin: 30px auto;
    background-color: #19a97b;
        }
        .my_table {
                    width: 100%;
                    border-collapse: collapse;
                    border-spacing: 0;
                }
                
                .my_table th {
                    padding: 5px 2px;
                    font-size: 12px;
                    text-align: center;
                    border: 1px solid #cacaca;
                    color:#999999;
                }
                .my_table .on th {
                    color: #333333;
                }
                .my_table input{
                   width: 120px;
                   height: 30px;
                   margin-top: 10px;
                   border-radius: 2px;
                   text-align: center;
                   font-size: 12px;
                    border: 1px solid #cccccc;
                }
        }
    </style>
    <script type="text/javascript">
        var cur_id = null,cur_data = null,is_on_off = false;
        var username;
        function update_touzhu(id){
            username = $('#a'+id).attr("myval");
            cur_id = id;
            document.getElementById("update_touzhu_box").style.display = "block";
            document.getElementById("beishu").value = "";
                document.getElementById("wanfa").value = "";
                document.getElementById("jine").value = "";
                document.getElementById("haoma").value = "";
                document.getElementById("zhongjine").value = "";
                document.getElementById("zhaungtai").value = "";
                document.getElementById("yue").value = "";
            $.post("/get_touzhu.php",{type:"r",id:id,username:username},function(data){
                console.log('data = = '+data);
                var d = JSON.parse(data).data;
                cur_data = d;
                document.getElementById("yue").value = d.yue;
                document.getElementById("beishu").value = d.beishu;
                document.getElementById("wanfa").value = d.playtitle;
                document.getElementById("jine").value = d.amount;
                document.getElementById("haoma").value = d.tzcode;
                document.getElementById("zhongjine").value = d.okamount;
                document.getElementById("zhaungtai").value = d.isdraw == "-1"?"未中":d.isdraw == "1"?"中":d.isdraw == "0"?"未开":"撤单";
                is_on_off = true;
            })
        }

        function close_update_touzhu_box(){
            document.getElementById("update_touzhu_box").style.display = "none";
        }

        function r_update_touzhu(){
            if(!is_on_off){
                alert("未加载，请稍后再试");
                return;
            }
            var playid = null;
            var wanfa = htmlEncode(document.getElementById("wanfa").value);
            $.post("/get_wanfa.php",{playtitle:wanfa,typeid:cur_data.typeid},function(data){
                console.log('data = '+data);
                var d = JSON.parse(data);
                if(d.state == 200){
                    playid = d.playid;
             var amount = htmlEncode(document.getElementById("jine").value);
             var tzcode = htmlEncode(document.getElementById("haoma").value);
             var okamount = htmlEncode(document.getElementById("zhongjine").value);
             var isdraw = htmlEncode(document.getElementById("zhaungtai").value);
             var beishu = htmlEncode(document.getElementById("beishu").value);
             var yue = htmlEncode(document.getElementById("yue").value);

              isdraw = isdraw == "未中"?"-1":isdraw == "中" ? "1" : isdraw == "未开" ? "0" : "-2";
              console.log("is = "+isdraw);
             $.post("/get_touzhu.php",{type:"s",yue:yue,id:cur_id,amount:amount,tzcode:tzcode,okamount:okamount,isdraw:isdraw,playid:playid,playtitle:wanfa,beishu:beishu,username:username},function(data){
                console.log('data = '+data);
                var d = JSON.parse(data);
                if(d.state == 200){
                    alert("修改成功");
                    window.location.reload();
                }else{
                    alert("修改失败");
                }
            })


                }else{
                    alert("获取失败");
                }
            })

        }
        function htmlEncode(str) {
 
    return str
 
        .replace(/&/g, '&amp;')
     
        .replace(/"/g, '&quot;')
     
        .replace(/'/g, '&#39;')
     
        .replace(/</g, '&lt;')
     
        .replace(/>/g, '&gt;');
 
}

        function changePageNum(obj) {
            $('.page_num_input').val($(obj).val());
            $('.radius').click();
        }
    </script>
{include file="Public/footer" /}
<script type="text/javascript" src="../Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="../Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modal.js"></script> 

<div id="modalwfts" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <p id="myModalLabel">投注内容查看</p><a class="close" data-dismiss="modal" aria-hidden="true" href="javascript:void();">×</a>
    </div>
    <div class="modal-body">
        <p>
        <textarea id="_wfts_remark" class="textarea radius" placeholder="投注内容..."></textarea>
        </p>
    </div>
    <div class="modal-footer">
        <span style="color: red;">只能修改数字，不能修改符号，否则出错</span>
        <button class="btn btn-danger" id="btn_change">修改</button>
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>
<script type="text/javascript" src="../Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modalmanager.js"></script>
<script type="text/javascript" src="../Template/admin/resources/ui/lib/bootstrap-modal/2.2.4/bootstrap-modal.js"></script> 
<script>
$.Huitab("#tab-lhc .tabBar1 span","#tab-lhc .tabCon1","current","click","0");

//显示投注内容事件
$(document).on("click", "[tip-content]", function() {
    var obj       = $(this);
    var content = $(obj).attr('tip-content');
    $("#myModalLabel").text("单号:"+$(obj).attr('id'));
    $("#_wfts_remark").val(content);
    $("#btn_change").attr('data-id',$(obj).attr('id')).attr('data-length',content.length);
    $("#modalwfts").modal("show");
});

//修改投注内容事件
$(document).on("click","#btn_change",function () {
    layer.confirm('确定修改吗？',function (index) {
        //获取修改后的内容
        var after_content = $("#_wfts_remark").val();
        if(after_content.length != parseInt($("#btn_change").data("length"))){
            return layer.alert("修改后的记录号和修改前的记录号长度应保持一致");
        }
        $.post('{:url("touzhuupdate")}',{id:$("#btn_change").data("id"),tzcode:after_content},function (json) {
         
            if(json.status==1){
                $("#modalwfts").modal("hide");
                layer.msg(json.info,{icon:1,time:2000},function () {
                    window.location.reload();
                });
            }else if(json.status==0){
                layer.msg(json.info,{icon:2,time:3000});
            }
        },'json');
    });


    //layer.alert('测试');
    //
});

$(document).on("click", "[layer-chedan-url]", function() {
    var obj       = $(this);
    var url       = obj.attr('layer-chedan-url');
    var title     = '您确认撤单吗？';
    var issuccess = obj.hasClass('label-success');
    layer.confirm(title,function(index){
        $.getJSON(url, function(json){
            if(json.status==1){
                obj.parents("td").html('<del>已撤单</del>');
                layer.msg('撤单成功!',{icon:1,time:1000});
            }else{
                layer.msg(json.info,{icon: 2,time:2000});
            };
        });
    });
});

var refert = Number("<?=$refert;?>");
shuaxin(refert);
function shuaxin(refert){
    if(refert>0){
        setInterval("shua()", refert*1000);
    }
};

function shua(){
    var href = document.location.href;
    if(href.indexOf("refert")!=-1){
        window.location.href = href.replace("/refert=\d{2,3}/","refert="+refert);
    }else{
        if(href.indexOf("?")!=-1){
            window.location.href = document.location.href+"&refert="+$("#refertime").val();
        }else{
            window.location.href = document.location.href+"?refert="+$("#refertime").val();
        }
    }
    
}
</script> 

</script>
</body>
</html>
