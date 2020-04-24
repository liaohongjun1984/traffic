package com.devops.suc.vo;

import com.devops.suc.model.App;

/**
 * AppAction输入参数接收
 * @author liaohongjun 2012年4月19日 09:41:02
 *
 */
public class AppVO extends App{
	/**
	 * 名称
	 */
	private String group_name   = "";

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	
	
	
}
