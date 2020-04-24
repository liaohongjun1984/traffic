package com.devops.suc.dao;

import java.util.List;
import com.devops.suc.vo.TpCarTypeVO;
import com.devops.suc.model.TpCarType;
import com.devops.suc.vo.TpCarTypeSearchVO;

public interface TpCarTypeDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpCarTypeVO> list(TpCarTypeSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpCarTypeSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpCarType get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpCarType vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpCarType vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public List<TpCarTypeVO> listAll();
	
	/**
	 * 根据car_type_id获得car_type_name
	 */
	public String getCarTypeNameById(String car_type_id);
	
}
