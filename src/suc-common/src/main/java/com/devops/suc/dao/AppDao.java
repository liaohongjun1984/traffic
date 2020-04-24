package com.devops.suc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.devops.suc.model.App;
import com.devops.suc.model.KeyValueSetting;
import com.devops.suc.vo.AppSearchVO;
import com.devops.suc.vo.AppVO;
import com.idhoo.dhutil.util.Row;

public interface AppDao extends SqlMapper{
	/**
	 * 查询系统 查询参数为 name app_group_id status
	 * 
	 * @param row
	 * @return
	 */
	public List<AppVO> list(Row row);
	
	//参数列表
	public List<KeyValueSetting> listParam();
	
	public KeyValueSetting getParamById(int param_id);

	/**
	 * 根据name、cn_name获取系统列表(严格匹配)
	 * 
	 * @param appSearchVO
	 *            --搜索条件
	 * @return
	 */
	public List<App> listAll(AppSearchVO appSearchVO);

	/**
	 * 统计系统个数 查询参数为 name app_group_id status
	 * 
	 * @param row
	 * @return
	 */
	public int count(Row row);
	
	@Update("update key_value_setting set value=#{value},name=#{name} where dic_key=#{dicKey}")
	public void updateParam(KeyValueSetting keyValueSetting);

	@Select("select * from app where name=#{name} and app_group_id=#{app_group_id}")
	public App getByNameAndGroup(App app);

	@Select("select * from app where app_id=#{app_id}")
	public App getByAppId(int app_id);

	@Insert("insert into app(name,cn_name,app_key,descript,status,app_group_id,url,sequence,operator,last_modify) values(#{name},#{cn_name},#{app_key},#{descript},#{status},#{app_group_id},#{url},#{sequence},#{operator},now())")
	public int save(App app);

	@Update("update app set name=#{name},cn_name=#{cn_name},app_key=#{app_key},descript=#{descript},status=#{status},app_group_id=#{app_group_id},url=#{url},sequence=#{sequence},operator=#{operator},last_modify=now() where app_id=#{app_id}")
	public void update(App app);

	public List<AppVO> listAppByUser(Row row);
	
	/**
	 * 查询所有有效的app
	 * @return
	 */
	public List<AppVO> listAllEffApp();
	
	@Select("select * from app")
	public List<App> listApp();
	
}
