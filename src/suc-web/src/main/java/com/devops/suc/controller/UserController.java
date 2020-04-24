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
import com.devops.suc.model.User;
import com.devops.suc.service.SysLogService;
import com.devops.suc.service.UserService;
import com.devops.suc.vo.UpdatePwd;
import com.devops.suc.vo.UserRoleVO;
import com.devops.suc.vo.UserSearchVO;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;

@ClassResourceDesc(firstCate="用户管理")
@Controller
@Scope("prototype")
public class UserController{

	@Autowired
	private UserService userService;
	@Autowired
	private SysLogService sysLogService;
	
	@MethodResourceDesc(name = "查询符合条件的用户信息")
	@RequestMapping(value = "/admin/userList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result userList(UserSearchVO userSearchVO){
		Result result = userService.list(userSearchVO);
		return result;
	}
	
	@MethodResourceDesc(name = "获取指定的用户信息")
	@RequestMapping(value = "/admin/getUser.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getUser(UserSearchVO userSearchVO){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		User user = userService.get(userSearchVO.getUser_name());
		if(user!=null){
			result.setCode(ResultCode.SUCCESS);
			result.setObject(user);
		}else{
			result.setMessage("没有指定的用户数据.");
		}
		return result;
	}
	
	@MethodResourceDesc(name = "获取系统角色列表")
	@RequestMapping(value = "/admin/getUserRole.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getUserRole(UserSearchVO userSearchVO){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<UserRoleVO> urList = userService.listRoleByAppId(userSearchVO.getApp_id(), userSearchVO.getUser_id());
		if(urList!=null){
			result.setCode(ResultCode.SUCCESS);
			result.setObject(urList);
		}else{
			result.setMessage("没有指定的用户数据.");
		}
		return result;
	}
	
	@MethodResourceDesc(name = "获取用户角色")
	@RequestMapping(value = "/admin/userRole.do", method = RequestMethod.GET)
	@ResponseBody
	public Result userRole(UserSearchVO vo){
		Result result = userService.userRole(vo.getUser_id(), vo.getRole_id(),vo.isChecked());
		return result;
	}	
	
	@MethodResourceDesc(name = "保存用户角色")
	@RequestMapping(value = "/admin/saveUser.do", method = RequestMethod.GET)
	@ResponseBody
	public Result saveUser(HttpServletRequest request,HttpServletResponse response,User user){
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		user.setOperator(auth.getUserName());
		Result result = userService.save(user);
		
		Type targetType = new TypeToken<User>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_MENU, auth.getUserName(),JSONUtils.toJson(user,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}
	
	@MethodResourceDesc(name = "按照名称查询用户信息")
	@RequestMapping(value = "/admin/userListByUserName.do", method = RequestMethod.GET)
	@ResponseBody
	public Result userList(String user_name){
		Result result = userService.list(user_name);
		return result;
	}
	
	@MethodResourceDesc(name = "按照姓名查询用户信息")
	@RequestMapping(value = "/admin/userListByNickName.do", method = RequestMethod.GET)
	@ResponseBody
	public Result userListByNickName(String nick_name){
		Result result = userService.listByNickName(nick_name);
		return result;
	}
	
	@MethodResourceDesc(name = "设置是否为管理员")
	@RequestMapping(value = "/admin/setAdmin.do", method = RequestMethod.GET)
	@ResponseBody
	public Result setAdmin(HttpServletRequest request,HttpServletResponse response,User user){
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		User oldUser = userService.get(user.getUser_name());
		oldUser.setAdmin(user.getAdmin());
		oldUser.setOperator(auth.getUserName());
		Result result = userService.update(oldUser);
		
		Type targetType = new TypeToken<User>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(),JSONUtils.toJson(user,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}	
	
	@MethodResourceDesc(name = "重置用户密码")
	@RequestMapping(value = "/admin/updateUserPwd.do", method = RequestMethod.GET)
	@ResponseBody
	public Result updateUserPwd(HttpServletRequest request,HttpServletResponse response,UpdatePwd updatePwd){
		Result result = userService.updateUserPwd(updatePwd);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<UpdatePwd>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(),JSONUtils.toJson(updatePwd,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}
	
	@MethodResourceDesc(name = "根据id删除用户")	
	@RequestMapping(value = "/admin/deleteUserById.do", method = RequestMethod.GET)
	@ResponseBody
	public Result deleteUserById(HttpServletRequest request,HttpServletResponse response,User user){
		Result result = userService.deleteUserById(user);
		
		Authencation auth = new Authencation(request, response);
		Type targetType = new TypeToken<UpdatePwd>() {}.getType();
		sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(),JSONUtils.toJson(user,targetType, false), "操作结果:"+result.isSuccess());
		return result;
	}
	
	@MethodResourceDesc(name = "用户列表页面")
	@RequestMapping(value = "/admin/user_list.jspx")
	public ModelAndView userList(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/user_list.jsp");  
	}	
	@MethodResourceDesc(name = "用户信息查看")
	@RequestMapping(value = "/admin/user_view.jspx")
	public ModelAndView userView(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/user_view.jsp");  
	}		
	@MethodResourceDesc(name = "用户添加")
	@RequestMapping(value = "/admin/user_add.jspx")
	public ModelAndView userAdd(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/user_add.jsp");  
	}		
	@MethodResourceDesc(name = "角色待添加用户列表")
	@RequestMapping(value = "/admin/add_role_users.jspx")
	public ModelAndView addRoleUser(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/add_role_users.jsp");  
	}	
	@MethodResourceDesc(name = "角色列表")
	@RequestMapping(value = "/admin/role_index.jspx")
	public ModelAndView roleIndex(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/role_index.jsp");  
	}
	@MethodResourceDesc(name = "重置用户密码")
	@RequestMapping(value = "/admin/update_user_pwd.jspx")
	public ModelAndView resetUserPwd(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/update_user_pwd.jsp");  
	}
}
