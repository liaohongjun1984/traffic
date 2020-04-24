package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.model.TpCarNumTitle;
import com.devops.suc.service.TpCarNumTitleService;
import com.devops.suc.vo.TpCarNumTitleSearchVO;
import com.devops.suc.vo.TpCarTypeVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate = "车牌前缀控制器接口")
@Controller
@Scope("prototype")
public class TpCarNumTitleController {

	@Autowired
	private TpCarNumTitleService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleList.do")
	@ResponseBody
	public Result list(TpCarNumTitleSearchVO svo){
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleGet.do")
	@ResponseBody
	public Result get(int crt_id) {
		return service.get(crt_id);
	}
	
	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleSave.do")
	@ResponseBody
	public Result save(TpCarNumTitle vo) {
		return service.save(vo);
	}
	
	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleDelete.do")
	@ResponseBody
	public Result delete(int crt_id) {
		return service.delete(crt_id);
	}
	
	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */
	
	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_car_num_title_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpCarNumTitle/tpCarNumTitleOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_car_num_title_op.jsp");
	}
}
