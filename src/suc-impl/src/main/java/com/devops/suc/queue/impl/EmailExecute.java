package com.devops.suc.queue.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.mail.Address;
import javax.mail.AuthenticationFailedException;
import javax.mail.BodyPart;
import javax.mail.PasswordAuthentication;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.devops.suc.dao.SendLogDao;
import com.devops.suc.model.Queue;
import com.devops.suc.model.SendLog;
import com.devops.suc.queue.ExecutableQueue;
import com.devops.suc.queue.QueueType;
import com.idhoo.dhutil.spring.SpringContextUtil;

public class EmailExecute extends ExecutableQueue {

	private static Logger logger = Logger.getLogger(EmailExecute.class);
	SendLogDao sendLogDao = (SendLogDao) SpringContextUtil.getBean("sendLogDao");
	@Override
	public int execute(Queue queue) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(queue.toString()).append(",");
    	try{
    		String data = queue.getData();
    		JSONObject object = (JSONObject) JSONValue.parse(data);
        	String hostName = (String)object.get("hostName");
    		String userName = (String)object.get("userName");
    		String password = (String)object.get("password");
    		String from     = (String)object.get("from");
    		
        	Properties props = System.getProperties();  
        	props.put("mail.smtp.host", hostName);  
        	props.put("mail.smtp.auth", "true"); 
        	
	       //真正的连接邮件服务器并进行身份验证  
	       Session mailSession = Session.getInstance(props, new MyAuthenticator(userName,password));  
	       Transport transport = mailSession.getTransport("smtp"); 
	       transport.connect(props.getProperty("mail.smtp.host"), userName,password);  
	      
	       ByteArrayInputStream is=new ByteArrayInputStream(queue.getMessage().getBytes());
	       MimeMessage mimeMsg = new MimeMessage(mailSession,is); 
	       //设置发件人地址 
	       mimeMsg.setFrom(new InternetAddress(from));  
	       
	       //设置收件人地址 ,如果不拆成Set，则其中有一个邮件出错，都会收不到。同时过虑掉重复的邮件
	       List<String> fiterAddr = new ArrayList<String>();
	       Set<InternetAddress> toSet = new HashSet<InternetAddress>();
	       for(String rec : queue.getRecipient().split(",")){
	    	   for(String r : rec.split(";")){
	    		   if(!fiterAddr.contains(r)){
	    			   try{
		    			   toSet.add(new InternetAddress(r));
		    			   fiterAddr.add(r);
	    			   }catch(Exception e) {
		    			   buffer.append("error address:" + r+",reason:"+e.getMessage()).append(",");
		    		   }
	    		   }
	    	   }
	       }
	       mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
	      
	       //抄送人
	       Set<InternetAddress> ccSet = new HashSet<InternetAddress>();
	       if(queue.getCc()!=null&&!queue.getCc().equals("")){
	    	   for(String cc : queue.getCc().split(",")){
		    		   for(String r : cc.split(";")){
		    			   if(!fiterAddr.contains(r)){
			    		   try{
			    			   ccSet.add(new InternetAddress(r));
			    			   fiterAddr.add(r);
			    		   }catch(Exception e) {
			    			   buffer.append("error address:" + r+",reason:"+e.getMessage()).append(",");
			    		   }
		    		   }
		    	   }
	    	   }
	    	  mimeMsg.setRecipients(javax.mail.Message.RecipientType.CC, (InternetAddress[]) ccSet.toArray(new InternetAddress[ccSet.size()]));  
	       }
	       String result = "true";
	       String invalidAddress = "";
	       //当某个地址出错时，会引起Recipient address rejected: User unknown in virtual mailbox table异常
	       //异常产生时，转换为按单个人发
	       try{
	    	   buffer.append("send Email,");
		      //CC和TO一起发送的功能
		      Transport.send(mimeMsg);	
		      //logger.info("邮件发送："+BeanUtils.describe(queue)); 
	       }catch(Exception ex){
	    	   buffer.append("send Email err,"+ex.getMessage()).append(",");
//	    	   logger.error(buffer,ex);
	    	   if (ex instanceof SendFailedException) {
	        		SendFailedException sfex = (SendFailedException)ex;
	        		 Address[] invalid = sfex.getInvalidAddresses();
	        		 if (invalid != null) {
	        	            
	        	            if (invalid != null) {
	        	              for (int i = 0; i < invalid.length; i++){
	        	              
	        	                invalidAddress = invalidAddress + invalid[i]+",";
	        	                toSet.remove(invalid[i]);
	        	                ccSet.remove(invalid[i]);
	        	              }
	        	         }
	        	    }
	        	 if(toSet.size() != 0 && ccSet.size()!=0){
		    		 mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
		    		 mimeMsg.setRecipients(javax.mail.Message.RecipientType.CC, (InternetAddress[]) ccSet.toArray(new InternetAddress[ccSet.size()]));
		    		 Transport.send(mimeMsg);
	        	 }
	    	  }
	    	 buffer.append("** Invalid Addresses:"+invalidAddress).append(",");
	    	 
	    	 result = "** Invalid Addresses:"+invalidAddress;
	    	 if(invalidAddress.length()!=0){
	    		 buffer.append("send error email,");
	    		 String to = queue.getCreate_admin();
//	    		 if(to == null)
//	    			 to = "dw_wangxichun";
	    		 buffer.append("notice org user=").append(to).append(",");
	    		 this.sendErrorMsg(userName, password, to+"@devop.com", invalidAddress.substring(0,invalidAddress.length()-1), mimeMsg.getSubject(), from, hostName);		
	    	 }
	    	 logger.error(buffer.toString(),ex);
	    	 this.setLog(queue, result); 
	    	 return 0;
	       }
	       logger.info(buffer.toString());
	       this.setLog(queue, result);
	       return 0;
		  
       }catch (Exception e) {
    	   buffer.append("send Email err"+e.getMessage()).append(",");
    	   
    	   String result = e.getLocalizedMessage();
    	   if (e instanceof AuthenticationFailedException){
    		   result = "javax.mail.AuthenticationFailedException:用户名或密码不正确";
    		   buffer.append(result);
    	   }
    	   logger.error(buffer,e);
    	   this.setLog(queue, result);
    	   return 0;
       }
//       logger.info(buffer.toString());
//	   return 0;
	}
	
	private void setLog(Queue queue,String result){
		  SendLog sendLog = new SendLog();
	      sendLog.setQueue_id(queue.getQueue_id());
	      sendLog.setRecipient(queue.getRecipient());
	      sendLog.setCc(queue.getCc());
	      sendLog.setSubject(queue.getSubject());
	      sendLog.setMessage(queue.getMessage());
	      sendLog.setExecute_time(new Date());
	      sendLog.setQueue_type(QueueType.EMAIL);
	      sendLog.setCreate_time(queue.getCreate_time());
	      sendLog.setLast_modify(queue.getLast_modify());
	      sendLog.setData(queue.getData());
	      sendLog.setResult(result);
	      sendLog.setQueue_index(queue.getQueue_index());
	      sendLogDao.add(sendLog);
	}
	
	private void sendErrorMsg(String userName,String password,String to,
			String content,String subject,String from,String hostName) throws Exception{
		
    	logger.info("Received request to update person");
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
		mimeMsg.setSubject("Undelivered Mail Returned to Sender");
		
        //设置邮件体,在组件上添加邮件文本             
        BodyPart bpBody = new MimeBodyPart();
        String mailbody = "你的邮件\""+subject+"\"发送地址有错误，错误地址为"+content;
        bpBody.setContent("<meta http-equiv=Content-Type content=text/html; charset=UTF-8>" + mailbody, "text/html;charset=UTF-8");
        mp.addBodyPart(bpBody); 
        
       
        //生成邮件内容
        mimeMsg.setContent(mp);
        mimeMsg.saveChanges();
        
        ByteArrayOutputStream os=new ByteArrayOutputStream();
        mimeMsg.writeTo(os);    
        mimeMsg.setFrom(new InternetAddress(from)); 
    
        Set<InternetAddress> toSet = new HashSet<InternetAddress>();
        toSet.add(new InternetAddress(to));
        
        mimeMsg.setRecipients(javax.mail.Message.RecipientType.TO, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
        mimeMsg.setRecipients(javax.mail.Message.RecipientType.CC, (InternetAddress[]) toSet.toArray(new InternetAddress[toSet.size()]));
        try{
        	Transport.send(mimeMsg);
        }catch (Exception ex) {
        	logger.error("sendErrorMsg",ex);
		}
	}
	
}
class MyAuthenticator extends javax.mail.Authenticator {

    private String user;
    private String password;

    public MyAuthenticator() {

    }

    public MyAuthenticator(String user, String password) {
        this.user = user;
        this.password = password;
    }

    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication(user, password);
    }
}  