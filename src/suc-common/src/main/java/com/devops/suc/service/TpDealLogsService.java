package com.devops.suc.service;

import com.devops.suc.vo.TpDealLogsSearchVO;
import com.devops.suc.vo.TpDealLogsVO;
import com.idhoo.dhutil.dto.Result;

public interface TpDealLogsService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpDealLogsSearchVO vo);
	
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
	public Result save(TpDealLogsVO vo);
	
	/**
	 * 重新校对记录
	 * @param vo
	 */
	public Result update(TpDealLogsVO vo);
	
	public Result again(TpDealLogsVO vo);
	 
	public Result delete(int id);

	public Result listForm(TpDealLogsSearchVO svo);
	
	public Result exportDealLogs(TpDealLogsSearchVO svo);

	public Result remember(int file_index);

}
