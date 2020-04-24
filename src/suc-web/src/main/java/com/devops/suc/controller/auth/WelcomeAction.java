package com.devops.suc.controller.auth;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.model.Menu;
import com.devops.suc.service.DomainWeightsService;
import com.devops.suc.service.MemcacheService;
import com.devops.suc.service.MenuService;
import com.devops.suc.service.SecurityService;
import com.devops.suc.service.SysLogService;
import com.devops.suc.service.UserService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.AuthencationHelper;

@ClassResourceDesc(firstCate="系统界面接口")
@Controller
@Scope("prototype")
public class WelcomeAction {
	
	protected static Logger logger = Logger.getLogger(WelcomeAction.class);
	
	@Autowired
	private MenuService menuService;

	@Autowired
	private MemcacheService memcacheService;
	
	@Autowired
	private SecurityService securityService;
	
	@Autowired
	private DomainWeightsService domainWeightsService;
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private UserService userService;	
	
	/**
	 * 退出请求，清理缓存数据
	 * @param request
	 * @param response
	 * @return
	 */
	@MethodResourceDesc(name = "退出系统")
	@RequestMapping(value = "/admin/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request,HttpServletResponse response){
		
		//clear memcache user data
		Authencation auth = new Authencation(request, response);
		//删除第一次访问的标志
		Authencation.removeFirstRequest(request, response);
		//删除cookie中的用户信息
		AuthencationHelper.clearAllCookie(request,response);
		//退出时，跳转到主域进行跳转
		String url  = "/udbSdkLogin.jsp";
		return new ModelAndView(new RedirectView(url));
	}
	
	@MethodResourceDesc(name = "登录跳转")
	@RequestMapping(value = "/admin/welcome.jspx", method = RequestMethod.GET)
	public ModelAndView adminWelcom(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		String port = request.getServerPort() == 80 ? "" : ":" + request.getServerPort();
		String basePath = request.getScheme() + "://" + request.getServerName() + port;
		
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		
		String url = menuService.getUserWelcomeUrl(userService.get(auth.getUserName()).getUser_id(),SucConstant.app_id);
		if(url==null){
			request.setAttribute("error", "用户没有配置任何权限，请联系管理员开启权限.");
			request.getRequestDispatcher("/error.jsp").forward(request,response);
			return null;
		}
		String redirect = basePath + url;
		return new ModelAndView(new RedirectView(redirect));
	}

	@MethodResourceDesc(name = "获取左侧菜单")
	@RequestMapping(value = "/admin/menu.do", method = RequestMethod.GET)
	@ResponseBody
	public Result menu(HttpServletRequest request, HttpServletResponse response) {
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		List<Menu> menus = menuService.getUserMenu(userService.get(auth.getUserName()).getUser_id(),SucConstant.app_id);
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(menus);
		return result;
	}
	
	@MethodResourceDesc(name = "登录页面")
	@RequestMapping(value = "/admin/index.jspx")
	public ModelAndView index(){
		return new ModelAndView("forward:/WEB-INF/login.jsp");  
	}
	
	@MethodResourceDesc(name = "登录接口")
	@RequestMapping(value = "/admin/login.do")
	@ResponseBody
	public Result login(HttpServletRequest request,HttpServletResponse response,String username,String password) throws UnsupportedEncodingException{

		Result result  = securityService.login(username, password, response, request);
		return result;
	}
	
	@MethodResourceDesc(name = "欢迎接口")
	@RequestMapping(value = "/welcome.do", method = RequestMethod.GET)
	public ModelAndView welcome(HttpServletRequest request,HttpServletResponse response) {
		
		Authencation auth = new Authencation(request, response);
		
		String port = request.getServerPort() == 80 ? "" : ":"+ request.getServerPort();
		String basePath = request.getScheme() + "://" + request.getServerName() + port;
		
		String redirect = "";
		redirect = basePath + "/admin/welcome.jspx";
		return new ModelAndView(new RedirectView(redirect));
	}

}
