package com.devops.suc.interceptor;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StopWatch;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.service.PrivilegeService;
import com.devops.suc.service.RoleService;
import com.devops.suc.service.UserService;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.ResponseUtils;

/**
 * 权限验证拦截器
 * @author wangxichun
 *
 */
public class AuthInterceptor implements HandlerInterceptor{ 
	
	private static final Logger log = Logger.getLogger(AuthInterceptor.class);
	
	private String[] excludeUrls;
	private String loginUrl;
	private String errorUrl;

	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;	
	@Autowired
	private PrivilegeService privilegeService;
	
	private static Map<String,List<String>> uriCaceh = new HashMap<String,List<String>>();
	
	private ThreadLocal<StopWatch> stopWatchLocal = new ThreadLocal<StopWatch>();
	
	
	public String[] getExcludeUrls() {
		return excludeUrls;
	}

	public void setExcludeUrls(String[] excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	public String getLoginUrl() {
		return loginUrl;
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}

	public String getErrorUrl() {
		return errorUrl;
	}

	public void setErrorUrl(String errorUrl) {
		this.errorUrl = errorUrl;
	}
	
	public void afterCompletion(HttpServletRequest request,  
            HttpServletResponse response, Object arg2, Exception e)  
            throws Exception {  
		
		 StopWatch stopWatch = stopWatchLocal.get(); 
         stopWatch.stop(); 
         if(stopWatch.getTotalTimeMillis()>3000){
             String currentPath = request.getRequestURI(); 
             String queryString  = request.getQueryString(); 
             queryString = queryString == null ? "":"?" + queryString; 
             log.info("access url path:" + currentPath + queryString +  " |time:" + stopWatch.getTotalTimeMillis()); 
         }
         stopWatchLocal.set(null);   
         
    }  
  
    public void postHandle(HttpServletRequest request, HttpServletResponse response,  
            Object arg2, ModelAndView arg3) throws Exception {  
    }  
  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
    	
    	StopWatch stopWatch = new StopWatch(handler.toString()); 
        stopWatchLocal.set(stopWatch); 
        stopWatch.start(handler.toString()); 
        
		String uri = getURI(request);
		if (exclude(uri))
			return true;
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		// 验证用户是否登录
		Authencation auth = new Authencation(request, null);
		// 如果用户没有登录
		if (!auth.isValidUser()) {
			result.setMessage("用户没有登录.");
			dealHandle(request, response, result, true);
			return false;
		}
		// 是否超级管理员 add wangxichun
		boolean isAdmin = roleService.isSuperAdmin(userService.get(auth.getUserName()).getUser_id(),SucConstant.ADMIN_GROUP_NAME);
		if (isAdmin) {
			return true;
		}
		
		UserInfoContext.setUserName(auth.getUserName());
		UserInfoContext.setUserId(auth.getUserId());
		
		List<String> uris = uriCaceh.get("user_id_"+auth.getUserId());
		//有时候可以取到KEY，但是取出来的数据为空的
		if (uris == null||uris.size()==0) {
			uris = privilegeService.getUserUri(userService.get(auth.getUserName()).getUser_id());
			uriCaceh.put("user_id_"+auth.getUserId(), uris);
		}
		if (uris.contains(uri)) {
			return true;
		}
//		result.setMessage("您没有" + uri + "的访问权限.");
//		dealHandle(request, response, result, false);
//		return false;
		return true;
    }
	/**
	 * 处理返回信息， 如果是JSPX页面的请求，则转到错误信息; 如果是AJAX请求，则返回JSON数据
	 * 
	 * @param request
	 * @param response
	 * @param result
	 * @throws IOException
	 * @throws ServletException
	 */
	public void dealHandle(HttpServletRequest request,HttpServletResponse response, Result result, boolean login)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		// 页面请求
		if (uri.lastIndexOf(".jspx") != -1) {
			request.setAttribute("result", result);
			if (login) {
				request.getRequestDispatcher(getLoginUrl(request)).forward(request, response);
			} else {
				request.setAttribute("error", result.getMessage());
				request.getRequestDispatcher(errorUrl).forward(request,response);
			}
		}
		// AJAX请求
		else {
			Type targetType = new TypeToken<Result>() {}.getType();
			String json = JSONUtils.toJson(result, targetType, false);
			ResponseUtils.renderXml(response, json);
		}
	}

	/**
	 * 获取登录地址
	 * 
	 * @param request
	 * @return
	 */
	private String getLoginUrl(HttpServletRequest request) {
		UrlPathHelper helper = new UrlPathHelper();
		StringBuilder buff = new StringBuilder();
		if (loginUrl.startsWith("/")) {
			String ctx = request.getContextPath();
			if (!StringUtils.isBlank(ctx)) {
				buff.append(ctx);
			}
		}
		buff.append(loginUrl).append("?");
		buff.append("callBack").append("=")
				.append(helper.getOriginatingQueryString(request));
		return buff.toString();
	}

	/**
	 * 获取系统资源地址
	 * 
	 * @param request
	 */
	private String getURI(HttpServletRequest request) {
		UrlPathHelper helper = new UrlPathHelper();
		String uri = helper.getOriginatingRequestUri(request);
		String ctxPath = helper.getOriginatingContextPath(request);
		return uri.replaceFirst(ctxPath, "");
	}

	/**
	 * 不需要权限控制URL
	 * 
	 * @param uri
	 * @return
	 */
	private boolean exclude(String uri) {
		if (excludeUrls != null) {
			for (String exc : excludeUrls) {
				if (exc.equals(uri)) {
					return true;
				}
			}
		}
		return false;
	}

}
