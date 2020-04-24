package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.Menu;

public interface MenuDao extends SqlMapper{
	
	@Insert("insert into menu(app_id,parent_id,name,url,sequence,operator,last_modify,hide) values(#{app_id},#{parent_id},#{name},#{url},#{sequence},#{operator},now(),#{hide})")
	@SelectKey(statement = "select last_insert_id()", keyProperty = "menu_id", before = false, resultType = Integer.class)
	public int save(Menu menu);
	
	@Update("update menu set app_id=#{app_id},parent_id=#{parent_id},name=#{name},url=#{url},sequence=#{sequence},operator=#{operator},last_modify=now(),hide=#{hide} where menu_id=#{menu_id}")
	public void update(Menu menu);
	
	@Delete("delete from menu where menu_id=#{menu_id}")
	public void remove(int menu_id);
	
	@Select("select * from menu where app_id=#{app_id} order by sequence")
	public List<Menu> listByAppId(int app_id);
	
	@Select("select count(*) from role_menu_relation where menu_id=#{menu_id}")
	public int countMenuUse(int menu_id);
	
	@Select("select * from menu where parent_id=#{parent_id} order by sequence")
	public List<Menu> listByParentId(int parent_id);
	
	@Select("select * from menu where menu_id=#{menu_id}")
	public Menu getByMenuId(int menu_id);
	
	@Insert("insert into menu_resources_relation values(#{menu_id},#{resources_id})")
	public void saveMenuResource(@Param("menu_id") int menu_id,@Param("resources_id") int resources_id);
	
	@Delete("delete from menu_resources_relation where menu_id=#{menu_id}")
	public void clearMenuResource(int menu_id);
	
	@Select("select url from menu where menu_id in (select menu_id from role_menu_relation where role_id in (select role_id from user_role_relation where user_id=#{user_id})) and app_id=#{app_id} and parent_id!=0 and hide=0 order by sequence limit 1")
	public String getUserWelcomeUrl(@Param("user_id") int user_id,@Param("app_id") int app_id);
	
	@Select("select * from menu where " +
			" (menu_id in (select menu_id from role_menu_relation where role_id in (select role_id from user_role_relation where user_id=#{user_id})) or menu_id in (select m.parent_id from role_menu_relation r left join menu m on r.menu_id=m.menu_id where r.role_id in (select role_id from user_role_relation where user_id=#{user_id})))" +
			" and app_id=#{app_id} and hide=0 order by sequence ")
	public List<Menu> getUserMenu(@Param("user_id") int user_id,@Param("app_id") int app_id);
	
	/**
	 * 取超级管理员菜单
	 * @param user_id
	 * @param app_id
	 * @return
	 */
	@Select("select * from menu where app_id=#{app_id} and hide=0")
	public List<Menu> getSuperAdminMenu(@Param("app_id") int app_id);
	
	/**
	 * 取超级管理员登录后第一个url
	 * @param app_id	--系统id
	 * @return			--
	 */
	@Select("select url from menu where app_id=#{app_id} and parent_id!=0 and hide=0 order by sequence limit 1")
	public String getSuperAdminWelcomeUrl(@Param("app_id") int app_id);

}
