package com.devops.suc.model;

import java.util.Date;

public class SendLog {

	private int id;
	/**队列ID**/
	private long queue_id;
	/**发送地址**/
	private String recipient;
	/**抄送地址**/
	private String cc;
	/**标题**/
	private String subject;
	/**内容**/
	private String message;
	/**执行时间**/
	private Date execute_time;
	/**数据类型**/
	private int queue_type;
	/**数据创建时间**/
	private Date create_time;
	/**最后修改时间**/
	private Date last_modify;
	/**执行队列标识**/
	private int queue_index;
	/**扩展JSON数据**/
	private String data;
	/**执行结果标识**/
	private String result;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public long getQueue_id() {
		return queue_id;
	}
	public void setQueue_id(long queue_id) {
		this.queue_id = queue_id;
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
	public void setExecute_time(Date execute_time) {
		this.execute_time = execute_time;
	}
	public int getQueue_type() {
		return queue_type;
	}
	public void setQueue_type(int queue_type) {
		this.queue_type = queue_type;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public int getQueue_index() {
		return queue_index;
	}
	public void setQueue_index(int queue_index) {
		this.queue_index = queue_index;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Date getLast_modify() {
		return last_modify;
	}
	public void setLast_modify(Date last_modify) {
		this.last_modify = last_modify;
	}
}
