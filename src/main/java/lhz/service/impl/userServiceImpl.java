package lhz.service.impl;
import lhz.dao.userDao;
import lhz.domain.User;
import lhz.service.userService;
import lhz.utils.MD5;
import lhz.utils.MailUtils;
import lhz.utils.UuidUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("userservice")
public class userServiceImpl implements userService {
    @Autowired
    userDao dao;
    @Override
    public User validateUser(String username, String password) {
         password=MD5.createMd5Code(password+"lhz123");
         User user = dao.findByUsernamePassword(username);
        if (user!=null){
            if (user.getPassword().equals(password)){
                return user;
            }else{
                return null;
            }
        }
        else {
            return null;
        }
    }
    @Override
    public User isUser(String registername) {
        return dao.isUser(registername);
    }
    //修改个人信息
    @Override
    public int updateInformation(User user) {
        return dao.updateInformation(user);
    }

    @Override
    public User findById(int id) {
        return dao.findById(id);
    }

    //
    @Override
    public int updatePassword(int id,String oldPassword,String newPassword) {
        User user=null;
        int a=0;
        oldPassword=MD5.createMd5Code(oldPassword+"lhz123");
        newPassword=MD5.createMd5Code(newPassword+"lhz123");
       try {
            user=dao.findById(id);
       }catch (Exception e){
           e.printStackTrace();
       }
       if (user!=null){
           if(user.getPassword().equals(oldPassword)){
              a= dao.updatePassword(newPassword,id);
           }  else{
               a=0;
           }
       }

       return a;
    }

    @Override
    public int insertUser(User user) {
        //加密密码
        user.setPassword(MD5.createMd5Code(user.getPassword()+"lhz123"));
        //设置激活码
        user.setCode(UuidUtil.getUuid());
        //设置激活状态
        user.setStatus("N");
        int a=dao.insertUser(user);
        String content="<a href='http://localhost:8080/ActiveRegister.do?code="+user.getCode()+"'>点击激活【智能考试平台】</a>";
        MailUtils.sendMail(user.getEmail(),content,"激活邮件");
        return a;
    }

    @Override
    public boolean active(String code) {
        //1.根据激活码查询用户对象
        User user =dao.findByCode(code);
        if(user != null){
            //2.调用dao的修改激活状态的方法
            dao.updateStatus(user.getId());
            return true;
        }else{
            return false;
        }

    }


}

