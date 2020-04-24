package com.devops.suc.service.impl;


import com.devops.suc.dao.TpDownloadStatisticsDao;
import com.devops.suc.service.TpDownloadStatisticsService;
import com.devops.suc.vo.TpDownloadStatisticsVO;
import com.devops.suc.model.TpDownloadStatistics;
import com.devops.suc.vo.TpDownloadStatisticsSearchVO;
import com.idhoo.dhutil.util.TimeUtil;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.context.UserInfoContext;

import java.util.*;


@Service
public class TpDownloadStatisticsServiceImpl implements TpDownloadStatisticsService {
	
	@Autowired
	private TpDownloadStatisticsDao tpDownloadStatisticsDao;

	@Override
	public Result list(TpDownloadStatisticsSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		
		List<TpDownloadStatisticsVO> list =  tpDownloadStatisticsDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpDownloadStatisticsDao.count(vo);
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
		
		result.setObject(tpDownloadStatisticsDao.get(id));
		return result;
	}

	@Override
	public Result save(TpDownloadStatisticsVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpDownloadStatistics updateModel = new TpDownloadStatistics();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpDownloadStatisticsDao.update(updateModel);
		}else{
			TpDownloadStatistics addModel = new TpDownloadStatistics();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpDownloadStatisticsDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpDownloadStatisticsDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
