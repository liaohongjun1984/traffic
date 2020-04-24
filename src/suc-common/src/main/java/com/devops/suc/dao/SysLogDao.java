package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

import com.devops.suc.model.SysLog;
import com.devops.suc.vo.SysLogSearchVO;

public interface SysLogDao extends SqlMapper{

	@Insert("insert into sys_log set " +
			"app_id=#{app_id},app_name=#{app_name},user_name=#{user_name}, " +
			"nick_name=#{nick_name},type=#{type},content=#{content},create_time=now(),result=#{result}")
	public void save(SysLog sysLog);
	
	public List<SysLog> search(SysLogSearchVO vo);
	
	public int searchCount(SysLogSearchVO vo);
}
