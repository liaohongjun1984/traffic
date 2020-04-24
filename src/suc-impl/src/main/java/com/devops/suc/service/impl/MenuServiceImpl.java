package com.devops.suc.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.dao.MenuDao;
import com.devops.suc.dao.RoleDao;
import com.devops.suc.dao.SecurityResourcesDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.Menu;
import com.devops.suc.model.SecurityResources;
import com.devops.suc.model.SecurityResourcesVO;
import com.devops.suc.model.User;
import com.devops.suc.service.MenuService;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;

@Service
public class MenuServiceImpl implements MenuService{

	@Autowired
	private MenuDao menuDao;
	@Autowired
	private SecurityResourcesDao securityResourcesDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	
	/* (non-Javadoc)
	 * @see com.duowan.yy.sysop.suc.service.MenuService#modifyMenu(java.util.List, java.lang.String)
	 */
	public Result modifyMenu(List<Menu> menus,String operator){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		int sequence = 0;
		for(Menu menu : menus){
			menu.setOperator(operator);
			menu.setSequence(sequence++);
			menuDao.update(menu);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	/* (non-Javadoc)
	 * @see com.duowan.yy.sysop.suc.service.MenuService#removeMenu(int)
	 */
	public Result removeMenu(int menu_id){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		int roleCount = menuDao.countMenuUse(menu_id);
		if(roleCount>0){
			result.setMessage("该菜单还有角色关联，请去掉角色关联后再删除.");
		}else{
			menuDao.remove(menu_id);
			result.setCode(ResultCode.SUCCESS);
		}
		
		return result;		
	}
	
	/* (non-Javadoc)
	 * @see com.duowan.yy.sysop.suc.service.MenuService#listByAppId(int)
	 */
	public List<Menu> listByAppId(int app_id){
		return menuDao.listByAppId(app_id);
	}

	@Override
	public Result addMenu(Menu menu) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<Menu> menus = menuDao.listByParentId(menu.getParent_id());
		if(menus!=null&&menus.size()>0){
			menu.setSequence(menus.get(menus.size()-1).getSequence()+0.1);
		}else{
			if(menu.getParent_id()!=0){
				Menu parentMenu = menuDao.getByMenuId(menu.getParent_id());
				menu.setSequence(parentMenu.getSequence()+0.1);
			}else{
				//如果是根结点的第一个，则自动增加序号1
				menu.setSequence(1);
			}
		}
		menuDao.save(menu);
		menu.setLast_modify(new Date());
		result.setObject(menu);
		
		result.setCode(ResultCode.SUCCESS);
		return result;		
	}
	
	/* (non-Javadoc)
	 * @see com.duowan.yy.sysop.suc.service.MenuService#getMenuResource(int)
	 */
	public List<SecurityResourcesVO> getMenuResource(int menu_id) {
		List<SecurityResourcesVO> vos = new LinkedList<SecurityResourcesVO>();
		Menu menu = menuDao.getByMenuId(menu_id);
		List<SecurityResources> srs      = securityResourcesDao.listByAppId(menu.getApp_id());
		List<Integer> mrrs = securityResourcesDao.listMrr(menu_id);
		for(SecurityResources sr : srs){
			SecurityResourcesVO vo = new SecurityResourcesVO();
			try {
				BeanUtils.copyProperties(vo, sr);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			if(mrrs.contains(vo.getResources_id())){
				vo.setChecked(true);
			}else{
				vo.setChecked(false);
			}
			if(vo.getParent_id()!=0){
				vo.setName(vo.getName()+"【"+vo.getUri()+"】");
			}
			vos.add(vo);
		}
		return vos;
	}

	@Override
	public Result modifyMenuResource(List<SecurityResources> srs,int menu_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		menuDao.clearMenuResource(menu_id);
		for(SecurityResources sr : srs){
			menuDao.saveMenuResource(menu_id, sr.getResources_id());
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;		
	}

	@Override
	public List<SecurityResources> getAppResource(int app_id) {
		List<SecurityResources> srs = securityResourcesDao.listByAppId(app_id);
		for(SecurityResources sr : srs){
			sr.setName(sr.getName()+"【"+sr.getUri()+"】");
		}
		return srs;
	}

	@Override
	public String getUserWelcomeUrl(int user_id, int app_id) {
		boolean isAdmin = roleDao.isSuperAdmin(user_id,SucConstant.ADMIN_GROUP_NAME) > 0;
		if(isAdmin){
			return menuDao.getSuperAdminWelcomeUrl(app_id);
		}
		return menuDao.getUserWelcomeUrl(user_id, app_id);
	}

	@Override
	public List<Menu> getUserMenu(int user_id, int app_id) {
		User u = userDao.getByUserId(user_id);
		boolean isAdmin = u.getAdmin()==1;
		if(isAdmin){
			return menuDao.getSuperAdminMenu(app_id);
		}
		return menuDao.getUserMenu(user_id, app_id);
	}
}
