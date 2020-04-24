package com.devops.suc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.CacheKeyConstant;
import com.devops.suc.model.App;
import com.devops.suc.model.User;
import com.devops.suc.redis.RedisDao;
import com.devops.suc.service.WebIntfaceService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.ObjectsTranscoderUtil;

@Service
@Scope("prototype")
public class WebIntfaceServiceImpl implements WebIntfaceService {
	@Autowired
	private RedisDao residDao;
	
	@Override
	public boolean checkWebApp(String app_id, String app_key) {
		
		String key = getKey(CacheKeyConstant.APP_PREFIX, app_id);
		byte[] in = residDao.getObject(key);
		if (in == null) {
			return false;
		}
		App app = (App) ObjectsTranscoderUtil.deserializeObject(in);
		if (app != null && app_key != null && app_key.equals(app.getApp_key())
				&& app.getStatus() == 1) {
			return true;
		}

		return false;
	}

	private String getKey(String head, String... value) {
		String key = head;
		for (String v : value) {
			key = key + "_" + v;
		}
		return key;
	}

	@Override
	public Result listOneUser(String app_id, String user_name, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
//		String key = this.getKey(app_user_head, app_id);
//
//		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao.getObject(key));
//		if (list == null) {
//			result.setMessage("没有此用户!");
//			return result;
//		}
//		User user = null;
//		boolean contains = false;
//		for (Object obj : list) {
//			user = (User) obj;
//			if (user_name != null && user_name.equals(user.getUser_name())) {
//				contains = true;
//				break;
//			}
//		}
//		if (!contains) {
//			result.setMessage("系统没有此用户!");
//			return result;
//		}
		
		String key = this.getKey(CacheKeyConstant.ALL_USER_PREFIX, user_name);
		byte[] in=residDao.getObject(key);
		User user = (User) ObjectsTranscoderUtil.deserializeObject(in);
		if (user == null) {
			result.setMessage("用户不存在!");
			return result;
		}
		
		result.setObject(user);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listAppUsers(String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		
		String key = this.getKey(CacheKeyConstant.APP_USER_PREFIX, app_id);

		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao
				.getObject(key));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listRess(String app_id, String user_name, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		Result tmp = this.listOneUser(app_id, user_name, app_key);
		if (!tmp.isSuccess()) {
			result.setMessage(tmp.getMessage());
			return result;
		}
		
		String key = this.getKey(CacheKeyConstant.RES_PREFIX, app_id, user_name);
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao.getObject(key));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listMenus(String app_id, String user_name, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		Result tmp = this.listOneUser(app_id, user_name, app_key);
		if (!tmp.isSuccess()) {
			result.setMessage(tmp.getMessage());
			return result;
		}
		
		String key = this.getKey(CacheKeyConstant.MENU_PREFIX, app_id, user_name);
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao
				.getObject(key));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listUserApp(String user_name, String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		
		String key = this.getKey(CacheKeyConstant.USER_APP_PREFIX, user_name);
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao
				.getObject(key));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listDomain(String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		String key = this.getKey(CacheKeyConstant.DOMIN_PREFIX, app_id);
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao
				.getObject(key));
		if (list == null) {
			result.setMessage("系统不存在或者不可用!");
			return result;
		}
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result getApp(String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		
		String key = this.getKey(CacheKeyConstant.APP_PREFIX, app_id);
		byte[] in=residDao.getObject(key);
		App app = (App) ObjectsTranscoderUtil.deserializeObject(in);
		if (app == null) {
			result.setMessage("系统不存在或者不可用!");
			return result;
		}
		result.setObject(app);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listRole(String app_id, String user_name, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		Result tmp = this.listOneUser(app_id, user_name, app_key);
		if (!tmp.isSuccess()) {
			result.setMessage(tmp.getMessage());
			return result;
		}
		String key = this.getKey(CacheKeyConstant.ROLE_PREFIX, app_id, user_name);
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao.getObject(key));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listAllApp(String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao.getObject(CacheKeyConstant.ALL_APP_PREFIX));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listAllUser(String app_id, String app_key) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if (!checkWebApp(app_id, app_key)) {
			result.setMessage("系统验证码输入不正确!");
			return result;
		}
		List<Object> list = ObjectsTranscoderUtil.deserialize(residDao.getObject(CacheKeyConstant.ALL_USER_PREFIX));
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		return result;
		
	}

}
