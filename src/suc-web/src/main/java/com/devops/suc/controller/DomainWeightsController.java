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
import com.devops.suc.model.DomainWeights;
import com.devops.suc.service.DomainWeightsService;
import com.devops.suc.service.SysLogService;
import com.devops.suc.vo.DomainWeightsSearchVO;
import com.google.gson.reflect.TypeToken;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.gson.JSONUtils;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.RequestUtil;
import com.idhoo.dhutil.util.Row;

@ClassResourceDesc(firstCate = "域名权重管理")
@Controller
@Scope("prototype")
public class DomainWeightsController {
	
	@Autowired
	private DomainWeightsService domainWeightsService;
	@Autowired
	private SysLogService sysLogService;

	@MethodResourceDesc(name = "查询符合条件的域名权重信息")
	@RequestMapping(value = "/admin/domainWeightsList.do", method = RequestMethod.GET)
	@ResponseBody
	public Result domainWeightsList(DomainWeightsSearchVO domainWeightsSearchVO) {
		Result result = domainWeightsService.list(domainWeightsSearchVO);
		return result;
	}
	
	@MethodResourceDesc(name = "通过系统id查找域名权重信息")
	@RequestMapping(value = "/admin/getDomainWeightsListByAppId.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getDomainWeightsListByAppId(HttpServletRequest request, HttpServletResponse response) {
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int app_id = row.getInt("app_id");
		Result result = domainWeightsService.listByAppId(app_id);
		return result;
	}
	
	@MethodResourceDesc(name = "按照域名符合条件的域名权重信息")
	@RequestMapping(value = "/admin/domainWeightsListByHost.do", method = RequestMethod.GET)
	@ResponseBody
	public Result domainWeightsListByHost(String host) {
		Result result = domainWeightsService.list(host);
		return result;
	}
	
	@MethodResourceDesc(name = "获得域名权重信息")
	@RequestMapping(value = "/admin/getDomainWeights.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getDomainWeights(HttpServletRequest request, HttpServletResponse response) {
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int id = row.getInt("id");
		Result result = domainWeightsService.get(id);
		return result;
	}
	
	@MethodResourceDesc(name = "按条件查询域名权重信息")
	@RequestMapping(value = "/admin/queryDomainWeights.do", method = RequestMethod.GET)
	@ResponseBody
	public Result queryDomainWeights(HttpServletRequest request, HttpServletResponse response) {
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		DomainWeights domainWeights = new DomainWeights();
		domainWeights.setHost(row.gets("host"));
		domainWeights.setApp_id(row.getInt("app_id"));
		Result result = domainWeightsService.listAll(domainWeights);
		return result;
	}
	
	@MethodResourceDesc(name = "保存域名权重")
	@RequestMapping(value = "/admin/saveDomainWeights.do", method = RequestMethod.GET)
	@ResponseBody
	public Result saveDomainWeights(HttpServletRequest request, HttpServletResponse response, DomainWeights domainWeights) {
		// 用户验证
		Authencation auth = new Authencation(request, response);
		domainWeights.setOperator(auth.getUserName());
		
		DomainWeights dw = new DomainWeights();
		dw.setHost(domainWeights.getHost());
		dw.setApp_id(domainWeights.getApp_id());
		Result r = domainWeightsService.listAll(dw);
		List<DomainWeights> list = (List<DomainWeights>)r.getObject();
		
		int id = domainWeights.getId();
		Result result = null;
		// id>0 时 更新记录，否则，增加一条记录
		if(id > 0) {
			if(list.size() == 0 || list.get(0).getId() == id) {
				result = domainWeightsService.update(domainWeights);
			}
		} else {
			if(list.size() == 0) {
				result = domainWeightsService.insert(domainWeights);
			}
		}
		
		Type targetType = new TypeToken<DomainWeights>(){}.getType();
		sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(), JSONUtils.toJson(domainWeights, targetType, false), "操作结果:" + result.isSuccess());
		return result;
	}
	
	@MethodResourceDesc(name = "删除域名权重信息")
	@RequestMapping(value = "/admin/delDomainWeights.do", method = RequestMethod.GET)
	@ResponseBody
	public Result delDomainWeights(HttpServletRequest request, HttpServletResponse response) {
		// 用户验证
		Authencation auth = new Authencation(request, response);
		Row row = RequestUtil.getParam(request, SucConstant.FILE_PRE);
		int id = row.getInt("id");
		Result result = domainWeightsService.delete(id);
		
		Type targetType = new TypeToken<Row>(){}.getType();
		sysLogService.addLog(SucConstant.sysLogType_USER, auth.getUserName(), JSONUtils.toJson(row, targetType, false), "操作结果:" + result.isSuccess());
		return result;
	}
	
	/**
	 *  ==============================   * jsp页面的jspx forward跳转 *   ========================================== 
	 */

	@MethodResourceDesc(name = "权重页面列表")
	@RequestMapping(value = "/admin/domain_weights_list.jspx")
	public ModelAndView domainWeightsList() {
		return new ModelAndView("forward:/WEB-INF/pages/admin/domain_weights_list.jsp");
	}
	
	@MethodResourceDesc(name = "添加域名权重记录")
	@RequestMapping(value = "/admin/domain_weights_add.jspx")
	public ModelAndView addDomainWeights() {
		return new ModelAndView("forward:/WEB-INF/pages/admin/domain_weights_add.jsp");
	}
	
	@MethodResourceDesc(name = "修改域名权重记录")
	@RequestMapping(value = "/admin/domain_weights_edit.jspx")
	public ModelAndView editDomainWeights() {
		return new ModelAndView("forward:/WEB-INF/pages/admin/domain_weights_edit.jsp");
	}

}
