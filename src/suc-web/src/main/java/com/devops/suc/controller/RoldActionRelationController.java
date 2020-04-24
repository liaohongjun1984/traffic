package com.devops.suc.controller;

import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.devops.suc.service.RoldActionRelationService;
import com.devops.suc.vo.RoldActionRelationVO;
import com.devops.suc.vo.RoldActionRelationSearchVO;


@ClassResourceDesc(firstCate = "路口与违法行为的对应关系控制器接口")
@Controller
@Scope("prototype")
public class RoldActionRelationController {
	
	@Autowired
	private RoldActionRelationService service;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationList.do")
	@ResponseBody
	public Result list(RoldActionRelationSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "根据id获取信息！")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationGet.do")
	@ResponseBody
	public Result get(int rold_id) {
		return service.get(rold_id);
	}

	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationSave.do")
	@ResponseBody
	public Result save(RoldActionRelationVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationDelete.do")
	@ResponseBody
	public Result delete(int rold_id) {
		return service.delete(rold_id);
	}

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/rold_action_relation_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/roldActionRelation/roldActionRelationOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/rold_action_relation_op.jsp");
	}

}
