package com.devops.suc.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.KeyValueSettingDao;
import com.devops.suc.model.KeyValueSetting;
import com.devops.suc.service.KeyValueSettingService;

@Service
public class KeyValueSettingServiceImpl implements KeyValueSettingService {
	@Autowired
	private KeyValueSettingDao keyValueSettingDao;
	
	@Override
	public KeyValueSetting get(String dic_key) {
		return keyValueSettingDao.get(dic_key);
	}

}
