package com.devops.suc.constant;
/**
 * 定义缓存key
 * @author wangxichun
 *
 */
public class CacheKeyConstant {
	
	public static final String KEY_PREFIX_ADMIN = "ADMIN_";
	
	/**业务memcached id的所有前缀*/
	public static final String _MEMCACHED_KEYPREFIX="_suc_bus_";
	
	
	/*************权限资源 memcached key*******************/
	
	/**权限域id的*/
	public static final String MEMCACHED_PRIVILEGE_ID = _MEMCACHED_KEYPREFIX+"PRIVILEGE";
	
	/**菜单key*/
	public static final String PRIVILEGE_MENU_KEY_PREFIX = _MEMCACHED_KEYPREFIX+"menu_";
	
	/**资源key*/
	public static final String PRIVILEGE_RESOURCE_KEY_PREFIX = _MEMCACHED_KEYPREFIX+"resource_";
	
	/**用户信息*/
	public static final String PRIVILEGE_USER_INFO_KEY_PREFIX = _MEMCACHED_KEYPREFIX+"user_info_";
	
	/*****************权限资源 memcached key end************/
	
	
	//redis key prefix
	
	/**redis app的key值前缀*/
	public static final String APP_PREFIX = "app";

	/** redis user的key值前缀*/
	public static final String ALL_USER_PREFIX = "all_user";
	
	/** redis res的key值前缀*/
	public static final String RES_PREFIX = "res";
	
	/**redis menu的key前缀*/
	public static final String MENU_PREFIX = "menu";

	/**redis app的user的key值前缀*/
	public static final String APP_USER_PREFIX = "app_user";
	
	
	/**redis 用户所属系统的key值前缀*/
	public static final String USER_APP_PREFIX = "user_app";
	
	/** redis 系统host的前缀*/
	public static final String DOMIN_PREFIX = "host";
	
	/** redis 系统role的前缀*/
	public static final String ROLE_PREFIX = "role";
	
	/** redis 所有系统的key值前缀*/
	public static final String ALL_APP_PREFIX = "all_app";
	
	
}
