package com.devops.suc.service;

import javax.servlet.http.HttpServletRequest;

import com.devops.suc.util.ApiResult;


public interface ApiService {
	
	/**
	 * 登录
	 * @param mdn
	 * @param pwd
	 * @return
	 */
	public ApiResult login(String mdn,String pwd,HttpServletRequest request);

	/**
	 * 找回密码
	 * @param mdn
	 * @param request
	 * @return
	 */
	public ApiResult findPwd(String mdn,String rd_register, HttpServletRequest request);

	/**
	 * 获取被监护人接口
	 * @param mdn
	 * @param session_id
	 * @return
	 */
	public ApiResult getCares(String mdn, String session_id);

	/**
	 * 定位
	 * @param mdn
	 * @param session_id
	 * @param careMdn
	 * @return
	 */
	public ApiResult location(String mdn, String session_id, String careMdn);

	/**
	 * 获取历史定位信息
	 * @param mdn
	 * @param session_id
	 * @param careMdn
	 * @param start
	 * @param end
	 * @return
	 */
	public ApiResult getHistory(String mdn, String session_id, String careMdn,String start, String end);

	/**
	 * 添加监护人
	 * @param mdn
	 * @param session_id
	 * @param careMdn
	 * @param name
	 * @param nickName
	 * @return
	 */
	public ApiResult addCare(String mdn, String session_id, String careMdn,String name, String nickName);

	/**
	 * 删除被监护人号码
	 * @param mdn
	 * @param session_id
	 * @param careMdn
	 * @return
	 */
	public ApiResult deleteCare(String mdn, String session_id, String careMdn);

	/**
	 * 更新被监护人的定位类型及昵称
	 * @param mdn
	 * @param session_id
	 * @param careMdn
	 * @param name
	 * @param nickName
	 * @return
	 */
	public ApiResult updateCare(String mdn, String session_id, String careMdn,
			String name, String nickName);
}
