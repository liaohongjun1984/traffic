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
import com.devops.suc.model.Role;
import com.devops.suc.service.RoleService;
import com.devops.suc.service.SysLogService;
import com.devops.suc.util.SucUtil;
import com.devops.suc.vo.MenuVO;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.AuthencationHelper;
import com.idhoo.dhutil.util.RequestUtil;
import com.idhoo.dhutil.util.Row;

/**
 * 用户角色管理
 * @author wangxc
 *
 */
@ClassResourceDesc(firstCate="用户角色管理")
@Controller
@Scope("prototype")
public class UserRoleController {
	@Autowired
	private RoleService roleService;
	@Autowired
	private SysLogService sysLogService;
	/**
	 * 浏览角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "获取角色列表")
	@RequestMapping(value = "/admin/roleList.do")
	@ResponseBody
	public Result listUserRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int page = row.getInt("page", 1);
		int displayRecord = row.getInt("displayRecord", 20);
		row.put("start", (page - 1)*displayRecord);
		row.put("size", displayRecord);
		Result result = roleService.listRole(row);
		return result;
	}
	/**
	 * 新增角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "新增角色")
	@RequestMapping(value = "/admin/addRole.do")
	@ResponseBody
	public Result addUserRole(HttpServletRequest request,HttpServletResponse response){
		Role role = (Role)SucUtil.getObjectFromReqeust(request, new Role());
		String username = AuthencationHelper.getUserName(request);
		role.setOperator(username);
		Result result = roleService.setRole(role);
		
		Authencation auth = new Authencation(request, response);		
		Type targetType = new TypeToken<Role>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(role,targetType, false), "操作结果:"+result.isSuccess());
		
		return result;
	}
	/**
	 * 获取角色信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "获取角色信息")
	@RequestMapping(value = "/admin/getRole.do")
	@ResponseBody
	public Result getUserRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.getRole(row.getInt("role_id", 0));
		return result;
	}
	
	/**
	 * 删除角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "删除角色")
	@RequestMapping(value = "/admin/deleteRole.do")
	@ResponseBody
	public Result deleteUserRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.delete(row.getInt("role_id", 0));		
		
		Authencation auth = new Authencation(request, response);		
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),"删除角色ID："+row.getInt("role_id", 0), "操作结果:"+result.isSuccess());
		
		return result;
	}
	
	/**
	 * 更新角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "更新角色")
	@RequestMapping(value = "/admin/updateRole.do")
	@ResponseBody
	public Result updateUserRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		String username = AuthencationHelper.getUserName(request);
		row.put("operator", username);
		Result result = roleService.update(row);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
				
		return result;
	}
	
	/**
	 * 通过角色获取用户信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "通过角色获取用户信息")
	@RequestMapping(value = "/admin/getUserByRole.do")
	@ResponseBody
	public Result getUserByRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int page = row.getInt("page", 1);
		int displayRecord = row.getInt("displayRecord", 20);
		row.put("start", (page - 1)*displayRecord);
		row.put("size", displayRecord);
		Result result = roleService.getUserByRole(row);
		return result;
	}
	
	/**
	 * 更新角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "删除角色")
	@RequestMapping(value = "/admin/deleteRoleUser.do")
	@ResponseBody
	public Result deleteRoleUser(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		String username = AuthencationHelper.getUserName(request);
		row.put("operator", username);
		Result result = roleService.deleteRoleUser(row);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
						
		return result;
	}
	
	/**
	 * 获取没有角色下的用户信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "获取没有角色下的用户信息")
	@RequestMapping(value = "/admin/getNotUserByRole.do")
	@ResponseBody
	public Result getNotUserByRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.getNotUserByRole(row);
		return result;
	}
	
	/**
	 * 绑定角色用户
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "绑定角色用户")
	@RequestMapping(value = "/admin/bindRoleUsers.do")
	@ResponseBody
	public Result bindRoleUsers(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.bindRoleUsers(row);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
		
		return result;
	}
	
	
	/**
	 * 快速修改角色下的用户信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "快速修改角色下的用户信息")
	@RequestMapping(value = "/admin/qucikRoleUser.do")
	@ResponseBody
	public Result qucikRoleUser(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.qucikRoleUser(row);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
				
		return result;
	}
	
	
	/**
	 * 快速修改角色下的用户信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "快速复制角色下的用户信息")
	@RequestMapping(value = "/admin/copyRoleUser.do")
	@ResponseBody
	public Result copyRoleUser(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.copyRoleUser(row);	
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
			
		return result;
	}
	@MethodResourceDesc(name = "用户角色")
	@RequestMapping(value = "/admin/user_role.jspx")
	public ModelAndView userRole(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/user_role.jsp");  
	}	
	@MethodResourceDesc(name = "角色用户列表")
	@RequestMapping(value = "/admin/role_users.jspx")
	public ModelAndView roleUser(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/role_users.jsp");  
	}	
	@MethodResourceDesc(name = "添加角色")
	@RequestMapping(value = "/admin/role_op.jspx")
	public ModelAndView roleOp(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/role_op.jsp");  
	}	
	@MethodResourceDesc(name = "快速复制角色")
	@RequestMapping(value = "/admin/quick_mr_role_users.jspx")
	public ModelAndView quickCpRole(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/quick_mr_role_users.jsp");  
	}
	@MethodResourceDesc(name = "配置角色菜单")
	@RequestMapping(value = "/admin/role_menu.jspx")
	public ModelAndView roleMenu(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/role_menu.jsp");  
	}	
	/**
	 * 获取角色下的菜单信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "获取角色菜单")
	@RequestMapping(value = "/admin/getRoleMenu.do")
	@ResponseBody
	public Result getRoleMenu(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = roleService.getRoleMenu(row);
		return result;
	}
	
	/**
	 * 修改角色下的菜单信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "更新角色菜单")
	@RequestMapping(value = "/admin/updateRoleMenu.do")
	@ResponseBody
	public Result updateRoleMenu(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<MenuVO> menus = null;
		try{
			menus  = JSONUtils.fromJson(row.gets("data"), new TypeToken<List<MenuVO>>(){});		
		}catch(Exception e){
			e.printStackTrace();
			result.setMessage(e.getMessage());
		}
		if(menus!=null){
			result = roleService.updateRoleMenu(menus, row.getInt("role_id"));
		}
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<Row>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_ROLE, auth.getUserName(),JSONUtils.toJson(row,targetType, false), "操作结果:"+result.isSuccess());
			
		return result;
	}
	
	/**
	 * 浏览角色
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "通过名称获取角色列表")
	@RequestMapping(value = "/admin/roleListByName.do")
	@ResponseBody
	public Result listUserRoleByName(String role_name){
		Result result = roleService.listRoleByName(role_name);
		return result;
	}

}
