package com.devops.suc.controller;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.model.Queue;
import com.devops.suc.queue.QueueType;
import com.devops.suc.service.SendLogService;
import com.devops.suc.vo.SendLogSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate = "消息通道管理管理")
@Controller
@Scope("prototype")
public class MessageNoticeController {
	@Autowired
	private SendLogService sendLogService;
	
	@MethodResourceDesc(name = "查询符合条件的消息信息")
	@RequestMapping(value = "/admin/sendLogsList.do")
	@ResponseBody
	public Result SendLogList(SendLogSearchVO sendLogSearchVO) {
		Result result = sendLogService.list(sendLogSearchVO);
		return result;
	}
	
	@MethodResourceDesc(name = "导出消息信息")
	@RequestMapping(value = "/admin/sendLogsExport.do")
	@ResponseBody
	public Result SendLogExport(HttpServletResponse response,int id,int queue_type) throws IOException {
		String filename = "message.eml"; // 设置下载时客户端Excel的名称
		if(queue_type != QueueType.EMAIL){
			filename = "message.txt";
		}
		response.setContentType("application/txt");
		response.setHeader("Content-disposition", "attachment;filename="
				+ filename);
		OutputStream os = response.getOutputStream();
		os.write(sendLogService.export(id));
		os.flush();
		os.close();
		return null;
	}
	
	@MethodResourceDesc(name = "测试消息信息")
	@RequestMapping(value = "/admin/sendTest.do")
	@ResponseBody
	public Result SendTest(Queue queue) {
		Result result = sendLogService.test(queue);
		return result;
	}
	
	@MethodResourceDesc(name = "消息查询界面")
	@RequestMapping(value = "/admin/send_log_query.jspx")
	public ModelAndView logQuery(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/send_log_query.jsp");  
	}
	
	@MethodResourceDesc(name = "消息测试界面")
	@RequestMapping(value = "/admin/send_test.jspx")
	public ModelAndView testQuery(){
		return new ModelAndView("forward:/WEB-INF/pages/admin/send_test.jsp");  
	}

}
