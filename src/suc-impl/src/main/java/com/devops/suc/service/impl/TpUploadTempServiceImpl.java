package com.devops.suc.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpCarTypeDao;
import com.devops.suc.dao.TpDealLogsDao;
import com.devops.suc.dao.TpEqualLogDao;
import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.dao.TpViolationActionDao;
import com.devops.suc.model.TpDealLogs;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.service.TpUploadTempService;
import com.devops.suc.vo.TpCarTypeVO;
import com.devops.suc.vo.TpRoadVO;
import com.devops.suc.vo.TpUploadTempSearchVO;
import com.devops.suc.vo.TpUploadTempVO;
import com.devops.suc.vo.TpViolationActionVO;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;


@Service
public class TpUploadTempServiceImpl implements TpUploadTempService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpUploadTempServiceImpl.class);
	@Autowired
	private TpUploadTempDao tpUploadTempDao;
	@Autowired
	private TpCarTypeDao tpCarTypeDao;
	@Autowired
	private TpRoadDao tpRoadDao;
	@Autowired
	private TpViolationActionDao tpViolationActionDao;
	@Autowired
	private TpFilterFileDao tpFilterFileDao;
	@Autowired
	private TpEqualLogDao tpEqualLogDao;
	@Autowired
	private TpDealLogsDao tpDealLogsDao;

	@Override
	public Result list(TpUploadTempSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		int user_id = UserInfoContext.getUserId();
		vo.setUser_id(user_id);
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpUploadTempVO> list = tpUploadTempDao.list(vo);
		paginInfo.put("lists", list);
		if(list.size()>0){
			int totalNum  = tpUploadTempDao.count(vo);
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
	public Result DownPicByIndex(TpUploadTempSearchVO vo){
		List<TpUploadTempVO> list = tpUploadTempDao.DownPicByIndex(vo);
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		result.setObject(list);
		return result;
	}
	
	@Override
	public Result Downlist(TpUploadTempSearchVO vo) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		int user_id = UserInfoContext.getUserId();
		vo.setUser_id(user_id);
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpUploadTempVO> list =  tpUploadTempDao.Downlist(vo);
		
		paginInfo.put("lists", list);
		if(list.size()>0){
			int totalNum  = tpUploadTempDao.count(vo);
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
	public Result selectList() {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> map = new HashMap<String,Object>();
		
		//车型
		List<TpCarTypeVO> carList =  tpCarTypeDao.listAll();
		//路口
		List<TpRoadVO> roadList =  tpRoadDao.listAll();
		//违规行为
		List<TpViolationActionVO> tpViolationActionList =  tpViolationActionDao.listAll();
		
		map.put("carList", carList);
		map.put("roadList", roadList);
		map.put("tpViolationActionList", tpViolationActionList);
		result.setObject(map);
		return result;
	}

	@Override
	public Result get(int id) {	
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map<String,Object> map = new HashMap<String,Object>();
		TpUploadTemp tpUploadTemp = tpUploadTempDao.get(id);
		map.put("tpUploadTemp", tpUploadTemp);
		
		if(tpUploadTemp != null){
			Pattern p = Pattern.compile(".*?(湘.*?)-",Pattern.DOTALL);
			Matcher m = p.matcher(tpUploadTemp.getFile_name());
			while(m.find()){
				map.put("carNum", m.group(1));
			}
		}
		
		result.setObject(map);
		return result;
	}
	
	@Override
	public TpUploadTemp getModel(int id) {	
	
		TpUploadTemp tpUploadTemp = tpUploadTempDao.get(id);
		
		return tpUploadTemp;
	}

	@Override
	public Result save(TpUploadTempVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpUploadTemp updateModel = new TpUploadTemp();
			BeanUtils.copyProperties(vo, updateModel);			
			
			tpUploadTempDao.update(updateModel);
		}else{
			TpUploadTemp addModel = new TpUploadTemp();
			BeanUtils.copyProperties(vo, addModel);		
				
			tpUploadTempDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpUploadTempDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result tpDownLoaded(String ids) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<Integer> fileIds = new ArrayList<Integer>();
		for(String id : ids.split(",")){
			fileIds.add(Integer.parseInt(id));
		}
		tpFilterFileDao.batchDownLoadFileStatus(fileIds);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	/*
	 * 重新审核图片
	 */
	@Override
	public Result updateStatus(String ids) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		int file_id1= 0;
		for(String id : ids.split(",")){
			int file_id = Integer.parseInt(id);
			file_id1=file_id;
			//修改图片状态为未处理
			tpUploadTempDao.updateStatus(file_id);
			TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(file_id);
			TpDealLogs tpDealLogs = tpDealLogsDao.getByFileId(file_id);
			result.setObject(tpDealLogs);
			if(tpFilterFile != null){
				//如果下载表有该数据，删除
				tpFilterFileDao.delete(tpFilterFile.getId());
			}else{
				//如果下载表没有，则数据到了匹配记录，删除
			//	TpDealLogs tpDealLogs = tpDealLogsDao.getByFileId(file_id);
				if(tpDealLogs != null){
					//根据处理时间和车牌号码去删除匹配记录
					tpEqualLogDao.deleteByCarNoAndTime(tpDealLogs.getCar_num(),tpDealLogs.getCreate_time());
				}
			}
		}				
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public TpUploadTemp getModel1(int road_id) {
		// TODO Auto-generated method stub
		return null;
	}



}
