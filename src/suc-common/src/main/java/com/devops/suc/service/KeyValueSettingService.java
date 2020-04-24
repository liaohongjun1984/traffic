package com.devops.suc.service;

import com.devops.suc.model.KeyValueSetting;

public interface KeyValueSettingService {

	/**
	 * 
	 * @param dic_key
	 * @return
	 */
	public KeyValueSetting get(String dic_key);
}
