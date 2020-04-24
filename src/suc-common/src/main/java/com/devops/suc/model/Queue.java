package com.devops.suc.model;

import java.util.Date;

/**
 * 队列
 * @author wangxichun
 *
 */
public class Queue implements java.io.Serializable{
	
	private static final long serialVersionUID = 1701463619153604640L;

	/**流水号*/
	private long queue_id;
	
	/**收件人，多个用","分开*/
	private String recipient;
	
	/**抄送，多个用","分开*/
	private String cc;
	
	/**标题*/
	private String subject;
	
	/**信息*/
	private String message;
	
	/**执行时间*/
	private Date execute_time;
	
	/**队列类型*/
	private int queue_type;
	
	/**创建时间*/
	private Date create_time;
	
	/**最后修改时间*/
	private Date last_modify;
	
	/**用户自定义数据，可存在json数据等**/
	private String data;
	
	/**队列索引*/
	private int queue_index;
	
	/**
	 * 创建者帐号
	 */
	private String create_admin;
	
	public String getCreate_admin() {
		return create_admin;
	}

	public void setCreate_admin(String create_admin) {
		this.create_admin = create_admin;
	}

	public int getQueue_index() {
		return queue_index;
	}

	public void setQueue_index(int queueIndex) {
		queue_index = queueIndex;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public long getQueue_id() {
		return queue_id;
	}

	public void setQueue_id(long queueId) {
		queue_id = queueId;
	}

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

	public Date getExecute_time() {
		return execute_time;
	}

	public void setExecute_time(Date executeTime) {
		execute_time = executeTime;
	}

	public int getQueue_type() {
		return queue_type;
	}

	public void setQueue_type(int queueType) {
		queue_type = queueType;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date createTime) {
		create_time = createTime;
	}

	public Date getLast_modify() {
		return last_modify;
	}

	public void setLast_modify(Date lastModify) {
		last_modify = lastModify;
	}
	
	public String toString(){
		StringBuilder buff = new StringBuilder();
		buff.append("queue_id=<").append(queue_id).append(">,");
		buff.append("cc=<").append(cc).append(">,");
		buff.append("subject=<").append(subject).append(">,");
		buff.append("execute_time=<").append(execute_time).append(">,");
		buff.append("queue_type=<").append(queue_type).append(">,");
		buff.append("create_time=<").append(create_time).append(">,");
		buff.append("last_modify=<").append(last_modify).append(">");
		return buff.toString();
		
	}
}
