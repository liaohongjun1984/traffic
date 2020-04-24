package com.devops.suc.handler;

import java.util.List;

import com.devops.suc.model.User;

/**
 * 
 * @author wangxichun
 *
 */
public interface AdminHandler {
	
	/**
	 * 保存记录
	 * @param admin
	 */
	void save(User admin);
	
	/**
	 * 根据用户名获取记录
	 * @param userName	--用户名称
	 * @return
	 */
	User get(String userName);
	
	List<User>list(User admin,int start,int size);
	
	int count(User admin);
	
	int deleteUser(String userName);
	
	int update(User admin);
	
	int updateStatus(User user);
}
