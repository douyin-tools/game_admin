<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>{:GetVar('webtitle')} - AdminS'</title>
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon"/>
   <link rel="stylesheet" href="css/okadmin.css">
   <link rel="stylesheet" href="lib/loading/okLoading.css"/>
   <script type="text/javascript" src="./js/okconfig.js"></script>
   <script type="text/javascript" src="lib/loading/okLoading.js"></script>
</head>
<body class="layui-layout-body">
<!-- 更换主体 Eg:orange_theme|blue_theme -->
<div class="layui-layout layui-layout-admin okadmin blue_theme">
   <!--头部导航-->
   <div class="layui-header okadmin-header">
      <ul class="layui-nav layui-layout-left">
         <li class="layui-nav-item">
            <a class="ok-menu ok-show-menu" href="javascript:" title="菜单切换">
               <i class="layui-icon layui-icon-shrink-right"></i>
            </a>
         </li>
         <!--天气信息-->
         
         <li class="ok-nav-item ok-hide-md">
             <div class="weather-ok">
                 <iframe frameborder="0" scrolling="no" class="iframe-style" src="pages/weather.html" frameborder="0"></iframe>
             </div>
         </li>
       
      </ul>
      <ul class="layui-nav layui-layout-right">
         <li class="layui-nav-item ok-input-search">
            <input type="text" placeholder="搜索..." class="layui-input layui-input-search"/>
         </li>
         <li class="layui-nav-item">
            <a class="ok-refresh" href="javascript:" title="刷新">
               <i class="layui-icon layui-icon-refresh-3"></i>
            </a>
         </li>
         <li class="no-line layui-nav-item layui-hide-xs">
            <a id="notice" class="flex-vc pr10 pl10" href="javascript:">
               <i class="ok-icon ok-icon-notice icon-head-i" title="系统公告"></i>
               <span class="layui-badge-dot"></span>
               <cite></cite>
            </a>
         </li>

         <li class="no-line layui-nav-item layui-hide-xs">
            <a id="lock" class="flex-vc pr10 pl10" href="javascript:">
               <i class="ok-icon ok-icon-lock icon-head-i" title="锁屏"></i><cite></cite>
            </a>
         </li>

         <!-- 全屏 -->
         <li class="layui-nav-item layui-hide-xs">
            <a id="fullScreen" class=" pr10 pl10" href="javascript:;">
               <i class="layui-icon layui-icon-screen-full"></i>
            </a>
         </li>

         <li class="no-line layui-nav-item">
            <a href="javascript:">
               <img src="/static/img/logo.jpg" class="layui-nav-img">
               {$admininfo['username']}
            </a>
            <dl id="userInfo" class="layui-nav-child">
               <dd><a lay-id="u-1" href="javascript:" data-url="pages/member/user.html">个人中心<span
                   class="layui-badge-dot"></span></a></dd>
               <dd><a lay-id="u-2" href="javascript:void(0);" onclick="article_add('修改密码','{:U('Adminmember/editpass',['type'=>'pass'])}')">修改密码</a></dd>
               <dd><a lay-id="u-3" href="javascript:void(0);" onclick="article_add('修改安全码','{:U('Adminmember/editpass',['type'=>'safecode'])}')">修改安全码</a></dd>
               <dd><a lay-id="u-4" href="javascript:" id="alertSkin">皮肤动画</a></dd>
               <dd>
                  <hr/>
               </dd>
               <dd><a href="{:U('Public/loginout')}">退出登录</a></dd>
            </dl>
         </li>

         <!-- 菜单 -->
         <li class="layui-nav-item layui-hide-xs">
            <a id="okSetting" class="pr10 pl10" href="javascript:;">
               <i style="font-size: 18px" class="ok-icon ok-icon-moreandroid"></i>
            </a>
         </li>
      </ul>
   </div>
   <!--遮罩层-->
   <div class="ok-make"></div>
   <!--左侧导航区域-->
   <div class="layui-side layui-side-menu okadmin-bg-20222A ok-left">
      <div class="layui-side-scroll okadmin-side">
         <div class="okadmin-logo">{:GetVar('webtitle')}<!-- 管理系统 --></div>
         <div class="user-photo">
            <a class="img" title="我的头像">
               <img src="/static/img/logo.jpg" class="userAvatar">
            </a>
            <p>你好！<span class="userName">{$admininfo['groupname']}-{$admininfo['username']}</span>, 欢迎登录</p>
         </div>
         <!--左侧导航菜单-->
         <ul id="navBar" class="layui-nav okadmin-nav okadmin-bg-20222A layui-nav-tree ok-arrow2" style="height: 477px;">
          <li class="layui-nav-item layui-this"><a lay-id="1" data-url="pages/console.html" is-close="true"><i class="ok-icon"></i><cite>控制台</cite></a>
          </li>
          <li class="layui-nav-item"><a><i class="ok-icon"></i><cite>控制台示例</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="2-1" data-url="pages/console1.html" is-close="true"><i class="layui-icon"></i><cite>控制台一</cite></a>
                  </dd>
              </dl>
          </li>
          <!--li class="layui-nav-item"><a><i class="ok-icon ok-icon-yooxi"></i><cite>框架使用</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="3-1" data-url="pages/help/ok_font.html" is-close="true"><i class="layui-icon"></i><cite>字体图标</cite></a>
                  </dd>
                  <dd><a lay-id="3-2" data-url="pages/help/plug_directory.html" is-close="true"><i class="layui-icon"></i><cite>插件目录</cite></a>
                  </dd>
                  <dd><a lay-id="3-3" data-url="pages/help/nav_operate.html" is-close="true"><i class="layui-icon"></i><cite>内部添加导航</cite></a>
                  </dd>
                  <dd><a lay-id="3-4" data-url="pages/help/nav_icon.html" is-close="true"><i class="layui-icon"></i><cite>导航的图标</cite></a>
                  </dd>
                  <dd><a lay-id="3-5" data-url="pages/help/nav_parameter.html" is-close="true"><i class="layui-icon"></i><cite>导航的参数</cite></a>
                  </dd>
                  <dd><a lay-id="3-6" data-url="pages/help/okUtils.html" is-close="true"><i class="layui-icon"></i><cite>okUtils</cite></a>
                  </dd>
                  <dd><a lay-id="3-7" data-url="pages/help/okLayer.html" is-close="true"><i class="layui-icon"></i><cite>okLayer</cite></a>
                  </dd>
                  <dd><a lay-id="3-8" data-url="pages/help/okFly.html" is-close="true"><i class="layui-icon"></i><cite>okFly</cite></a>
                  </dd>
              </dl>
          </li-->
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>系统管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="4-1" data-url="{:U('System/setting')}" is-close="true"><i class="layui-icon"></i><cite>系统设置</cite></a>
                  </dd>
                  <dd><a lay-id="4-2" data-url="{:U('Caipiao/cptype')}" is-close="true"><i class="layui-icon"></i><cite>彩种管理</cite></a>
                  </dd>
                  <dd><a lay-id="4-3" data-url="{:U('Caipiao/wanfa')}" is-close="true"><i class="layui-icon"></i><cite>玩法管理</cite></a>
                  </dd>
				  <dd><a lay-id="4-4" data-url="{:U('Caipiao/kaijiang')}" is-close="true"><i class="layui-icon"></i><cite>开奖管理</cite></a>
                  </dd>
				  <dd><a lay-id="4-5" data-url="{:U('Caipiao/yukaijiang')}" is-close="true"><i class="layui-icon"></i><cite>设置开奖</cite></a>
                  </dd>
				  <dd><a lay-id="4-6" data-url="{:U('Game/manage')}" is-close="true"><i class="layui-icon"></i><cite>彩票注单</cite></a>
                  </dd>
                  <dd><a lay-id="4-6" data-url="{:U('Game/betorders')}" is-close="true"><i class="layui-icon"></i><cite>游戏注单</cite></a>
                  </dd>
				  <dd><a lay-id="4-7" data-url="{:U('Game/checkerrorder')}" is-close="true"><i class="layui-icon"></i><cite>注单异常检测</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>数据统计</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="5-1" data-url="{:U('Tongji/gaikuang')}" is-close="true"><i class="layui-icon"></i><cite>统计概况</cite></a>
                  </dd>
                  <dd><a lay-id="5-2" data-url="{:U('Tongji/yingkui')}" is-close="true"><i class="layui-icon"></i><cite>盈亏统计</cite></a>
                  </dd>
                  <dd><a lay-id="5-3" data-url="{:U('Tongji/user')}" is-close="true"><i class="layui-icon"></i><cite>用户统计</cite></a>
                  </dd>
				  <dd><a lay-id="5-4" data-url="{:U('Tongji/tdgaikuang')}" is-close="true"><i class="layui-icon"></i><cite>团队概况</cite></a>
                  </dd>
				  <dd><a lay-id="5-5" data-url="{:U('Tongji/cptouzhu3d')}" is-close="true"><i class="layui-icon"></i><cite>彩种投注统计</cite></a>
                  </dd>
				  <dd><a lay-id="5-6" data-url="{:U('Tongji/chongti3d')}" is-close="true"><i class="layui-icon"></i><cite>充提款统计</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>资金管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="6-1" data-url="{:U('Sysbank/manage')}" is-close="true"><i class="layui-icon"></i><cite>提款银行</cite></a>
                  </dd>
                  <dd><a lay-id="6-2" data-url="{:U('Member/payset')}" is-close="true"><i class="layui-icon"></i><cite>存款方式</cite></a>
                  </dd>
                  <dd><a lay-id="6-3" data-url="{:U('Member/recharge')}" is-close="true"><i class="layui-icon"></i><cite>充值记录</cite></a>
                  </dd>
                  <dd><a lay-id="6-4" data-url="{:U('Member/withdraw')}" is-close="true"><i class="layui-icon"></i><cite>提现记录</cite></a>
                  </dd>
                  <dd><a lay-id="6-5" data-url="{:U('Setting/index')}" is-close="true"><i class="layui-icon"></i><cite>系统配置</cite></a>
                  </dd>
                  <dd><a lay-id="6-6" data-url="{:U('Member/commission')}" is-close="true"><i class="layui-icon"></i><cite>代理佣金</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="ok-icon"></i><cite>会员管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="7-1" data-url="{:U('Membergroup/manage')}" is-close="true"><i class="layui-icon"></i><cite>会员组</cite></a>
                  </dd>
                  <dd><a lay-id="7-2" data-url="{:U('Member/manage')}" is-close="true"><i class="layui-icon"></i><cite>会员列表</cite></a>
                  </dd>
                  <dd><a lay-id="7-3" data-url="{:U('Member/sameipuser')}" is-close="true"><i class="layui-icon"></i><cite>同IP会员检测</cite></a>
                  </dd>
                  <dd><a lay-id="7-4" data-url="{:U('Member/fuddetail')}" is-close="true"><i class="layui-icon"></i><cite>账变记录</cite></a>
                  </dd>
                  <dd><a lay-id="7-5" data-url="{:U('Member/banklist')}" is-close="true"><i class="layui-icon"></i><cite>银行信息</cite></a>
                  </dd>
