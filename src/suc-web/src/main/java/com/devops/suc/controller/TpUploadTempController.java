package com.devops.suc.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.devops.suc.constant.TpStatus;
import com.devops.suc.dao.TpDealLogsDao;
import com.devops.suc.dao.TpDownloadStatisticsDao;
import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.dao.TpViolationActionDao;
import com.devops.suc.model.TpDealLogs;
import com.devops.suc.model.TpDownloadStatistics;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.model.TpViolationAction;
import com.devops.suc.service.TpDealLogsService;
import com.devops.suc.service.TpUploadTempService;
import com.devops.suc.util.FileOperateUtil;
import com.devops.suc.util.ZipUtils;
import com.devops.suc.vo.TpUploadTempSearchVO;
import com.devops.suc.vo.TpUploadTempVO;
import com.idhoo.dhutil.constant.CommConfig;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.resource.ClassResourceDesc;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.FileUtil;
import com.idhoo.dhutil.util.TimeUtil;


@ClassResourceDesc(firstCate = "文件上传临时表控制器接口")
@Controller
@Scope("prototype")
public class TpUploadTempController {
	
	private static final Logger logger = Logger.getLogger(TpUploadTempController.class);
	
	@Autowired
	private TpUploadTempService service;
	@Autowired
	private TpUploadTempService service1;
	@Autowired
	private TpDealLogsService tpDealLogsService;
	@Autowired
	private TpFilterFileDao tpFilterFileDao;
	@Autowired
	private TpUploadTempDao tpUploadTempDao;
	@Autowired
	private TpDealLogsDao tpDealLogsDao;
	@Autowired
	private TpViolationActionDao tpViolationActionDao;
	@Autowired
	private TpDownloadStatisticsDao tpDownloadStatisticsDao;
	@Autowired
	private TpRoadDao tpRoadDao;
	
	
	@MethodResourceDesc(name = "查询符合条件的信息")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempList.do")
	@ResponseBody
	public Result list(TpUploadTempSearchVO svo) {
		return service.list(svo);
	}
	
	@MethodResourceDesc(name = "查询已经校队的图片")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempDownList.do")
	@ResponseBody
	public Result Downlist(TpUploadTempSearchVO svo) {
		return service.Downlist(svo);
	}
	
	
	
	@MethodResourceDesc(name = "查询符合条件select的信息")
	@RequestMapping(value = "/traffic/tpUploadTemp/selectList.do")
	@ResponseBody
	public Result selectList() {
		return service.selectList();
	}
	
	
	
	@MethodResourceDesc(name = "根据id获取信息")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempGet.do")
	@ResponseBody
	public Result get(int id) {
		return service.get(id);
	}
	
	@MethodResourceDesc(name = "保存")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempSave.do")
	@ResponseBody
	public Result save(TpUploadTempVO vo) {
		return service.save(vo);
	}
	
	@MethodResourceDesc(name = "删除")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempDelete.do")
	@ResponseBody
	public Result delete(int id) {
		return service.delete(id);
	}
	
	@MethodResourceDesc(name = "确认已下载")
	@RequestMapping(value = "/traffic/tpDownLoadTemp/tpDownLoaded.do")
	@ResponseBody
	public Result tpDownLoaded(String ids) {
		return service.tpDownLoaded(ids);
	}
	
	@MethodResourceDesc(name = "重新审核")
	@RequestMapping(value = "/traffic/tpDownLoadTemp/updateStatus.do")
	@ResponseBody
	public Result updateStatus(String ids) {
		return service.updateStatus(ids);
	}
	
	@MethodResourceDesc(name = "重新校对,按取出关联的图片")
	@RequestMapping(value = "/traffic/tpDownLoadTemp/DownPicByIndex.do")
	@ResponseBody
	public Result DownPicByIndex(TpUploadTempSearchVO vo) {
		return service.DownPicByIndex(vo);
	}
	
	//打包下载
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempDownload.do")  
    public ModelAndView download(HttpServletRequest request,  
            HttpServletResponse response,String ids) throws Exception {  
  
		logger.debug("******************打包开始.");
		
        response.setHeader("Content-disposition","attachment;filename=TP-"+TimeUtil.getMyCurDateTime()+".zip");      
          
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream()); 

