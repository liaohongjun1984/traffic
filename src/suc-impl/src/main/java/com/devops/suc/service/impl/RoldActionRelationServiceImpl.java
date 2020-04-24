package com.devops.suc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.RoldActionRelationDao;
import com.devops.suc.model.RoldActionRelation;
import com.devops.suc.service.RoldActionRelationService;
import com.devops.suc.vo.RoldActionRelationSearchVO;
import com.devops.suc.vo.RoldActionRelationVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;


@Service
public class RoldActionRelationServiceImpl implements RoldActionRelationService {
	
	@Autowired
	private RoldActionRelationDao roldActionRelationDao;

	@Override
	public Result list(RoldActionRelationSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<RoldActionRelationVO> list =  roldActionRelationDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = roldActionRelationDao.count(vo);
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
		
		result.setObject(roldActionRelationDao.get(id));
		return result;
	}

	@Override
	public Result save(RoldActionRelationVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getRoad_id() > 0){
			RoldActionRelation updateModel = new RoldActionRelation();
			BeanUtils.copyProperties(vo, updateModel);			
			
			roldActionRelationDao.update(updateModel);
		}else{
			RoldActionRelation addModel = new RoldActionRelation();
			BeanUtils.copyProperties(vo, addModel);		
				
			roldActionRelationDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		roldActionRelationDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}
}
