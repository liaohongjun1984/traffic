package com.devops.suc.constant;

import java.util.HashMap;
import java.util.Map;

public class CollDataTypeConstant {
	/**
	 * 手动定位
	 */
	public static final int SINGLE=2111;
	/**
	 * 定时定位
	 */
	public static final int TIME_INTERVAL=2201;
	/**
	 * 进入围栏
	 */
	public static final int ENTER_FENCE=3011;
	/**
	 * 离开围栏
	 */
	public static final int EXIT_FANCE=3010;
	/**
	 * sos告警
	 */
	public static final int SOS_FANCE=3361;
	/**
	 * 低电告警
	 */
	public static final int LOW_FANCE=3503;
	/**
	 * 开机
	 */
	public static final int OPEN=3501;
	
	private static Map<Integer,String> map=new HashMap<Integer, String>();
	
	static{
		map.put(SINGLE, "手动定位");
		map.put(TIME_INTERVAL, "定时定位");
		map.put(ENTER_FENCE, "进入围栏");
		map.put(EXIT_FANCE, "离开围栏");
		map.put(SOS_FANCE, "sos告警");
		map.put(LOW_FANCE, "低电告警");
		map.put(OPEN, "开机");
	}
	
	public static String get(int key){
		return map.get(key);
	}
}
