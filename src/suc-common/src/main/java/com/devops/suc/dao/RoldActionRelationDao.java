package com.devops.suc.dao;

import java.util.List;
import com.devops.suc.vo.RoldActionRelationVO;
import com.devops.suc.model.RoldActionRelation;
import com.devops.suc.vo.RoldActionRelationSearchVO;

public interface RoldActionRelationDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<RoldActionRelationVO> list(RoldActionRelationSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(RoldActionRelationSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public RoldActionRelation get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(RoldActionRelation vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(RoldActionRelation vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int road_id);

	public RoldActionRelation getByActionId(int v_id);

}
