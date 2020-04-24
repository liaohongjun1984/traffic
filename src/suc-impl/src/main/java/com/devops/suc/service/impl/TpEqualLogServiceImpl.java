package com.devops.suc.service.impl;


import com.devops.suc.dao.TpEqualLogDao;
import com.devops.suc.service.TpEqualLogService;
import com.devops.suc.vo.TpEqualLogVO;
import com.devops.suc.model.TpEqualLog;
import com.devops.suc.vo.TpEqualLogSearchVO;
import com.idhoo.dhutil.util.TimeUtil;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.context.UserInfoContext;

import java.util.*;


@Service
public class TpEqualLogServiceImpl implements TpEqualLogService {
	
	@Autowired
	private TpEqualLogDao tpEqualLogDao;

	@Override
	public Result list(TpEqualLogSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpEqualLogVO> list =  tpEqualLogDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpEqualLogDao.count(vo);
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
		
		result.setObject(tpEqualLogDao.get(id));
		return result;
	}

	@Override
	public Result save(TpEqualLogVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpEqualLog updateModel = new TpEqualLog();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpEqualLogDao.update(updateModel);
		}else{
			TpEqualLog addModel = new TpEqualLog();
			BeanUtils.copyProperties(vo, addModel);		
				
			addModel.setCreate_time(TimeUtil.getCurDateTime());
			
			tpEqualLogDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpEqualLogDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
