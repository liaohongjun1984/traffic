package com.devops.suc.dao;

import java.util.List;
import com.devops.suc.vo.TpFtpConfigVO;
import com.devops.suc.model.TpFtpConfig;
import com.devops.suc.vo.TpFtpConfigSearchVO;

public interface TpFtpConfigDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpFtpConfigVO> list(TpFtpConfigSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpFtpConfigSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpFtpConfig get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpFtpConfig vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpFtpConfig vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

}
