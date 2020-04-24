package com.devops.suc.constant;

import java.util.HashMap;
import java.util.Map;

public class ProtocolTypeConstant {
	private static Map<Integer,String> map=new HashMap<Integer,String>();
	static{
		map.put(3, "普通手机协议");
		map.put(2, "1.0");
		map.put(5, "2.0");
		map.put(7, "GPSone");
		map.put(6, "天安");
		map.put(8, "DW");
		map.put(9, "1.1");
	}
	public static String get(int key){
		return map.get(key);
	}
}
