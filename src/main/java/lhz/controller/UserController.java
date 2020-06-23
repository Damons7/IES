package lhz.controller;
import lhz.domain.User;;
import lhz.service.userService;
import lhz.utils.getCheckCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

@Controller

public class UserController {
    @Autowired
    userService userservice;

    @RequestMapping("/login")
    public String loginMethod(String username, String password, HttpServletRequest request ) {

        if (username == "" || username.length() <= 0){
            //提示信息
            request.getSession().setAttribute("login_msg", "用户名不能为空！");
            //跳转登录页面
            return "redirect:/login.jsp";
        }else if (password == "" || password.length() <= 0){
            //提示信息
            request.getSession().setAttribute("login_msg", "密码不能为空！");
            //跳转登录页面
            return "redirect:/login.jsp";
        }else  {
            User user=null;
            try {
                user=userservice.validateUser(username, password);
            }catch (Exception e){
                e.printStackTrace();
            }
            if (user==null){
                request.getSession().setAttribute("login_msg", "用户名或密码错误！");
                return "redirect:/login.jsp";
            }else if(user.getStatus().equals("N")){
                request.getSession().setAttribute("login_msg", "该用户尚未激活！");
                return "redirect:/login.jsp";
            }else
            {
                request.getSession().setAttribute("user",user);
            }
            return "home";
        }

    }

    @RequestMapping("/isUser")
    public @ResponseBody String isUserMethod(@RequestParam String registername ) {
        System.out.println("ajax-->" + registername);
        User user = new User();
        try {
            user = userservice.isUser(registername);
        }catch (Exception e){
            e.printStackTrace();
        }
        String reg="true";
        if(user!=null){
            System.out.println("用户存在");
            reg="true";
        }else {
            System.out.println("用户不存在");
            reg="false";
        }
        return reg;

    }

    //验证码功能
    @RequestMapping("/CheckCode")
    public void CheckCodeMethod(HttpServletRequest request, HttpServletResponse response) {
        //服务器通知浏览器不要缓存
        response.setHeader("pragma", "no-cache");
        response.setHeader("cache-control", "no-cache");
        response.setHeader("expires", "0");
        //在内存中创建一个长80，宽30的图片，默认黑色背景
        //参数一：长
        //参数二：宽
        //参数三：颜色
        int width = 125;
        int height = 46;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        //获取画笔
        Graphics g = image.getGraphics();
        //设置画笔颜色
        g.setColor(Color.white);
        //填充图片
        g.fillRect(0, 0, width, height);

        //产生4个随机验证码，12Ey
        getCheckCode code=new getCheckCode();
        String checkCode = code.getCheckCode();
        //将验证码放入HttpSession中
        request.getSession().setAttribute("CHECKCODE_SERVER", checkCode);

        //设置画笔颜色为黄色
        g.setColor(new Color(66, 139, 202));
        //设置字体的小大
        g.setFont(new Font("黑体", Font.BOLD, 30));
        //向图片上写入验证码
        g.drawString(checkCode, 15, 25);

        //将内存中的图片输出到浏览器
        //参数一：图片对象
        //参数二：图片的格式，如PNG,JPG,GIF
        //参数三：图片输出到哪里去
        try {
            ImageIO.write(image, "PNG", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    // 注册功能
    @RequestMapping("/Register")
    public void RegisterMethod(String verifycode,User user,HttpServletRequest request,HttpServletResponse response) {
//        String verifycode = request.getParameter("verifycode");
        //3.验证码校验
        System.out.println("user："+user.getPassword());
        System.out.println("user："+user.getUsername());
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = null;

        session.removeAttribute("CHECKCODE_SERVER");//确保验证码一次性
        if (!checkcode_server.equalsIgnoreCase(verifycode)) {
            //验证码不正确
            //提示信息
            //跳转登录页面
            try {
                out = response.getWriter();
            } catch (IOException e) {
                e.printStackTrace();
            }
            out.print("<script language=\"javascript\">alert('验证码错误！');window.location.href='/login.jsp'</script>");
           } else {
            //5.调用Service查询
            int a = userservice.insertUser(user);
            if (a != 0) {
                try {
                    out = response.getWriter();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                out.print("<script language=\"javascript\">alert('注册成功，请前往邮箱激活！');window.location.href='/login.jsp'</script>");
              } else {
                try {
                    out = response.getWriter();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                out.print("<script language=\"javascript\">alert('注册失败，服务器维护中！');window.location.href='/login.jsp'</script>");
            }

        }
    }
  //   注册激活功能
    @RequestMapping("/ActiveRegister.do")
    public void ActiveRegisterMethod(String code,HttpServletRequest request, HttpServletResponse response) {
        code = request.getParameter("code");
        if (code != null) {
            //2.调用service完成激活
            boolean flag = userservice.active(code);
            //3.判断标记
            String msg = null;
            if (flag) {
                //激活成功
                msg = "激活成功，请<a href='login.jsp'>登录</a>";
            } else {
                //激活失败
                msg = "激活失败，请联系管理员!";
            }
            response.setContentType("text/html;charset=utf-8");
            try {
                response.getWriter().write(msg);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/exitUser")
    public String exitUserMethod( HttpServletRequest request) {
        request.getSession().invalidate();
        System.out.println("已退出帐号");
        return "redirect:/login.jsp";
    }

    @RequestMapping("/updateInformation")
    public @ResponseBody int updateInformationMethod( User user, HttpServletRequest request) {
      int a= userservice.updateInformation(user);
      if(a!=0){
          User user2=null;
          try {
              user2= userservice.findById(user.getId());
          }catch (Exception e){
              e.printStackTrace();
              System.err.println("找不到id对应的用户");
          }
          if (user2!=null){
              request.getSession().removeAttribute("user");
              request.getSession().setAttribute("user",user2);
          }
      }
      return a;
    }

    @RequestMapping("/updatePassword")
    public @ResponseBody int updatePasswordMethod( String id,String oldPassword,String newPassword) {
        int a= userservice.updatePassword(Integer.parseInt(id),oldPassword,newPassword);
        return a;
    }

}
