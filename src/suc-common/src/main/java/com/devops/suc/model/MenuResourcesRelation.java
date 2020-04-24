package com.devops.suc.model;

/**
 * <pre>
 * Title:
 * Description: 
 * </pre>
 * @author wangxc  wangxc@yuchengtech.com
 * @version 1.00.00
 * <pre>
 * 
 * </pre>
 */
 
public class MenuResourcesRelation{

	// Fields

	/**资源id*/

	private String menu_id;

	/**菜单id*/

	private String resources_id;

	public String getMenu_id() {
		return menu_id;
	}

	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}

	public String getResources_id() {
		return resources_id;
	}

	public void setResources_id(String resources_id) {
		this.resources_id = resources_id;
	}

}