package com.devops.suc.util;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

import com.devops.suc.cfg.SucCommConfig;


public class SendEmail {
	private static Logger logger = Logger.getLogger(SendEmail.class);
	
	public static void main(String[] args) throws MessagingException, IOException{
		send("123456","465087012@qq.com");
	}
	public static void send(String pwd,String email) throws MessagingException, IOException{
		
    	logger.info("Received request to update person");
		Properties props = System.getProperties(); 
		props.put("mail.smtp.host", "smtp.189.cn");  
    	props.put("mail.smtp.auth", "true"); 
		//用props对象来创建并初始化session对象  
		Session session = Session.getDefaultInstance(props, new MyAuthenticator("care10000@189.cn","care#kf2012"));
		// 用session对象来创建并初始化邮件对象  
		MimeMessage mimeMsg = new MimeMessage(session);  
		// 生成附件组件的实例  
		MimeMultipart mp = new MimeMultipart("related"); 
		//设置邮件主题 
		mimeMsg.setSubject("天翼关爱,密码找回");
		
        //设置邮件体,在组件上添加邮件文本             
        BodyPart bpBody = new MimeBodyPart();
        String mailbody = "您刚进行密码找回操作，密码是："+pwd+"，请妥善保管.";
        bpBody.setContent("<meta http-equiv=Content-Type content=text/html; charset=UTF-8>" + mailbody, "text/html;charset=UTF-8");
        mp.addBodyPart(bpBody); 
        
       
        //生成邮件内容
        mimeMsg.setContent(mp);
        mimeMsg.saveChanges();
        
        ByteArrayOutputStream os=new ByteArrayOutputStream();
        mimeMsg.writeTo(os);    
        mimeMsg.setFrom(new InternetAddress("care10000@189.cn")); 
        Set<InternetAddress> toSet = new HashSet<InternetAddress>();
        toSet.add(new InternetAddress(email));
        mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
        try{
        	Transport.send(mimeMsg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	if (ex instanceof SendFailedException) {
        		SendFailedException sfex = (SendFailedException)ex;
        		 Address[] invalid = sfex.getInvalidAddresses();
        		 if (invalid != null) {
        	            System.out.println("    ** Invalid Addresses");
        	            if (invalid != null) {
        	              for (int i = 0; i < invalid.length; i++){
        	                System.out.println("         " + invalid[i]);
        	                toSet.remove(invalid[i]);
        	              }
        	         }
        	    }
        	}
		}
	}
}
