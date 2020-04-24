package com.devops.suc.service;

import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.vo.TpUploadTempSearchVO;
import com.devops.suc.vo.TpUploadTempVO;
import com.idhoo.dhutil.dto.Result;

public interface TpUploadTempService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpUploadTempSearchVO vo);
	
	/**
	 * 根据已经校对返回列表
	 * @param svo
	 * @return
	 */
	public Result Downlist(TpUploadTempSearchVO vo);
	
	
	/**
	 * 根据索引获取多条记录
	 * @param svo
	 * @return
	 */
	public Result DownPicByIndex(TpUploadTempSearchVO vo);
	
	public Result get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public Result save(TpUploadTempVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);

	public Result selectList();

	public TpUploadTemp getModel(int id);
	
	public TpUploadTemp getModel1(int road_id);

	public Result tpDownLoaded(String ids);

	public Result updateStatus(String ids);

}
