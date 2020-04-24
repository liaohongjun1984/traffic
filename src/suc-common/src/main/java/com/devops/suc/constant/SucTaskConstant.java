package com.devops.suc.constant;

public class SucTaskConstant {
	//版本号，方便调试的时候，知道是那个版本的代码跑出来的数据
	public static final String version = "1.0";
	//连接超时时间,单位为毫秒
	public static final int connectTimeout = 60000;
	//读取数据超时时间,单位为毫秒
	public static final int readTimeout    = 60000;	
	
	//连接超时时间,单位为毫秒
	public static final int connectTimeout_baidu = 1000;
	//读取数据超时时间,单位为毫秒
	public static final int readTimeout_baidu    = 2000;	
	
	//粗定位
	public static final int locationType_MAL = 0;
	//精定位
	public static final int locationType_MPC = 1;
}
