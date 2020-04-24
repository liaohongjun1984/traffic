package com.duowan.yy.sysop.suc.service.impl;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.devops.suc.dao.SecurityResourcesDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:applicationContext-mvc.xml",
								   "classpath*:applicationContext-suc-db.xml",
								   "classpath*:applicationContext-suc-mapper.xml"})

public class SecurityResourcesServiceImplTest {
	@Autowired 
	private  SecurityResourcesDao securityResourcesDao;
	
	@Test
	public void testInStatement(){
		System.out.println("ffasdfasdfadsf");
//		List<String> test = securityResourcesDao.testIn("3,2,1");
//		System.out.println("*****************"+test);
	}
}
