package com.devops.suc.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.dao.TpEqualLogDao;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate = "交警违章接口")
@Controller
@Scope("prototype")
public class TrafficContoller {
	
	private static final Logger logger = LoggerFactory.getLogger(TrafficContoller.class);
	@Autowired
	private TpEqualLogDao tpEqualLogDao;

	@MethodResourceDesc(name = "数据更新语句")
	@RequestMapping(value = "/traffic/mysql/reflashSQL.do")
	@ResponseBody
	public Result reflashSQL(String sql) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		//ReflashDatabase reflashDatabase = new ReflashDatabase();
		for(String sql2 : sql.split(";")){
			//reflashDatabase.init(sql2);
			logger.info("reflashSQL  "+sql2);
			tpEqualLogDao.init(sql2);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */
	
	@MethodResourceDesc(name = "数据更新")
	@RequestMapping(value = "/traffic/mysql/reflashSQL.jspx")
	public ModelAndView reflashSQL() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/reflash_sql.jsp");
	}
	
	@MethodResourceDesc(name = "中队图片上传")
	@RequestMapping(value = "/traffic/fileUpload/fileUpload.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/file_upload.jsp");
	}

	@MethodResourceDesc(name = "中队图片校对")
	@RequestMapping(value = "/traffic/fileUpload/fileAudit.jspx")
	public ModelAndView fileAudit() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/trafic_audit.jsp");
	}
}
