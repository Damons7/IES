package lhz.controller;
        import com.fasterxml.jackson.databind.ObjectMapper;
        import lhz.domain.*;
        import lhz.service.myTestService;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.stereotype.Controller;
        import org.springframework.web.bind.annotation.RequestMapping;
        import org.springframework.web.bind.annotation.RequestParam;
        import org.springframework.web.bind.annotation.ResponseBody;
        import org.springframework.web.servlet.ModelAndView;
        import java.io.IOException;
        import java.util.List;

@Controller
public class myTestController {
    @Autowired
    myTestService myTestservice;
    @RequestMapping("/submitTest")
    public @ResponseBody int submitTestMethod(@RequestParam String mySelect) throws IOException {
        try {
            mySelect = new String(mySelect.getBytes("ISO-8859-1"), "UTF-8");
        }catch (Exception e){
            e.printStackTrace();
        }
        ObjectMapper mapper = new ObjectMapper();
        Answer answer= mapper.readValue(mySelect, Answer.class);
        String testname=answer.getTestname();//考试名称
        String testAnswer=myTestservice.findAnswer(testname);

        int grade=0;
        int everyGrde=answer.getGrade();
        String testAnswerArr[]=testAnswer.split(",");
//        String myQuestionArr[]=answer.getMyQuestion().split(",");
        String myAnswerArr[]=answer.getMyAnswer().split(",");
        for (int i=0;i<testAnswerArr.length;i++){
                if (myAnswerArr[i].equals(testAnswerArr[i])){
                    grade+=everyGrde;
                }
        }
        System.out.println("myanswer:"+answer.getMyAnswer());

        int myGrade=myTestservice.insertGrade2(grade,answer.getSno(),testname,answer.getMyAnswer());
        return myGrade;
    }

    @RequestMapping("/getTest")
    public ModelAndView getTestMethod(@RequestParam String testname, String sno, ModelAndView mv) {
        try {
            testname = new String(testname.getBytes("ISO-8859-1"), "UTF-8");
        }catch (Exception e){
            e.printStackTrace();
        }
        myTest mytest=myTestservice.findTest(testname);
        mv.addObject("testname",mytest.getName());
        mv.addObject("leng",mytest.getLeng());
        mv.addObject("grade",mytest.getGrade());
        mv.addObject("testid",mytest.getId());
        mv.addObject("sno",sno);
        mv.setViewName("myTest");
        //表明点击考试后便录入成绩（以防止恶意退出重新开始）
        myTestservice.insertGrade(0,testname,sno);
        return mv;
    }

    @RequestMapping("/getGradeReport")
    public ModelAndView getGradeReportMethod(@RequestParam String testname, String sno, ModelAndView mv) {
        try {
            testname = new String(testname.getBytes("ISO-8859-1"), "UTF-8");
        }catch (Exception e){
            e.printStackTrace();
        }
        myTest mytest=myTestservice.findTest(testname);
        mv.addObject("testname",mytest.getName());
        mv.addObject("leng",mytest.getLeng());
        mv.addObject("grade",mytest.getGrade());
        mv.addObject("testid",mytest.getId());
        mv.addObject("sno",sno);
        mv.setViewName("myAnswer");
        return mv;
    }

    @RequestMapping("/getAnswer")
    public @ResponseBody String getmyAnswerMethod(@RequestParam String sno,String testname ) {
        MyGrade grade= myTestservice.getmyAnswer(sno,testname);
            String realanswer=myTestservice.findAnswer(testname);
            String json="{\"grade\":"+grade.getGrade()+",\"myanswer\":\""+grade.getMyanswer()+"\",\"realanswer\":\""+realanswer+"\"}";
            System.out.println("成绩单："+json);
            return json;
    }

    @RequestMapping(value = "/getTestQuestion",produces ="application/text;charset=utf-8")
    public @ResponseBody String getTestQuestionMethod(@RequestParam String id) {
        detailTest mytest=myTestservice.findTestQuestion(Integer.parseInt(id));
        String question=mytest.getQuestion().replace("\"","\\\"");
        String answer=mytest.getAnswer();
        String questionArr[]=question.split("#####");
        String myAnswerArr[]=answer.split(",\n");
        String json="";
        int d=0;
        json+="{";
        for (int i=0;i<questionArr.length;i++){
            json=json+"\"ques"+(i+1)+"\":\""+questionArr[i].trim()+"\",\"answer"+(i+1)+"\":"+myAnswerArr[i].trim();
            if (i<questionArr.length-1){
                json+=",";
            }
        }
        json+="}";

        return json;
    }

    @RequestMapping(value = "/getNotyetTestList",produces ="application/text;charset=utf-8")
    public @ResponseBody String getNotyetTestListMethod(String sno) {
        List<MyGrade> gradeList= myTestservice.findAreadlyGradeList(sno);
        List<myTest> list= myTestservice.findNotyetTestList();
        String s1="[";String s2="]";
        String json="";
        String ss="";
        ObjectMapper mapper = new ObjectMapper();
        try {
            for (int i = 0; i < list.size(); i++) {
                myTest test = list.get(i);
                int x = 0;//排查
                if (gradeList.size() > 0) {
                    for (int j = 0; j < gradeList.size(); j++) {
                        MyGrade mygrade = gradeList.get(j);
                        if (!mygrade.getTestname().equals(test.getName())) {
                            x++;
                            if (x == gradeList.size()) {
                                if (ss.length() > 0) {
                                    ss += ",";
                                }
                                json = mapper.writeValueAsString(test);
                                ss += json;
                            }
                        }
                    }
                } else {
                    json = mapper.writeValueAsString(test);
                    ss += json;
                    if (i<list.size()-1) {
                        ss += ",";
                    }
                }
            }
            ss = s1 + ss + s2;
            System.out.println("看看未考试json：" + ss);
        }catch (Exception e){
            e.printStackTrace();
        }
        return ss;
    }

    @RequestMapping(value = "/getAreadlyTestList",produces ="application/text;charset=utf-8")
    public @ResponseBody String getAreadlyTestListMethod(@RequestParam String sno)
    {
        List<MyGrade> gradeList= myTestservice.findAreadlyGradeList(sno);
        String json="";
        String ss="";
        String s1="[";
        String s2="]";
        for (int j=0;j<gradeList.size();j++){
            MyGrade mygrade =  gradeList.get(j);
            myTest list= myTestservice.findAreadlyTest(mygrade.getTestname());
            list.setStudentgrade(mygrade.getGrade());
            try {
                ObjectMapper mapper = new ObjectMapper();
                json=mapper.writeValueAsString(list);
                ss+=json;
                if (j<gradeList.size()-1){
                    ss+=",";
                };

            }catch (Exception e){
                e.printStackTrace();
            }
        }
        ss=s1+ss+s2;
        System.out.println("看下已考试json："+ss);
        return ss;
    }

//    @RequestMapping(value = "/getMyGrade",produces ="application/text;charset=utf-8")
//    public @ResponseBody String getMyGradeMethod(@RequestParam String testname) {
//        try {
//            testname = new String(testname.getBytes("ISO-8859-1"), "UTF-8");
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        return myTestservice.findMyGrade(testname);
//    }
}

