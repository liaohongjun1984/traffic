package com.devops.suc.constant;

import java.util.HashMap;
import java.util.Map;

public class AccStatusConstant {
	/**
	 * 正常
	 */
	private static final int NORMAL=0;
	/**
	 * 暂停
	 */
	private static final int SUSPEND=1;
	/**
	 * 禁用
	 */
	private static final int FORBIT=2;
	private static Map<Integer,String> map=new HashMap<Integer, String>();
	static{
		map.put(NORMAL, "正常");
		map.put(SUSPEND, "暂停");
		map.put(FORBIT, "禁用");
	}
	
	public static String get(int status){
		return map.get(status);
	}
}
