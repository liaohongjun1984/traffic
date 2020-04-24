package com.devops.suc.controller;

import java.lang.reflect.Type;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.model.App;
import com.devops.suc.model.AppGroup;
import com.devops.suc.model.KeyValueSetting;
import com.devops.suc.model.SecurityResources;
import com.devops.suc.service.AppService;
import com.devops.suc.service.MenuService;
import com.devops.suc.service.SysLogService;
import com.devops.suc.vo.AppSearchVO;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.RequestUtil;
import com.idhoo.dhutil.util.Row;

@ClassResourceDesc(firstCate="系统及系统分组管理")
@Controller
@Scope("prototype")
public class AppController {

	@Autowired
	private AppService appService;
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private MenuService menuService;
	
	@MethodResourceDesc(name = "获取系统分组列表")
	@RequestMapping(value = "/admin/appGroupList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result appGroupList(){
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		List<AppGroup> appGroupList = appService.listGroup();
		result.setObject(appGroupList);
		
		return result;
	}
	
	@MethodResourceDesc(name = "删除系统分组")
	@RequestMapping(value = "/admin/appGroupRemove.do", method = RequestMethod.GET)
	@ResponseBody
	public Result appGroupRemove(HttpServletRequest request,HttpServletResponse response,int app_group_id){
		Result result = appService.delAppGroup(app_group_id);
		
		// 从cookie获取用户信息
		Authencation auth = new Authencation(request, response);		
		sysLogService.addLog(SucConstant.sysLogType_APPGROUP, auth.getUserName(), "删除系统分组ID:"+app_group_id, "操作结果:"+result.isSuccess());
		
		return result;
	}	
	
	@MethodResourceDesc(name = "保存系统分组")
	@RequestMapping(value = "/admin/appGroupSave.do", method = RequestMethod.GET)
	@ResponseBody
	public Result appGroupSave(HttpServletRequest request,HttpServletResponse response,AppGroup appGroup){
		Result result = appService.saveAppGroup(appGroup);
		
		// 从cookie获取用户信息
		Authencation auth = new Authencation(request, response);	
		Type targetType = new TypeToken<AppGroup>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_APPGROUP, auth.getUserName(),JSONUtils.toJson(appGroup,targetType, false), "操作结果:"+result.isSuccess());
				
		return result;
	}	
	
	@MethodResourceDesc(name = "修改系统参数")
	@RequestMapping(value = "/admin/updateParam.do", method = RequestMethod.GET)
	@ResponseBody
	public Result updateParam(HttpServletRequest request,HttpServletResponse response,KeyValueSetting keyValueSetting){
		Result result = appService.updateParam(keyValueSetting);
		
		//YctBdAuthencation auth = new YctBdAuthencation(request, response);
		//Type targetType = new TypeToken<KeyValueSetting>() {}.getType();
		//sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(),JSONUtils.toJson(keyValueSetting,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}
	
	@MethodResourceDesc(name = "获取系统分组信息")
	@RequestMapping(value = "/admin/getAppGroup.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getAppGroup(int app_group_id){
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		AppGroup appGroup = appService.getAppGroup(app_group_id);
		result.setObject(appGroup);
		
		return result;
	}
	
	@MethodResourceDesc(name = "按条件获取系统列表")
	@RequestMapping(value = "/admin/getAppList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getAppList(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);	
		row.put("start", 0);
		row.put("size", Integer.MAX_VALUE);
		Result result  = appService.listApp(row);
		return result;
	}	
	
	@MethodResourceDesc(name = "获取参数列表")
	@RequestMapping(value = "/admin/getParamList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getParamList(){
		Result result  = appService.listParam();
		return result;
	}	
	
	@MethodResourceDesc(name = "按ID获取参数列表")
	@RequestMapping(value = "/admin/getParamById.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getParamById(String param_id){
		int id = Integer.parseInt(param_id);
		Result result  = appService.getParamById(id);
		return result;
	}	
	
	@MethodResourceDesc(name = "根据name、cn_name获取系统列表(严格匹配)")
	@RequestMapping(value = "/admin/queryApp.do", method = RequestMethod.GET)
	@ResponseBody
	public Result queryApp(AppSearchVO appSearchVO) {
		Result result = appService.listAll(appSearchVO);
		return result;
	}
	
	@MethodResourceDesc(name = "获取指定系统的信息")
	@RequestMapping(value = "/admin/getApp.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getApp(int app_id){
		Result result  = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		App app = appService.getApp(app_id);
		result.setObject(app);
		
		return result;
	}	
	
	@MethodResourceDesc(name = "禁用与启用指定系统")
	@RequestMapping(value = "/admin/disableAndAble.do", method = RequestMethod.GET)
	@ResponseBody
	public Result disableAndAble(HttpServletRequest request,HttpServletResponse response,int app_id,int status){
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		Result result  = appService.disableAndAble(app_id, status, auth.getUserName());
		sysLogService.addLog(SucConstant.sysLogType_APP, auth.getUserName(), "操作："+status+" app_id:"+app_id, "操作结果:"+result.isSuccess());		
		return result;
	}
	
	@MethodResourceDesc(name = "保存系统信息")
	@RequestMapping(value = "/admin/appSave.do", method = RequestMethod.GET)
	@ResponseBody
	public Result appSave(HttpServletRequest request,HttpServletResponse response,App app){
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		app.setOperator(auth.getUserName());
		Result result  = appService.saveApp(app);
		
		Type targetType = new TypeToken<App>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_APP, auth.getUserName(), JSONUtils.toJson(app,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}	
	
	@MethodResourceDesc(name = "获取指定系统资源")
	@RequestMapping(value = "/admin/appResource.do", method = RequestMethod.GET)
	@ResponseBody	
	public Result appResource(int app_id){
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		List<SecurityResources> srs = menuService.getAppResource(app_id);
		result.setObject(srs);
		return result;
	}
	
	
	@MethodResourceDesc(name = "更新系统")
	@RequestMapping(value = "/admin/updateSystem.do")
	@ResponseBody
	public Result updateSystem(){	
		Result result = appService.updateSystem();
		return result;
	}

	@MethodResourceDesc(name = "系统分组管理")
	@RequestMapping(value = "/admin/app_group_list.jspx")
	public ModelAndView groupList(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_group_list.jsp");  
	}
	
	@MethodResourceDesc(name = "系统分组添加")
	@RequestMapping(value = "/admin/app_group_add.jspx")
	public ModelAndView groupAdd(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_group_add.jsp");  
	}	
	
	@MethodResourceDesc(name = "系统列表")
	@RequestMapping(value = "/admin/app_list.jspx")
	public ModelAndView appList(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_list.jsp");  
	}		
	
	@MethodResourceDesc(name = "系统添加")
	@RequestMapping(value = "/admin/app_add.jspx")
	public ModelAndView appAdd(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_add.jsp");  
	}
	
	@MethodResourceDesc(name = "系统菜单")
	@RequestMapping(value = "/admin/app_menu.jspx")
	public ModelAndView appMenu(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_menu.jsp");  
	}
	
	@MethodResourceDesc(name = "参数查看")
	@RequestMapping(value = "/admin/param_list.jspx")
	public ModelAndView listParam(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/param_list.jsp");  
	}
	@MethodResourceDesc(name = "参数修改")
	@RequestMapping(value = "/admin/param_update.jspx")
	public ModelAndView updateParam(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/param_update.jsp");  
	}
	
	@MethodResourceDesc(name = "系统资源查看")
	@RequestMapping(value = "/admin/app_resource.jspx")
	public ModelAndView resource(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/app_resource.jsp");  
	}
	
}
	
	
