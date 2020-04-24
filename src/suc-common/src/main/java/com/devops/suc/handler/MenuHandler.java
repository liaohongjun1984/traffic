package com.devops.suc.handler;

import java.util.List;

import com.devops.suc.model.Menu;

public interface MenuHandler {
	
	public List <Menu> getAllMenu(String appId);
	
	public int save(Menu vo);

	public Menu get(String menuId);

	public void delete(String menuId);

}
