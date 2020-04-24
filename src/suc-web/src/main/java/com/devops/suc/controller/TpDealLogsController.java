package com.devops.suc.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpDealLogsService;
import com.devops.suc.vo.TpDealLogsSearchVO;
import com.devops.suc.vo.TpDealLogsVO;
import com.devops.suc.vo.TpVipUserSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "处理文件记录表控制器接口")
@Controller
@Scope("prototype")
public class TpDealLogsController {
	
	@Autowired
	private TpDealLogsService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsList.do")
	@ResponseBody
	public Result list(TpDealLogsSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "统计报表")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsForm.do")
	@ResponseBody
	public Result listForm(TpDealLogsSearchVO  svo) {
		return service.listForm(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}

	@MethodResourceDesc(name = "图片校对")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsSave.do")
	@ResponseBody
	public Result save(TpDealLogsVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}
	
	@MethodResourceDesc(name = "中队导出审核记录")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsExport.do")
	public void exportVipUser(HttpServletResponse response,TpDealLogsSearchVO svo){
		Result result = service.exportDealLogs(svo);
		response.setContentType("application/x-download");
		try{
			response.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode("DealLogs.xls","GBK"));
			byte[] buff = (byte[])result.getObject();
			response.getOutputStream().write(buff,0,buff.length);
			response.getOutputStream().flush();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	@MethodResourceDesc(name = "查询要重新校对图片的信息")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsRemember.do")
	@ResponseBody
	public Result remember(@RequestParam(defaultValue="0") int file_index) {
		return service.remember(file_index);
	}
	
	@MethodResourceDesc(name = "重新校对，更新处理文件记录表")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsUpdate.do")
	@ResponseBody
	public Result update(TpDealLogsVO vo) {
		return service.update(vo);
	}
	
	@MethodResourceDesc(name = "重新校对，清空数据")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsAgain.do")
	@ResponseBody
	public Result again(TpDealLogsVO vo) {
		return service.again(vo);
	}
	
	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */
	
	@MethodResourceDesc(name = "中队个人审核列表页面")
	@RequestMapping(value = "/traffic/tpDealLogs/tpSingleDealLogsList.jspx")
	public ModelAndView tpSingleDealLogsList() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_single_deal_log_list.jsp");
	}

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_deal_log_list.jsp");
	}
	
	@MethodResourceDesc(name = "统计报表")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsForm.jspx")
	public ModelAndView tpDealLogsForm() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_deal_log_form_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpDealLogs/tpDealLogsOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_deal_logs_op.jsp");
	}



}
