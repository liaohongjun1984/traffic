package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpDownloadStatisticsService;
import com.devops.suc.vo.TpDownloadStatisticsSearchVO;
import com.devops.suc.vo.TpDownloadStatisticsVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "下载审核统计表控制器接口")
@Controller
@Scope("prototype")
public class TpDownloadStatisticsController {
	
	@Autowired
	private TpDownloadStatisticsService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsList.do")
	@ResponseBody
	public Result list(TpDownloadStatisticsSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsSave.do")
	@ResponseBody
	public Result save(TpDownloadStatisticsVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_download_static_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpDownloadStatistics/tpDownloadStatisticsOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_download_statistics_op.jsp");
	}

}
