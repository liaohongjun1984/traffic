package com.devops.suc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.dao.SecurityResourcesDao;
import com.devops.suc.dao.UserRoleRelationDao;
import com.devops.suc.service.PrivilegeService;
import com.idhoo.dhutil.util.StringUtil;
@Service
public class PrivilegeServiceImpl implements PrivilegeService {
	
	@Autowired 
	private  SecurityResourcesDao securityResourcesDao;
	@Autowired 
	private UserRoleRelationDao   userRoleRelationDao;
	
	@Override
	public List<String> getUserUri(int user_id) {
		List<Integer> role_ids = userRoleRelationDao.getUserRoleByAppId(user_id, SucConstant.app_id);
		if(role_ids.size()==0){
			return new ArrayList<String>();
		}
		String idsStr = StringUtil.sqlIds(role_ids);
		List<String> uris = securityResourcesDao.getUserUri(idsStr);
		return uris;
	}

}
