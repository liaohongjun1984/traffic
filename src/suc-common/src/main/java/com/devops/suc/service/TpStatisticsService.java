package com.devops.suc.service;

import java.util.List;

import com.devops.suc.vo.TpStatisticsVO;
import com.devops.suc.vo.TpStatisticsSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface TpStatisticsService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpStatisticsSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public Result get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public Result save(TpStatisticsVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);

}
