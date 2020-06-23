

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<html>
<head>
    <title>L智能考试平台</title>
    <script type="text/javascript" src="js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="js/Home.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/check_form.js"></script>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/Home.css">
    <script>
        //开始考试按钮
        function goTest(thisname) {
            if (flag){
                window.open("/getTest?testname="+thisname+"&sno=${user.username}");
                flag=false;
                $("."+this.id).prop("disabled", true);
            }
            else{
                alert("请忽重复点击！");
            }
        }
        //查询成绩单按钮
        function goGrade(thisname) {
            window.open("/getGradeReport?testname="+thisname+"&sno=${user.username}");
        }
        //ajax修改信息
        function update_information_sumbit() {
            if (check_up_information()){
                $.post("/updateInformation", {id:${user.id}, phone:$("#input_phone").val(), email:$("#input_email").val()},
                    function (a) {
                        if (a!=0){
                            alert("修改成功！");
                        }else{
                            alert("修改失败！服务器维护中。。。");
                        }
                    })
            }

        }
        //修改密码
        function update_password_sumbit() {
            if (check_up_password()){
                $.post("/updatePassword", {id:${user.id}, oldPassword:$("#old_password").val(), newPassword:$("#new_password").val()},
                    function (a) {
                        if (a!=0){
                            alert("修改成功！");
                            window.location.href=('/exitUser');
                        }else{
                            alert("原密码错误");
                        }
                    })
            }

        }

        $(function (){
            //获取未考试
            getTest("${user.username}");
            //获取已考试
            getAreadlyTest("${user.username}");
        })

    </script>
</head>
<body>

<%--顶部--%>
<div class="homeTop">
    <%--logo部分--%>
    <div class="logo">
        <img src="/img/logo.png">
        <span>L智能考试平台</span>
    </div>
    <%--头像信息--%>
    <div class="head" id="head">
        <span>${user.name}</span>
        <img src="/img/head.jpg">

        <%--鼠标移至显示更多个人信息--%>
        <div class="headInformation"style="display:none;">
            <ul class="headInformationUl">
                <li data-toggle="modal" data-target="#myModal"><img src="/img/information.png"/>个人信息</li>
                <li onclick="ExitLogin()"><img src="/img/quit.png"/>安全退出</li>
            </ul>

        </div>
    </div>
</div>
<%--具体页面标题信息--%>
<div class="bodyTitle">
    <span style="font-weight: bold
">考试列表</span>
    <img src="/img/icon.png">
    <span id="mtTestTitle">未考试</span>
</div>
<%--具体页面--%>
<div class="myBody">
    <div class="myBodyTitle">
        <ul>
            <li id="notyetTest" class="selectList" onclick="testList(1)">未考试<div id="notyetTestBorder" class="border"></div></li>
            <li id="areadlyTest" class="noselectList"onclick="testList(2)">已考试<div id="areadlyTestBorder"></div></li>
        </ul>
    </div>

    <%--未考试列表--%>
    <div id="notyetTestDiv"></div>

    <%--已考试列表--%>
    <div id="areadlyTestDiv" style="display: none">

    </div>

    <%--右侧导航--%>
    <div class="navigationDiv">
        <img src="/img/navigation.png" id="navigationImg">
        <div class="navigation" style="display: none">
            <ul>
                <li data-toggle="modal" data-target="#myModal"><img src="/img/information.png"/>我的信息</li>
                <li onclick="testList(1)"><img src="/img/testlogo.png"/>考试列表</li>
                <li data-toggle="modal" data-target="#myModal"><img src="/img/aboutlogo.png"/>关于我们</li>
            </ul>
        </div>
        <div class="bubbleTail"style="display: none"></div>
    </div>
</div>


<div class="row">
    <div class="foot-style">
        <p>吉林大学珠海学院软件1711班李鸿智  版权所有Copyright 2020-2021, All Rights Reserved 04172505</p>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel" style="text-align:center;margin-left: 100px">
                    我的个人信息
                </h4>
            </div>
            <%--显示管理员信息--%>
            <div class="modal-body" id="information">
                <div class="row mymodal" >
                    <div class="col-md-5">帐号：</div>
                    <div class="col-md-7">${user.username}</div>
                </div>
                <div class="row mymodal" >
                    <div class="col-md-5">姓名：</div>
                    <div class="col-md-7" > ${user.name}</div>
                </div>
                <div class="row mymodal">
                    <div class="col-md-5">性别：</div>
                    <div class="col-md-7"> ${user.sex}</div>
                </div>
                <div class="row mymodal" >
                    <div class="col-md-5">电话：</div>
                    <div class="col-md-7"  id="phone">${user.phone}</div>
                    <div class="col-md-7 up_information" style="display: none;" id="up_phone">
                        <input type="text" name="phone" id="input_phone" value="${user.phone}" class="form-control" style="width: 200px;height: 22px;">
                        <span class="reg_spInfor" id="reg_sp6"></span>
                    </div>
                </div>
                <div class="row mymodal" style="margin-bottom:35px;">
                    <div class="col-md-5">邮箱：</div>
                    <div class="col-md-7" id="email">${user.email}</div>
                    <div class="col-md-7 up_information" style="text-align:left;display: none;" id="up_email">
                        <input type="email" id="input_email" name="email" value="${user.email}" class="form-control upd_email" style="width: 200px;height: 22px;">
                        <span class="reg_spInfor" id="reg_sp7"></span>
                    </div>
                </div>

            </div>
            <%--显示修改密码信息--%>
            <form action="/updatePassword" method="post">
            <div class="modal-body" id="upd_password" style="display: none;">
                <div class="row" style="margin-top: 35px">
                    <div class="col-md-5"style="text-align: right">原始密码：</div>
                    <div class="col-md-7 up_information" style="text-align:left;">
                        <input type="text" name="old_password" id="old_password" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
                        <span class="reg_spInfor" id="reg_sp8"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 35px">
                    <div class="col-md-5"style="text-align: right">新密码：</div>
                    <div class="col-md-7 up_information" style="text-align:left;" >
                        <input type="text" name="new_password" id="new_password" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
                        <span class="reg_spInfor" id="reg_sp9"></span>
                    </div>
                </div>

                <div class="row" style="margin-top: 35px;margin-bottom:35px;">
                    <div class="col-md-5"style="text-align: right">确认密码：</div>
                    <div class="col-md-7 up_information" style="text-align:left;" >
                        <input type="text" name="new_password2" id="new_password2" placeholder="请输入6-16位密码" class="form-control" style="width: 200px;height: 22px;">
                        <span class="reg_spInfor" id="reg_sp10"></span>
                    </div>
                </div>

            </div>

            <div class="modal-footer" style="text-align: center">
                <button type="button" class="btn btn-default" onclick="update_information(1);" id="up_information">修改信息</button>
                <button type="button" class="btn btn-default" onclick="update_password(1);"id="up_password">修改密码</button>
                <button type="button" class="btn btn-default" onclick="update_information(0);" style="display: none;" id="returnInformation">返回</button>
                <button type="button" class="btn btn-default" onclick="update_password(0);" style="display: none;" id="returnPassword">返回</button>
                <button type="button" class="btn btn-default" onclick="update_password_sumbit();"style="display: none;" id="up_password_sumbit">提交</button>
                <button type="button" class="btn btn-default" onclick="update_information_sumbit();" style="display: none;" id="up_information_sumbit">提交</button>
            </div>
            </form>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>