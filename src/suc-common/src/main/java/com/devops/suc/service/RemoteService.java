package com.devops.suc.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface RemoteService {

	/**
	 * 建立数据连接
	 * @param mobile
	 */
	public void createLink(String mobile,String joonData);
	
	/**
	 * 接收上传的数据
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public void dealRequest(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
