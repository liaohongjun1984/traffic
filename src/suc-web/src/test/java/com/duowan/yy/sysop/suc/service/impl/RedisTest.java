package com.duowan.yy.sysop.suc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.devops.suc.model.App;
import com.devops.suc.model.Menu;
import com.devops.suc.model.SecurityResources;
import com.devops.suc.model.User;
import com.devops.suc.redis.RedisDao;
import com.idhoo.dhutil.util.ObjectsTranscoderUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:applicationContext-mvc.xml",
								   "classpath*:applicationContext-suc-db.xml",
								   "classpath*:applicationContext-suc-mapper.xml"})
public class RedisTest {
	@Autowired
	RedisDao residDao;
	@Test
	public void addUser(){
		User user = new User();
		user.setNick_name("王喜春");
		user.setUser_name("dw_wangxichun");
		String key = "user_dw_wangxichun";
		residDao.set(key, ObjectsTranscoderUtil.serializeObject(user));
	}
	@Test
	public void addAPp(){
		App app = new App();
		app.setApp_id(1);
		app.setApp_key("123456");
		app.setCn_name("用户中心");
		String key = "app_1";
		residDao.set(key, ObjectsTranscoderUtil.serializeObject(app));
		
		residDao.getObject(key);
	}
	@Test
	public void addAppUser(){
		User user = new User();
		user.setNick_name("王喜春");
		user.setUser_name("dw_wangxichun");
		List list = new ArrayList();
		list.add(user);
		String key = "app_user_1";
		residDao.set(key, ObjectsTranscoderUtil.serialize(list));
		residDao.get(key);
	}
	@Test
	public void addUserRes(){
		SecurityResources res = new SecurityResources();
		res.setUri("/action.do");
		res.setType(1);
		res.setApp_id(1);
		List list = new ArrayList();
		list.add(res);
		
		String key = "res_1_dw_wangxichun";
		residDao.set(key, ObjectsTranscoderUtil.serialize(list));	
	}
	@Test
	public void addUserMenu(){
		Menu menu = new Menu();
		menu.setApp_id(1);
		menu.setName("测试菜单");
		List list = new ArrayList();
		list.add(menu);
		
		String key = "menu_1_dw_wangxichun";
		residDao.set(key, ObjectsTranscoderUtil.serialize(list));
		
	}
	
	@Test
	public void addUserAPP(){
		App app = new App();
		app.setApp_id(1);
		app.setApp_key("123456");
		app.setCn_name("用户中心");
		List list = new ArrayList();
		list.add(app);
		String key = "user_app_dw_wangxichun";
		residDao.set(key, ObjectsTranscoderUtil.serialize(list));
		
		residDao.getObject(key);
	}

}
