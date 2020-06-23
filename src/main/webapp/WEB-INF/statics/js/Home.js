var flag=true;
//获取分数
function getMyGrade(allGrade,i,grade){
        var average=parseFloat(grade)/parseFloat(allGrade);
        if (average>=0.9){
            $(".myTestGradeText"+i).html("恭喜，新一代学霸诞生！");
        }else if (average>=0.8&&average<0.9){
            $(".myTestGradeText"+i).html("不错，继续努力！");
        }else if (average>=0.6&&average<0.8){
            $(".myTestGradeText"+i).html("要加把劲了！");
        }else if (average<0.6){
            $(".myTestGradeText"+i).html("不太行啊老铁！")
        }
        $(".myTestGrade"+i).html(grade);
}
//获取未考试
function getTest(username) {
    $.get("/getNotyetTestList",{sno:username},function (data) {
        if (data){
            data=JSON.parse(data);
            var jsonleng=getJsonLength(data);
            for(var i=0;i<jsonleng;i++) {
                var mydiv = '   <div class="myTestList">\n' +

                    '            <div class="testImg">\n' +
                    '                <img src="/img/test1.jpg">\n' +
                    '            </div>\n' +
                    '            <div class="testRight">\n' +

                    '                <div>\n' +
                    '                    <h5>'+data[i].name+'</h5>\n' +
                    '                </div>\n' +
                    '\n' +
                    '                <div>\n' +
                    '                    <span>题目数量：     ' + data[i].leng + '</span>\n' +
                    '                    <span class="testGrade">总分数：    ' + data[i].grade + '</span>\n' +
                    '                </div>\n' +
                    '\n' +
                    '                <div>\n' +
                    '                    <span>截止时间：     <span style="color: red">'+data[i].outtime+'</span></span>\n' +
                    '                    <span class="testTeacher">发布教师：    <span>'+data[i].teacher+'</span></span>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '            <div class="testButton">\n' +
                    '                <button id="gotestButton'+i+'" onclick=\''+'goTest("'+data[i].name+'")'+'\'>开始考试</button>\n' +
                    '            </div>\n' +
                    '        </div>';
                $("#notyetTestDiv").append(mydiv);
            }
        }else{
            alert("你已经提交过了！");

        }
    })
}
//获取已考试
function getAreadlyTest(username) {

    $.get("/getAreadlyTestList",{sno:username},function (data2) {
        if (data2){
            data2=JSON.parse(data2);
            var jsonleng=getJsonLength(data2);
            for(var i=0;i<jsonleng;i++) {
                var mydiv2 = '   <div class="myTestList">\n' +
                    '            <div class="testImg report">\n' +
                    '                <img src="/img/test1.jpg">\n' +
                    '            </div>\n' +
                    '            <div class="testRight report">\n' +
                    '                <div>\n' +
                    '                    <h5>'+data2[i].name+'</h5>\n' +
                    '                </div>\n' +
                    '\n' +
                    '                <div>\n' +
                    '                    <span>题目数量：     ' + data2[i].leng + '</span>\n' +
                    '                    <span class="testGrade">总分数：    ' + data2[i].grade + '</span>\n' +
                    '                </div>\n' +
                    '\n' +
                    '                <div>\n' +
                    '                    <span>截止时间：     <span style="color: red">'+data2[i].outtime+'</span></span>\n' +
                    '                    <span class="testTeacher">发布教师：    <span>'+data2[i].teacher+'</span></span>\n' +
                    '                </div>\n' +
                    '            </div>\n' +
                    '<div class="testButton report">\n' +
                    '                <div class="myTestGradeText myTestGradeText'+i+'"></div>\n' +
                    '                <div class="myTestGrade myTestGrade'+i+'"></div>\n' +
                    '                <div class="myGrade">作业成绩</div>\n' +
                    '            </div>'
                    '        </div>';
                $("#areadlyTestDiv").append(mydiv2);
                $(".report").attr("onclick","goGrade(\""+data2[i].name+"\")");

                getMyGrade(data2[i].grade,i,data2[i].studentgrade);

            }
        }
    })
}



//获取json长度
function getJsonLength(jsonData) {
    var length=0;
    for(var ever in jsonData) {
        length++;
    }
    return length;
}

//切换未考试、已考试
function testList(x) {

    if(x==1){
        $("#mtTestTitle").html("未考试");
        //考试列表变化
        $("#areadlyTest").removeClass("selectList");
        $("#areadlyTest").addClass("noselectList");
        $("#notyetTest").removeClass("noselectList");
        $("#notyetTest").addClass("selectList");
        $("#notyetTestBorder").addClass("border");
        $("#areadlyTestBorder").removeClass("border");

        $("#areadlyTestDiv").css("display","none");
        $("#notyetTestDiv").css("display","");

    }else if(x==2){
        $("#mtTestTitle").html("已考试");
        $("#notyetTest").removeClass("selectList");
        $("#notyetTest").addClass("noselectList");
        $("#areadlyTest").removeClass("noselectList");
        $("#areadlyTest").addClass("selectList");
        $("#areadlyTestBorder").addClass("border");
        $("#notyetTestBorder ").removeClass("border");

        $("#notyetTestDiv").css("display","none");
        $("#areadlyTestDiv").css("display","");

    }
}

function ExitLogin() {
    if(confirm('确定退出？')==false)
        return false;
    else
        window.location.href=('/exitUser');
}

function navigationFadeIn() {
    $(".navigation").fadeIn("slow");
    $(".bubbleTail").fadeIn("slow");
}
function navigationFadeOut() {
    $(".navigation").fadeOut("slow");
    $(".bubbleTail").fadeOut("slow");
}
//修改个人信息
function update_information(w1) {
    $("#up_email"), $("#up_phone").toggle(0,"swing",function () {
        if(w1===1){
            $("#up_phone").css("display","");
            $("#up_email").css("display","");
            $("#phone").css("display","none");
            $("#email").css("display","none");

            $("#returnInformation").css("display","");
            $("#up_information").css("display","none");

            $("#up_password").css("display","none");
            $("#up_information_sumbit").css("display","");
        } else if(w1===0)
        {

            $("#up_phone").css("display","none");
            $("#up_email").css("display","none");
            $("#phone").css("display","");
            $("#email").css("display","");

            $("#returnInformation").css("display","none");
            $("#up_information").css("display","");

            $("#up_password").css("display","");
            $("#up_information_sumbit").css("display","none");
        }
    })

}
//修改个人密码
function update_password(w2) {
    $("#information").toggle(0,"swing",function () {
        if(w2===1){
            $("#myModalLabel").html("我的密码信息");
            $("#information").css("display","none");
            $("#upd_password").css("display","");
            $("#up_password").css("display","none");
            $("#up_information").css("display","none");
            $("#up_password_sumbit").css("display","");
            $("#returnPassword").css("display","");

        } else if(w2===0)
        {
            $("#myModalLabel").html("我的个人信息");
            $("#information").css("display","");
            $("#upd_password").css("display","none");

            $("#up_password").css("display","");
            $("#up_information").css("display","");
            $("#up_password_sumbit").css("display","none");
            $("#returnPassword").css("display","none");
        }
    })
}


$(function () {
    $("#head").mouseenter(function (){
        $(".headInformation").css("display","");
    })
    $("#head").mouseleave(function () {
            $(".headInformation").css("display","none");
        })

    $("#navigationImg").mouseover(function (){
        navigationFadeIn();
    })
    $(".navigationDiv").mouseleave(function () {
        navigationFadeOut();
    })
})