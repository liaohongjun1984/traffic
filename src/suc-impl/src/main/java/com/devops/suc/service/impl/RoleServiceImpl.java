package com.devops.suc.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.MenuDao;
import com.devops.suc.dao.RoleDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.Menu;
import com.devops.suc.model.Role;
import com.devops.suc.model.User;
import com.devops.suc.service.RoleService;
import com.devops.suc.vo.MenuVO;
import com.devops.suc.vo.RoleVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Row;
@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private MenuDao menuDao;
	
	@Override
	public Result setRole(Role role) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(role.getApp_id() == 0||role.getRole_name() == null || role.getRole_name().equals("")){
			result.setMessage("参数错误!");
			return result;
		}
		
		List<Role> roles = roleDao.getByNameAndApp(role.getRole_name(), role.getApp_id());
		if(roles.size() > 0){
			result.setMessage("系统里已经存在此角色!");
			return result;
		}
		roleDao.add(role);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("创建成功");
		return result;
	}

	@Override
	public Result listRole(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<RoleVO> roles = roleDao.list(row);
		paginInfo.put("lists", roles);
		
		
		if(roles.size()>0){
			int totalNum = roleDao.count(row);
			int totalPage = totalNum%row.getInt("size")==0?totalNum/row.getInt("size"):totalNum/row.getInt("size")+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result getRole(int role_id) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		result.setObject(roleDao.get(role_id));
		return result;
	}

	@Override
	public Result delete(int role_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		Row row = new Row();
		row.put("role_id", role_id);
		int users = userDao.countUserByRoleId(row);
		if(users > 0){
			result.setMessage("此角色有用户在使用，请先删除此角色下用户");
			return result;
		}
		roleDao.delete(role_id);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}

	@Override
	public Result update(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		roleDao.update(row);
		return result;
	}

	@Override
	public Result getUserByRole(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<User> users = userDao.getUserByRoleId(row);
		paginInfo.put("lists", users);
		
		
		if(users.size()>0){
			int totalNum = userDao.countUserByRoleId(row);
			int totalPage = totalNum%row.getInt("size")==0?totalNum/row.getInt("size"):totalNum/row.getInt("size")+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result deleteRoleUser(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		roleDao.deleteRoleUser(row);
		return result;
	}

	@Override
	public Result getNotUserByRole(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		result.setObject(userDao.getUserNotinRoleId(row));
		return result;
	}

	@Override
	public Result bindRoleUsers(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		String user_ids = row.gets("user_ids");
		if(user_ids == null || user_ids.length() == 0){
			result.setMessage("参数错误");
			return result;
		}
		row.put("user_list", user_ids.split(","));
		roleDao.bindUserRole(row);
		
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}

	@Override
	public Result qucikRoleUser(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		String user_name = row.gets("user_name");
		String op_type = row.gets("op_type");
		if(user_name == null || user_name.length() == 0){
			result.setMessage("参数错误");
			return result;
		}
		Row tmp = new Row();
		tmp.put("role_id", row.gets("role_id"));
		List<String> res = new ArrayList<String>();
		User user = null;
		String []user_list = null; 
		for(String u : user_name.split(",")){
			user = userDao.get(u);
			if(user == null){
				res.add("fail user("+u+") does not exist");
				continue;
			}
			tmp.put("user_id", user.getUser_id());
			user_list = new String[]{user.getUser_id() + ""};
			tmp.put("user_list", user_list);
			try{
				if(op_type.equals("add")){
					roleDao.bindUserRole(tmp);
				}else{
					roleDao.deleteRoleUser(tmp);
				}
				res.add("success user("+u+") " + op_type);
			}catch(Exception e){
				res.add("fail user("+u+") already exists in this role");
			}
		}
		result.setCode(ResultCode.SUCCESS);
		result.setObject(res);
		return result;
	}

	@Override
	public Result copyRoleUser(Row row) {
		Role role = new Role();
		String role_name = row.gets("role_name");
		int copy_role_id = row.getInt("copy_role_id");
		int app_id = row.getInt("app_id");
		String same_app = row.gets("same_app");
		role.setApp_id(app_id);
		role.setRole_name(role_name);
		role.setNotes("复制");
		//写入角色
		Result result = this.setRole(role);
		if(!result.isSuccess()){
			return result;
		}
		int role_id = role.getRole_id();
		
		//同系统复制菜单
		if("true".equals(same_app)){
			roleDao.copyRoleMenu(copy_role_id, role_id);
		}
		roleDao.copyRoleUser(copy_role_id, role_id);
		result.setMessage("复制成功");
		return result;
	}

	@Override
	public Result getRoleMenu(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		//获取系统的菜单
		int role_id = row.getInt("role_id");
		Role role   = roleDao.get(role_id);
		int app_id  = role.getApp_id(); 
		List<Menu> menus = menuDao.listByAppId(app_id);
		List<Integer> selMenus  = roleDao.getMenu(row.getInt("role_id"));
		
		List<MenuVO> reMenus = new ArrayList<MenuVO>();
		for(Menu menu : menus){
			MenuVO vo = new MenuVO();
			vo.setApp_id(menu.getApp_id());
			vo.setName(menu.getName());
			vo.setMenu_id(menu.getMenu_id());
			vo.setParent_id(menu.getParent_id());
			vo.setChecked(selMenus.contains(menu.getMenu_id()));
			vo.setHide(menu.getHide());
			reMenus.add(vo);
		}
		result.setObject(reMenus);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result updateRoleMenu(List<MenuVO> menus,int role_id) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		roleDao.deleteMenuByRoleId(role_id);
		Row row = new Row();
		row.put("role_id", role_id);
		
		List<Integer> parendIds = new ArrayList<Integer>();
		for(MenuVO vo : menus){
			row.put("menu_id",vo.getMenu_id());
			roleDao.addRoleMenu(row);
			if(!parendIds.contains(vo.getParent_id())){
				row.put("menu_id",vo.getParent_id());
				roleDao.addRoleMenu(row);
				parendIds.add(vo.getParent_id());
			}
		}
		//增加隐藏的菜单
		Role role   = roleDao.get(role_id);
		int app_id  = role.getApp_id(); 	
		List<Menu> menusHide = menuDao.listByAppId(app_id);
		for(Menu vo : menusHide){
			if(vo.getHide()==1){
				row.put("menu_id",vo.getMenu_id());
				roleDao.addRoleMenu(row);				
			}
		}
		return result;
	}

	@Override
	public boolean isSuperAdmin(int user_id,String role_name){
		return roleDao.isSuperAdmin(user_id,role_name) > 0;
	}

	@Override
	public Result listRoleByName(String role_name) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(this.roleDao.getRoleByName(role_name));
		return result;
	}

}
