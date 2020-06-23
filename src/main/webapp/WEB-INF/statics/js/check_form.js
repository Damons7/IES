//定义一个全局变量：作来标记具体的是什么错误，如果这个变量 是0说明没有信息问题，可以注册
var a = "1";
var b = "2";
var c = "3";
var d = "4";
var e= "5";
var f= "6";
var g="7";
var h="8";
// 用户名正则
function checkUserame() {
    var register = $("#registername").val();
    var message = "";
    var flag = false;
    // 完成正则匹配
    if (register.length < 0 || register.length === 0) {
        a = "1";// 修改全局变量
        message = "帐号不能为空！";
        $("#registername").css("border-bottom", "0.2px solid red");
    } else if (register.length > 0) {
        a = "0";
        flag = true;
        $("#registername").css("border", "");
    }
    if (flag) {
        $("#reg_sp1").text(message).css('color', '#0000ff');
        var json = {
            "registername": $("#registername").val()
        };
        $.get("http://localhost:8080/isUser", json, function (data) {

            if (data == "true") {
                a = "1";
                $("#reg_sp1").text("帐号已存在").css('color', '#f53808');
            } else {
                $("#reg_sp1").text("✔").css('color', '#0000ff');
                a = "0";
            }
        });
    } else {
        $("#reg_sp1").text(message).css('color', '#f53808');
    }

}
function checkPassword(){
    var len = $("#password").val();
    var reg_password=/^[0-9a-zA-Z]+$/;
    var message = "";
    var flag = false;
    if (len.length < 0 || len.length === 0) {
        b = "2";// 修改全局变量
        message = "密码为空！";
        $("#password").css("border-bottom", "0.2px solid red");
    }
    else if(!reg_password.test(len)) {
        b = "2";// 修改全局变量
        message = "密码只能是数字和字母！";
        $("#password").css("border-bottom", "0.2px solid red");
    }
    else if (len.length < 6) {
        b = "2";// 修改全局变量
        message = "密码不能少于6位！";
        $("#password").css("border-bottom", "0.2px solid red");
    }
    else if (len.length > 16) {
        b = "2";// 修改全局变量
        message = "密码不能大于16位！";
        $("#password").css("border-bottom", "0.2px solid red");
    }
    else {
        b = "0";// 修改全局变量
        flag = true;
        $("#password").css("border", "");
    }
    if (flag) {
        $("#reg_sp2").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp2").text(message).css('color', '#f53808');
    }
}
function checkEmail(){
    var email = $("#email").val();
    var message = "";
    var reg_email=/[0-9a-zA-Z_]{0,19}@[0-9a-zA-Z]{1,13}\.[com,cn,net]{1,3}/gi;
    var flag = false;
    if (email.length < 0 || email.length === 0) {
        d = "4";// 修改全局变量
        message = "请输入邮箱!";
        $("#email").css("border-bottom", "0.2px solid red");
    } else if (!reg_email.test(email)) {
        d = "4";// 修改全局变量
        message = "邮箱格式错误!";
        $("#email").css("border-bottom", "0.2px solid red");
    }else {
        d = "0";// 修改全局变量
        flag = true;
        $("#email").css("border", "");
    }
    if (flag) {
        $("#reg_sp3").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp3  ").text(message).css('color', '#f53808');
    }

}
function checkVerifycode() {
    var verifycode = $("#verifycode").val();
    var message = "";
    var flag = false;
    if (verifycode.length < 0 || verifycode.length === 0) {
        e = "5";// 修改全局变量
        message = "验证码为空!";
        $("#verifycode").css("border-bottom", "0.2px solid red");
    } else {
        e = "0";// 修改全局变量
        flag = true;
        $("#verifycode").css("border", "");

    }
    if (flag) {
        $("#reg_sp5").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp5").text(message).css('color', '#f53808');
    }
}

function checkUpdatePhone() {
    var phone = $("#input_phone").val();
    var reg_phone = /^1[345678][0-9]{9}$/;
    var message = "";
    var flag = false;
    if (!reg_phone.test(phone)) {
        c= "3";// 修改全局变量
        message = "手机号格式错误!"
    } else {
        c= "0";// 修改全局变量
        flag = true;
    }
    if (flag) {
        $("#reg_sp6").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp6").text(message).css('color', '#f53808');
    }

}
function checkUpdateEmail() {
    var email = $("#input_email").val();
    var message = "";
    var reg_email=/[0-9a-zA-Z_]{0,19}@[0-9a-zA-Z]{1,13}\.[com,cn,net]{1,3}/gi;
    var flag = false;
    if (email.length < 0 || email.length === 0) {
        f= "6";// 修改全局变量
        message = "请输入邮箱!";
    } else if (!reg_email.test(email)) {
        f = "6";// 修改全局变量
        message = "邮箱格式错误!";
    }else {
        f = "0";// 修改全局变量
        flag = true;
        $("#input_email").css("border", "");
    }
    if (flag) {
        $("#reg_sp7").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp7  ").text(message).css('color', '#f53808');
    }
}

