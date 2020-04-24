package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.SysLogService;
import com.devops.suc.vo.SysLogSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate="日志管理")
@Controller
@Scope("prototype")
public class SysLogController {
	
	@Autowired
	private SysLogService sysLogService;
	
	/**
	 * 查询日志信息
	 * @param request
	 * @param response
	 * @param menu
	 * @return
	 */
	@MethodResourceDesc(name = "查询日志信息")
	@RequestMapping(value = "/admin/sysLog/queryLog.do")
	@ResponseBody	
	public Result query(SysLogSearchVO vo){
		return null;
	}
	@MethodResourceDesc(name = "日志查询界面")
	@RequestMapping(value = "/admin/log_query.jspx")
	public ModelAndView logQuery(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/log_query.jsp");  
	}		
	
	@MethodResourceDesc(name = "按条件查询日志信息")
	@RequestMapping(value = "/admin/logSearch.do", method = RequestMethod.GET)
	@ResponseBody
	public Result logSearch(SysLogSearchVO sysLogSearchVO){
		Result result = sysLogService.search(sysLogSearchVO);
		return result;
	}	
}
