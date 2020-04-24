package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.model.TpCarNumTitle;
import com.devops.suc.model.TpCarType;
import com.devops.suc.vo.TpCarNumTitleSearchVO;
import com.devops.suc.vo.TpCarNumTitleVO;
import com.devops.suc.vo.TpCarTypeSearchVO;

public interface TpCarNumTitleDao extends SqlMapper{
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpCarNumTitleVO> list(TpCarNumTitleSearchVO svo);

	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpCarNumTitle get(int id);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpCarNumTitleSearchVO svo);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpCarNumTitle vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpCarNumTitle vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

}
