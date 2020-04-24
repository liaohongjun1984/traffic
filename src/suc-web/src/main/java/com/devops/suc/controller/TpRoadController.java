package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpRoadService;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpRoadSearchVO;
import com.devops.suc.vo.TpRoadVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "路口管理控制器接口")
@Controller
@Scope("prototype")
public class TpRoadController {
	
	@Autowired
	private TpRoadService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadList.do")
	@ResponseBody
	public Result list(TpRoadSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpRoad/listAll.do")
	@ResponseBody
	public Result listAll(TpFilterFileSearchVO vo) {
		return service.listAll(vo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadGet.do")
	@ResponseBody
	public Result get(int cr_id) {
		return service.get(cr_id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadSave.do")
	@ResponseBody
	public Result save(TpRoadVO vo) {
		return service.save(vo);
	}
	
	@MethodResourceDesc(name = "添加路口所属违规行为")
	@RequestMapping(value = "/traffic/tpRoad/addViolationAction.do")
	@ResponseBody
	public Result addViolationAction(int road_id,String v_ids) {
		return service.addViolationAction(road_id,v_ids);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadDelete.do")
	@ResponseBody
	public Result delete(int cr_id) {
		return service.delete(cr_id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_road_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpRoad/tpRoadOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_road_op.jsp");
	}
	
	@MethodResourceDesc(name = "添加所属违规行为")
	@RequestMapping(value = "/traffic/tpRoad/addViolation.jspx")
	public ModelAndView addViolation() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_road_add_violation.jsp");
	}

}
