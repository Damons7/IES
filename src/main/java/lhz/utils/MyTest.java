package lhz.utils;
import lhz.dao.userDao;
import lhz.domain.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class MyTest {
//    @Test
//    public void testSpring(){
//        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
//        AccountService as = (AccountService) ac.getBean("accountService");
//        as.findAll();
//    }
//    @Test
//    public void testMyBatis() throws IOException {
//        InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
//        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
//        SqlSession session = factory.openSession();
//        AccountDao accountDao = session.getMapper(AccountDao.class);
//        List<Account> list = accountDao.findAll();
//        for(Account findaccount : list){
//            System.out.println(findaccount);
//        }
//        session.commit();
//        session.close();
//        in.close();
//    }
//    @Test
//    public void testMyBatisUser() throws IOException {
//        InputStream in = Resources.getResourceAsStream("SqlMapConfig.xml");
//        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
//        SqlSession session = factory.openSession();
//        userDao dao = session.getMapper(userDao.class);
//        List<User> list = dao.findAll();
//        for(User finduser : list){
//            System.out.println(finduser);
//        }
//        session.commit();
//        session.close();
//        in.close();
//    }
    @Test
    public void testMyBatisUser() throws IOException{
        String dd="dsada\"d\"ad#####1111111111111#####dsaaf1414#####jhf";
        String DS= dd.replace("\"","\\\"");
        String arr[]=DS.split("#####");
        for (int i=0;i<arr.length;i++){
            System.out.println("的："+arr[i]);
        }
    }
}
