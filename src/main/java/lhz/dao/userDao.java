package lhz.dao;
import lhz.domain.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface userDao {
    @Select("select * from user where username=#{username}")
    public User findByUsernamePassword(String username);

    @Select("select * from user where username=#{registername}")
    public User isUser(String registername);

    @Update("update user set phone=#{phone},email=#{email} where id=#{id}")
    public int updateInformation(User user);

    @Select("select * from user where id=#{id}")
    public User findById(int id);

    @Update("update user set password=#{newPassword} where id=#{id}")
    public int updatePassword(@Param("newPassword")String newPassword,@Param("id") int id);

    @Insert("insert into user(username,password,phone,email,code,status)value(#{username},#{password},#{phone},#{email},#{code},#{status})")
    public int insertUser(User user);

    @Select("select * from user where code =#{code} ")
    public User findByCode(String code);

    @Update("update user set status ='Y' where id=#{id}")
    public void updateStatus(int id);


}

