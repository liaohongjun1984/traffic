package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.BusGroup;
import com.devops.suc.model.User;
import com.devops.suc.model.UserGroupRelation;
import com.devops.suc.vo.BusGroupVO;
import com.devops.suc.vo.GroupUserVO;
import com.devops.suc.vo.UserGroupRelationVO;
import com.idhoo.dhutil.util.Row;

public interface BusGroupDao extends SqlMapper{
	
	@Select("select u.* from user_group_relation ugr left join user u on ugr.user_id=u.user_id where ugr.group_id=#{group_id}")
	public List<User> listUserByGroup(@Param("group_id") String group_id);
	/**
	 * 浏览group_id（含）所有子节点
	 * @param group_id
	 * @return
	 */
	public List<BusGroupVO> listChilds(Row row);
	/**
	 * 查询用户所在的组ID
	 * @param user_id
	 * @return
	 */
	@Select("select u.*,b.name from user_group_relation u left join bus_group b on u.group_id = b.group_id where u.user_id = #{user_id}")
	public List<UserGroupRelationVO> getGroupIds(@Param("user_id") int user_id);
	/**
	 * 增加业务分组
	 * @param vo
	 */
	@Insert("insert into bus_group (group_id,parent_id,name,notes,status,last_modify,operator) " +
			"values(#{group_id},#{parent_id},#{name},#{notes},#{status},now(),#{operator})")
	public void add(BusGroup vo);
	/**
	 * 更新分组
	 * @param vo
	 */
	@Update("update bus_group set name = #{name},notes = #{notes},last_modify = now(),operator = #{operator} where group_id = #{group_id}")
	public void update(@Param("name")String name,@Param("notes")String notes,@Param("operator")String operator,@Param("group_id")String group_id);
	/**
	 * 删除分组
	 * @param group_id
	 */
	@Delete("delete from bus_group where group_id = #{group_id}")
	public void delete(@Param("group_id")String group_id);
	/**
	 * 查询某个分组的人员
	 * @param group_id
	 */
	@Select("select u.*,g.group_id,g.charge_admin from user u left join user_group_relation g on u.user_id = g.user_id where g.group_id = #{group_id}")
	public List<GroupUserVO> listGroupUser(@Param("group_id")String group_id);
	
	/**
	 * 根据ID获取组织架构
	 * @param name
	 * @return
	 */
	@Select("select * from bus_group where group_id = #{group_id}")
	public BusGroup getBusGroupByID(@Param("group_id")String group_id);
	/**
	 * 增加业务人员
	 * @param row
	 */
	public void addGroupUser(Row row);
	
	/**
	 * 删除业务人员
	 * @param row
	 */
	@Delete("delete from user_group_relation where group_id = #{group_id} and user_id = #{user_id}")
	public void deleteGroupUser(@Param("group_id")String group_id,@Param("user_id")String user_id);
	/**
	 * 设置管理员
	 * @param group_id
	 * @param user_id
	 */
	@Update("update user_group_relation set charge_admin = #{charge_admin} where group_id=#{group_id} and user_id = #{user_id}")
	public void setAdmin(@Param("group_id")String group_id,@Param("user_id")String user_id,@Param("charge_admin")String charge_admin);
	/**
	 * 
	 * @return
	 */
	@Select("select u.*,b.name from user_group_relation u left join bus_group b on u.group_id = b.group_id")
	public List<UserGroupRelationVO> list();
	
	@Select("select * from bus_group where parent_id in (select group_id from bus_group where parent_id='00')")
	public List<BusGroup> getFirGradeDep();
	
	@Select("select * from user_group_relation where user_id=#{user_id}")
	public List<UserGroupRelation> getByUserId(@Param("user_id") int user_id);
}
