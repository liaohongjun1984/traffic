package com.devops.suc.service;

import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.util.Row;

public interface InfoFlowService {
	/**
	 * 浏览信息
	 * @param row
	 * @return
	 */
	public Result list(Row row);
}
