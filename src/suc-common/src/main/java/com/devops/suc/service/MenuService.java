package com.devops.suc.service;

import java.util.List;

import com.devops.suc.model.Menu;
import com.devops.suc.model.SecurityResources;
import com.devops.suc.model.SecurityResourcesVO;
import com.idhoo.dhutil.dto.Result;

public interface MenuService {
	/**
	 * 添加菜单
	 * @param menu
	 * @return
	 */
	public Result addMenu(Menu menu);
	/**
	 * 新增，修改与移动菜单
	 * @param menus
	 * @param operator
	 * @return
	 */
	public Result modifyMenu(List<Menu> menus,String operator);
	/**
	 * 删除菜单
	 * @param menu_id
	 * @return
	 */
	public Result removeMenu(int menu_id);
	/**
	 * 按系统ID获取菜单列表
	 * @param app_id
	 * @return
	 */
	public List<Menu> listByAppId(int app_id);
	/**
	 * 获取菜单的权限资源
	 * @param menu_id
	 * @return
	 */
	public List<SecurityResourcesVO> getMenuResource(int menu_id);
	/**
	 * 获取应用服务器的资源
	 * @param app_id
	 * @return
	 */
	public List<SecurityResources> getAppResource(int app_id);
	/**
	 * 更新菜单权限
	 * @param srs
	 */
	public Result modifyMenuResource(List<SecurityResources> srs,int menu_id);
	/**
	 * 获取后台登录跳转地址
	 * @param user_id
	 * @param app_id
	 * @return
	 */
	public String getUserWelcomeUrl(int user_id,int app_id);
	/**
	 * 获取用户中心用户菜单
	 * @param user_id
	 * @param app_id
	 * @return
	 */
	public List<Menu> getUserMenu(int user_id,int app_id);
}
