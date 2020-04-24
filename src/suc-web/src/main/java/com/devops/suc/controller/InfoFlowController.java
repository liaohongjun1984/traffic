package com.devops.suc.controller;

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
import com.devops.suc.service.AppService;
import com.devops.suc.service.InfoFlowService;
import com.devops.suc.service.UserService;
import com.devops.suc.vo.AppVO;
import com.devops.suc.vo.UpdatePwd;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.EncryptUtil;
import com.idhoo.dhutil.util.RequestUtil;
import com.idhoo.dhutil.util.Row;

@ClassResourceDesc(firstCate="用户工作台")
@Controller
@Scope("prototype")
public class InfoFlowController {
	@Autowired
	private InfoFlowService infoFlowService;
	@Autowired
	private AppService appService;
	@Autowired
	private UserService userService;
	
	/**
	 * 浏览信息
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "获取信息列表")
	@RequestMapping(value = "/user/infoFlowList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result listUserRole(HttpServletRequest request,HttpServletResponse response){
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int page = row.getInt("page", 1);
		int displayRecord = row.getInt("displayRecord", 20);
		row.put("start", (page - 1)*displayRecord);
		row.put("size", displayRecord);
		Result result = infoFlowService.list(row);
		return result;
	}
	@MethodResourceDesc(name = "工作台页面")
	@RequestMapping(value = "/user/index.jspx")
	public ModelAndView index(){
		return new ModelAndView("forward:/WEB-INF/pages/user/index.jsp");  
	}
	
	@MethodResourceDesc(name = "获取系统信息")
	@RequestMapping(value = "/user/listPrewApp.do", method = RequestMethod.GET)
	@ResponseBody	
	public Result listPrewApp(HttpServletRequest request,HttpServletResponse response){
		Authencation auth = new Authencation(request, response);
		int user_id = userService.get(auth.getUserName()).getUser_id();
		Result result = appService.listPrewApp(user_id);
		return result;
	}
	/**
	 * 过虑外部系统
	 * @param apps
	 * @param userName
	 * @param userip
	 */
	public void filter(List<AppVO> apps,String userName,String userip){
		String verify = "$YTKLPOI*-UU&^%GKJ-2EOI-UUIO-JUYOJ9";
		String time =String.valueOf(System.currentTimeMillis());

		verify = EncryptUtil.getMD5(userName + verify+ time+userip).toLowerCase();
		String verifyUrl = String.format("name=%s&verify=%s&time=%s&userip=%s", userName,verify,time,userip);
		for(AppVO vo : apps){
			if(vo.getApp_id()==20||vo.getApp_id()==22){
				if(vo.getUrl().indexOf("?")!=-1){
					vo.setUrl(vo.getUrl()+"&"+verifyUrl);
				}else{
					vo.setUrl(vo.getUrl()+"?"+verifyUrl);
				}
			}
		}
	}
	@MethodResourceDesc(name = "用户信息查看页面")
	@RequestMapping(value = "/user/user_view.jspx", method = RequestMethod.GET)
	public ModelAndView user_view(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("forward:/WEB-INF/pages/user/user_view.jsp");  
	}	
	@MethodResourceDesc(name = "修改用户密码")
	@RequestMapping(value = "/user/user_update_pwd.jspx")
	public ModelAndView user_update_pwd(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("forward:/WEB-INF/pages/user/user_update_pwd.jsp");  
	}
	@MethodResourceDesc(name = "后台修改用户密码")
	@RequestMapping(value = "/user/bd_user_update_pwd.jspx")
	public ModelAndView bd_user_update_pwd(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("forward:/WEB-INF/pages/user/bd_user_update_pwd.jsp");  
	}	
	@MethodResourceDesc(name = "修改用户信息")
	@RequestMapping(value = "/user/user_update_info.jspx")
	public ModelAndView user_update_info(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("forward:/WEB-INF/pages/user/user_update_info.jsp");  
	}		
	
	@MethodResourceDesc(name = "修改用户密码")
	@RequestMapping(value = "/user/updatePwd.do")
	@ResponseBody
	public Result getUserRole(HttpServletRequest request,HttpServletResponse response,UpdatePwd updatePwd){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		Authencation auth = new Authencation(request, response);
		updatePwd.setUsername(auth.getUserName());
		
		result = userService.updatePwd(updatePwd);
		
		return result;
	}	
	
	@MethodResourceDesc(name = "获取指定的用户信息")
	@RequestMapping(value = "/user/getUser.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getUser(HttpServletRequest request,HttpServletResponse response) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		Authencation auth = new Authencation(request, response);
		User user = userService.get(auth.getUserName());
		if (user != null) {
			result.setCode(ResultCode.SUCCESS);
			result.setObject(user);
		} else {
			result.setMessage("没有指定的用户数据.");
		}
		return result;
	}	
	
	@MethodResourceDesc(name = "修改用户密码")
	@RequestMapping(value = "/user/updateInfo.do", method = RequestMethod.GET)
	@ResponseBody
	public Result updateInfo(HttpServletRequest request,HttpServletResponse response,User user){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		Authencation auth = new Authencation(request, response);
		user.setUser_name(auth.getUserName());
		
		result = userService.updateInfo(user);
		
		return result;
	}	
}
