package com.devops.suc.constant;

import java.util.HashMap;
import java.util.Map;

public class ResultExplainConstant {
	public static final int PRECISE_SUCESS=0;
	public static final int CRUDE_SUCESS=1;
	public static final int PRECISE_SHIFT_SUCESS=2;
	public static final int PRECISE_SHIFT_FAIL=3;
	/**
	 * 离开围栏告警
	 */
	public static final int EXIT_FANCE=3;
	
	private static Map<Integer,String> map=new HashMap<Integer, String>();
	
	static{
		map.put(PRECISE_SUCESS, "精定位成功");
		map.put(CRUDE_SUCESS, "粗定位成功");
		map.put(PRECISE_SHIFT_SUCESS, "精定位失败转粗定位成功");
		map.put(PRECISE_SHIFT_FAIL, "精定位失败转粗定位失败");
	}
	
	public static String get(int key){
		return map.get(key);
	}
}
