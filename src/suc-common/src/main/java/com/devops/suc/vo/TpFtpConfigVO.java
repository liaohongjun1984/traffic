package com.devops.suc.vo;
import java.io.Serializable;


public class TpFtpConfigVO  implements Serializable{

	
	/** id */
	private int id;
	
	/** 名称 */
	private String ftp_mark;
	
	/** 服务器地址 */
	private String ftp_host;
	
	/** 服务器端口 */
	private String ftp_port;
	
	/** 服务器帐号 */
	private String ftp_user;
	
	/** 服务器密码 */
	private String ftp_pwd;
	
	/** 服务器路径 */
	private String ftp_dir;
	
	/** 创建者 */
	private String create_operator;
	
	/** 创建时间 */
	private String create_time;
	
	/** 最后修改者 */
	private String last_modify_operator;
	
	/** 最后修改时间 */
	private String last_modify_time;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getFtp_mark() {
		return ftp_mark;
	}
	
	public void setFtp_mark(String ftp_mark) {
		this.ftp_mark = ftp_mark;
	}
	
	public String getFtp_host() {
		return ftp_host;
	}
	
	public void setFtp_host(String ftp_host) {
		this.ftp_host = ftp_host;
	}
	
	public String getFtp_port() {
		return ftp_port;
	}
	
	public void setFtp_port(String ftp_port) {
		this.ftp_port = ftp_port;
	}
	
	public String getFtp_user() {
		return ftp_user;
	}
	
	public void setFtp_user(String ftp_user) {
		this.ftp_user = ftp_user;
	}
	
	public String getFtp_pwd() {
		return ftp_pwd;
	}
	
	public void setFtp_pwd(String ftp_pwd) {
		this.ftp_pwd = ftp_pwd;
	}
	
	public String getFtp_dir() {
		return ftp_dir;
	}
	
	public void setFtp_dir(String ftp_dir) {
		this.ftp_dir = ftp_dir;
	}
	
	public String getCreate_operator() {
		return create_operator;
	}
	
	public void setCreate_operator(String create_operator) {
		this.create_operator = create_operator;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	public String getLast_modify_operator() {
		return last_modify_operator;
	}
	
	public void setLast_modify_operator(String last_modify_operator) {
		this.last_modify_operator = last_modify_operator;
	}
	
	public String getLast_modify_time() {
		return last_modify_time;
	}
	
	public void setLast_modify_time(String last_modify_time) {
		this.last_modify_time = last_modify_time;
	}
	
	
}
