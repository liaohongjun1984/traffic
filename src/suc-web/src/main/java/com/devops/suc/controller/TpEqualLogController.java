package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpEqualLogService;
import com.devops.suc.vo.TpEqualLogSearchVO;
import com.devops.suc.vo.TpEqualLogVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "匹配记录表控制器接口")
@Controller
@Scope("prototype")
public class TpEqualLogController {
	
	@Autowired
	private TpEqualLogService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogList.do")
	@ResponseBody
	public Result list(TpEqualLogSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogSave.do")
	@ResponseBody
	public Result save(TpEqualLogVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_equal_log_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpEqualLog/tpEqualLogOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_equal_log_op.jsp");
	}

}
