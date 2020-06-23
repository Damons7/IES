package lhz.service.impl;

import lhz.dao.myTestDao;
import lhz.domain.MyGrade;
import lhz.domain.detailTest;
import lhz.domain.myTest;
import lhz.service.myTestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("myTestservice")
public class myTestServiceImpl implements myTestService {
    @Autowired
    myTestDao dao;
    @Override
    public detailTest findTestQuestion(int id){
        return dao.findTestQuestion(id);
    }
    @Override
    public String findAnswer(String testname) {
        return dao.findAnswer(testname);
    }

    @Override
    public int insertGrade(int grade,String testname,String sno)
    {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowtime=now_time.format(new Date());
        return dao.insertGrade(grade,testname,sno,nowtime);
    }

    @Override
    public int insertGrade2(int grade ,String sno,String testname,String myanswer)
    {
        SimpleDateFormat now_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowtime=now_time.format(new Date());
        return dao.insertGrade2(grade,nowtime,myanswer,sno,testname);
    }

    @Override
    public myTest findTest(String name) {
        return dao.findTest(name);
    }

    @Override
    public List<myTest> findNotyetTestList() {
        return dao.findNotyetTestList();
    }

    @Override
    public MyGrade getmyAnswer(String sno,String testname) {
        return dao.getmyAnswer(sno,testname);
    }


    @Override
    public myTest findAreadlyTest(String name) {
        return dao.findAreadlyTest(name);
    }

    @Override
    public List<MyGrade> findAreadlyGradeList(String sno) {
        return dao.findAreadlyGradeList(sno);
    }

}
