package com.devops.suc.service;

import com.devops.suc.model.BusGroup;
import com.idhoo.dhutil.dto.Result;

public interface BusGroupService {
	/**
	 * 通过用户组ID获取组下面的成员
	 * @param group_id
	 * @return
	 */
	public Result listUserByGroup(String group_id);
	/**
	 * 
	 * @param user_id
	 * @param user_name
	 * @return
	 */
	public Result list(int user_id,String user_name); 
	/**
	 * 获取登陆用户的组织架构
	 * @param user_id
	 * @return
	 */
	public Result listChild(String group_id,int user_id,String user_name);
	/**
	 * 添加
	 * @param vo
	 * @return
	 */
	public Result add(BusGroup vo);
	/**
	 * 更新
	 * @param busGroup
	 * @return
	 */
	public Result update(String name,String notes,String operator,String group_id);
	/**
	 * 删除
	 * @param group_id
	 * @return
	 */
	public Result delete(String group_id);
	/**
	 * 浏览人员
	 * @param group_id
	 * @return
	 */
	public Result listUser(String group_id);
	/**
	 * 增加人员
	 * @param group_id
	 * @param user_ids
	 * @return
	 */
	public Result addUser(String group_id, String user_ids);
	/**
	 * 删除人员
	 * @param group_id
	 * @param user_id
	 * @return
	 */
	public Result deleteUser(String group_id, String user_id);
	/**
	 * 查询未在分组的人员
	 * @param group_id
	 * @param user_name
	 * @param nick_name
	 * @return
	 */
	public Result listNotInUser(String group_id, String user_name,
			String nick_name);
	/**
	 * 设置管理员
	 * @param group_id
	 * @param user_id
	 * @return
	 */
	public Result setAdmin(String group_id, String user_id,boolean isAdmin);
	
	/**
	 * 获取一级部门列表
	 * @return
	 */
	public Result getFirGradeDep();

	public Result getByUser(String user_name);
	/**
	 * 获取二级业务架构
	 * @return
	 */
	public Result listAllSecond();
}
