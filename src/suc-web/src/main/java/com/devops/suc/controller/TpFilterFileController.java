package com.devops.suc.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpFilterFileService;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpFilterFileVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "过滤文件表控制器接口")
@Controller
@Scope("prototype")
public class TpFilterFileController {
	
	@Autowired
	private TpFilterFileService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileList.do")
	@ResponseBody
	public Result list(TpFilterFileSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileSave.do")
	@ResponseBody
	public Result save(TpFilterFileVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}
	
	@MethodResourceDesc(name = "更新数据")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileUpdateSome.do")
	@ResponseBody
	public Result updateTFFSome() {
		return service.updateTFFSome();
	}
	@MethodResourceDesc(name = "导出EXCEL")
	@RequestMapping(value = "/traffic/tpFilterFile/exportExcel.do")
	@ResponseBody
	public void exportExcel(HttpServletResponse response,TpFilterFileSearchVO  svo) {
		Result result = service.exportExcel(svo);
		response.setContentType("application/x-download");
		try{
			response.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode("tp_filter_file.xls","GBK"));
			byte[] buff = (byte[])result.getObject();
			response.getOutputStream().write(buff,0,buff.length);
			response.getOutputStream().flush();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_filter_file_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpFilterFile/tpFilterFileOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_filter_file_op.jsp");
	}

}
