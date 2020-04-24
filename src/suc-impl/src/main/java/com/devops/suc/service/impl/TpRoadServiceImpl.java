package com.devops.suc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.RoldActionRelationDao;
import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.model.RoldActionRelation;
import com.devops.suc.model.TpRoad;
import com.devops.suc.service.TpRoadService;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpRoadSearchVO;
import com.devops.suc.vo.TpRoadVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;


@Service
public class TpRoadServiceImpl implements TpRoadService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpRoadServiceImpl.class); 
	@Autowired
	private TpRoadDao tpRoadDao;
	@Autowired
	private RoldActionRelationDao roldActionRelationDao;
	@Autowired
	private TpFilterFileDao tpFilterFileDao;	

	@Override
	public Result list(TpRoadSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpRoadVO> list =  tpRoadDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpRoadDao.count(vo);
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
		
		result.setObject(tpRoadDao.get(id));
		return result;
	}

	@Override
	public Result save(TpRoadVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getCr_id() > 0){
			TpRoad updateModel = new TpRoad();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpRoadDao.update(updateModel);
		}else{
			TpRoad addModel = new TpRoad();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpRoadDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpRoadDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result listAll(TpFilterFileSearchVO vo) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> map = new HashMap<String,Object>();
		List<TpRoadVO> list = tpRoadDao.listAll();
		
		int totalAllNum = 0;
		for(TpRoadVO t : list){
			TpFilterFileSearchVO tpVo = new TpFilterFileSearchVO();
			tpVo.setRoad_id(t.getCr_id());
			tpVo.setFile_down_status(0);
			int totalNum  = tpFilterFileDao.count(tpVo);
			t.setNoDownLoadNum(totalNum);
			totalAllNum = totalAllNum + totalNum;
		}
		
		map.put("list", list);
		map.put("num", totalAllNum);
		result.setObject(map);
		return result;
	}

	@Override
	public Result addViolationAction(int road_id, String v_ids) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setMessage("操作成功");
		
		//每次修改都删除之前的数据
		roldActionRelationDao.delete(road_id);
		
		RoldActionRelation roldActionRelation = new RoldActionRelation();
		roldActionRelation.setRoad_id(road_id);
		for(String v_id : v_ids.split(",")){
			roldActionRelation.setAction_id(Integer.parseInt(v_id));
			roldActionRelationDao.insert(roldActionRelation);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
}
