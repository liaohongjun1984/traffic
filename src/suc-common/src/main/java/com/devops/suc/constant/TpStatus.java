package com.devops.suc.constant;

public class TpStatus {

	public static interface file_status{
		public int confirm_match = 0;//确认匹配
		public int confirm_nomatch = 1;//确认不匹配
		public int invalid = 2;//无效
	}
	
	/*
	 * 是否已下载
	 */
	public static interface is_downLoad{
		public int not_downLoad = 0;//未下载
		public int downLoaded = 1;//已下载
	}
}

