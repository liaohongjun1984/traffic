package com.devops.suc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.model.BusGroup;
import com.devops.suc.service.BusGroupService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.AuthencationHelper;

@ClassResourceDesc(firstCate="业务组织架构管理")
@Controller
@Scope("prototype")
public class BusGroupController {
	@Autowired
	private BusGroupService busGroupService;
	
	/**
	 * 获取业务架构列表
	 * @return
	 */
	@MethodResourceDesc(name = "获取二级业务架构")
	@RequestMapping(value = "/admin/group/listAllSecond.do")
	@ResponseBody	
	
	public Result listAllSecond(HttpServletRequest request,HttpServletResponse response){
		return busGroupService.listAllSecond();		
	}
	/**
	 * 获取业务架构列表
	 * @return
	 */
	@MethodResourceDesc(name = "获取业务架构列表")
	@RequestMapping(value = "/admin/group/list.do")
	@ResponseBody	
	
	public Result list(HttpServletRequest request,HttpServletResponse response){
		String user_name = AuthencationHelper.getUserName(request);
		int user_id = AuthencationHelper.getUserId(request);
		Result result = busGroupService.list(user_id, user_name);		
		return result;
	}
	
	/**
	 * 获取某一个架构
	 * @return
	 */
	@MethodResourceDesc(name = "获取某一个架构")
	@RequestMapping(value = "/admin/group/listOne.do")
	@ResponseBody	
	
	public Result listOneGroup(HttpServletRequest request,HttpServletResponse response){
		String user_name = AuthencationHelper.getUserName(request);
		int user_id = AuthencationHelper.getUserId(request);
		String group_id = request.getParameter("group_id");
		Result result = busGroupService.listChild(group_id, user_id, user_name);		
		return result;
	}
	
	/**
	 * 增加一个业务架构
	 * @return
	 */
	@MethodResourceDesc(name = "增加一个业务架构")
	@RequestMapping(value = "/admin/group/add.do")
	@ResponseBody	
	
	public Result add(HttpServletRequest request,HttpServletResponse response,BusGroup busGroup){
		String user_name = AuthencationHelper.getUserName(request);
		busGroup.setOperator(user_name);
		Result result = busGroupService.add(busGroup);		
		return result;
	}
	
	/**
	 * 更新一个业务架构
	 * @return
	 */
	@MethodResourceDesc(name = "修改一个业务架构")
	@RequestMapping(value = "/admin/group/update.do")
	@ResponseBody	
	
	public Result update(HttpServletRequest request,HttpServletResponse response,String name,String notes,String group_id){
		String user_name = AuthencationHelper.getUserName(request);
		Result result = busGroupService.update(name,notes,user_name,group_id);		
		return result;
	}
	
	/**
	 * 删除一个业务架构
	 * @return
	 */
	@MethodResourceDesc(name = "删除一个业务架构")
	@RequestMapping(value = "/admin/group/delete.do")
	@ResponseBody	
	
	public Result delete(HttpServletRequest request,HttpServletResponse response,String group_id){
		String user_name = AuthencationHelper.getUserName(request);
		Result result = busGroupService.delete(group_id);		
		return result;
	}
	
	/**
	 * 浏览业务架构下的人员
	 * @return
	 */
	@MethodResourceDesc(name = "浏览一个业务架构人员")
	@RequestMapping(value = "/admin/group/listUser.do")
	@ResponseBody	
	
	public Result listUser(HttpServletRequest request,HttpServletResponse response,String group_id){
		String user_name = AuthencationHelper.getUserName(request);
		Result result = busGroupService.listUser(group_id);		
		return result;
	}
	
	/**
	 * 增加业务架构下的人员
	 * @return
	 */
	@MethodResourceDesc(name = "增加一个架构人员")
	@RequestMapping(value = "/admin/group/addUser.do")
	@ResponseBody	
	
	public Result addUser(HttpServletRequest request,HttpServletResponse response,String group_id,String user_ids){
		Result result = busGroupService.addUser(group_id,user_ids);		
		return result;
	}
	/**
	 * 增加业务架构下的人员
	 * @return
	 */
	@MethodResourceDesc(name = "增加一个架构人员")
	@RequestMapping(value = "/admin/group/deleteUser.do")
	@ResponseBody
	public Result deleteUser(HttpServletRequest request,HttpServletResponse response){
		String group_id = request.getParameter("group_id");
		String user_id = request.getParameter("user_id");
		
		Result result = busGroupService.deleteUser(group_id,user_id);		
		return result;
	}
	
	/**
	 * 查询业务架构未添加的人员
	 * @return
	 */
	@MethodResourceDesc(name = "查询业务架构未添加的人员")
	@RequestMapping(value = "/admin/group/listNotInUser.do")
	@ResponseBody
	public Result listNotInUser(HttpServletRequest request,HttpServletResponse response){
		String group_id = request.getParameter("group_id");
		String user_name = request.getParameter("user_name");
		String nick_name = request.getParameter("nick_name");
		
		Result result = busGroupService.listNotInUser(group_id,user_name,nick_name);		
		return result;
	}
	
	/**
	 * 设置管理员
	 * @return
	 */
	@MethodResourceDesc(name = "查询业务架构未添加的人员")
	@RequestMapping(value = "/admin/group/setAdmin.do")
	@ResponseBody
	public Result setAdmin(HttpServletRequest request,HttpServletResponse response){
		String group_id = request.getParameter("group_id");
		String user_id = request.getParameter("user_id");
		
		Result result = busGroupService.setAdmin(group_id,user_id,true);		
		return result;
	}
	
	/**
	 * 取消管理员
	 * @return
	 */
	@MethodResourceDesc(name = "查询业务架构未添加的人员")
	@RequestMapping(value = "/admin/group/cancelAdmin.do")
	@ResponseBody
	public Result cancelAdmin(HttpServletRequest request,HttpServletResponse response){
		String group_id = request.getParameter("group_id");
		String user_id = request.getParameter("user_id");
		
		Result result = busGroupService.setAdmin(group_id,user_id,false);		
		return result;
	}
	
	/**
	 * 获取一级部门
	 * @return
	 */
	@MethodResourceDesc(name = "获取一级部门")
	@RequestMapping(value = "/admin/group/listFirDep.do")
	@ResponseBody
	public Result getFirGradeDep(HttpServletRequest request,HttpServletResponse response){
		Result result = busGroupService.getFirGradeDep();	
		return result;
	}
	
	@MethodResourceDesc(name = "业务架构列表")
	@RequestMapping(value = "/group/group_tree.jspx")
	public ModelAndView roleIndex(){
		return new ModelAndView("forward:/WEB-INF/pages/group/group_tree.jsp");  
	}	
	
}
