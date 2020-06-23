package lhz.service;

import lhz.domain.MyGrade;
import lhz.domain.TestAnswer;
import lhz.domain.detailTest;
import lhz.domain.myTest;

import java.util.List;

public interface myTestService {
    //获取试卷题目
    public detailTest findTestQuestion(int id);
    //查询试卷答案
    public String findAnswer(String testname);
    ////录入分数
    public int insertGrade(int grade,String testname,String sno);
    ////录入分数
    public int insertGrade2(int grade ,String sno,String testname,String myanswer);
    //查询试卷信息
    public myTest findTest(String name);
    //查询未考试试卷
    public List<myTest> findNotyetTestList();
    //查询已考试试卷
    public myTest findAreadlyTest(String name);
    //查询已考试成绩
    public List<MyGrade> findAreadlyGradeList(String sno);
    //查询个人答案、分数
   public MyGrade getmyAnswer(String sno,String testname);

}
