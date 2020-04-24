/**
 * @author: code@xiepeiyang.com
 * @date: 2016年3月26日-下午7:18:29
 */
package com.devops.suc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.apache.log4j.Logger;

import com.devops.suc.service.TpCheckedService;
import com.devops.suc.vo.TpCheckedSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;

@ClassResourceDesc(firstCate = "已校对文件表")
@Controller
@Scope("prototype")
public class TpCheckedController {
	//private static final Logger logger = Logger.getLogger(TpUploadTempController.class);
	
	@Autowired
	private TpCheckedService service;
	
	@MethodResourceDesc(name = "查询符合条件的已校对文件表")
	@RequestMapping(value = "/traffic/TpChecked/List.do")
	@ResponseBody
	public Result list(TpCheckedSearchVO svo) {
		return service.list(svo);
	}
}
