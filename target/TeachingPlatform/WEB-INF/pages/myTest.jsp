<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/6/1
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/myTest.css">
    <script type="text/javascript" src="js/jquery-1.12.3.min.js"></script>
    <title>智能考试平台</title>
<style>
    html,body{
        cursor: url('/img/pen.png'),auto;
    }
</style>
    <script>
        window.history.forward(1);
        var inputTime=new Date();
        var nowM=inputTime.getMinutes();
        inputTime.setMinutes(nowM+1 );
        var teleng="${leng}";
        teleng=parseInt(teleng);
        var queArr=new Array(teleng);

        function mytimes()
        {
            var nowtime=new Date();
            var times=(inputTime-nowtime)/1000;
            var h=parseInt(times/60/60%24);
            h=h<10 ? '0'+h : h;
            $(".hour").html(h);
            var m=parseInt(times/60%60);
            m=m<10?'0'+m:m;
            $(".minute").html(m);
            var s=parseInt(times%60);
            s=s<10?'0'+s:s;
            $(".second").html(s);

            if (h=="00"&&m=="00"&&s=="00"){
                clearInterval(mytime);
                $("#Getsubmit").removeAttr("onclick");
                $("#Getsubmit").attr("onclick","GetAutomysubmit()");
                $("#Getsubmit").trigger("click");
            }
        }
        function getA(testleng) {

            var leng=parseInt(testleng);
            for  (var i=1;i<=leng;i++){

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

                $(':radio').click(function(){
                    var checkValue = $(this).val();
                    var indexArr= checkValue.split(",");
                    queArr[parseInt(indexArr[0])-1]=checkValue;
                    var ids=this.id.split("_");
                    $("#que_"+ids[0]+"byA").css("background-color","#389FC3");
                });
            })
        }
        function myAnswer() {
            var arrAnswer=new Array(teleng);
            for (var i=0;i<teleng;i++){
                if (queArr[i]){
                    var arrs = queArr[i].split(",");
                    arrAnswer[i]=arrs[1];
                }else{
                    arrAnswer[i]="0";
                }

            }
            var grade=parseInt("${grade}")/teleng;
            var data={
                "sno":"${sno}","testname":"${testname}",
                "myAnswer":arrAnswer.join(","),
                "grade":grade};
            $.get("submitTest", {
                mySelect: JSON.stringify(data)
            }, function (myGrade) {
                if (myGrade!=0){
                    alert("已提交");
                    window.location.href=("/getGradeReport?testname=${testname}&sno=${user.username}");
                }else
                {
                   alert("提交失败，请联系负责人！");
                }

            });
        }
        function Getmysubmit() {
            if(confirm('确定交卷？')==false)
                return false;
            else{
                $("#Getsubmit").attr("disabled", "disabled");
                myAnswer();
            }
        }
        function GetAutomysubmit() {
            $("#Getsubmit").attr("disabled", "disabled");
            myAnswer();

        }
        $(function () {
            mytimes();
            mytime=setInterval(mytimes,1000);
            getA("${leng}");
            getmyTest("${testid}","${leng}","${grade}");
        })
    </script>
</head>
<body>
<div class="row" style="margin-top: 15px;margin-bottom: 5px;">
    <h4>${testname}</h4>
    <h4>${sno}</h4>
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
        <%--底部区域--%>
        <%--交卷--%>
        <div class="mybottom">
            <button  id="Getsubmit" class="btn btn-primary btn-lg" onclick="Getmysubmit()"> 交卷</button>
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
                <span class="minute">00 </span>:
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
