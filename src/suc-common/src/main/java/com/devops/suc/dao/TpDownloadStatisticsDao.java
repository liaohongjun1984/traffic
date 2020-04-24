package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpDownloadStatisticsVO;
import com.devops.suc.model.TpDownloadStatistics;
import com.devops.suc.vo.TpDownloadStatisticsSearchVO;

public interface TpDownloadStatisticsDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpDownloadStatisticsVO> list(TpDownloadStatisticsSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpDownloadStatisticsSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpDownloadStatistics get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpDownloadStatistics vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpDownloadStatistics vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public TpDownloadStatistics getByDateAndUserId(String curDate, int userId);

	public void updateDownLoadNum(int staticId);

}
