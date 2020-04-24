package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.service.TpViolationActionService;
import com.devops.suc.vo.TpViolationActionSearchVO;
import com.devops.suc.vo.TpViolationActionVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "违反交通规则行为表控制器接口")
@Controller
@Scope("prototype")
public class TpViolationActionController {
	
	@Autowired
	private TpViolationActionService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionList.do")
	@ResponseBody
	public Result list(TpViolationActionSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "列出所有违规行为（不分页）")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionListAll.do")
	@ResponseBody
	public Result listAll(TpViolationActionSearchVO  svo) {
		return service.listAll(svo);
	}
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpViolationAction/listViolationActionByRoadId.do")
	@ResponseBody
	public Result listViolationActionByRoadId(int road_id) {
		return service.listViolationActionByRoadId(road_id);
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionGet.do")
	@ResponseBody
	public Result get(int v_id) {
		return service.get(v_id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionSave.do")
	@ResponseBody
	public Result save(TpViolationActionVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionDelete.do")
	@ResponseBody
	public Result delete(int v_id) {
		return service.delete(v_id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_violation_action_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpViolationAction/tpViolationActionOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_violation_action_op.jsp");
	}

}
