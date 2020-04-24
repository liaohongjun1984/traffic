package com.devops.suc.controller;

import java.lang.reflect.Type;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.model.Menu;
import com.devops.suc.model.SecurityResources;
import com.devops.suc.model.SecurityResourcesVO;
import com.devops.suc.service.MenuService;
import com.devops.suc.service.SysLogService;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;

@ClassResourceDesc(firstCate="菜单管理")
@Controller
@Scope("prototype")
public class MenuController {

	@Autowired
	private MenuService menuService;
	@Autowired
	private SysLogService sysLogService;
	
	/**
	 * 修改与移动菜单
	 * @param menus
	 * @param operator
	 * @return
	 */
	@MethodResourceDesc(name = "修改与移动菜单")
	@RequestMapping(value = "/admin/menu/modifyMenu.do")
	@ResponseBody	
	public Result modifyMenu(HttpServletRequest request,HttpServletResponse response,String data){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<Menu> menus = null;
		try{
			menus  = JSONUtils.fromJson(data, new TypeToken<List<Menu>>(){});		
		}catch(Exception e){
			e.printStackTrace();
			result.setMessage(e.getMessage());
		}
		if(menus!=null){
			// 设置cookie
			Authencation auth = new Authencation(request, response);
			result = menuService.modifyMenu(menus,auth.getUserName()==null?"noLogin":auth.getUserName());	
			
			sysLogService.addLog(SucConstant.sysLogType_MENU, auth.getUserName(), data, "操作结果:"+result.isSuccess());
		}
		return result;
	}
	/**
	 * 删除菜单
	 * @param menu_id
	 * @return
	 */
	@MethodResourceDesc(name = "删除菜单")
	@RequestMapping(value = "/admin/menu/removeMenu.do")
	@ResponseBody	
	public Result removeMenu(HttpServletRequest request,HttpServletResponse response,int menu_id){
		Result result = menuService.removeMenu(menu_id);
		Authencation auth = new Authencation(request, response);
		sysLogService.addLog(SucConstant.sysLogType_MENU, auth.getUserName(), "删除的菜单ID："+menu_id, "操作结果:"+result.isSuccess());
		return result;
	}
	/**
	 * 按系统ID获取菜单列表
	 * @param app_id
	 * @return
	 */
	@MethodResourceDesc(name = "按系统ID获取菜单列表")
	@RequestMapping(value = "/admin/menu/listByAppId.do")
	@ResponseBody	
	public Result listByAppId(int app_id){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<Menu> menus = menuService.listByAppId(app_id);
		if(menus.size()==0){
			Menu menu = new Menu();
			menu.setApp_id(app_id);
			menu.setMenu_id(0);
			menu.setParent_id(0);
			menu.setName("自动生成的菜单");
			menu.setUrl("#");
			menu.setOperator("auto_create");
			menu.setSequence(0.0f);
			
		}
		result.setObject(menus);
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	/**
	 * 添加菜单
	 * @param request
	 * @param response
	 * @param menu
	 * @return
	 */
	@MethodResourceDesc(name = "添加菜单")
	@RequestMapping(value = "/admin/menu/addMenu.do")
	@ResponseBody	
	public Result addMenu(HttpServletRequest request,HttpServletResponse response,Menu menu){
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		menu.setOperator(auth.getUserName()==null?"noLogin":auth.getUserName());
		Result result = menuService.addMenu(menu);
		
		Type targetType = new TypeToken<Menu>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_MENU, auth.getUserName(),JSONUtils.toJson(menu,targetType, false), "操作结果:"+result.isSuccess());
		
		return result;
	}
	/**
	 * 获取菜单对应的权限
	 * @param request
	 * @param response
	 * @param menu
	 * @return
	 */
	@MethodResourceDesc(name = "获取菜单对应的权限")
	@RequestMapping(value = "/admin/menu/getMenuResource.do")
	@ResponseBody	
	public Result getMenuResource(int menu_id){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<SecurityResourcesVO> resources = menuService.getMenuResource(menu_id);
		result.setObject(resources);
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}	
	/**
	 * 修改菜单对应的资源
	 * @param request
	 * @param response
	 * @param menu
	 * @return
	 */
	@MethodResourceDesc(name = "修改菜单对应的资源")
	@RequestMapping(value = "/admin/menu/modifyMenuResource.do")
	@ResponseBody	
	public Result modifyMenuResource(HttpServletRequest request,HttpServletResponse response,String data,int menu_id){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<SecurityResources> srs = null;
		try{
			srs  = JSONUtils.fromJson(data, new TypeToken<List<SecurityResources>>(){});		
		}catch(Exception e){
			e.printStackTrace();
			result.setMessage(e.getMessage());
		}
		if(srs!=null){
			result = menuService.modifyMenuResource(srs, menu_id);
			result.setCode(ResultCode.SUCCESS);
		}
		Authencation auth = new Authencation(request, response);
		sysLogService.addLog(SucConstant.sysLogType_MENU, auth.getUserName(),data, "操作结果:"+result.isSuccess());
		return result;
	}		
	@MethodResourceDesc(name = "菜单资源管理界面")
	@RequestMapping(value = "/admin/menu_resource.jspx")
	public ModelAndView menuResource(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/menu_resource.jsp");  
	}		
}
