package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.devops.suc.model.UserRoleRelation;

public interface UserRoleRelationDao extends SqlMapper{

	@Insert("insert into user_role_relation(user_id,role_id) values(#{userRoleRelation.user_id},#{userRoleRelation.role_id})")
	int save(@Param("userRoleRelation") UserRoleRelation userRoleRelation) ;
	
	@Delete("delete from user_role_relation where user_id=#{userRoleRelation.user_id} and role_id=#{userRoleRelation.role_id}")
	void remove(@Param("userRoleRelation") UserRoleRelation userRoleRelation);
	
	@Select("SELECT * FROM user_role_relation WHERE user_id = #{user_id}")
	List<UserRoleRelation> getByUserId(@Param("user_id") int user_id);
	
	@Select("select r.role_id from user_role_relation urr " +
			"left join role r on urr.role_id=r.role_id " +
			"where app_id=#{app_id} and  user_id=#{user_id}")
	List<Integer> getUserRoleByAppId(@Param("user_id") int user_id,@Param("app_id") int app_id);
	 
}
