package com.devops.suc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.dao.AppDao;
import com.devops.suc.dao.SysLogDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.App;
import com.devops.suc.model.SysLog;
import com.devops.suc.model.User;
import com.devops.suc.service.SysLogService;
import com.devops.suc.vo.SysLogSearchVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;

@Service
public class SysLogServiceImpl implements SysLogService {
	@Autowired 
	private SysLogDao sysLogDao;
	@Autowired 
	private AppDao  appDao;
	@Autowired 
	private UserDao userDao;
	
	private String appName = null;
	
	@Override
	public void addLog(int type, String user_name, String content, String result) {
		if(appName==null){
			App app = appDao.getByAppId(SucConstant.app_id);
			appName = app.getName();
		}
		User user = userDao.get(user_name);
		
		SysLog sysLog = new SysLog();
		
		sysLog.setApp_id(SucConstant.app_id);
		sysLog.setApp_name(appName);
		
		sysLog.setUser_name(user_name);
		sysLog.setNick_name(user.getNick_name());
		
		sysLog.setType(String.valueOf(type));
		sysLog.setContent(content);
		sysLog.setResult(result);
		
		sysLogDao.save(sysLog);
	}

	@Override
	public Result addLogByJson(String user_name,String app_id_str,String action,String content,String result) {
		int app_id = Integer.valueOf(app_id_str.trim());
		
		Result reslt = new Result();
		reslt.setSuccess(false);
		String app_name = null;
		
		if(app_name==null){
			App app = appDao.getByAppId(app_id);
			app_name = app.getName();
		}
		User user = userDao.get(user_name);
		
		SysLog sysLog = new SysLog();
		sysLog.setApp_id(app_id);
		sysLog.setApp_name(app_name);
		sysLog.setUser_name(user.getUser_name());
		sysLog.setNick_name(user.getNick_name());
		sysLog.setType(action);
		sysLog.setContent(content);
		sysLog.setResult(result);
		
		sysLogDao.save(sysLog);
		reslt.setSuccess(true);
		reslt.setMessage("success");
		return reslt;
	}
	
	@Override
	public Result search(SysLogSearchVO sysLogSearchVO) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<SysLog> logs = sysLogDao.search(sysLogSearchVO);
		paginInfo.put("lists", logs);
		
		
		if(logs.size()>0){
			int totalNum = sysLogDao.searchCount(sysLogSearchVO);
			int totalPage = totalNum%sysLogSearchVO.getSize()==0?totalNum/sysLogSearchVO.getSize():totalNum/sysLogSearchVO.getSize()+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  sysLogSearchVO.getPage());
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  sysLogSearchVO.getPage());
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

}
