package com.devops.suc.service;

import java.util.List;

import com.devops.suc.model.App;
import com.devops.suc.model.AppGroup;
import com.devops.suc.model.KeyValueSetting;
import com.devops.suc.vo.AppSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.util.Row;

public interface AppService {
	/**
	 * 列出当前所有可用的应用系统
	 * @return
	 */
	public Result listUseApp();
	/**
	 * 列出所有的APP数据
	 * @param row
	 * @return
	 */
	public Result listApp(Row row);
	
	/**
	 * 根据name、cn_name获取系统列表(严格匹配)
	 * @param appSearchVO --搜索条件
	 * @return
	 */
	public Result listAll(AppSearchVO appSearchVO);
	/**
	 * 增加应用系统
	 * @param appVO
	 * @return
	 */
	public Result saveApp(App app);
	/**
	 * 禁用启用应用系统功能
	 * @param id
	 * @param status
	 * @return
	 */
	public Result updateStatus(int id,String operator,short status);
	/**
	 * 通过ID获取应用系统
	 * @param id
	 * @return
	 */
	public App    getApp(int id);
	
	/**
	 * 获取所有的系统分组
	 * @return
	 */
	public List<AppGroup> listGroup();
	
	/**
	 * 删除系统分组
	 * @param app_group_id
	 * @return
	 */
	public Result delAppGroup(int app_group_id);
	
	/**
	 * 保存用户的分组
	 * @param appGroup
	 * @return
	 */
	public Result saveAppGroup(AppGroup appGroup);
	
	public AppGroup getAppGroup(int app_group_id);
	
	public App getByAppId(int app_id);
	
	public Result disableAndAble(int app_id,int status,String operator);
	/**
	 * 获取用户系统
	 * @param user_name
	 * @return
	 */
	public Result listPrewApp(int user_id);
	public Result listParam();
	public Result updateParam(KeyValueSetting keyValueSetting);
	public List<App> listApp();
	public Result listMenu(int app_id);
	public Result getParamById(int param_id);
	
	//更新系统操作
	public Result updateSystem();
	
}
