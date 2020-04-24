package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpDealLogsVO;
import com.devops.suc.model.TpDealLogs;
import com.devops.suc.vo.TpDealLogsSearchVO;

public interface TpDealLogsDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpDealLogsVO> list(TpDealLogsSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpDealLogsSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpDealLogs get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpDealLogs vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpDealLogs vo);
	
	/**
	 * 重新校对
	 * 
	 */
	public void delete(int id);

	public TpDealLogs getByFileId(int file_id);
	
	public TpDealLogs getByRoadId(int road_id);

	public List<Integer> listDistinctUserId(TpDealLogsSearchVO svo);

	public List<Integer> listRoadByUserId(TpDealLogsSearchVO svo);

	public List<TpDealLogsVO> listForm(TpDealLogsSearchVO svo);

	public int countForm(TpDealLogsSearchVO svo);

	public TpDealLogsVO remember(int file_index);
	
	public List<TpDealLogsVO> ergodic();

}
