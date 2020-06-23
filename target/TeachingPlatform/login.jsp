<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <title>智能考试平台</title>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="js/check_form.js"></script>
    <script type="text/javascript">
        //切换验证码
        function refreshCode(){
            //1.获取验证码图片对象
            var vcode = document.getElementById("vcode");
            //2.设置其src属性，加时间戳
            vcode.src = "/CheckCode?time="+new Date().getTime();
        }

    </script>
</head>

<body>

<div class="content">
    <div class="form sign-in" style="position: relative;">
        <h2>智能考试平台</h2>
        <form action="login" method="post">
        <label>
            <span>帐号</span>
            <input type="text" id="sss" name="username"/>
        </label>
        <label>
            <span>密码</span>
            <input type="password"id="ddd" name="password"/>
        </label>
        <p class="forgot-pass"><a href="javascript:alert('自己想办法');">忘记密码？</a></p>
        <button type="submit" class="submit">登 录</button>
        <button type="button" class="fb-btn">手机 <span>短信验证</span> 登录</button>
        </form>

        <!-- 出错显示的信息框 -->
        <div style="color:red;position: absolute; left: 270px; top: 400px;">
            <strong>${login_msg}</strong>

        </div>

    </div>

    <div class="sub-cont">
        <div class="img">
            <div class="img__text m--up">
                <h2>还未注册？</h2>
                <p>立即注册，开启学习之旅！</p>
            </div>
            <div class="img__text m--in">
                <h2>已有帐号？</h2>
                <p>有帐号就登录吧，好久不见了！</p>
            </div>
            <div class="img__btn">
                <span class="m--up">注 册</span>
                <span class="m--in">登 录</span>
            </div>
        </div>
        <div class="form sign-up" >
            <h2>立即注册</h2>
            <form action="/Register" method="post" onsubmit="return check()">
            <label>
                <span>帐号</span>
                <input type="text" name="username" id="registername" class="registername" onkeyup="value=value.replace(/[^/1-9a-zA-Z]/g,'')" />
                <span class="reg_sp1" id="reg_sp1"></span>
            </label>

            <label>
                <span>密码</span>
                <input type="password"  name="password" id="password" class="password"/>
                <span class="reg_sp2" id="reg_sp2"></span>
            </label>
                <label>
                    <span>邮箱</span>
                    <input type="text" name="email" id="email" class="email"/>
                    <span class="reg_sp3" id="reg_sp3"></span>
                </label>
            <label>
                <span>验证码</span>
                <input type="text" name="verifycode" class="verifycode" id ="verifycode"/>
                <span class="reg_sp4"><a href="javascript:refreshCode();">
                <img src="/CheckCode" title="看不清点击刷新" id="vcode" style="background-color: yellow;"/>
            </a>
                </span>
                <span class="reg_sp5" id="reg_sp5"></span>
            </label>
            <button type="submit" class="submit">注 册</button>
            <button type="button" class="fb-btn">手机 <span>短信验证</span> 注册</button>
            </form>
        </div>
    </div>
</div>
<script src="js/script.js"></script>

</body>

</html>
