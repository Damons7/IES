<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/6/11
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/myTest.css">
    <link rel="stylesheet" href="css/myAnswer.css">
    <script type="text/javascript" src="js/jquery-1.12.3.min.js"></script>
    <title>智能考试平台</title>
    <script>
        function getA(leng) {
            var myleng=parseInt(leng);
            for  (var i=1;i<=myleng;i++){

                var  test1a=$('<a id="que_'+i+'byA" href="#que_'+i+'"type="button" class="btn btn-default aa">'+i+'</a>');
                $("#danxuan").append(test1a);
            }
        }
        function getmyTest(testid,testleng,gradeAll) {
            var leng=parseInt(testleng);
            var grade=parseInt(gradeAll);
            grade=grade/leng;
            $.get("/getTestQuestion",{id:testid},function (data) {

                data=JSON.parse(data);
                for (var i=1;i<=leng;i++){
                    var mytest1Div='<div id="que_'+i+'" class="mySubjectDiv">\n' +
                        '            <ul>\n' +
                        '                <%--每道题--%>\n' +
                        '                <li>\n' +
                        '                    <div class="subject">\n' +
                        '                    <i>'+i+'</i>\n' +
                        '                    <%--具体题目--%>\n' +
                        '                        <div class="question">\n' +

                        '                            <span>('+grade+'分)</span> '+data["ques"+i]+'\n' +
                        '                           <div class="everyAnswer">正确答案：<span class="realAnswer'+i+'"></span>' +
                        '                           <div>你的答案：<span class="myAnswer'+i+'"></span></div></div>' +
                        '                        </div>\n' +
                        '                    </div>\n' +
                        '                    <ul class="selectUl">\n' +
                        '                        <%--选项--%>\n' +
                        '                            <label for="'+i+'_que_1_option">\n' +
                        '                        <li>\n' +
                        '                            <input id="'+i+'_que_1_option" value="'+i+',1" type="radio" name="'+i+'_que"/>\n' +
                        '                            A.<P id="A_FROM_'+i+'"></P>\n' +
                        '                        </li></label>\n' +
                        '                            <label for="'+i+'_que_2_option">\n' +
                        '                        <li>\n' +
                        '                            <input id="'+i+'_que_2_option" value="'+i+',2" type="radio" name="'+i+'_que">\n' +
                        '                            B.<P id="B_FROM_'+i+'"></P>\n' +
                        '                        </li></label>\n' +
                        '                            <label for="'+i+'_que_3_option">\n' +
                        '                        <li>\n' +
                        '                            <input id="'+i+'_que_3_option" value="'+i+',3"type="radio" name="'+i+'_que"/>\n' +
                        '                            C.<P id="C_FROM_'+i+'"></P>\n' +
                        '                        </li></label>\n' +
                        '                            <label for="'+i+'_que_4_option">\n' +
                        '                        <li>\n' +
                        '                            <input id="'+i+'_que_4_option" value="'+i+',4" type="radio" name="'+i+'_que"/>\n' +
                        '                            D.<P id="D_FROM_'+i+'"></P>\n' +
                        '                        </li></label>\n' +
                        '                    </ul>\n' +
                        '                </li>\n' +
                        '            </ul>\n' +
                        '        </div>'
                    test1Div=$(mytest1Div);
                    $(".myleft").append(test1Div);
                    $("#A_FROM_"+i).text(data["answer"+i].A);
                    $("#B_FROM_"+i).text(data["answer"+i].B);
                    $("#C_FROM_"+i).text(data["answer"+i].C);
                    $("#D_FROM_"+i).text(data["answer"+i].D);
                }
            })
        }
        function getRealAnswer(testname) {
            $.ajax({
                url: "/getRealAnswer",
                type: "post",
                data: {testname: testname},
                async: false,
                success: function (data) {
                    var answerArr = data.split(",");
                    for (var i = 1; i <= answerArr.length; i++) {
                        switch (answerArr[i - 1]) {
                            case "1":
                                $(".realAnswer" + i).html("A");
                                $(":radio[id='" + i + "_que_1_option']").prop("checked", "checked");
                                break;
                            case "2":
                                $(".realAnswer" + i).html("B");
                                $(":radio[id='" + i + "_que_2_option']").prop("checked", "checked");
                                break;
                            case "3":
                                $(".realAnswer" + i).html("C");
                                $(":radio[id='" + i + "_que_3_option']").prop("checked", "checked");
                                break;
                            case "4":
                                $(".realAnswer" + i).html("D");
                                $(":radio[id='" + i + "_que_4_option']").prop("checked", "checked");
                                break;
                        }

                    }
                }
            });
        }


        function getmyAnswer(sno,testname) {
            $.ajax({
                url: "/getmyAnswer",
                type: "post",
                data: {sno: sno, testname: testname},
                async: false,
                success: function (data) {
                    data = JSON.parse(data);
                    $("#mythisgrade").html(data.grade);
                    var answerArr2 = data.myanswer.split(",");
                    for (var i = 1; i <= answerArr2.length; i++) {

                        switch (answerArr2[i - 1]) {
                            case "1":
                                $(".myAnswer" + i).html("A");
                                break;
                            case "2":
                                $(".myAnswer" + i).html("B");
                                break;
                            case "3":
                                $(".myAnswer" + i).html("C");
                                break;
                            case "4":
                                $(".myAnswer" + i).html("D");
                                break;
                        }

                        if (($(".myAnswer" + i).html() != $(".realAnswer" + i).html())) {
                            var ssda = '<img src="/img/error.png" style="opacity: 0.9;position: absolute;top: 1px;left: 3px">';
                            $("#que_" + i + "byA").append(ssda);
                        }
                    }
                }
            });
        }

        $(function () {
            getA("${leng}");
            getmyTest("${testid}","${leng}","${grade}");
            <%--getRealAnswer("${testname}");--%>
            <%--getmyAnswer("${sno}","${testname}");--%>
            var testname="${testname}";
            var sno="${sno}";
            var ajax1=$.ajax({
                url: "/getAnswer",
                type: "post",
                data:{sno:sno,testname:testname},
                success: function (data) {
                    data=JSON.parse(data);
                    $("#mythisgrade").html(data.grade);
                    var answerArr1=data.realanswer.split(",");
                    var answerArr2=data.myanswer.split(",");

                    for (var i=1;i<=answerArr1.length;i++){
                        switch (answerArr1[i-1]) {
                            case "1":$(".realAnswer"+i).html("A");$(":radio[id='"+i+"_que_1_option']").prop("checked", "checked");break;
                            case "2":$(".realAnswer"+i).html("B");$(":radio[id='"+i+"_que_2_option']").prop("checked", "checked");break;
                            case "3":$(".realAnswer"+i).html("C");$(":radio[id='"+i+"_que_3_option']").prop("checked", "checked");break;
                            case "4":$(".realAnswer"+i).html("D");$(":radio[id='"+i+"_que_4_option']").prop("checked", "checked");break;
                        }
                        switch (answerArr2[i-1]) {
                            case "1":$(".myAnswer"+i).html("A");break;
                            case "2":$(".myAnswer"+i).html("B");break;
                            case "3":$(".myAnswer"+i).html("C");break;
                            case "4":$(".myAnswer"+i).html("D");break;
                        }
                    }
                }
            });
            var len="${leng}";
            len=parseInt(len);
            $.when(ajax1).done(function () {
                for (var i=1;i<=len;i++){
                    if (($(".myAnswer"+i).html()!=$(".realAnswer"+i).html())){
                        var errorimg='<img src="/img/error.png" style="opacity: 0.9;position: absolute;top: 1px;left: 3px">';
                        $("#que_"+i+"byA").append(errorimg);
                    }else{
                        var rightimg='<img src="/img/right.png" style="opacity: 0.9;position: absolute;top: 1px;left: 3px">';
                        $("#que_"+i+"byA").append(rightimg);
                    }
                }
                $(":radio").attr("disabled",true);

            });
        })
    </script>