<!--                  <dd><a lay-id="7-6" data-url="{:U('Member/agentlink')}" is-close="true"><i class="layui-icon"></i><cite>代理注册链接</cite></a>-->
                  </dd>
                  <dd><a lay-id="7-7" data-url="{:U('Member/memlog')}" is-close="true"><i class="layui-icon"></i><cite>登录日志</cite></a>
                  </dd>
                  <dd><a lay-id="7-8" data-url="{:U('Member/waterlog')}" is-close="true"><i class="layui-icon"></i><cite>会员返水记录</cite></a>
                  </dd>
                  <dd><a lay-id="7-9" data-url="{:U('Member/message')}" is-close="true"><i class="layui-icon"></i><cite>站内信通知</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>游戏记录</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
<!--                  <dd><a lay-id="8-1" data-url="{:U('Zhenren/merchant')}" is-close="true"><i class="layui-icon"></i><cite>商户信息</cite></a>-->
                  </dd>
<!--                  <dd><a lay-id="8-2" data-url="{:U('Zhenren/transrecord')}" is-close="true"><i class="layui-icon"></i><cite>额度转让</cite></a>-->
                  <dd><a lay-id="8-3" data-url="{:U('Zhenren/zrOrder')}" is-close="true"><i class="layui-icon"></i><cite>真人记录</cite></a>
                  </dd>
				  <dd><a lay-id="8-4" data-url="{:U('Zhenren/cpOrder')}" is-close="true"><i class="layui-icon"></i><cite>彩票记录</cite></a>
                  </dd>
				  <dd><a lay-id="8-5" data-url="{:U('Zhenren/djOrder')}" is-close="true"><i class="layui-icon"></i><cite>电竞记录</cite></a>
                  </dd>
				  <dd><a lay-id="8-6" data-url="{:U('Zhenren/qpOrder')}" is-close="true"><i class="layui-icon"></i><cite>棋牌记录</cite></a>
                  </dd>
				  <dd><a lay-id="8-7" data-url="{:U('Zhenren/dyOrder')} is-close="true"><i class="layui-icon"></i><cite>电游记录</cite></a>
                  </dd>
				  <dd><a lay-id="8-8" data-url="{:U('Zhenren/tyOrder')} is-close="true"><i class="layui-icon"></i><cite>体育记录</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>管理员管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="9-1" data-url="{:U('Admingroup/manage')}" is-close="true"><i class="layui-icon"></i><cite>管理员组</cite></a>
                  </dd>
                  <dd><a lay-id="9-2" data-url="{:U('Adminmember/manage')}" is-close="true"><i class="layui-icon"></i><cite>管理员列表</cite></a>
                  </dd>
				  <dd><a lay-id="9-3" data-url="{:U('Adminmember/memlog')}" is-close="true"><i class="layui-icon"></i><cite>管理员日志</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="ok-icon"></i><cite>活动管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="10-1" data-url="{:U('System/zengsong')}" is-close="true"><i class="layui-icon"></i><cite>赠送活动</cite></a>
                  </dd>
                  <dd><a lay-id="10-2" data-url="{:U('Member/fanshui')}" is-close="true"><i class="layui-icon"></i><cite>每日加奖</cite></a>
                  </dd>
				  <dd><a lay-id="10-3" data-url="{:U('Member/jinjijiangli')}" is-close="true"><i class="layui-icon"></i><cite>晋级奖励</cite></a>
                  </dd>
				  <dd><a lay-id="10-4" data-url="{:U('Member/dailiyongjin')}" is-close="true"><i class="layui-icon"></i><cite>代理佣金</cite></a>
                  </dd>
              </dl>
          </li>
          <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>内容管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="11-1" data-url="{:U('News/category')}" is-close="true"><cite>资讯栏目管理</cite></a>
                  </dd>
                  <dd><a lay-id="11-2" data-url="{:U('News/manage')}" is-close="true"><cite>新闻资讯管理</cite></a>
                  </dd>
                  <dd><a lay-id="11-3" data-url="{:U('News/gonggao')}" is-close="true"><cite>网站公告管理</cite></a>
                  </dd>
              </dl>
          </li>
		  <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>运维管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="12-1" data-url="{:U('Yunwei/caiji')}" is-close="true"><cite>采集设置</cite></a>
                  </dd>
                  <dd><a lay-id="12-2" data-url="{:U('Yunwei/dbclear')}" is-close="true"><cite>数据清理</cite></a>
                  </dd>
                  <dd><a lay-id="12-3" data-url="{:U('Database/index',['type'=>'export'])}" is-close="true"><cite>数据库备份</cite></a>
                  </dd>
				  <dd><a lay-id="12-4" data-url="{:U('Database/index',['type'=>'import'])}" is-close="true"><cite>数据库还原</cite></a>
                  </dd>
				  <dd><a lay-id="12-5" data-url="{:U('Database/nization')}" is-close="true"><cite>数据备份同步</cite></a>
                  </dd>
				  <dd><a lay-id="12-6" data-url="{:U('Yunwei/jihua')}" is-close="true"><cite>计划任务</cite></a>
                  </dd>
				  <dd><a lay-id="12-7" data-url="{:U('Yunwei/yijianclear')}" is-close="true"><cite>一键清理数据</cite></a>
                  </dd>
              </dl>
          </li>
		  <li class="layui-nav-item"><a><i class="layui-icon"></i><cite>聊天室/动画管理</cite><span class="layui-nav-more"></span></a>
              <dl class="layui-nav-child">
                  <dd><a lay-id="13-1" data-url="{:U('Adminmember/chat')}" is-close="true"><cite>聊天室/动画管理</cite></a>
                  </dd>
              </dl>
          </li><span class="layui-nav-bar" style="top: 60px; height: 0px; opacity: 0;"></span>
        </ul>
      </div>
   </div>

   <!-- 内容主体区域 -->
   <div class="content-body">
      <div class="layui-tab ok-tab" lay-filter="ok-tab" lay-allowClose="true" lay-unauto>
         <div data-id="left" id="okLeftMove"
              class="ok-icon ok-icon-back okadmin-tabs-control move-left okNavMove"></div>
         <div data-id="right" id="okRightMove"
              class="ok-icon ok-icon-right okadmin-tabs-control move-right okNavMove"></div>
         <div class="layui-icon okadmin-tabs-control ok-right-nav-menu" style="right: 0;">
            <ul class="okadmin-tab">
               <li class="no-line okadmin-tab-item">
                  <div class="okadmin-link layui-icon-down" href="javascript:;"></div>
                  <dl id="tabAction" class="okadmin-tab-child layui-anim-upbit layui-anim">
                     <dd><a data-num="1" href="javascript:">关闭当前标签页</a></dd>
                     <dd><a data-num="2" href="javascript:">关闭其他标签页</a></dd>
                     <dd><a data-num="3" href="javascript:">关闭所有标签页</a></dd>
                  </dl>
               </li>
            </ul>
         </div>

         <ul id="tabTitle" class="layui-tab-title ok-tab-title not-scroll">
            <li class="layui-this" lay-id="1" tab="index">
               <i class="ok-icon">&#xe654;</i>
               <cite is-close=false>控制台</cite>
            </li>
         </ul>

         <div id="tabContent" class="layui-tab-content ok-tab-content">
            <div class="layui-tab-item layui-show">
               <iframe src="{:U('Tongji/gaikuang')}" frameborder="0" scrolling="yes" width="100%"
                       height="100%"></iframe>
            </div>
         </div>
      </div>
   </div>

   <!--底部信息-->
   <div class="layui-footer okadmin-text-center">
   </div>
