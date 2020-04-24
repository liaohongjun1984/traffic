package com.devops.suc.util;

import java.io.ByteArrayOutputStream;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;

import javax.mail.BodyPart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

public class MailUtil {
	
	private static Logger logger = Logger.getLogger(MailUtil.class);  
	
	/**
	 * 
	 * @param mailbody
	 * @param toSet 多个用逗号分隔
	 * @throws Exception
	 */
	public static void sendMail(String hostName,String userName,String password,String mailbody,String toSetMail,String subject) throws Exception{
		
		logger.info("host:"+hostName);
		logger.info("userName:"+userName);
		logger.info("password:"+password);
		logger.info("mailbody:"+mailbody);
		logger.info("toSetMail:"+toSetMail);
		logger.info("subject:"+subject);
		
		Properties props = System.getProperties(); 
		props.put("mail.smtp.host", hostName);  
    	props.put("mail.smtp.auth", "true"); 
		//用props对象来创建并初始化session对象  
		Session session = Session.getDefaultInstance(props, new MyAuthenticator(userName,password));
		// 用session对象来创建并初始化邮件对象  
		MimeMessage mimeMsg = new MimeMessage(session);  
		// 生成附件组件的实例  
		MimeMultipart mp = new MimeMultipart("related"); 
		//设置邮件主题 
		mimeMsg.setSubject(subject);
        //设置邮件体,在组件上添加邮件文本             
        BodyPart bpBody = new MimeBodyPart();
        bpBody.setContent("<meta http-equiv=Content-Type content=text/html; charset=UTF-8>" + mailbody, "text/html;charset=UTF-8");
        mp.addBodyPart(bpBody); 
       
        //生成邮件内容
        mimeMsg.setContent(mp);
        mimeMsg.saveChanges();
        
        ByteArrayOutputStream os=new ByteArrayOutputStream();
        mimeMsg.writeTo(os);    
       
        Set<InternetAddress> toSet = new HashSet<InternetAddress>();
        mimeMsg.setFrom(new InternetAddress(userName)); 
        for(String s : toSetMail.split(",")){
        	  toSet.add(new InternetAddress(s));
        }  
        mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
        
        try{
        	Transport.send(mimeMsg);
        }catch (Exception ex) {
        	ex.printStackTrace();
		}
     
	}
}
