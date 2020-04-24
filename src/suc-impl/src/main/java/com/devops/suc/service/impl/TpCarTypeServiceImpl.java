package com.devops.suc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpCarTypeDao;
import com.devops.suc.model.TpCarType;
import com.devops.suc.service.TpCarTypeService;
import com.devops.suc.vo.TpCarTypeSearchVO;
import com.devops.suc.vo.TpCarTypeVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;


@Service
public class TpCarTypeServiceImpl implements TpCarTypeService {
	
	@Autowired
	private TpCarTypeDao tpCarTypeDao;

	@Override
	public Result list(TpCarTypeSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpCarTypeVO> list =  tpCarTypeDao.list(vo);
		paginInfo.put("lists", list);
		
		
		if(list.size()>0){
			int totalNum  = tpCarTypeDao.count(vo);
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
		
		result.setObject(tpCarTypeDao.get(id));
		return result;
	}

	@Override
	public Result save(TpCarTypeVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getCt_id() > 0){
			TpCarType updateModel = new TpCarType();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpCarTypeDao.update(updateModel);
		}else{
			TpCarType addModel = new TpCarType();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpCarTypeDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpCarTypeDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
