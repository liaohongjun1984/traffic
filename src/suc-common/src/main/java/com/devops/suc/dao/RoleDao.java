package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.Role;
import com.devops.suc.vo.RoleVO;
import com.idhoo.dhutil.util.Row;

public interface RoleDao extends SqlMapper{
	/**
	 * 查询角色信息
	 * 查询参数为 role_name,app_id
	 * @param row
	 * @return
	 */
	public List<RoleVO> list(Row row);
	
	/**
	 * 统计角色个数
	 * 查询参数为 role_name,app_id
	 * @param row
	 * @return
	 */
	public int count(Row row);
	
	public void add(Role role);
	/**
	 * 通过角色名称和系统ID获取角色
	 * @param role_name,app_id
	 */
	@Select("select * from role where app_id = #{app_id} and role_name = #{role_name}")
	public List<Role> getByNameAndApp(@Param("role_name") String role_name,@Param("app_id") int app_id);
	/**
	 * 通过系统ID获取角色
	 * @param app_id
	 */
	@Select("select * from role where app_id = #{app_id}")
	public List<Role> getByApp(@Param("app_id") int app_id);	
	/**
	 * 通过角色ID获取角色
	 * @param role_id
	 * @return
	 */
	@Select("select * from role where role_id = #{role_id}")
	public Role get(@Param("role_id") int role_id);
	
	@Update("delete from role where role_id = #{role_id}")
	public void delete(@Param("role_id") int role_id);
	/**
	 * 更新角色
	 * @param row
	 */
	public void update(Row row);
	/**
	 * 删除角色下用户
	 * @param row
	 */
	public void deleteRoleUser(Row row);
	/**
	 * 绑定用户和角色关系
	 * @param row
	 */
	public void bindUserRole(Row row);
	/**
	 * 复制角色用户
	 * @param copy_role_id
	 * @param role_id
	 */
	@Insert("insert into user_role_relation(user_id,role_id) select user_id,#{role_id} from user_role_relation where role_id = #{copy_role_id} ")
	public void copyRoleUser(@Param("copy_role_id")int copy_role_id,@Param("role_id")int role_id);
	/**
	 * 复制角色菜单
	 * @param copy_role_id
	 * @param role_id
	 */
	@Insert("insert into role_menu_relation(menu_id,role_id) select menu_id,#{role_id} from role_menu_relation where role_id = #{copy_role_id} ")
	public void copyRoleMenu(@Param("copy_role_id")int copy_role_id,@Param("role_id")int role_id);
	/**
	 * 获取角色下的菜单
	 * @param role_id
	 * @return
	 */
	@Select("select menu_id from menu where menu_id in (select menu_id from role_menu_relation where role_id = #{role_id})")
	public List<Integer> getMenu(@Param("role_id")int role_id);
	/**
	 * 删除角色下的菜单
	 * @param role_id
	 */
	@Delete("delete from role_menu_relation where role_id = #{role_id}")
	public void deleteMenuByRoleId(@Param("role_id")int role_id);
	/**
	 * 增加角色下的菜单
	 * @param role
	 */
	@Insert("insert into role_menu_relation(menu_id,role_id) values(#{menu_id},#{role_id})")
	public void addRoleMenu(Row row);
	
	/**
	 * 查找用户是否是超管
	 * @param user_id		--用户id
	 * @param role_name		--角色名称
	 * @return
	 */
	@Select("select count(*) from user_role_relation urr left join role r on urr.role_id = r.role_id where urr.user_id =#{user_id} and r.role_name=#{role_name}")
	public int isSuperAdmin(@Param("user_id")int user_id,@Param("role_name")String role_name);
	/**
	 * 
	 * @param role_name
	 * @return
	 */
	@Select("select * from role where role_name like CONCAT('%',#{role_name},'%')")
	public List<Role> getRoleByName(@Param("role_name") String role_name);

}
