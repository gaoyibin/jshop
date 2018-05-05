package net.jeeshop.core.mail;

import net.jeeshop.core.front.SystemManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;
import java.util.Vector;


/**
 * Created by gaoyibin on 2016/8/5.
 */
public class MailUtil {

    Logger logger = LoggerFactory.getLogger(MailUtil.class);
    // 定义发件人、收件人、主题等
    String to = null;
    String from = null;
    String password = null;
    String host = null;
    String user = null;
    String filename = null;
    //	String subject = null;

    // 做一个可以传发件人等参数的构造
    public MailUtil(String to, String from,String password, String smtpServer, String subject) {
        // 初始化发件人、收件人、主题等
        this.to = to;
        this.from = from;
        this.password = password;
        this.host = smtpServer;
        this.user = from;
//		this.subject = subject;
    }

    public MailUtil(String to){
        this.to = to;
        this.from = SystemManager.getInstance().getSystemSetting().getEmailAccount();//SystemManager.getInstance().getProperty("from_email_account");
        this.user = this.from;
        this.password = SystemManager.getInstance().getSystemSetting().getEmailPassword();//SystemManager.getInstance().getProperty("from_email_password");
        this.host = SystemManager.getInstance().getSystemSetting().getEmailSmtpServer();//SystemManager.getInstance().getProperty("from_eamil_smtpServer");
//		this.subject = subject;
    }

    public boolean startSend(String mailTitle,
                                String mailContent){
        boolean success = false;
        try {
            Properties props = new Properties(); //可以加载一个配置文件
            // 使用smtp：简单邮件传输协议
            props.put("mail.smtp.host", host);//存储发送邮件服务器的信息
            props.put("mail.smtp.auth", "true");//同时通过验证

            Session session = Session.getInstance(props);//根据属性新建一个邮件会话
//        session.setDebug(true); //有他会打印一些调试信息。

            MimeMessage message = new MimeMessage(session);//由邮件会话新建一个消息对象
            message.setFrom(new InternetAddress(from));//设置发件人的地址
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(this.to));//设置收件人,并设置其接收类型为TO
            message.setSubject(mailTitle);//设置标题
            //设置信件内容
//        message.setText(mailContent); //发送 纯文本 邮件 todo
            message.setContent(mailContent, "text/html;charset=gbk"); //发送HTML邮件，内容样式比较丰富
            message.setSentDate(new Date());//设置发信时间
            message.saveChanges();//存储邮件信息

            //发送邮件
//        Transport transport = session.getTransport("smtp");
            Transport transport = session.getTransport("smtp");
            transport.connect(user, password);
            transport.sendMessage(message, message.getAllRecipients());//发送邮件,其中第二个参数是所有已设好的收件人地址
            transport.close();
            success  = true;
        }catch (Exception e){
            logger.error(e.getMessage(),e);
        }
        return success;
    }

    public static void main(String[] args) throws Exception {
        MailUtil mailUtil = new MailUtil("381527417@qq.com","gao_yi_bin@163.com", "gyb890901",
                "smtp.163.com",null);
        mailUtil.startSend(
                "Java Mail 测试邮件",
                "<a>html 元素</a>：<b>邮件内容</b>");
    }
}