        List<File> zipFiles = new ArrayList<File>();
        for(String id : ids.split(",")){
        	try{
	        	int file_id = Integer.parseInt(id);
	        	TpUploadTemp tpUploadTemp = tpUploadTempDao.get(file_id);
	        	System.out.println(tpUploadTemp);
	        	TpDealLogs tpDealLogs = tpDealLogsDao.getByFileId(file_id);
	        	TpViolationAction tpViolationAction = new TpViolationAction();
	        	
	        	TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(file_id);
	        	int action_id;
	        	if(tpFilterFile.getViolation_action_id()==0){
	        		action_id = 0;
	        	}else{
	        		tpViolationAction = tpViolationActionDao.get(tpFilterFile.getViolation_action_id()); 	
	            	action_id = tpViolationAction.getAction_id();
	        	}
	        	String downLoadPath = CommConfig.get("upload_dir")+tpUploadTemp.getFile_addr();
	        	 System.out.println("downLoadPath  "+downLoadPath);
	        	 //处理时间
	        	String deal_time = tpDealLogs.getDeal_time().replace(" ", "-").replaceAll(":", "");
	        	deal_time = deal_time.substring(0, deal_time.length()-2);
	        	//处理人名字
	        	String name = tpDealLogs.getDeal_user_name();
	        	//路口编码
	        	String road_code = tpRoadDao.get(tpFilterFile.getRoad_id()).getRoad_code();
	        	//得到新的文件名  日期时间,车片号码,违法代码
	        	//String downloadName = ZipUtils.splitStr(tpUploadTemp.getFile_addr())+deal_time.replaceAll(":", "-")+"-"+ZipUtils.getFileId()+"-"+tpFilterFile.getCar_num()+"-"+action_id+"-"+tpFilterFile.getCar_type_id()+FileUtil.getFilePrex(downLoadPath);
	        	String downloadName = ZipUtils.splitStr(tpUploadTemp.getFile_addr())+deal_time+"-"+tpFilterFile.getCar_type_id()+"-"+tpFilterFile.getCar_num()+"-"+road_code+"-"+action_id+"-"+tpFilterFile.getSp_standard()+"-"+tpFilterFile.getSp_measured()+"-"+tpFilterFile.getSp_kilometers()+"-"+tpFilterFile.getSp_place_metre()+"-"+name+"-"+"("+ZipUtils.getFileId()+")"+FileUtil.getFilePrex(downLoadPath);
	        	//如果最后四项有值为null的，直接替换
	        	downloadName = downloadName.replace("-null", "");
	        	logger.info(">>>mutil_DownLoadName:"+downloadName);
	        	
	        	String newFileName = CommConfig.get("upload_dir")+downloadName;
	        	//files[i]=ZipUtils.renameFile(downLoadPath, newFileName);
	        	ZipUtils.compressPic(downLoadPath, newFileName);
	        	File file = new File(newFileName);
	        	if(file != null && file.exists()){
	        		zipFiles.add(file);
	        	}
	        	
	        	//因为新的文件名的改变，文件存储路径也发生了改变，所以修改数据库文件路径   
	        	//tpUploadTemp.setFile_addr(downloadName);
	        	//tpUploadTempDao.update(tpUploadTemp);
	        	
	        	/*//更新文件的状态
	        	tpFilterFile.setFile_down_status(TpStatus.is_downLoad.downLoaded);
	    		tpFilterFileDao.update(tpFilterFile);*/
	        	
	        	//下载统计
	        	TpDownloadStatistics tpDownloadStatistics = tpDownloadStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),UserInfoContext.getUserId());
				if(tpDownloadStatistics == null){
					tpDownloadStatistics = new TpDownloadStatistics();
					tpDownloadStatistics.setUser_id(UserInfoContext.getUserId());
					tpDownloadStatistics.setUser_name(UserInfoContext.getUserName());
					tpDownloadStatistics.setDate(TimeUtil.getCurDate());
					tpDownloadStatisticsDao.insert(tpDownloadStatistics);
				}
				int staticId = tpDownloadStatistics.getId();
				tpDownloadStatisticsDao.updateDownLoadNum(staticId);

    		
        	}catch(Exception e){
        		logger.error("生成压缩文件出错：",e);
        		e.printStackTrace();
        	}
			
        }
        int length = zipFiles.size();
        File[] files = new File[length];
        int i=0;
        for(File file : zipFiles){
        	files[i] = file;
        	i++;
        }
        ZipUtils zipUtil = new ZipUtils();  
        zipUtil.zipFile(files,"", zos);
        
        zos.flush();       
        zos.close();
        return null;  
    } 
	//打包下载
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempDownloadAll.do")  
    public ModelAndView tpUploadTempDownloadAll(HttpServletRequest request,  
            HttpServletResponse response,String ids) throws Exception {  
  
        response.setHeader("Content-disposition","attachment;filename=TP-"+TimeUtil.getMyCurDateTime()+".zip");      
          
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream()); 
        //单个文件
        List<File> zipFiles = new ArrayList<File>();
        for(String id : ids.split(",")){
        	try{
	        	int file_id = Integer.parseInt(id);
	        	TpUploadTemp tpUploadTemp = tpUploadTempDao.get(file_id);
	        	System.out.println(tpUploadTemp);
	        	TpDealLogs tpDealLogs = tpDealLogsDao.getByFileId(file_id);
	        	TpViolationAction tpViolationAction = new TpViolationAction();
	        	
	        	TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(file_id);
	        	int action_id;
	        	if(tpFilterFile.getViolation_action_id()==0){
	        		action_id = 0;
	        	}else{
	        		tpViolationAction = tpViolationActionDao.get(tpFilterFile.getViolation_action_id()); 	
	            	action_id = tpViolationAction.getAction_id();
	        	}
	        	String downLoadPath = CommConfig.get("upload_dir")+tpUploadTemp.getFile_addr();
	        	 System.out.println("downLoadPath  "+downLoadPath);
	        	 //处理时间
	        	String deal_time = tpDealLogs.getDeal_time().replace(" ", "-").replaceAll(":", "");
	        	deal_time = deal_time.substring(0, deal_time.length()-2);
	        	//处理人名字
	        	String name = tpDealLogs.getDeal_user_name();
	        	//路口编码
	        	String road_code = tpRoadDao.get(tpFilterFile.getRoad_id()).getRoad_code();
	        	//得到新的文件名  日期时间,车片号码,违法代码
	        	//String downloadName = ZipUtils.splitStr(tpUploadTemp.getFile_addr())+deal_time.replaceAll(":", "-")+"-"+ZipUtils.getFileId()+"-"+tpFilterFile.getCar_num()+"-"+action_id+"-"+tpFilterFile.getCar_type_id()+FileUtil.getFilePrex(downLoadPath);
	        	String downloadName = ZipUtils.splitStr(tpUploadTemp.getFile_addr())+deal_time+"-"+tpFilterFile.getCar_type_id()+"-"+tpFilterFile.getCar_num()+"-"+road_code+"-"+action_id+"-"+tpFilterFile.getSp_standard()+"-"+tpFilterFile.getSp_measured()+"-"+tpFilterFile.getSp_kilometers()+"-"+tpFilterFile.getSp_place_metre()+"-"+name+"-"+"("+ZipUtils.getFileId()+")"+FileUtil.getFilePrex(downLoadPath);
	        	//如果最后四项有值为null的，直接替换
	        	downloadName = downloadName.replace("-null", "");
	        	logger.info(">>>mutil_DownLoadName:"+downloadName);
	        	
	        	String newFileName = CommConfig.get("upload_dir")+downloadName;
	        	//files[i]=ZipUtils.renameFile(downLoadPath, newFileName);
	        	ZipUtils.compressPic(downLoadPath, newFileName);
	        	File file = new File(newFileName);
	        	if(file != null && file.exists()){
	        		zipFiles.add(file);
	        	}
	        	
	        	//因为新的文件名的改变，文件存储路径也发生了改变，所以修改数据库文件路径   
	        	//tpUploadTemp.setFile_addr(downloadName);
	        	//tpUploadTempDao.update(tpUploadTemp);
	        	
	        	//更新文件的状态
	        	tpFilterFile.setFile_down_status(TpStatus.is_downLoad.downLoaded);
	    		tpFilterFileDao.update(tpFilterFile);
	        	
	        	//下载统计
	        	TpDownloadStatistics tpDownloadStatistics = tpDownloadStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),UserInfoContext.getUserId());
				if(tpDownloadStatistics == null){
					tpDownloadStatistics = new TpDownloadStatistics();
					tpDownloadStatistics.setUser_id(UserInfoContext.getUserId());
					tpDownloadStatistics.setUser_name(UserInfoContext.getUserName());
					tpDownloadStatistics.setDate(TimeUtil.getCurDate());
					tpDownloadStatisticsDao.insert(tpDownloadStatistics);
				}
				int staticId = tpDownloadStatistics.getId();
				tpDownloadStatisticsDao.updateDownLoadNum(staticId);
        	
        	}catch(Exception e){
        		logger.error("生成压缩文件出错：",e);
        		e.printStackTrace();        		
        	}
        }
        int length = zipFiles.size();
        File[] files = new File[length];
        int i=0;
        for(File file : zipFiles){
        	files[i] = file;
        	i++;
        }
        ZipUtils zipUtil = new ZipUtils();  
        zipUtil.zipFile(files,"", zos);
        
        zos.flush();       
        zos.close();
        return null;  
    } 	
	
	//单个下载
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempSimpleDownload.do")  
    public ModelAndView simpleDownload(HttpServletRequest request,  
        HttpServletResponse response,int file_id) throws Exception {  

		TpUploadTemp tpUploadTemp = service.getModel(file_id);
		
		//存储路径
		//TpUploadTemp tpUploadTemp = tpUploadTempDao.get(file_id);
		
		//通过file_id到对应的文件
    	TpDealLogs tpDealLogs = tpDealLogsDao.getByFileId(file_id);
		
		//通过tpFilterFileDao来获得表
		TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(file_id);
		
    	TpViolationAction tpViolationAction = new TpViolationAction();
    	int action_id;
    	if(tpFilterFile.getViolation_action_id()==0){
    		action_id = 0;
    	}else{
    		tpViolationAction = tpViolationActionDao.get(tpFilterFile.getViolation_action_id()); 	
        	action_id = tpViolationAction.getAction_id();
    	}
    	
    	String deal_time = tpDealLogs.getDeal_time().replace(" ", "-").replaceAll(":", "");
    	deal_time = deal_time.substring(0, deal_time.length()-2);
    	//System.out.println(">>>>>>>>>>>>处理时间："+deal_time);
    	
    	String downLoadPath = CommConfig.get("upload_dir")+tpUploadTemp.getFile_addr();
    	String name = tpDealLogs.getDeal_user_name();
    	String road_code = tpRoadDao.get(tpFilterFile.getRoad_id()).getRoad_code();
    	String temp = tpFilterFile.getSp_kilometers();
    	String downloadName = deal_time+"-"+tpFilterFile.getCar_type_id()+"-"+tpFilterFile.getCar_num()+"-"+road_code+"-"+action_id+"-"+tpFilterFile.getSp_standard()+"-"+tpFilterFile.getSp_measured()+"-"+tpFilterFile.getSp_kilometers()+"-"+tpFilterFile.getSp_place_metre()+"-"+name+FileUtil.getFilePrex(downLoadPath);	
    	//如果最后四项有值为null的，直接替换
    	downloadName = downloadName.replace("-null", "");
    	logger.info(">>>one_DownLoadName:"+downloadName);
    	
    	
		FileOperateUtil.download(request, response, tpUploadTemp.getFile_addr(),downloadName);
    	//修改图片下载状态
		//TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(file_id);
		tpFilterFile.setFile_down_status(TpStatus.is_downLoad.downLoaded);
		tpFilterFileDao.update(tpFilterFile);
		
		//下载统计
    	//统计
    	TpDownloadStatistics tpDownloadStatistics = tpDownloadStatisticsDao.getByDateAndUserId(TimeUtil.getCurDate(),UserInfoContext.getUserId());
		if(tpDownloadStatistics == null){
			tpDownloadStatistics = new TpDownloadStatistics();
			tpDownloadStatistics.setUser_id(UserInfoContext.getUserId());
			tpDownloadStatistics.setUser_name(UserInfoContext.getUserName());
			tpDownloadStatistics.setDate(TimeUtil.getCurDate());
			tpDownloadStatisticsDao.insert(tpDownloadStatistics);
		}
		int staticId = tpDownloadStatistics.getId();
		tpDownloadStatisticsDao.updateDownLoadNum(staticId);
		
        return null;  
    }

	/**
	 * ============================== * jsp页面的jspx forward跳转 * ==========================================
	 */

	@MethodResourceDesc(name = "列表页面")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempList.jspx")
	public ModelAndView _list() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_upload_temp_list.jsp");
	}

	@MethodResourceDesc(name = "操作页面")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpUploadTempOp.jspx")
	public ModelAndView _op() {
		return new ModelAndView("forward:/WEB-INF/pages/tp_upload_temp_op.jsp");
	}
	
	@MethodResourceDesc(name = "下载页面")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpDownLoadTempOp.jspx")
	public ModelAndView _download() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/file_download.jsp");
	}
	
	//中队图片下载页面（按用户ID筛选）
	@MethodResourceDesc(name = "下载页面")
	@RequestMapping(value = "/traffic/tpUploadTemp/tpDownLoadTempOp2.jspx")
	public ModelAndView _download2() {
		return new ModelAndView("forward:/WEB-INF/pages/traffic/file_download2.jsp");
	}

}
