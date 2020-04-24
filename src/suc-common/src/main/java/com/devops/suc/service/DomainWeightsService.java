package com.devops.suc.service;

import java.util.List;

import com.devops.suc.model.DomainWeights;
import com.devops.suc.vo.DomainWeightsSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface DomainWeightsService {
	/**
	 * 通过APP_ID获取排序的域名
	 * @param app_id
	 * @return
	 */
	List<DomainWeights> getDomainByAppId(int app_id);
	/**
	 * 按条件搜索域名权重
	 * @param domainWeightsVO
	 * @return
	 */
	public Result list(DomainWeightsSearchVO domainWeightsVO);
	
	/**
	 * 按条件搜索域名权重（全部）
	 * @param domainWeights
	 * @return
	 */
	public Result listAll(DomainWeights domainWeights);
	
	/**
	 *根据系统id查找记录
	 * 
	 * @param app_id --系统id
	 * @return
	 */
	public Result listByAppId(int app_id);
	
	/**
	 * 根据id查找记录
	 * @param id
	 * @return
	 */
	public Result get(int id);
	
	/**
	 * 插入一条记录
	 * @param domainWeights
	 * @return
	 */
	public Result insert(DomainWeights domainWeights);

	/**
	 * 根据id更新一条记录
	 * @param domainWeights
	 * @return
	 */
	public Result update(DomainWeights domainWeights);
	
	/**
	 * 根据id删除一条记录
	 * @param domainWeights
	 * @return
	 */
	public Result delete(int id);
	/**
	 * 
	 * @param host
	 * @return
	 */
	public Result list(String host);
}
