package com.devops.suc.dao;

import java.util.List;
import com.devops.suc.vo.TpRoadVO;
import com.devops.suc.model.TpRoad;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpRoadSearchVO;

public interface TpRoadDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpRoadVO> list(TpRoadSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpRoadSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
    public int countDown(TpFilterFileSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpRoad get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpRoad vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpRoad vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public List<TpRoadVO> listAll();

}
