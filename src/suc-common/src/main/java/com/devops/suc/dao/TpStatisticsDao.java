package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpStatisticsVO;
import com.devops.suc.model.TpStatistics;
import com.devops.suc.vo.TpStatisticsSearchVO;

public interface TpStatisticsDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpStatisticsVO> list(TpStatisticsSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpStatisticsSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpStatistics get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpStatistics vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpStatistics vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public void updateInvalid(int parseInt);

	public void updateChecked(int fileId);
	
	public void reduceChecked(int fileId);
	
	public void reduceInvalid(int fileId);

	public int countStatic();

	public TpStatistics getByDateAndUserId(String curDate,int userId);

	public void updateUpNum(int staticId);

}
