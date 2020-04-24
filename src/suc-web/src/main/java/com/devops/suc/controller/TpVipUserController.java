package com.devops.suc.controller;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.dao.TpVipUserDao;
import com.devops.suc.service.TpVipUserService;
import com.devops.suc.vo.TpVipUserSearchVO;
import com.devops.suc.vo.TpVipUserVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;


@ClassResourceDesc(firstCate = "重要人物表控制器接口")
@Controller
@Scope("prototype")
public class TpVipUserController {
	
	@Autowired
	private TpVipUserService service;
	@Autowired
	private TpVipUserDao tpVipUserDao;
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserList.do")
	@ResponseBody
	public Result list(TpVipUserSearchVO  svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "查询符合条件的信息条数")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserCount.do")
	@ResponseBody
	public Result count(TpVipUserSearchVO  svo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setObject(tpVipUserDao.count(svo));
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}
	@MethodResourceDesc(name = "获取姓名的下拉提示")
	@RequestMapping(value = "/traffic/tpVipUser/likeUserName.do")
	@ResponseBody
	public Result likeUserName(String userName) {
		return service.likeUserName(userName);
	}
	@MethodResourceDesc(name = "获取车牌号下拉提示")
	@RequestMapping(value = "/traffic/tpVipUser/likeCarNo.do")
	@ResponseBody
	public Result likeCarNo(String carNo) {
		return service.likeCarNo(carNo);
	}
	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserSave.do")
	@ResponseBody
	public Result save(TpVipUserVO vo) {
		return service.save(vo);
	}

	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}
	
	@MethodResourceDesc(name = "导出重要人物资料")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserExport.do")
	public void exportVipUser(HttpServletResponse response,TpVipUserSearchVO svo){
		Result result = service.exportVip(svo);
		response.setContentType("application/x-download");
		try{
			response.setHeader("Content-disposition", "attachment;filename="+URLEncoder.encode("importantUser.xls","GBK"));
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
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_vip_user_list.jsp");
	}
	
	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserSearch.jspx")
	public ModelAndView _search() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_vip_user_search.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpVipUser/tpVipUserOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/tp_vip_user_op.jsp");
	}

}
