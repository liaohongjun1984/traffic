package com.devops.suc.vo;

public class UpdatePwd {

	private String username;
	private String old_pwd;
	private String new_pwd;
	private String new_pwd1;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getOld_pwd() {
		return old_pwd;
	}
	public void setOld_pwd(String old_pwd) {
		this.old_pwd = old_pwd;
	}
	public String getNew_pwd() {
		return new_pwd;
	}
	public void setNew_pwd(String new_pwd) {
		this.new_pwd = new_pwd;
	}
	public String getNew_pwd1() {
		return new_pwd1;
	}
	public void setNew_pwd1(String new_pwd1) {
		this.new_pwd1 = new_pwd1;
	}	
}
