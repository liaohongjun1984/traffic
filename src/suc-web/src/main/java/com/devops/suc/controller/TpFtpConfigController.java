package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpFtpConfigService;
import com.devops.suc.vo.TpFtpConfigSearchVO;
import com.devops.suc.vo.TpFtpConfigVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "FTP配置表控制器接口")
@Controller
@Scope("prototype")
public class TpFtpConfigController {
	
	@Autowired
	private TpFtpConfigService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigList.do")
	@ResponseBody
	public Result list(TpFtpConfigSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigSave.do")
	@ResponseBody
	public Result save(TpFtpConfigVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_ftp_config_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpFtpConfig/tpFtpConfigOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_ftp_config_op.jsp");
	}

}