</div>

<!-- 锁屏 -->
<div class="lock-screen">
   <div class="lock-bg">
      <img class="active lock-gradual" src="/static/img/login-bg.jpg" alt="" />
   </div>
   <div class="lock-content">
      <!--雪花-->
      <div class="snowflake">
         <canvas id="snowflake"></canvas>
      </div>
      <!--雪花 END-->
      <div class="time">
         <div>
            <div class="hhmmss"></div>
            <div class="yyyymmdd"></div>
         </div>
      </div>
      <div class="quit">
         <a class="layui-icon layui-icon-logout" href="{:U('Public/loginout')}" title="退出登录"></a>
      </div>
      <table class="unlock">
         <tr>
            <td>
               <div class="layui-form lock-form">
                  
                  <div class="layui-form-item">
                     <div class="layui-col-xs8 layui-col-sm8 layui-col-md8">
                        <input type="password"
                               required
                               lay-verify="required"
                               id="lockPassword"
                               name="lock_password"
                               style="border-radius: 0;border:0;height: 44px"
                               placeholder="请填写锁屏密码"
                               autocomplete="off"
                               class="layui-input" />
                     </div>
                     <div class="layui-col-xs4 layui-col-sm4 layui-col-md4">
                        <button style="width: 100%;box-sizing:border-box;border-radius: 0;"
                                type="button"
                                lay-submit
                                lay-filter="lockSubmit"
                                class="layui-btn lock-btn layui-btn-lg layui-btn-normal">确定</button>
                     </div>
                  </div>
               </div>
            </td>
         </tr>
      </table>
   </div>
