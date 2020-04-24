package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpEqualLogVO;
import com.devops.suc.model.TpEqualLog;
import com.devops.suc.vo.TpEqualLogSearchVO;

public interface TpEqualLogDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpEqualLogVO> list(TpEqualLogSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpEqualLogSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpEqualLog get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpEqualLog vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpEqualLog vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public void deleteByCarNoAndTime(String car_num, String create_time);

	public void init(String sql2);

}
