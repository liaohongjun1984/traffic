package com.devops.suc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.devops.suc.model.User;
import com.devops.suc.vo.UpdatePwd;
import com.devops.suc.vo.UserRoleVO;
import com.devops.suc.vo.UserSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface UserService {
	/**
	 * 获取所有的用户
	 * @return
	 */
	public List<User> getAllUser();
	/**
	 * 按条件搜索用户
	 * @param row
	 * @return
	 */
	public Result list(UserSearchVO userSearchVO);
	/**
	 * 获取用户信息
	 * @param userName
	 * @return
	 */
	public User   get(String userName);
	/**
	 * add user
	 * @param user
	 * @return
	 */
	public Result save(User user);
	/**
	 * add user
	 * @param user
	 * @return
	 */
	public Result update(User user);	
	/**
	 * 通过APPID获取角色列表
	 * @return
	 */
	public List<UserRoleVO> listRoleByAppId(int app_id,int user_id);
	/**
	 * 添加或删除用户角色
	 * @param user_id
	 * @param role_id
	 * @param checked
	 * @return
	 */
	public Result userRole(int user_id,int role_id,boolean checked);
	
	public Result list(String user_name);
	/**
	 * 
	 * @param nick_name
	 * @return
	 */
	public Result listByNickName(String nick_name);
	
	public Result check(String userName,String userPasswd,HttpServletResponse response, HttpServletRequest request);
	
	public Result updatePwd(UpdatePwd updatePwd);
	
	public Result updateInfo(User user);
	
	public Result updateUserPwd(UpdatePwd updatePwd);
	public Result deleteUserById(User user);
}
