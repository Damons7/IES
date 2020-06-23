package lhz.dao;
import lhz.domain.MyGrade;
import lhz.domain.TestAnswer;
import lhz.domain.detailTest;
import lhz.domain.myTest;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface myTestDao {
    //查询试卷题目
    @Select("select * from detailtest where testid=#{id}")
    public detailTest findTestQuestion(int id);

    //查询试卷答案
    @Select("select answer from testanswer where testname=#{testname}")
    public String findAnswer(String testname);

    //录入成绩
    @Insert("insert into sc(sno,testname,grade,addtime) values(#{sno},#{testname},#{grade},#{nowtime})")
    public int insertGrade(@Param("grade")int grade,@Param("testname")String testname ,@Param("sno")String sno ,@Param("nowtime")String nowtime);

    //录入成绩
    @Update("update sc set grade=#{grade},addtime=#{nowtime},myanswer=#{myanswer} where sno=#{sno} and testname=#{testname}")
    public int insertGrade2(@Param("grade")int grade ,@Param("nowtime")String nowtime,@Param("myanswer")String myanswer,@Param("sno")String sno,@Param("testname")String testname);
    //查询试卷信息
    @Select("select * from mytest where name=#{name}")
    public myTest findTest(String name);

    //修改试卷状态为已考试(consitions=0)
//    @Update("update mytest set consitions=0 where name=#{textname}")
//    public int UpdateConsitions(String textname);

    //查询未试卷信息
    @Select("select * from mytest where consitions=1")
    public List<myTest> findNotyetTestList();

    //查询已考试试卷信息
    @Select("select * from mytest where name=#{name}")
    public myTest findAreadlyTest(String name);

    //查询已考试分数
    @Select("select * from sc where sno=#{sno}")
    public List<MyGrade> findAreadlyGradeList(String sno);

    //查询个人答案、分数
    @Select("select *from sc where sno=#{sno} and testname=#{testname}")
    public MyGrade getmyAnswer(@Param("sno")String sno,@Param("testname")String testname);
}
