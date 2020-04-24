package com.devops.suc.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.DelForm.RoadInfo;
import com.devops.suc.DelForm.UserInfo;
import com.devops.suc.constant.TpStatus;
import com.devops.suc.dao.TpCarTypeDao;
import com.devops.suc.dao.TpDealLogsDao;
import com.devops.suc.dao.TpEqualLogDao;
import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.dao.TpStatisticsDao;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.dao.TpViolationActionDao;
import com.devops.suc.dao.TpVipUserDao;
import com.devops.suc.dao.TpCheckedDao;
import com.devops.suc.model.TpCarType;
import com.devops.suc.model.TpDealLogs;
import com.devops.suc.model.TpEqualLog;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.model.TpRoad;
import com.devops.suc.model.TpStatistics;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.model.TpViolationAction;
import com.devops.suc.model.TpVipUser;
import com.devops.suc.model.TpChecked;
import com.devops.suc.service.TpDealLogsService;
import com.devops.suc.vo.DelLogForm;
import com.devops.suc.vo.TpDealLogsSearchVO;
import com.devops.suc.vo.TpDealLogsVO;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.ExportUtil;
import com.idhoo.dhutil.util.TimeUtil;


@Service
public class TpDealLogsServiceImpl implements TpDealLogsService {
	
	private static final Logger logger = LoggerFactory.getLogger(TpDealLogsServiceImpl.class); 
	@Autowired
	private TpDealLogsDao tpDealLogsDao;
	@Autowired
	private TpUploadTempDao tpUploadTempDao;
	@Autowired
	private TpVipUserDao tpVipUserDao;
	@Autowired
	private TpEqualLogDao tpEqualLogDao;
	@Autowired
	private TpStatisticsDao tpStatisticsDao;
	@Autowired
	private TpFilterFileDao tpFilterFileDao;
	@Autowired
	private TpCarTypeDao tpCarTypeDao;
	@Autowired
	private TpRoadDao tpRoadDao;
	@Autowired
	private TpViolationActionDao tpViolationActionDao;
	//@Autowired
	//private TpCheckedDao tpCheckedDao;
	
	@Override
	public Result again(TpDealLogsVO vo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		//判断传入的记录是否被清空过了，防止用户连续点击“重新校对”
		if(tpDealLogsDao.get(vo.getId()) != null){
			
			TpDealLogs need = tpDealLogsDao.get(vo.getId());
			String needTime = need.getCreate_time();
			String needNum = need.getCar_num();
			int user_id = UserInfoContext.getUserId();
			int file_status =tpDealLogsDao.get(vo.getId()).getFile_status();
			List<Integer> fileIds = new ArrayList<Integer>();
			//删除原来过滤表
			for(String file_id : vo.getFile_id().split(",")){
				int fileId = Integer.parseInt(file_id);
				fileIds.add(fileId);
				TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(fileId);
				if(tpFilterFile != null){
					tpFilterFileDao.delete(tpFilterFile.getId());
				}
			
			//修改statistics表
				TpStatistics tpStatistics = tpStatisticsDao.getByDateAndUserId(needTime.substring(0, 10), user_id);
				if(tpStatistics != null){
					int statisId = tpStatistics.getCr_id();
					if(file_status == TpStatus.file_status.invalid){
						tpStatisticsDao.reduceInvalid(statisId);
					}else{
						tpStatisticsDao.reduceChecked(statisId);
					}
				}
				
			int index = tpUploadTempDao.get(fileId).getFile_index();
			tpDealLogsDao.delete(index);
			tpEqualLogDao.deleteByCarNoAndTime(needNum,needTime);
			//删除tpUploadTemp里的file_index值
			tpUploadTempDao.deleteFile_index(fileId);
			
			}
			//把数据库的file_status重置为0
			tpUploadTempDao.recoverFileStatus(fileIds);
			//把数据库的deal_time重置null
			tpUploadTempDao.recoverDeal_time(fileIds);
			result.setCode(ResultCode.SUCCESS);
		}
		
		return result;
	}
	
