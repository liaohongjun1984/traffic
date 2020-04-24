package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.AppGroup;

public interface AppGroupDao extends SqlMapper{

	/**
	 * 系统分组列表
	 * @return
	 */
	@Select("select * from app_group")
	public List<AppGroup> list();
	
	@Insert("insert into app_group(name,last_modify) values(#{name},now())")
	int save(AppGroup appGroup) ;	
	
	@Update("update app_group set name=#{name} where app_group_id=#{app_group_id}")
	void update(AppGroup appGroup) ;	
	
	@Delete("delete from app_group where app_group_id=#{app_group_id}")
	void delete(int app_group_id); 
	
	@Select("select count(*) as num from app where app_group_id=#{app_group_id}")
	int queryApp(int app_group_id);
	
	@Select("select * from app_group where name=#{name}")
	AppGroup queryByName(String name);
	
	@Select("select * from app_group where app_group_id=#{app_group_id}")
	AppGroup queryById(int app_group_id);	
}
