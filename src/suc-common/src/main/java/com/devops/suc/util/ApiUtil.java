package com.devops.suc.util;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.idhoo.dhutil.util.TripleDES;

public class ApiUtil {
	
	private static final Logger logger = Logger.getLogger(ApiUtil.class);
	
	/**
	 * 获取参数数据
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static Map<String,String> getParam(HttpServletRequest request) throws Exception{
		String data = request.getParameter("data");
		TripleDES tripleDes = new TripleDES();
		logger.info("data:"+data);
		String param = tripleDes.Decrypt(data);
		logger.info("param:"+param);
		Map<String,String> requestParam = new HashMap<String,String>();
		String[] params = param.split("&");
		for(String pair : params){
			requestParam.put(pair.split("=")[0], URLDecoder.decode(pair.split("=")[1], "utf-8"));
		}
		logger.info("request data : "+requestParam);
		return requestParam;
	}
}