</head>
<body>
<div class="row" style="margin-bottom: 5px;margin-top: 15px;">
    <h4>${testname}</h4>
    <h4><span>学号：${sno}</span>
        <span> <img class="answerlogo" src="/img/logo.png" >  分数：<span id="mythisgrade"></span></span>
    </h4>
</div>

<div class="row">
    <%--左区域--%>
    <div class="col-md-9">
        <div>
            <div class="myleft">
                <div class="mytitle">
                    <span>单选题</span>

                    <span>共${leng}题，合计${grade}分</span>
                </div>
            </div>

        </div>

    </div>
    <%--右侧区域--%>
    <div class="col-md-3">
        <div class="myright">
            <%--答题卡--%>
            <div style="border-bottom:  1px solid #e4e4e4;">
            <span class="card" >
                答题卡
            </span>
                <span class="time">
                end：
                <span class="hour">00</span>:
                <span class="minute"> 00</span>:
                <span class="second">00</span>
            </span>
            </div>
            <%--单选题--%>
            <div style="border-bottom:  1px solid #e4e4e4;">
            <span class="singleChoiceSpan">
               单选题
            </span>
                <span class="testAcount">
                共${leng}道题
            </span>
            </div>
            <%--具体题目链接--%>
            <div class="singleChoice" id="danxuan">

            </div>

        </div>
    </div>

</div>

</body>
</html>

