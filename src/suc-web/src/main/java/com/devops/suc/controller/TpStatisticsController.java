package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpStatisticsService;
import com.devops.suc.vo.TpStatisticsSearchVO;
import com.devops.suc.vo.TpStatisticsVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "审核统计表控制器接口")
@Controller
@Scope("prototype")
public class TpStatisticsController {
	
	@Autowired
	private TpStatisticsService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsList.do")
	@ResponseBody
	public Result list(TpStatisticsSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsGet.do")
	@ResponseBody
	public Result get(int cr_id) {
		return service.get(cr_id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsSave.do")
	@ResponseBody
	public Result save(TpStatisticsVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsDelete.do")
	@ResponseBody
	public Result delete(int cr_id) {
		return service.delete(cr_id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "单个列表页面")
	@RequestMapping(value = "/traffic/tpStatistics/tpSingleStatisticsList.jspx")
	public ModelAndView _singleList() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_single_static_list.jsp");
	}
	
	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_static_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpStatistics/tpStatisticsOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_statistics_op.jsp");
	}

}
