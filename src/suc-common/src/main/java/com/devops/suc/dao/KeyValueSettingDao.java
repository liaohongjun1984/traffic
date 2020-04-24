package com.devops.suc.dao;

import org.apache.ibatis.annotations.Select;

import com.devops.suc.model.KeyValueSetting;

public interface KeyValueSettingDao extends SqlMapper{

	@Select("select * from key_value_setting where dic_key=#{dic_key}")
	public KeyValueSetting get(String dic_key);
}
