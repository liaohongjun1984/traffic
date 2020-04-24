package com.devops.suc.vo;

import java.util.List;

public class BatchUpdateVO {
	private List<String> accountList;
	private int status;
	public List<String> getAccountList() {
		return accountList;
	}
	public void setAccountList(List<String> accountList) {
		this.accountList = accountList;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
