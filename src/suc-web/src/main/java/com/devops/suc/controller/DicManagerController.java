package com.devops.suc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.model.App;
import com.devops.suc.service.AppService;
import com.devops.suc.service.MenuService;
import com.devops.suc.service.SysLogService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate="系统及系统分组管理")
@Controller
@Scope("prototype")
public class DicManagerController {
	
	@Autowired
	private AppService appService;
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private MenuService menuService;
	
	@MethodResourceDesc(name = "获取字典分组列表")
	@RequestMapping(value = "/admin/appList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result appGroupList(){
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		List<App> appList = appService.listApp();
		result.setObject(appList);
		
		return result;
	}
	
	@MethodResourceDesc(name = "字典资源查看")
	@RequestMapping(value = "/admin/dic_manager.jspx")
	public ModelAndView resource(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/dic_manager.jsp");  
	}
	
	@MethodResourceDesc(name = "按条件获取系统列表")
	@RequestMapping(value = "/admin/getMenuList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getAppList(int app_id){
		
		Result result  = appService.listMenu(app_id);
		return result;
	}	
	
}
	
	