function checkUpdateOldPassword() {
    var len = $("#old_password").val();
    var reg_old_password=/^[0-9a-zA-Z]+$/;
    var message = "";
    var flag = false;
    if (len.length < 0 || len.length === 0) {
        h = "8";// 修改全局变量
        message = "密码为空！";
    }
    else if(!reg_old_password.test(len)){
        h = "8";// 修改全局变量
        message = "密码只能为数字和字母！";
    }
    else if (len.length < 6) {
        h = "8";// 修改全局变量
        message = "密码不能少于6位！";
    }
    else if (len.length >16) {
        h = "8";// 修改全局变量
        message = "密码不能多于16位！";
    }
    else {
        h = "0";// 修改全局变量
        flag = true;

    }
    if (flag) {
        $("#reg_sp8").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp8").text(message).css('color', '#f53808');
    }

}
function checkUpdateNewPassword(){
    var len = $("#new_password").val();
    var reg_new_password = /^[0-9a-zA-Z]+$/;
    var message = "";
    var flag = false;
    if (len.length < 0 || len.length === 0) {
        g = "7";// 修改全局变量
        message = "密码为空！";
    }
    else if(!reg_new_password.test(len)){
        g = "7";// 修改全局变量
        message = "密码只能为数字和字母！";
    }
    else if (len.length < 6) {
        g = "7";// 修改全局变量
        message = "密码不能少于6位！";
    }
    else if (len.length >16) {
        g = "7";// 修改全局变量
        message = "密码不能多于16位！";
    }
    else {
        g = "0";// 修改全局变量
        flag = true;
    }
    if (flag) {
        $("#reg_sp9").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp9").text(message).css('color', '#f53808');
    }

}
function checkUpdateNewPassword2(){
    var p1 = $("#new_password").val();
    var p2 = $("#new_password2").val();
    var message = "";
    var flag = false;
    if (p1 != p2) {
        c = "3";// 修改全局变量
        message = "两次密码不一样！";
    } else {
        c = "0";// 修改全局变量
        flag = true;
    }
    if (flag) {
        $("#reg_sp10").text(message).css('color', '#0000ff');
    } else {
        $("#reg_sp10").text(message).css('color', '#f53808');
    }
}
$(function() {
        $("#registername").blur(function () {
            checkUserame();
    });

        $(document).keydown(function (event) {
            if (event.keyCode == 13) {
                checkUserame();
            }
        });

        $("#password").blur(function () {
            checkPassword();
        });

        $("#email").blur(function () {
            checkEmail();
        });

        $("#verifycode").blur(function () {
            checkVerifycode();
        });

        $("#input_phone").blur(function () {
            checkUpdatePhone();
        });

        $("#input_email").blur(function () {
            checkUpdateEmail();
        });

        $("#old_password").blur(function () {
            checkUpdateOldPassword();
    });

        $("#new_password").blur(function () {
            checkUpdateNewPassword();
    });

        $("#new_password2").blur(function () {
            checkUpdateNewPassword2();
    });



    });


    function check() {


        if (a == 1) {
            alert("用户信息有误!请检查后重新输入!")
            return false;
        }
        if (b == 2) {
            alert("密码信息有误!请检查后重新输入!")
            return false;
        }
        if (d == 4) {
            alert("邮箱输入有误!请检查后重新输入!")
            return false;
        }
        if (e == 5) {
            alert("验证码为空!")
            return false;
        }
    }
    function check_up_password(){
        checkUpdateOldPassword();
        checkUpdateNewPassword();
        checkUpdateNewPassword2();
    if (g == 7||c==3||h==8) {
        alert("密码信息错误!请检查后重新输入!");
        return false;
    }
    else
        return true;
}
    function check_up_information(){
        checkUpdatePhone();
        checkUpdateEmail();
    if ( f== 6) {
        alert("邮箱信息错误!请检查后重新输入!")
        return false;
    } if (c == 3) {
        alert("手机信息错误!请检查后重新输入!")
        return false;
    }
    return true;
}