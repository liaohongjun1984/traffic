package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpViolationActionVO;
import com.devops.suc.model.TpViolationAction;
import com.devops.suc.vo.TpViolationActionSearchVO;

public interface TpViolationActionDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpViolationActionVO> list(TpViolationActionSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpViolationActionSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpViolationAction get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpViolationAction vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpViolationAction vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public List<TpViolationActionVO> listAll();

	public List<TpViolationActionVO> listByRoadId(int road_id);

	public TpViolationActionVO getVO(int id);

}
