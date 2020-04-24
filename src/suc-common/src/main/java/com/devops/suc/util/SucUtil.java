package com.devops.suc.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;

import com.idhoo.dhutil.util.StringUtil;

public class SucUtil {

	@SuppressWarnings("rawtypes")
	public static Object getObjectFromReqeust(HttpServletRequest request,
			Object obj) {
		Map<String, String> paramsMap = new HashMap<String, String>();
		for (Iterator i = request.getParameterMap().entrySet().iterator(); i
				.hasNext();) {
			Map.Entry entry = (Map.Entry) i.next();
			String[] values = (String[]) entry.getValue();
			if (values != null && values.length == 1) {
				String value = ((String[]) entry.getValue())[0];
				paramsMap.put((String) entry.getKey(), value);
			}
			if (values != null && values.length > 1) {
				String[] value = (String[]) entry.getValue();
				paramsMap.put((String) entry.getKey(),
						StringUtil.toString(value, ","));
			}
		}
		try {
			BeanUtils.copyProperties(obj, paramsMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return obj;
	}

	public static String genRandomNum(int pwd_len) {
		// 35是因为数组是从0开始的，26个字母+10个数字
		final int maxNum = 36;
		int i; // 生成的随机数
		int count = 0; // 生成的密码的长度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
				'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
				'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

		StringBuffer pwd = new StringBuffer("");
		Random r = new Random();
		while (count < pwd_len) {
			// 生成随机数，取绝对值，防止生成负数，

			i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1

			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}

	public static boolean isAdmin(String user_name) {
		if ("admin".equals(user_name)) {
			return true;
		}
		return false;
	}
	
	public static void main(String[] args) {
		System.out.println(SucUtil.genRandomNum(6));
		
	}

}
