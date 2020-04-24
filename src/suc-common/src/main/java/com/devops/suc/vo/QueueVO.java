package com.devops.suc.vo;


public class QueueVO {
	/**收件人，多个用","分开*/
	private String recipient;
	
	/**抄送，多个用","分开*/
	private String cc;
	
	/**标题*/
	private String subject;
	
	/**信息*/
	private String message;
	
	/**执行时间*/
	private String execute_time;
	
	/**队列类型*/
	private int queue_type;

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getExecute_time() {
		return execute_time;
	}

	public void setExecute_time(String execute_time) {
		this.execute_time = execute_time;
	}

	public int getQueue_type() {
		return queue_type;
	}

	public void setQueue_type(int queue_type) {
		this.queue_type = queue_type;
	}
}
