package com.devops.suc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devops.suc.model.User;
import com.devops.suc.service.AppService;
import com.devops.suc.service.CommonService;
import com.devops.suc.service.UserService;
import com.devops.suc.vo.UserSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.Authencation;

@ClassResourceDesc(firstCate = "公共服务接口")
@Controller
@Scope("prototype")
public class CommonController {
	@Autowired
	private AppService appService;
	@Autowired
	private UserService userService;
	@Autowired
	private CommonService commonService;

	@MethodResourceDesc(name = "获取用户信息")
	@RequestMapping(value = "/common/loadUserInfo.do", method = RequestMethod.GET)
	@ResponseBody
	public Result loadUserInfo(HttpServletRequest request,HttpServletResponse response) {
		// 从cookie获取用户信息
		Authencation auth = new Authencation(request, response);

		User user = userService.get(auth.getUserName());
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(user);
		return result;
	}

	@MethodResourceDesc(name = "获取服务器IP地址")
	@RequestMapping(value = "/common/loadServerIp.do", method = RequestMethod.GET)
	@ResponseBody
	public Result loadServerIp() {
		List<String> ips = commonService.getCurServerIps();
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(ips);
		return result;
	}

	@MethodResourceDesc(name = "获取指定的用户信息")
	@RequestMapping(value = "/common/getUser.do", method = RequestMethod.GET)
	@ResponseBody
	public Result getUser(UserSearchVO userSearchVO) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		User user = userService.get(userSearchVO.getUser_name());
		if (user != null) {
			result.setCode(ResultCode.SUCCESS);
			result.setObject(user);
		} else {
			result.setMessage("没有指定的用户数据.");
		}
		return result;
	}

	@MethodResourceDesc(name = "获取所有系统")
	@RequestMapping(value = "/app/listUseApp.do", method = RequestMethod.GET)
	@ResponseBody
	public Result listAllUseBiz(HttpServletRequest request,HttpServletResponse response){
		Result result = appService.listUseApp();
		return result;
	}
}
