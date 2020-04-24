package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpCarTypeService;
import com.devops.suc.vo.TpCarTypeSearchVO;
import com.devops.suc.vo.TpCarTypeVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "车辆类型控制器接口")
@Controller
@Scope("prototype")
public class TpCarTypeController {
	
	@Autowired
	private TpCarTypeService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeList.do")
	@ResponseBody
	public Result list(TpCarTypeSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeGet.do")
	@ResponseBody
	public Result get(int ct_id) {
		return service.get(ct_id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeSave.do")
	@ResponseBody
	public Result save(TpCarTypeVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeDelete.do")
	@ResponseBody
	public Result delete(int ct_id) {
		return service.delete(ct_id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_car_type_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpCarType/tpCarTypeOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_car_type_op.jsp");
	}

}
