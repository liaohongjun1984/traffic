package com.devops.suc.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.model.TpCarType;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.service.TpFilterFileService;
import com.devops.suc.vo.TpDealLogsVO;
import com.devops.suc.vo.TpFilterFileSearchVO;
import com.devops.suc.vo.TpFilterFileVO;
import com.devops.suc.vo.TpVipUserVO;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.ExportUtil;


@Service
public class TpFilterFileServiceImpl implements TpFilterFileService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpFilterFileServiceImpl.class);
	@Autowired
	private TpFilterFileDao tpFilterFileDao;

	@Override
	public Result list(TpFilterFileSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		if(vo.getBeginTime() != null && vo.getBeginTime() != ""){
			vo.setBeginTime(vo.getBeginTime() + " 00:00:00");
		}
		if(vo.getEndTime() != null && vo.getEndTime() != ""){
			vo.setEndTime(vo.getEndTime() + " 23:59:59");
		}
		if(vo.getUser_id() == -1){
			vo.setUser_id(UserInfoContext.getUserId());
		}
		List<TpFilterFileVO> list =  tpFilterFileDao.list(vo);
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpFilterFileDao.count(vo);
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
		
		result.setObject(tpFilterFileDao.get(id));
		return result;
	}

	@Override
	public Result save(TpFilterFileVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpFilterFile updateModel = new TpFilterFile();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpFilterFileDao.update(updateModel);
		}else{
			TpFilterFile addModel = new TpFilterFile();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpFilterFileDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpFilterFileDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result updateTFFSome() {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		List<TpFilterFileVO> list = tpFilterFileDao.listTFFData();
		
		for(TpFilterFileVO vo : list){
			
			String file_id = String.valueOf(vo.getFile_id());
			TpDealLogsVO list_dealLog = tpFilterFileDao.listTDLData(file_id);
			if(list_dealLog!=null){
				//System.out.println(">>>>>>>>>>>Car_num="+list_dealLog.getCar_type_id());
				vo.setCar_num(list_dealLog.getCar_num());
				vo.setCar_type_id(Integer.toString(list_dealLog.getCar_type_id()));
				vo.setViolation_action_id(list_dealLog.getViolation_action_id());
				
				tpFilterFileDao.updateTFFData(vo);
			}else{
			System.out.println("没有相关的数据！");
			}
			
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}



	@Override
	public Result exportExcel(TpFilterFileSearchVO svo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setMessage("操作成功！");
		if(svo.getBeginTime() != null && svo.getBeginTime() != ""){
			svo.setBeginTime(svo.getBeginTime() + " 00:00:00");
		}
		if(svo.getEndTime() != null && svo.getEndTime() != ""){
			svo.setEndTime(svo.getEndTime() + " 23:59:59");
		}
		if(svo.getUser_id() == -1){
			svo.setUser_id(UserInfoContext.getUserId());
		}
		List<TpFilterFileVO> list =  tpFilterFileDao.list(svo);
		
		String[] column = new String[]{"图片名称","时间"};
		List<List<String>> listData = new ArrayList<List<String>>(list.size());
		for(TpFilterFileVO vo:list){
			List<String> listInfo = new ArrayList<String>();
			//图片名称
			listInfo.add(vo.getFile_name());
			//时间
			listInfo.add(vo.getCreatime());
			
			listData.add(listInfo);
		}
		result.setObject(ExportUtil.exportServer(listData, column, ""));
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
}
