package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.devops.suc.model.DomainWeights;
import com.devops.suc.vo.DomainWeightsSearchVO;
import com.devops.suc.vo.DomainWeightsVO;

public interface DomainWeightsDao extends SqlMapper{

	/**
	 * 按条件搜索域名权重
	 * 
	 * @param domainWeightsVO
	 *            --域名搜索条件
	 * @return
	 */
	public List<DomainWeightsVO> list(DomainWeightsSearchVO domainWeightsSearchVO);
	
	/**
	 * 按条件搜索域名权重（全部）
	 * 
	 * @param domainWeightsVO
	 *            --域名搜索条件
	 * @return
	 */
	public List<DomainWeights> listAll(DomainWeights domainWeights);

	/**
	 * 根据app_id查找记录
	 * 
	 * @param app_id
	 *            --应用系统id
	 * @return
	 */
	public List<DomainWeights> listByAppId(int app_id);

	/**
	 * 按条件搜索域名权重总数
	 * 
	 * @param domainWeightsVO
	 *            --域名搜索条件
	 * @return
	 */
	public int listCount(DomainWeightsSearchVO domainWeightsSearchVO);

	/**
	 * 根据id查找记录
	 * 
	 * @param id
	 * @return
	 */
	public DomainWeights get(int id);

	/**
	 * 插入一条记录
	 * 
	 * @param domainWeights
	 */
	public void insert(DomainWeights domainWeights);

	/**
	 * 根据id更新一条记录
	 * 
	 * @param domainWeights
	 */
	public void update(DomainWeights domainWeights);

	/**
	 * 根据id删除一条记录
	 * 
	 * @param domainWeights
	 */
	public void delete(int id);
	@Select("select * from domain_weights where host like CONCAT('%',#{host},'%')")
	public List<DomainWeights> listByHost(@Param("host") String host);

}
