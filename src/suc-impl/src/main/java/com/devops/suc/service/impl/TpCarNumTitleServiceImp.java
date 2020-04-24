package com.devops.suc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpCarNumTitleDao;
import com.devops.suc.model.TpCarNumTitle;
import com.devops.suc.service.TpCarNumTitleService;
import com.devops.suc.vo.TpCarNumTitleSearchVO;
import com.devops.suc.vo.TpCarNumTitleVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;

@Service
public class TpCarNumTitleServiceImp implements TpCarNumTitleService{

	@Autowired
	private TpCarNumTitleDao tpCarNumTitleDao;

	@Override
	public Result list(TpCarNumTitleSearchVO svo) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map<String,Object> paginInfo = new HashMap<String, Object>();
		List<TpCarNumTitleVO> list = tpCarNumTitleDao.list(svo);
		paginInfo.put("lists", list);
		//页数控制
		if(list.size()>0){
			int totalNum = tpCarNumTitleDao.count(svo);
			int totalPage = totalNum%svo.getSize()==0?totalNum/svo.getSize():totalNum/svo.getSize()+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page", svo.getPage());
			paginInfo.put("pageCount", totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page", svo.getPage());
			paginInfo.put("pageCount", 0);
		}
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result get(int id) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		
		result.setMessage("操作成功");
		result.setObject(tpCarNumTitleDao.get(id));
		return result;
	}

	@Override
	public Result save(TpCarNumTitle vo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		System.out.println(">>>>>>>>>>>>>>>>crt_num_id:"+vo.getCrt_num_id());
		if(vo.getCrt_id()>0){
			TpCarNumTitle updateModel = new TpCarNumTitle();
			BeanUtils.copyProperties(vo, updateModel);
			
			tpCarNumTitleDao.update(updateModel);
		}else{
			TpCarNumTitle addModel = new TpCarNumTitle();
			BeanUtils.copyProperties(vo, addModel);
			
			tpCarNumTitleDao.insert(addModel);
		}
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result delete(int id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpCarNumTitleDao.delete(id);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	

}
