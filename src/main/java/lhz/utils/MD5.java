package lhz.utils;
import org.apache.commons.codec.digest.DigestUtils;
import java.util.UUID;
public class MD5 {
    public static String uuid = UUID.randomUUID().toString().replace("-", "");
    //创建md5对象

    public static String createMd5Code(String code) {
        return DigestUtils.md5Hex(code);
    }
    //进行密码校验
    public static boolean checkPassword(String userCode, String dbCode) {
        if (dbCode.equals(createMd5Code(userCode))) {
            return true;
        } else {
            return false;
        }
    }

    public static String getUUID() {
        return uuid;
    }
    public static String getSalt() {
        String salt = uuid.substring(0, 5);
        return salt;
    }

}
