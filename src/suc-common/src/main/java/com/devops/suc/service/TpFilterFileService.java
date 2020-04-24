package com.devops.suc.service;

import java.util.List;

import com.devops.suc.vo.TpFilterFileVO;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface TpFilterFileService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpFilterFileSearchVO vo);
	
	
	
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
	public Result save(TpFilterFileVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);
	
	/**
	 * 更新其中的数据
	 * @param 
	 */
	public Result updateTFFSome();

	/**
	 * 导出下载列表的EXCEL
	 * @param svo
	 * @return
	 */

	public Result exportExcel(TpFilterFileSearchVO svo);

}