	@Override
	public Result remember(int file_index){
		Result result = new Result();
		TpDealLogsVO tpDealLogsVO = tpDealLogsDao.remember(file_index);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

			//汽车类型名称
			int car_type_id = tpDealLogsVO.getCar_type_id();
			TpCarType tpCarType = tpCarTypeDao.get(car_type_id);
			if(tpCarType != null){
				tpDealLogsVO.setCar_type_name(tpCarType.getCt_type_name());
			}else{
				logger.info("TpDealLogsServiceImpl--------getCar_type_name is null!");
			}
			//路口名称
			int road_id = tpDealLogsVO.getRoad_id();
			TpRoad tpRoad = tpRoadDao.get(road_id);
			if(tpRoad != null){
				tpDealLogsVO.setRoad_name(tpRoad.getRoad_name());
			}
			//违反行为
			int violation_action_id = tpDealLogsVO.getViolation_action_id();
			TpViolationAction tpViolationAction = tpViolationActionDao.get(violation_action_id);
			if(tpViolationAction != null){
				tpDealLogsVO.setViolation_action_name(tpViolationAction.getAction_name());
			}
		result.setObject(tpDealLogsVO);
		return result;
	}

	@Override
	public Result list(TpDealLogsSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpDealLogsVO> list =  tpDealLogsDao.list(vo);
		List<TpDealLogsVO> fillList =  new ArrayList<TpDealLogsVO>();
		for(TpDealLogsVO tpDealLogsVO: list){
			//汽车类型名称
			int car_type_id = tpDealLogsVO.getCar_type_id();
			TpCarType tpCarType = tpCarTypeDao.get(car_type_id);
			if(tpCarType != null){
				tpDealLogsVO.setCar_type_name(tpCarType.getCt_type_name());
			}else{
				logger.info("TpDealLogsServiceImpl--------getCar_type_name is null!");
			}
			//路口名称
			int road_id = tpDealLogsVO.getRoad_id();
			TpRoad tpRoad = tpRoadDao.get(road_id);
			if(tpRoad != null){
				tpDealLogsVO.setRoad_name(tpRoad.getRoad_name());
			}
			//违反行为
			int violation_action_id = tpDealLogsVO.getViolation_action_id();
			TpViolationAction tpViolationAction = tpViolationActionDao.get(violation_action_id);
			if(tpViolationAction != null){
				tpDealLogsVO.setViolation_action_name(tpViolationAction.getAction_name());
			}
			//图片地址
			List<String> file_addr = new ArrayList<String>();
			for(String id:tpDealLogsVO.getFile_id().split(",")){
				if(StringUtils.isBlank(id))continue;
				TpUploadTemp tpUploadTemp = tpUploadTempDao.get(Integer.parseInt(id));
				if(tpUploadTemp != null){
					file_addr.add(tpUploadTemp.getFile_addr());
				}
			}
			tpDealLogsVO.setFile_addr(file_addr);
			fillList.add(tpDealLogsVO);
		}
		paginInfo.put("lists", fillList);
		
		if(list.size()>0){
			int totalNum  = tpDealLogsDao.count(vo);
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
		
		result.setObject(tpDealLogsDao.get(id));
		return result;
	}
	
	@Override
	public Result update(TpDealLogsVO vo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		//把数据库里的file_status赋值到新数据，用于下面的匹配表判断
		vo.setFile_status(tpDealLogsDao.get(vo.getId()).getFile_status());
		int user_id = UserInfoContext.getUserId();
		String user_name = UserInfoContext.getUserName();
		
		TpDealLogs updateModel = new TpDealLogs();
		BeanUtils.copyProperties(vo, updateModel);
		//建立全局时间变量，带秒
		String curDateTime = TimeUtil.getCurDateTime();
		
		TpDealLogs need = tpDealLogsDao.get(vo.getId());
		String needTime = need.getCreate_time();
		String needNum = need.getCar_num();
		
		if(vo.getId() > 0){
			
			
			
			//修改图片状态
			if(vo.getFile_id().length() > 0){
				for(String file_id : vo.getFile_id().split(",")){
					int fileId = Integer.parseInt(file_id);
					//统计
					TpStatistics tpStatistics = tpStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),user_id);
					if(tpStatistics == null){
						tpStatistics = new TpStatistics();
						tpStatistics.setUser_id(user_id);
						tpStatistics.setUser_name(user_name);
						tpStatistics.setDate(TimeUtil.getCurDate());
						tpStatisticsDao.insert(tpStatistics);
					}
					int staticId = tpStatistics.getCr_id();
					if(vo.getFile_status() == TpStatus.file_status.invalid){
						tpStatisticsDao.updateInvalid(staticId);
					}else{
						tpStatisticsDao.updateChecked(staticId);
					}
				}
				
			
			
				
				
				//匹配时间，应该从系统的输入框中获取时间
				String weifaTime = vo.getDeal_time();
				int car_type_id = vo.getCar_type_id();
				//传入vo是否匹配红名单
				TpVipUser tpVipUser = tpVipUserDao.getByCarNum(vo.getCar_num(),car_type_id,weifaTime);
				if(tpVipUser != null){
					if(vo.getFile_status() == TpStatus.file_status.confirm_match){
						TpEqualLog updateEqual = new TpEqualLog();
						updateEqual.setVp_id(tpVipUser.getId());
						updateEqual.setUser_name(tpVipUser.getUser_name());
						updateEqual.setCar_no(vo.getCar_num());
						updateEqual.setCreate_time(curDateTime);
						updateEqual.setEqual_type(vo.getViolation_action_id());
						updateEqual.setRoad_id(vo.getRoad_id());
						tpEqualLogDao.update(updateEqual); 
					}else{
						TpEqualLog tpEqualLog = new TpEqualLog();
						tpEqualLog.setVp_id(tpVipUser.getId());
						tpEqualLog.setUser_name(tpVipUser.getUser_name());
						tpEqualLog.setCar_no(vo.getCar_num());
						tpEqualLog.setCreate_time(curDateTime);
						tpEqualLog.setEqual_type(vo.getViolation_action_id());
						tpEqualLog.setRoad_id(vo.getRoad_id());
						tpEqualLogDao.insert(tpEqualLog);
						//如果匹配，则把处理表的状态改成匹配
						updateModel.setFile_status(TpStatus.file_status.confirm_match);
						
						//删除原来过滤表
						for(String file_id : vo.getFile_id().split(",")){
							int fileId = Integer.parseInt(file_id);
							TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(fileId);
							if(tpFilterFile != null){
								tpFilterFileDao.delete(tpFilterFile.getId());
							}
						}
					}
					
					
				}else{
					if(vo.getFile_status() == TpStatus.file_status.confirm_nomatch){
						//更新过滤表
						for(String file_id : vo.getFile_id().split(",")){
							int fileId = Integer.parseInt(file_id);
							TpFilterFile tpFilterFile = new TpFilterFile();
							tpFilterFile.setFile_id(fileId);
							tpFilterFile.setCar_type_id(String.valueOf(vo.getCar_type_id()));
							tpFilterFile.setCar_num(vo.getCar_num());
							tpFilterFile.setViolation_action_id(vo.getViolation_action_id());
							tpFilterFile.setSp_kilometers(vo.getSp_kilometers());
							tpFilterFile.setSp_measured(vo.getSp_measured());
							tpFilterFile.setSp_place_metre(vo.getSp_place_metre());
							tpFilterFile.setSp_standard(vo.getSp_standard());
							tpFilterFile.setCreatime(vo.getCreate_time());
							tpFilterFile.setRoad_id(vo.getRoad_id());
							tpFilterFile.setId(tpFilterFileDao.getByFileId(fileId).getId());
							tpFilterFile.setCreatime(curDateTime);
							//通过汽车类型的自增长id找到汽车类型的编码
							String car_type_code = tpCarTypeDao.get(vo.getCar_type_id()).getCt_type_id();
							tpFilterFile.setCar_type_id(car_type_code);
							//下载次数清0
							tpFilterFile.setFile_down_status(0);
							tpFilterFileDao.update(tpFilterFile);
						}
					}else{
						//删除旧的匹配表
						tpEqualLogDao.deleteByCarNoAndTime(needNum,needTime);
						//新增过滤表
						String car_type_code;
						for(String file_id : vo.getFile_id().split(",")){
							int fileId = Integer.parseInt(file_id);
								TpFilterFile tpFilterFile = new TpFilterFile();
								tpFilterFile.setRoad_id(vo.getRoad_id());
								tpFilterFile.setFile_id(fileId);
								tpFilterFile.setFile_down_status(TpStatus.is_downLoad.not_downLoad);
								tpFilterFile.setCreatime(curDateTime);
								tpFilterFile.setCar_num(vo.getCar_num());
								
								//通过汽车类型的自增长id找到汽车类型的编码
								car_type_code = tpCarTypeDao.get(vo.getCar_type_id()).getCt_type_id();
								tpFilterFile.setCar_type_id(car_type_code);
								
								tpFilterFile.setViolation_action_id(vo.getViolation_action_id());
					
								//超速标识数据
								tpFilterFile.setSp_standard(vo.getSp_standard());
								tpFilterFile.setSp_measured(vo.getSp_measured());
								tpFilterFile.setSp_kilometers(vo.getSp_kilometers());
								tpFilterFile.setSp_place_metre(vo.getSp_place_metre());
								
								tpFilterFileDao.insert(tpFilterFile);
							}
					}
					
				}
				
				//更新DealLogs表
				updateModel.setCreate_time(curDateTime);
				updateModel.setDeal_user_name(UserInfoContext.getUserName());
				updateModel.setUser_id(UserInfoContext.getUserId());
				updateModel.setUser_name(UserInfoContext.getUserName());
				tpDealLogsDao.update(updateModel);
				result.setCode(ResultCode.SUCCESS);
			}
			
		}	
		
		
		return result;
	}
	
	@Override
	public Result save(TpDealLogsVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		int user_id = UserInfoContext.getUserId();
		String user_name = UserInfoContext.getUserName();
		
		logger.info("--------TpDealLogsServiceImpl:提交图片校对操作"+vo.getFile_id());
		
		//判断当前上传的vo里面的文件，有没有在DealLogs表存在信息
		boolean index_flag = false;
		if(vo.getFile_id().length() > 0){
			for(String file_id : vo.getFile_id().split(",")){
				int fileId = Integer.parseInt(file_id);
				TpUploadTemp tpUploadTemp = tpUploadTempDao.getByFileId(fileId);
				int index = tpUploadTemp.getFile_index();
				if(index > 0){
					index_flag = true;
				}
			}
		}
		
		if(index_flag){
			return result;
		}else{
			TpDealLogs addModel = new TpDealLogs();
			BeanUtils.copyProperties(vo, addModel);	
			
			//修改图片状态
			List<Integer> fileIds = new ArrayList<Integer>();
			if(vo.getFile_id().length() > 0){
				for(String file_id : vo.getFile_id().split(",")){
					int fileId = Integer.parseInt(file_id);
					fileIds.add(fileId);
					//insert to TABLE tp_checked
					/*
					TpChecked tpCheckedModel = new TpChecked();
					TpUploadTemp tpUploadTempModel = tpUploadTempDao.get(fileId);
					tpCheckedModel.setUser_name(tpUploadTempModel.getUser_name());
					tpCheckedModel.setUser_id(tpUploadTempModel.getUser_id());
					tpCheckedModel.setRoad_id(tpUploadTempModel.getRoad_id());
					tpCheckedModel.setFile_name(tpUploadTempModel.getFile_name());
					tpCheckedModel.setFile_addr(tpUploadTempModel.getFile_addr());
					tpCheckedModel.setCheck_result(vo.getFile_status());
					tpCheckedModel.setCreate_time(TimeUtil.getCurDateTime());
					tpCheckedModel.setCar_type_name(vo.getCar_type_name());
					tpCheckedModel.setCar_num(vo.getCar_num());
					tpCheckedModel.setIllegal_time(vo.getDeal_time());
					tpCheckedModel.setUpload_temp_id(fileId);
					tpCheckedDao.insert(tpCheckedModel);
					*/
					//统计
					TpStatistics tpStatistics = tpStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),user_id);
					if(tpStatistics == null){
						tpStatistics = new TpStatistics();
						tpStatistics.setUser_id(user_id);
						tpStatistics.setUser_name(user_name);
						tpStatistics.setDate(TimeUtil.getCurDate());
						tpStatisticsDao.insert(tpStatistics);
					}
					int staticId = tpStatistics.getCr_id();
					if(vo.getFile_status() == TpStatus.file_status.invalid){
						tpStatisticsDao.updateInvalid(staticId);
					}else{
						tpStatisticsDao.updateChecked(staticId);
					}
					tpUploadTempDao.updateFileStatus(vo.getFile_status(),vo.getRoad_id() ,fileId);
				}
			}
			//tpUploadTempDao.batchUpdateFileStatus(fileIds);
			
			
			//建立全局时间变量，带秒
			String curDateTime = TimeUtil.getCurDateTime();
			
			//匹配时间，应该从系统的输入框中获取时间
			String weifaTime = vo.getDeal_time();
			if(vo.getFile_status() == TpStatus.file_status.confirm_nomatch){
				//车辆类型的匹配
				int car_type_id = vo.getCar_type_id();
				//查询匹配红名单
				TpVipUser tpVipUser = tpVipUserDao.getByCarNum(vo.getCar_num(),car_type_id,weifaTime);
				if(tpVipUser != null){
					TpEqualLog tpEqualLog = new TpEqualLog();
					tpEqualLog.setVp_id(tpVipUser.getId());
					tpEqualLog.setUser_name(tpVipUser.getUser_name());
					tpEqualLog.setCar_no(vo.getCar_num());
					tpEqualLog.setCreate_time(curDateTime);
					tpEqualLog.setEqual_type(vo.getViolation_action_id());
					tpEqualLog.setRoad_id(vo.getRoad_id());
					tpEqualLogDao.insert(tpEqualLog);
					//如果匹配，则把处理表的状态改成匹配
					addModel.setFile_status(TpStatus.file_status.confirm_match);
				}else{
					//如果不匹配则放到过滤表中
					String car_type_code;
					for(String file_id : vo.getFile_id().split(",")){
						int fileId = Integer.parseInt(file_id);
							TpFilterFile tpFilterFile = new TpFilterFile();
							tpFilterFile.setRoad_id(vo.getRoad_id());
							tpFilterFile.setFile_id(fileId);
							tpFilterFile.setFile_down_status(TpStatus.is_downLoad.not_downLoad);
							tpFilterFile.setCreatime(curDateTime);
							tpFilterFile.setCar_num(vo.getCar_num());
							
							//通过汽车类型的自增长id找到汽车类型的编码
							car_type_code = tpCarTypeDao.get(vo.getCar_type_id()).getCt_type_id();
							tpFilterFile.setCar_type_id(car_type_code);
							
							tpFilterFile.setViolation_action_id(vo.getViolation_action_id());
				
							//超速标识数据
							tpFilterFile.setSp_standard(vo.getSp_standard());
							tpFilterFile.setSp_measured(vo.getSp_measured());
							tpFilterFile.setSp_kilometers(vo.getSp_kilometers());
							tpFilterFile.setSp_place_metre(vo.getSp_place_metre());
							
							//用户ID
							tpFilterFile.setUser_id(user_id);
							
							tpFilterFileDao.insert(tpFilterFile);
						}
					}//end匹配
			}
			
			addModel.setUser_id(UserInfoContext.getUserId());
			addModel.setUser_name(UserInfoContext.getUserName());
			addModel.setFile_id(vo.getFile_id());
			addModel.setCreate_time(curDateTime);
			addModel.setDeal_user_name(UserInfoContext.getUserName());
			if(vo.getDeal_time().equals("")){
				addModel.setDeal_time(curDateTime);
			}
			tpDealLogsDao.insert(addModel);
			
			//给temp index
			if(vo.getFile_id().length() > 0){
				for(String file_id : vo.getFile_id().split(",")){
					int fileId = Integer.parseInt(file_id);
					tpUploadTempDao.updateIndex(addModel.getId(),fileId);
					tpUploadTempDao.updateDeal_time(curDateTime,fileId);
					//添加三个字段
					tpUploadTempDao.updateCar_num(vo.getCar_num(), fileId);
					tpUploadTempDao.updateCar_type_name(vo.getCar_type_name(), fileId);
					tpUploadTempDao.updateIllegal_time(vo.getDeal_time(), fileId);
				}
			}
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpDealLogsDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result listForm(TpDealLogsSearchVO svo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		Map<String,Object> paginInfo = new HashMap<String,Object>();
		
		if(svo.getBeginTime() != null && svo.getBeginTime() != ""){
			svo.setBeginTime(svo.getBeginTime()+" 00:00:00");
		}
		if(svo.getEndTime() != null && svo.getEndTime() != ""){
			svo.setEndTime(svo.getEndTime()+" 23:59:59");
		}
		
		//得到用户id列表
		List<Integer> userIds = tpDealLogsDao.listDistinctUserId(svo);
		//用户信息列表
		List<UserInfo> userInfos = new ArrayList<UserInfo>();
		for(int user_id : userIds){
			//路口列表
			List<RoadInfo> roadInfos = new ArrayList<RoadInfo>();
			svo.setUser_id(user_id);
			List<Integer> roadIds = tpDealLogsDao.listRoadByUserId(svo);
			
			for(int road_id : roadIds){
				svo.setRoad_id(road_id);
				//违法行为列表
				List<TpDealLogsVO> delLogList = tpDealLogsDao.listForm(svo);
				//int totalNum  = tpDealLogsDao.countForm(svo);
				TpRoad tpRoad = tpRoadDao.get(road_id);
				
				RoadInfo roadInfo = new RoadInfo();
				if(tpRoad != null){
					roadInfo.setRoadName(tpRoad.getRoad_name());
				}
				roadInfo.setDelLogList(delLogList);
				//roadInfo.setTotalNum(totalNum);
				roadInfos.add(roadInfo);
			}
			
			UserInfo userInfo = new UserInfo();
			userInfo.setUserId(user_id);
			userInfo.setRoadInfo(roadInfos);
			userInfos.add(userInfo);
		}
		
		paginInfo.put("list", userInfos);

		result.setObject(paginInfo);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result exportDealLogs(TpDealLogsSearchVO svo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setMessage("操作成功");
		List<TpDealLogsVO> list = tpDealLogsDao.list(svo);
		
		String[] column = new String[]{
				"证件类型","汽车类型","图片名称","车牌号",
				"路口","违反行为","违法时间","状态","处理人","处理时间"
		};
		List<List<String>> listData = new ArrayList<List<String>>(list.size());

		for(TpDealLogsVO vo:list){
			List<String> listInfo = new ArrayList<String>();
			//证件类型
			switch(vo.getCertificates_type()){
			case 1: listInfo.add("公安证件");break;
			}
			//汽车类型
			int car_type_id = vo.getCar_type_id();
			TpCarType tpCarType = tpCarTypeDao.get(car_type_id);
			if(tpCarType!=null){
				listInfo.add(tpCarType.getCt_type_name());
			}else{
				listInfo.add("空");
			}
			
			//图片名称
			String file_name = null;
			for(String id:vo.getFile_id().split(",")){
				TpUploadTemp tpUploadTemp = tpUploadTempDao.get(Integer.parseInt(id));
				file_name = tpUploadTemp.getFile_name()+";";
				listInfo.add(file_name);
			}
			//车牌号
			listInfo.add(vo.getCar_num());
			//路口
			int road_id = vo.getRoad_id();
			TpRoad tpRoad = tpRoadDao.get(road_id);
			if(tpRoad!=null){
				listInfo.add(tpRoad.getRoad_name());
			}else{
				listInfo.add("空");
			}
			
			//违反行为
			int violation_action_id = vo.getViolation_action_id();
			TpViolationAction tpViolationAction = tpViolationActionDao.get(violation_action_id);
			if(tpRoad!=null){
				listInfo.add(tpViolationAction.getAction_name());
			}else{
				listInfo.add("空");
			}
			
			//违法时间
			listInfo.add(vo.getDeal_time());
			//状态
			switch (vo.getFile_status()) {
			case 0:listInfo.add("确认");break;
			case 1:listInfo.add("确认");break;
			case 2:listInfo.add("无效");break;
			}
			//处理人
			listInfo.add(vo.getDeal_user_name());
			//处理时间
			listInfo.add(vo.getDeal_time());
			
			listData.add(listInfo);
		}
		result.setObject(ExportUtil.exportServer(listData, column, ""));
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
}
