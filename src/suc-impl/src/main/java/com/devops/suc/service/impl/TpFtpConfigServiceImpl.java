package com.devops.suc.service.impl;


import com.devops.suc.dao.TpFtpConfigDao;
import com.devops.suc.service.TpFtpConfigService;
import com.devops.suc.vo.TpFtpConfigVO;
import com.devops.suc.model.TpFtpConfig;
import com.devops.suc.vo.TpFtpConfigSearchVO;
import com.idhoo.dhutil.util.TimeUtil;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.context.UserInfoContext;

import java.util.*;


@Service
public class TpFtpConfigServiceImpl implements TpFtpConfigService {
	
	@Autowired
	private TpFtpConfigDao tpFtpConfigDao;

	@Override
	public Result list(TpFtpConfigSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpFtpConfigVO> list =  tpFtpConfigDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpFtpConfigDao.count(vo);
			int totalPage = totalNum%vo.getSize()==0?totalNum/vo.getSize():totalNum/vo.getSize()+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  vo.getPage());
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  vo.getPage());
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result get(int id) {	
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		result.setObject(tpFtpConfigDao.get(id));
		return result;
	}

	@Override
	public Result save(TpFtpConfigVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpFtpConfig updateModel = new TpFtpConfig();
			BeanUtils.copyProperties(vo, updateModel);			
			
			updateModel.setLast_modify_operator(UserInfoContext.getUserName());
			updateModel.setLast_modify_time(TimeUtil.getCurDateTime());
			
			tpFtpConfigDao.update(updateModel);
		}else{
			TpFtpConfig addModel = new TpFtpConfig();
			BeanUtils.copyProperties(vo, addModel);		
				
			addModel.setCreate_operator(UserInfoContext.getUserName());
			addModel.setCreate_time(TimeUtil.getCurDateTime());
			addModel.setLast_modify_operator(UserInfoContext.getUserName());
			addModel.setLast_modify_time(TimeUtil.getCurDateTime());
			
			tpFtpConfigDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpFtpConfigDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
