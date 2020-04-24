package com.devops.suc.service;

import com.devops.suc.vo.SysLogSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface SysLogService {

	public void addLog(int type,String user_name,String content,String result);
	public Result addLogByJson(String user_name,String app_id,String action,String content,String result);
	
	public Result search(SysLogSearchVO sysLogSearchVO);
}
