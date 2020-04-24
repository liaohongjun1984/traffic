package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.User;
import com.devops.suc.vo.UpdatePwd;
import com.devops.suc.vo.UserSearchVO;
import com.devops.suc.vo.UserVO;
import com.idhoo.dhutil.util.Row;

public interface UserDao extends SqlMapper{

	public List<User> getUserByRoleId(Row row);
	
	public int countUserByRoleId(Row row);
	
	public List<User> getUserNotinRoleId(Row row);
	/**
	 * user_name get user info
	 * @param role_id
	 * @return
	 */
	@Select("select * from user where user_name = #{user_name} and del_flag!=1")
	public User get(@Param("user_name") String user_name);
	
	@Select("select * from user where user_id = #{user_id}")
	public User getByUserId(@Param("user_id") int user_id);
	
	@Select("select * from user")
	public List<User> getAllUser();
	
	@Insert("insert into user(user_name,nick_name,password,operator,status,mobile_no,work_no,department," +
			"yy_no,email,admin,meta_default_data,last_modify) " +
			" values " +
			"(#{user_name},#{nick_name},#{password},#{operator},#{status}" +
			",#{mobile_no},#{work_no},#{department},#{yy_no},#{email},#{admin}" +
			",#{meta_default_data},now())")
	public void save(User user);
	
	@Update("update user set user_name=#{user_name},nick_name=#{nick_name},operator=#{operator}," +
			"status=#{status},mobile_no=#{mobile_no},work_no=#{work_no},department=#{department},yy_no=#{yy_no}," +
			"email=#{email},admin=#{admin},meta_default_data=#{meta_default_data},last_modify=now() where user_id=#{user_id}")
	public void update(User user);
	/**
	 * 按条件搜索用户
	 * @param row
	 * @return
	 */
	public List<UserVO> list(UserSearchVO userSearchVO);
	/**
	 * 按条件搜索用户总数
	 * @param userSearchVO
	 * @return
	 */
	public int listCount(UserSearchVO userSearchVO);
	
	public List<User> getUserNotinGroupId(Row row);
	
	/**
	 * user_name get user info
	 * @param role_id
	 * @return
	 */
	@Select("select * from user where user_name like CONCAT('%',#{user_name},'%')")
	public List<User> getUsers(@Param("user_name") String user_name);
	
	/**
	 * nick_name get user info
	 * @param nick_name
	 * @return
	 */
	@Select("select * from user where nick_name like CONCAT('%',#{nick_name},'%')")
	public List<User> getUsersByNickName(@Param("nick_name") String nick_name);
	
	@Update("update user set password=#{new_pwd},status=1 where user_name=#{username}")
	public void updatePwd(UpdatePwd updatePwd);
	
	@Update("update user set nick_name=#{nick_name},mobile_no=#{mobile_no},work_no=#{work_no},department=#{department},yy_no=#{yy_no},email=#{email} where user_name=#{user_name}")
	public void updateInfo(User user);
	
	public void delete(int user_id);
}
