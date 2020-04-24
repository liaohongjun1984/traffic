package com.devops.suc.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.RoldActionRelationDao;
import com.devops.suc.dao.TpViolationActionDao;
import com.devops.suc.model.TpViolationAction;
import com.devops.suc.service.TpViolationActionService;
import com.devops.suc.vo.RoldActionRelationSearchVO;
import com.devops.suc.vo.RoldActionRelationVO;
import com.devops.suc.vo.TpViolationActionSearchVO;
import com.devops.suc.vo.TpViolationActionVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.TimeUtil;


@Service
public class TpViolationActionServiceImpl implements TpViolationActionService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpViolationActionServiceImpl.class); 
	@Autowired
	private TpViolationActionDao tpViolationActionDao;
	@Autowired
	private RoldActionRelationDao roldActionRelationDao;

	@Override
	public Result list(TpViolationActionSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		logger.info("select violation "+TimeUtil.getCurDateTime());
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpViolationActionVO> list =  tpViolationActionDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpViolationActionDao.count(vo);
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
	public Result listAll(TpViolationActionSearchVO  svo) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		logger.info("select All violation "+TimeUtil.getCurDateTime());
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		
		List<TpViolationActionVO> list =  tpViolationActionDao.listAll();
		
		RoldActionRelationSearchVO vo = new RoldActionRelationSearchVO();
		System.out.println(svo.getCr_id());
		vo.setRoad_id(svo.getCr_id());
		List<RoldActionRelationVO> road = roldActionRelationDao.list(vo);
		for (TpViolationActionVO tpViolationActionVO : list) {
			for (RoldActionRelationVO roldActionRelationVO : road) {
				if(roldActionRelationVO.getAction_id()==tpViolationActionVO.getV_id()){
					tpViolationActionVO.setStatus(1);
				}
			}
		}
		
		
		paginInfo.put("lists", list);

		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result get(int id) {	
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		/*Map<String,Object> map = new HashMap<String,Object>();
		map.put("tpViolationAction", tpViolationActionDao.get(id));
		map.put("road_id", value);*/
		
		result.setObject(tpViolationActionDao.get(id));
		return result;
	}

	@Override
	public Result save(TpViolationActionVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getV_id() > 0){
			TpViolationAction updateModel = new TpViolationAction();
			updateModel.setV_id(vo.getV_id());
			updateModel.setAction_name(vo.getAction_name());
			updateModel.setAction_id(vo.getAction_id());
			tpViolationActionDao.update(updateModel);
			
		}else{
			TpViolationAction addModel = new TpViolationAction();
			addModel.setV_id(vo.getV_id());
			addModel.setAction_name(vo.getAction_name());
			addModel.setAction_id(vo.getAction_id());
			tpViolationActionDao.insert(addModel);
			
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpViolationActionDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result listViolationActionByRoadId(int road_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		result.setObject(tpViolationActionDao.listByRoadId(road_id));
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	
}
