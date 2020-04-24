package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpFilterFileVO;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.vo.TpDealLogsVO;
import com.devops.suc.vo.TpFilterFileSearchVO;

public interface TpFilterFileDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpFilterFileVO> list(TpFilterFileSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpFilterFileSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpFilterFile get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpFilterFile vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpFilterFile vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public TpFilterFile getByFileId(int file_id);
	
	public TpFilterFile getByRoadId(int road_id);

	public void batchDownLoadFileStatus(List<Integer> ids);

	public void updateSome();

	public List<TpFilterFileVO> listTFFData();

	public TpDealLogsVO listTDLData(String file_id);

	public void updateTFFData(TpFilterFileVO vo);
}