</div>
<!--js逻辑-->
<script src="lib/layui/layui.js"></script>
<script src="js/snowflake.js?snowflake=雪花"></script>
<script src="js/okadmin.js"></script>
<script type="text/javascript" src="../Template/admin/resources/ui/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="../Template/admin/resources/ui/lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="../Template/admin/resources/ui/static/h-ui/js/H-ui.js"></script> 
<script type="text/javascript" src="../Template/admin/resources/ui/static/h-ui.admin/js/H-ui.admin.js"></script> 
<script type="text/javascript">
function article_add(title,url){
	layer_show(title,url);
}
loadAudioSource();
function loadAudioSource(num) {
	var audioHtml = '';
	audioHtml += '<audio controls id="audiotikuan" style="display:none;"><source src="../Template/admin/resources/audio/tikuan.mp3" type="audio/mpeg"></audio>';
	audioHtml += '<audio controls id="audiochongzhi" style="display:none;"><source src="../Template/admin/resources/audio/chongzhi.mp3" type="audio/mpeg"></audio>';
	audioHtml += '<audio controls id="audiobankbind" style="display:none;"><source src="../Template/admin/resources/audio/bankbind.mp3" type="audio/mpeg"></audio>';
	$("body").append(audioHtml);

}

// 播放提示声音
function audioPlay(name) {
	var audio = document.getElementById("audio" + name);
	if(!audio) {
		setTimeout(function(){
			audioPlay(name);
		}, 50);
		return false;
	}
	audio.play('tikuan');
}
function checkspeck(){
	$.getJSON("{:U('Index/checkspeck')}", function(data){
	   if(data.sign){
		   if(data.tkcount>0){
			   audioPlay('tikuan');
		   }else if(data.czcount>0){
			   audioPlay('chongzhi');
		   }else if(data.bankbindcount>0){
			   audioPlay('bankbind');
		   }
	   }
	});
}
window.setInterval("checkspeck();",10000);
</script> 
</body>
</html>
