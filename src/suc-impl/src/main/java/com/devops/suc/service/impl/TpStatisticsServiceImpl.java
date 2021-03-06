package com.devops.suc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpStatisticsDao;
import com.devops.suc.model.TpStatistics;
import com.devops.suc.service.TpStatisticsService;
import com.devops.suc.vo.TpStatisticsSearchVO;
import com.devops.suc.vo.TpStatisticsVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;


@Service
public class TpStatisticsServiceImpl implements TpStatisticsService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpStatisticsServiceImpl.class);
	@Autowired
	private TpStatisticsDao tpStatisticsDao;

	@Override
	public Result list(TpStatisticsSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpStatisticsVO> list =  tpStatisticsDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpStatisticsDao.count(vo);
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
		
		result.setObject(tpStatisticsDao.get(id));
		return result;
	}

	@Override
	public Result save(TpStatisticsVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getCr_id() > 0){
			TpStatistics updateModel = new TpStatistics();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpStatisticsDao.update(updateModel);
		}else{
			TpStatistics addModel = new TpStatistics();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpStatisticsDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpStatisticsDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
