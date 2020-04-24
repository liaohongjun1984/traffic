package com.devops.suc.service.impl;

import java.io.File;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.Status;
import com.devops.suc.constant.TpStatus;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.dao.TpStatisticsDao;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.model.TpRoad;
import com.devops.suc.model.TpStatistics;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.service.FileService;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.FileUtil;
import com.idhoo.dhutil.util.TimeUtil;
@Service
public class FileServiceImp implements FileService {
	
	@Autowired
	private TpUploadTempDao tpUploadTempDao;
	@Autowired
	private TpStatisticsDao tpStatisticsDao;
	@Autowired
	private TpRoadDao tpRoadDao;

	public Result uploadFile(String oriFileName, InputStream in, long size,String uploadFilePath,int road_id) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		Date curDate = new Date();
		String year  = TimeUtil.getYear(curDate);
		String month = TimeUtil.getMonth(curDate);
		String day   = TimeUtil.getDay(curDate);
		
		//保存相对路径地址
		String filePath = year+File.separator+month+File.separator+day;
		FileUtil.mkdirs(uploadFilePath+File.separator+"udata"+File.separator+filePath);
		
		String fileName = UUID.randomUUID().toString()+FileUtil.getFilePrex(oriFileName);
		try {
			if(tpUploadTempDao.checkFileRep(oriFileName)==0){
				FileUtil.copyFile(in,uploadFilePath+File.separator+"udata"+File.separator+filePath,fileName);
			}else{
				result.setMessage("文件重复,上传失败");
				result.setSuccess(false);
				return result;
			}
		} catch (Exception e) {
			
			e.printStackTrace();
			//logger.error("文件上传异常： ",e);
			result.setMessage("上传失败");
			result.setSuccess(false);
			return result;
		}
		
		int user_id = UserInfoContext.getUserId();
		String user_name = UserInfoContext.getUserName();
		//根据road_id获取路口信息
		//加入到上传文件记录表
		TpUploadTemp tpUploadTemp = new TpUploadTemp();
		tpUploadTemp.setCheck_road_id(road_id);
		tpUploadTemp.setUser_id(user_id);
		tpUploadTemp.setUser_name(user_name);
		tpUploadTemp.setFile_name(oriFileName);
		tpUploadTemp.setFile_addr("/udata/"+year+"/"+month+"/"+day+"/"+fileName);
		tpUploadTemp.setCreate_time(TimeUtil.getCurDateTime());
		tpUploadTemp.setFile_status(Status.FILEUPLOAD.file_status_wait);
		tpUploadTemp.setRoad_id(road_id);
		tpUploadTempDao.insert(tpUploadTemp);
		
		//统计 更新上传数
		TpStatistics tpStatistics = tpStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),user_id);
		if(tpStatistics == null){
			tpStatistics = new TpStatistics();
			tpStatistics.setUser_id(user_id);
			tpStatistics.setUser_name(user_name);
			tpStatistics.setDate(TimeUtil.getCurDate());
			tpStatisticsDao.insert(tpStatistics);
		}
		int staticId = tpStatistics.getCr_id();
		tpStatisticsDao.updateUpNum(staticId);
		
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("上传成功");
		result.setObject("/udata/"+year+"/"+month+"/"+day+"/"+fileName);
		result.setSuccess(true);
		return result;
	}

	public Result uploadFileExtend(String oriFileName, InputStream in, long size,String uploadFilePath) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		//保存相对路径地址
		FileUtil.mkdirs(uploadFilePath);
		
		String fileName = UUID.randomUUID().toString()+FileUtil.getFilePrex(oriFileName);
		try {
				FileUtil.copyFile(in,uploadFilePath,fileName);
		} catch (Exception e) {
			
			e.printStackTrace();
			//logger.error("文件上传异常： ",e);
			result.setMessage("上传失败");
			result.setSuccess(false);
			return result;
		}
		result.setCode(ResultCode.SUCCESS);
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("oriFileName", oriFileName);
		obj.put("newFileUrl", fileName);
		obj.put("size", size);
		result.setMessage("上传成功");
		result.setObject(obj);
		result.setSuccess(true);
		return result;
	}


	
}
