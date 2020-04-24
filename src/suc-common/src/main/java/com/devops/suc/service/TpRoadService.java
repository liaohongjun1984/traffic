package com.devops.suc.service;

import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpRoadSearchVO;
import com.devops.suc.vo.TpRoadVO;
import com.idhoo.dhutil.dto.Result;

public interface TpRoadService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpRoadSearchVO vo);
	
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
	public Result save(TpRoadVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);

	public Result listAll(TpFilterFileSearchVO vo);

	public Result addViolationAction(int road_id, String v_ids);

}
