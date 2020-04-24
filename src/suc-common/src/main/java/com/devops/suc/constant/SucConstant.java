package com.devops.suc.constant;

import com.devops.suc.cfg.SucCommConfig;


/**
 * 常量定义
 * @author wangxichun
 *
 */
public class SucConstant {
	
	/**分页每页显示记录数*/
	public static final int PAGE_SIZE=SucCommConfig.getInt("page_size", 15);
	
	/**对于分页，每页最多允许1000条数据*/
	public static final int PAGE_MAX_ROWS = SucCommConfig.getInt("page_max_size", 1000);
	
	/** 是否使用本地 cache(EHCache) */
	public static final boolean LOCAL_CACHE = SucCommConfig.getBool("local_cache");
	
	public static final String SERVER_QUEUE_FILEPATH = SucCommConfig.get("server_queue_filepath");
	
	public static final String domain = ".bd.haochibang.cn";
	
	public static final short APP_STATUS_USE   = 1; //系统可用
	public static final short APP_STATUS_UNUSE = 2; //系统不可用
	public static final short APP_TYPE_INNERSYS=1;  //运维系统
	public static final short APP_TYPE_OUTSYS  =2;  //外部系统
	
	
	//***************权限**************
	
	/**用户名在 cookie 的 key*/
	public static final String KEY_USER_NAME = "sysop_privilege_user_name";
	
	/**用户ID 在 cookie 中的 key (浏览器进程)*/
	public static final String KEY_USER_ID ="sysop_privilege_user_id";
	
	/**用户ID 在 cookie 中的 key (永久性)*/
	public static final String KEY_GLOBAL_USER_ID = "sysop_privilege_global_user_id";

	/**验证码在 cookie 的 key*/
	public static final String KEY_IDENTIFYING_CODE = "sysop_privilege_idcode";
	
	/**用户进行强制检验的code*/
	public static final String KEY_VERIFY_CODE = "sysop_privilege_u_verifycode";
	
	/**系统域*/
	public static final String  SYSTEM_DOMAIN =SucCommConfig.get("system_domain");
	
	/** 检测盗号 */
	public static final boolean CHEDCK_STEAL_ACCOUNT = true;
	
	/** 是否检测用户的memcached验证码 */
	public static final boolean FORCE_CHECK_USER_KEY = true;
	
	/**管理员、组名称*/
	public static final String ADMIN_GROUP_NAME = "admin";
	
	/**跳转url*/
	public static final String GOING_TO_URL_KEY="GOING_TO";  
	
	//***************权限end**************
	public static String FILE_PRE = "file_";// 上传控件的前缀
	
	/**系统id**/
	public static int app_id = 1;
	
	public static int sysLogType_APPGROUP = 1;
	public static int sysLogType_APP  = 2;
	public static int sysLogType_USER = 3;
	public static int sysLogType_ROLE = 4;
	public static int sysLogType_MENU = 5;
	public static int sysLogType_LOGIN= 6;
	
	public static String group_root = "00";
	
}
