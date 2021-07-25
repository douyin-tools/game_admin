<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>文件上传</title>

    <link href="/lib/layui/css/layui.css" rel="stylesheet" />
</head>

<body style="width:800px !important;">
<div class="layui-main"  style="width:800px !important;">
    <form class="layui-form" method="post" action="javascript:;">
        <div class="layui-form-item" style="margin-top:20px;">
            <label class="layui-form-label"></label>
            <div class="layui-inline">
                <div class="layui-upload-drag" id="upload">
                    <i class="layui-icon"></i>
                    <p>点击上传，或将文件拖拽到此处</p>
                </div>
            </div>
            <div class="layui-inline" id="upload_preview"></div>
        </div>
        <div class="layui-form-item" id="upload_progress">
            <label class="layui-form-label"></label>
            <div class="layui-input-inline" style="width:21%;">
                <div class="layui-progress" lay-showpercent="true" lay-filter="upload_progress">
                    <div class="layui-progress-bar layui-bg-blue" lay-percent="0%"></div>
                </div>
            </div>
        </div>

        <table class="layui-table file-list layui-hide">
            <tr>
                <td width="200">名称</td>
                <td width="80">大小</td>
                <td width="100">状态</td>
                <td width="50">操作</td>
            </tr>
        </table>
        <center>
            <button class="layui-btn all-upload layui-hide">上传</button>
        </center>

    </form>
</div>
</body>
<!--<script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>-->
<script type="text/javascript" src="../../plugins/jquery-1.4.4.min.js"></script>
<script src="https://www.layuicdn.com/layui/layui.js" type="text/javascript"></script>
<script>
    $(function() {

        layui.use(['layer', 'element', 'form', 'upload' ], function() {
            let layer = layui.layer,
                element = layui.element,
                form = layui.form,
                upload = layui.upload;

            var files;

            $('.layui-layer-close').click(function () {
                parent.location.reload();
            });

            //创建监听函数
            var xhrOnProgress = function(fun) {
                xhrOnProgress.onprogress = fun; //绑定监听
                //使用闭包实现监听绑
                return function() {
                    //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
                    var xhr = $.ajaxSettings.xhr();
                    //判断监听函数是否为函数
                    if (typeof xhrOnProgress.onprogress !== 'function')
                        return xhr;
                    //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
                    if (xhrOnProgress.onprogress && xhr.upload) {
                        xhr.upload.onprogress = xhrOnProgress.onprogress;
                    }
                    return xhr;
                }
            };

            upload.render({
                elem : '#upload',
                url : "{:U('upload', ['id' => $id])}",
                data : {},
                accept : 'file',
                size : 1024 * 500,
                auto : false,
                bindAction : ".all-upload",
                multiple : false,
                xhr: xhrOnProgress,
                progress:function(value){
                    if (value <= 80) {
                        element.progress('upload_progress', value+'%')
                    }
                },
                choose : function(obj) {
                    files = obj.pushFile();
                    $(".file-list").removeClass("layui-hide");
                    $(".all-upload").removeClass("layui-hide");
                    obj.preview(function(index, file, result) {
                        let tr = $([ "<tr id='upload-" + index + "'>",
                            "<td>" + file.name + "</td>",
                            "<td>" + (file.size / 1024).toFixed(1) + "KB</td>",
                            "<td>等待上传</td>",
                            "<td>",
                            "<button class='layui-btn layui-mini layui-btn-danger file-del'>删除</button>",
                            "</td>",
                            "</tr>" ].join(""));

                        tr.find(".file-reload").on("click", function() {
                            obj.upload(index, file);
                        })

                        tr.find(".file-del").on("click", function() {
                            delete files[index];
                            tr.remove();
                        })

                        $("table").append(tr);
                    });
                },
                allDone : function(obj) { //当文件全部被提交后，才触发
                    console.log(obj.total); //得到总文件数
                    console.log(obj.successful); //请求成功的文件数
                    console.log(obj.aborted); //请求失败的文件数
                },
                done : function(res, index, upload) { //上传后的回调
                    if (res.status == 1) { //上传成功
                        var upload_progress = 81;
                        setInterval(function () {
                            if (upload_progress > 100) {
                                var tr = $("table").find('tr#upload-' + index),
                                    tds = tr.children();
                                tds.eq(2).html("<span style='color:#5FB878;'>上传成功</span>");
                                tds.eq(3).html(""); //清空操作
                                delete files[index];
                                return
                            }
                            element.progress('upload_progress', upload_progress+'%')
                            upload_progress ++
                        },100);

                    } else {
                        var tr = $("table").find('tr#upload-' + index),
                            tds = tr.children();
                        tds.eq(2).html("<span style='color:#b8474f;'>" + res.info + "</span>");
                    }
                },
                error : function(index, upload) {
                    var tr = $("table").find('tr#upload-' + index),
                        tds = tr.children();
                    tds.eq(2).html("<span style='color:#FF5722;'>上传失败</span>")
                    tds.eq(3).find(".file-reload").removeClass("layui-hide"); //清空操作
                }
            })
        })
    })



</script>

</html>
