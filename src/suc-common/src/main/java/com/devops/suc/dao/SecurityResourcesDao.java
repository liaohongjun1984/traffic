package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.devops.suc.model.SecurityResources;

public interface SecurityResourcesDao extends SqlMapper{
	
	@Select("select * from security_resources where app_id=#{app_id} order by sequence")
	public List<SecurityResources> listByAppId(int app_id);
	
	@Select("select resources_id from menu_resources_relation where menu_id=#{menu_id}")
	public List<Integer> listMrr(int menu_id);
	
	@Select("select distinct sr.uri from role_menu_relation rmr " +
			"left join menu_resources_relation mrr on rmr.menu_id=mrr.menu_id " +
			"left join security_resources sr on sr.resources_id=mrr.resources_id " +
			"where rmr.role_id in (${ids})")
	public List<String> getUserUri(@Param("ids") String ids);
	
}
