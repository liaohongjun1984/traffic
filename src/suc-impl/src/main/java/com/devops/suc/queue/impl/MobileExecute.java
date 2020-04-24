package com.devops.suc.queue.impl;

import java.io.IOException;
import java.util.Date;

import org.apache.log4j.Logger;

import com.devops.suc.cfg.SucCommConfig;
import com.devops.suc.dao.SendLogDao;
import com.devops.suc.model.Queue;
import com.devops.suc.model.SendLog;
import com.devops.suc.queue.ExecutableQueue;
import com.devops.suc.queue.QueueType;
import com.devops.suc.util.TextFileWrite;
import com.idhoo.dhutil.spring.SpringContextUtil;

public class MobileExecute extends ExecutableQueue {
	private static Logger logger = Logger.getLogger(MobileExecute.class);
	SendLogDao sendLogDao = (SendLogDao) SpringContextUtil.getBean("sendLogDao");
	@Override
	public int execute(Queue queue) {
		StringBuilder buff = new StringBuilder();
		buff.append(queue.toString()).append(",");
		String recipient = queue.getRecipient();
		String msg = queue.getMessage();
		try {
			this.send(recipient, msg,buff);
		} catch (Exception e) {
			logger.error(buff.toString(),e);
		}
		SendLog sendLog = new SendLog();
		sendLog.setQueue_id(queue.getQueue_id());
		sendLog.setRecipient(queue.getRecipient());
		sendLog.setCc(queue.getCc());
		sendLog.setSubject(queue.getSubject());
		sendLog.setMessage(queue.getMessage());
		sendLog.setExecute_time(new Date());
		sendLog.setQueue_type(QueueType.MOBILE);
		sendLog.setCreate_time(queue.getCreate_time());
		sendLog.setLast_modify(queue.getLast_modify());
		sendLog.setData(queue.getData());
		sendLog.setQueue_index(queue.getQueue_index());
		sendLog.setResult("true");
		sendLogDao.add(sendLog);
		logger.info(buff.toString());
		return 0;
	}
	
	private void send(String rec,String msg,StringBuilder buff) throws Exception{
		String fileName = "/tmp/"+System.currentTimeMillis();
		String sh_dir = SucCommConfig.get("sh_dir");
		//String sh_dir = "D:/test/";
		if(!sh_dir.endsWith("/")){
			sh_dir = sh_dir + "/";
		}
		String python = "send_sms.py";
		TextFileWrite fw = new TextFileWrite(fileName);
		fw.writeFile(rec+"\n"+msg);
		String command = "python "+sh_dir+python+" "+fileName;
		buff.append("command=<").append(command).append(">");
		Runtime.getRuntime().exec(command);
	}
	public static void main(String[] args) throws IOException {
		String msg = "13560244663\nass你好";		
		String sh_dir = "D:/test/";
		String python = "send_sms.py";
		
		TextFileWrite fw = new TextFileWrite("D:/test/1.txt");
		fw.writeFile(msg);	
		
		String command = "python "+sh_dir+python+" "+ "D:/test/1.txt";
		System.out.println(command);
		Runtime.getRuntime().exec(command);
	}

}
