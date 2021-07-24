<!DOCTYPE html>
<html lang="en" class="page-fill">
<head>
    <meta charset="UTF-8">
    <title>{:GetVar('webtitle')}-后台管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../css/oksub.css"/>
</head>
<body class="page-fill">
    <div class="page-fill" id="login">
        <form class="layui-form" action="" method="post">
            <div class="login_face"><img src="/static/img/logo.jpg"></div>
            <div class="layui-form-item input-item">
                <label for="username">用户名</label>
                <input type="text" lay-verify="required" id="name" name="info[name]"  placeholder="请输入账号" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-item input-item">
                <label for="password">密码</label>
                <input type="password" lay-verify="required|password" name="info[pass]" placeholder="请输入密码" autocomplete="off" id="pass" class="layui-input">
            </div>
			<div class="layui-form-item input-item">
                <label for="password">安全码</label>
                <input type="password" lay-verify="required|password" id="rzm" name="info[rzm]" placeholder="安全码" autocomplete="off" class="layui-input">
            </div>
			{if condition="GetVar('islogincode') eq 1"}
            <div class="layui-form-item input-item captcha-box">
                <label for="captcha">验证码</label>
                <input type="text" lay-verify="required|captcha" placeholder="请输入验证码" autocomplete="off" id="code" name="info[code]" maxlength="4" class="layui-input">
                <img id="verifycode" src="{:url('Public/verify',['imageW'=>100,'imageH'=>39,fontSize=>14])}" onclick="this.src=this.src+'?temp='+ 1" title="看不清，换一张"></div>
            </div>
			{/if}
            <div class="layui-form-item">
                <button name="do" type="submit" class="layui-btn layui-block" lay-filter="login" lay-submit="" value="登录">登录</button>
            </div>
        </form>
    </div>
<!--div class="footer">Copyright MKdinzhi 2020 </div-->
<script type="text/javascript" src="../Template/admin/resources/ui/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../Template/admin/resources/ui/static/h-ui/js/H-ui.js"></script>
<script>
    function sendcode(obj){
        if($("#name").val().length<3){
            alert('用户名/邮箱错误！');$("#name").focus();
            return false;
        }
        if($("#pass").val().length<6){
            alert('密码格式错误！');$("#pass").focus();
            return false;
        }
        $.post("{:U('Public/sendcode')}",{'act':'senddo','username':$("#name").val()}, function(json){
            if(json.status==1){
                alert(json.info);
                settime(obj);
            }else if(json.status==0){
                alert(json.info);
                return false;
            }
        },'json');
    }
    var countdown = countdown1 = parseInt("{:GetVar('adminemailcodetime')}");
    function settime(obj) {
        if (countdown == 0) {
            //obj.removeAttribute("disabled");
            obj.value="发送验证码";
            countdown = countdown1;
            return;
        } else {
            //obj.setAttribute("disabled", true);
            obj.value="重新发送(" + countdown + ")";
            countdown--;
        }
        setTimeout(function() {
                settime(obj) }
            ,1000)
    }

</script>
<script src="../lib/layui/layui.js"></script>
    <script>
        layui.use(["form", "okGVerify", "okUtils", "okLayer"], function () {
            let form = layui.form;
            let $ = layui.jquery;
            let okGVerify = layui.okGVerify;
            let okUtils = layui.okUtils;
            let okLayer = layui.okLayer;

            /**
             * 表单input组件单击时
             */
            $("#login .input-item .layui-input").click(function (e) {
                e.stopPropagation();
                $(this).addClass("layui-input-focus").find(".layui-input").focus();
            });

            /**
             * 表单input组件获取焦点时
             */
            $("#login .layui-form-item .layui-input").focus(function () {
                $(this).parent().addClass("layui-input-focus");
            });

            /**
             * 表单input组件失去焦点时
             */
            $("#login .layui-form-item .layui-input").blur(function () {
                $(this).parent().removeClass("layui-input-focus");
                if ($(this).val() != "") {
                    $(this).parent().addClass("layui-input-active");
                } else {
                    $(this).parent().removeClass("layui-input-active");
                }
            })
        });
    </script>
</body>
</html>
