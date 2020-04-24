package com.devops.suc.service;

import com.devops.suc.model.TpCarNumTitle;
import com.devops.suc.vo.TpCarNumTitleSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface TpCarNumTitleService {
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpCarNumTitleSearchVO svo);

	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public Result get(int id);
	
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public Result save(TpCarNumTitle vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);
}
