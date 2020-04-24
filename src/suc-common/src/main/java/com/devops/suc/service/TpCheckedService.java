/**
 * @author: code@xiepeiyang.com
 * @date: 2016年3月26日-下午6:33:04
 */
package com.devops.suc.service;

import com.idhoo.dhutil.dto.Result;
import com.devops.suc.vo.TpCheckedSearchVO;

public interface TpCheckedService {
	/**
	 * 根据搜索条件返回列表
	 */
	public Result list(TpCheckedSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 */
	//public int count(TpCheckedSearchVO vo);
}
