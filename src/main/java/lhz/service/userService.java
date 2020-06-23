package lhz.service;

import lhz.domain.User;
public interface userService {
    //登录查询用户帐号密码
    public User validateUser(String username,String password);
    //注册查询是否存在用户
    public User isUser(String registername);
    //修改个人信息
    public int updateInformation(User user);
    //通过id查询用户
    public User findById(int id);
    //修改密码
    public int updatePassword(int id,String oldPassoword,String newPassword);
    //注册用户
    public int insertUser(User user);
    //注册激活修改status
    public boolean active(String code);

}

