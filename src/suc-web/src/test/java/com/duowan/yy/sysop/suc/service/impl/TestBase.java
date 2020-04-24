package com.duowan.yy.sysop.suc.service.impl;

import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import com.idhoo.dhutil.spring.SpringContextUtil;

public class TestBase extends AbstractDependencyInjectionSpringContextTests {
	public String[] getConfigLocations() {
		String[] locations = { 
				"classpath*:applicationContext-suc-db.xml",
				"classpath*:applicationContext-suc.xml"
		};
		return locations;
	}
	
	@Override
	protected void onSetUp() throws Exception {
		super.onSetUp();
		SpringContextUtil.setContext(this.getApplicationContext());
	}

	public void test1(){
	}
}