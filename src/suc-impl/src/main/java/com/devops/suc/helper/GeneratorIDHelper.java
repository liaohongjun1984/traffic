package com.devops.suc.helper;

import org.springframework.jdbc.core.JdbcTemplate;

import com.idhoo.dhutil.spring.SpringContextUtil;

public class GeneratorIDHelper {
	
	private static JdbcTemplate sucJdbcTemplate = (JdbcTemplate) SpringContextUtil.getBean("sucJdbcTemplate");
	
	private static String[] first = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
		,"0","1","2","3","4","5","6","7","8","9"};
	
	private static String [] second = first;
	
	public static String generator(String table,String column,String parentId,String parentName){
		String sql = "select count(*) from "+ table + " where "+ parentName + " = ? and "+column+ " = ?";
		int firstNum = (int) (Math.random() * first.length);
		int secondNum = (int) (Math.random() * second.length);
		String id = parentId+first[firstNum]+second[secondNum];
		Object[] args = new Object[]{parentId,id};
		int count = sucJdbcTemplate.queryForInt(sql,args);
		while(count != 0){
			firstNum = (int) (Math.random() * first.length);
			secondNum = (int) (Math.random() * second.length);
			id = parentId+first[firstNum]+second[secondNum];
			args = new Object[]{parentId,id};
			count = sucJdbcTemplate.queryForInt(sql,args);
		}
		return id;
	}

}
