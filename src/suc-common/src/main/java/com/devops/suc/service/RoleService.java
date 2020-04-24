package com.devops.suc.service;

import java.util.List;

import com.devops.suc.model.Role;
import com.devops.suc.vo.MenuVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.util.Row;

public interface RoleService {

	/**
	 * 添加和修改用户角色信息
	 * @param role
	 * @return
	 */
	Result setRole(Role role);
	/**
	 * 查询角色信息
	 * @param vo
	 * @return
	 */
	Result listRole(Row row);
	/**
	 * 通过ID获取角色信息
	 * @param roleId
	 * @return
	 */
	Result getRole(int role_id);
	/**
	 * 删除角色，当有用户与角色绑定时不能删除角色
	 * @param roleId
	 * @return
	 */
	Result delete(int role_id);
	/**
	 * 修改角色
	 * @param row
	 * @return
	 */
	Result update(Row row);
	/**
	 * 根据角色获取用户信息
	 * @param row
	 * @return
	 */
	Result getUserByRole(Row row);
	/**
	 * 删除角色下的用户
	 * @param row
	 * @return
	 */
	Result deleteRoleUser(Row row);
	/**
	 * 获取未在某个角色下的用户信息
	 * @param row
	 * @return
	 */
	Result getNotUserByRole(Row row);
	/**
	 * 绑定用户角色
	 * @param row
	 * @return
	 */
	Result bindRoleUsers(Row row);
	/**
	 * 快速管理用户角色
	 * @param row
	 * @return
	 */
	Result qucikRoleUser(Row row);
	/**
	 * 复制角色
	 * @param row
	 * @return
	 */
	Result copyRoleUser(Row row);
	/**
	 * 获取角色下的菜单
	 * @param row
	 * @return
	 */
	Result getRoleMenu(Row row);
	/**
	 * 更改角色下的菜单信息
	 * @param row
	 * @return
	 */
	Result updateRoleMenu(List<MenuVO> menus,int role_id);

	/**
	 * 查找用户是否是超管
	 * @param user_id		--用户id
	 * @param role_name		--角色名称
	 * @return
	 */
	boolean isSuperAdmin(int user_id,String role_name);
	/**
	 * 
	 * @param role_name
	 * @return
	 */
	Result listRoleByName(String role_name);
}
