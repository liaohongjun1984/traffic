package com.devops.suc.service;

import com.devops.suc.model.User;
import com.idhoo.dhutil.dto.Result;

public interface AdminService {
	/**
	 * 查询所有用户信息
	 * @param user
	 * @param start
	 * @param size
	 * @param displayRecord
	 * @param page
	 * @return
	 */
	public Result listUsers(User user,int start,int size,int displayRecord,int page);
	/**
	 * 
	 * @param user
	 * @return
	 */
	public Result saveUser(User user);
	
	public Result deleteUser(String userName);
	
	public Result checkUser(String userName);
	
	public Result updateUser(User user);
	
	public Result updateStatus(User user);

}
