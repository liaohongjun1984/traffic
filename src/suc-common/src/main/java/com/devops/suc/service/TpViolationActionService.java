package com.devops.suc.service;

import com.devops.suc.vo.TpViolationActionSearchVO;
import com.devops.suc.vo.TpViolationActionVO;
import com.idhoo.dhutil.dto.Result;

public interface TpViolationActionService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpViolationActionSearchVO vo);
	
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
	public Result save(TpViolationActionVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);

	public Result listViolationActionByRoadId(int road_id);

	/**
	 * 列出所有违法行为（无分页）
	 * @param svo
	 * @return
	 */
	public Result listAll(TpViolationActionSearchVO  svo);

}
