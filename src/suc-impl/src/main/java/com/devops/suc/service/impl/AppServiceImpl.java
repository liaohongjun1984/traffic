package com.devops.suc.service.impl;

import java.util.List;
import java.util.ArrayList;
import java.util.logging.Logger;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.AppDao;
import com.devops.suc.dao.AppGroupDao;
import com.devops.suc.dao.MenuDao;
import com.devops.suc.dao.TpCarTypeDao;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.App;
import com.devops.suc.model.AppGroup;
import com.devops.suc.model.KeyValueSetting;
import com.devops.suc.model.Menu;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.model.User;
import com.devops.suc.model.TpFilterFile;
import com.devops.suc.model.TpRoad;
import com.devops.suc.model.TpCarType;
import com.devops.suc.service.AppService;
import com.devops.suc.vo.AppSearchVO;
import com.devops.suc.vo.AppVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Row;
import com.devops.suc.dao.TpUploadTempDao;
import com.devops.suc.dao.TpDealLogsDao;
import com.devops.suc.dao.TpFilterFileDao;
import com.devops.suc.dao.TpRoadDao;
import com.devops.suc.vo.TpDealLogsVO;
import com.devops.suc.vo.TpUploadTempVO;
import com.devops.suc.vo.TpFilterFileVO;
import com.devops.suc.vo.TpRoadVO;

@Service
public class AppServiceImpl implements AppService {
	
	@Autowired
	private AppDao appDao;
	@Autowired
	private AppGroupDao appGroupDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private TpDealLogsDao tpDealLogsDao;
	@Autowired
	private TpUploadTempDao tpUploadTempDao;
	@Autowired
	private TpFilterFileDao tpFilterFileDao;
	@Autowired
	private TpCarTypeDao tpCarTypeDao;
	@Autowired
	private TpRoadDao tpRoadDao;
	
	
	@Override
	public Result listUseApp() {
		Row row = new Row();
		row.put("status", (short) 1);
		row.put("start", 0);
		row.put("size", Integer.MAX_VALUE);
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(appDao.list(row));
		return result;
	}

	@Override
	public Result listApp(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);

		List<AppVO> vos = appDao.list(row);
		result.setObject(vos);

		return result;
	}

	@Override
	public Result listAll(AppSearchVO appSearchVO) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);

		List<App> apps = appDao.listAll(appSearchVO);
		result.setObject(apps);

		return result;
	}

	@Override
	public Result saveApp(App app) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		App appOld = appDao.getByNameAndGroup(app);
		if (appOld != null && appOld.getApp_id() != app.getApp_id()) {
			result.setMessage("同一个分组下面存在相同的英文名称系统.");
		} else {
			if (app.getApp_id() == 0) {
				appDao.save(app);
			} else {
				appDao.update(app);
			}
			result.setCode(ResultCode.SUCCESS);
		}
		return result;
	}

	@Override
	public Result updateStatus(int id, String operator, short status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public App getApp(int app_id) {
		return appDao.getByAppId(app_id);
	}

	@Override
	public List<AppGroup> listGroup() {
		return appGroupDao.list();
	}

	@Override
	public Result delAppGroup(int app_group_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		int count = appGroupDao.queryApp(app_group_id);
		if (count > 0) {
			result.setMessage("该系统分组下面还存在系统，请删除系统后再删除系统分组.");
		} else {
			appGroupDao.delete(app_group_id);
			result.setCode(ResultCode.SUCCESS);
		}

		return result;
	}

	@Override
	public Result saveAppGroup(AppGroup appGroup) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		AppGroup appGroupOld = appGroupDao.queryByName(appGroup.getName());
		if (appGroupOld != null
				&& appGroupOld.getApp_group_id() != appGroup.getApp_group_id()) {
			result.setMessage("存在同名的系统分组,请重新输入.");
		} else {
			if (appGroup.getApp_group_id() == 0) {
				appGroupDao.save(appGroup);
			} else {
				appGroupDao.update(appGroup);
			}
			result.setCode(ResultCode.SUCCESS);
		}

		return result;
	}

	@Override
	public AppGroup getAppGroup(int app_group_id) {
		return appGroupDao.queryById(app_group_id);
	}

	@Override
	public App getByAppId(int app_id) {
		return appDao.getByAppId(app_id);
	}

	@Override
	public Result disableAndAble(int app_id, int status, String operator) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);

		App app = appDao.getByAppId(app_id);
		app.setOperator(operator);
		app.setStatus(status == 1 ? (short) 2 : (short) 1);
		appDao.update(app);

		return result;
	}

	@Override
	public Result listPrewApp(int user_id) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		Row row = new Row();
		row.put("user_id", user_id);
		
		User u = userDao.getByUserId(user_id);
		if(u.getAdmin()==1){
			List<AppVO> apps = appDao.listAllEffApp();
			result.setObject(apps);
		}else{
			List<AppVO> apps = appDao.listAppByUser(row);
			if (apps.size() == 0) {
				result.setMessage("此用户没有权限");
				return result;
			}
			result.setObject(apps);
		}

		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result listParam() {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<KeyValueSetting> apps = appDao.listParam();
		result.setObject(apps);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result updateParam(KeyValueSetting keyValueSetting) {
		// TODO Auto-generated method stub
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		appDao.updateParam(keyValueSetting);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public List<App> listApp() {
		return appDao.listApp();
	}

	@Override
	public Result listMenu(int app_id) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);

		List<Menu> vos = menuDao.getSuperAdminMenu(app_id);
		result.setObject(vos);

		return result;
	}

	@Override
	public Result getParamById(int param_id){
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		KeyValueSetting keyValueSetting = appDao.getParamById(param_id);
		result.setObject(keyValueSetting);
		return result;
	}

	@Override
	public Result updateSystem() {
		Result result = new Result();
		boolean successOrNot = false;
		result.setCode(ResultCode.FAILURE);
		System.out.print(">>>>>>>>>>>>准备更新数据库！！！！");
		//一期更新
		//jdbcTemplate.execute("alter table tp_violation_action add action_id int(11) comment '违规行为编码' ");
		//jdbcTemplate.execute("alter table tp_car_type add ct_type_id int(11) comment '汽车类型编码'");
		//jdbcTemplate.execute("alter table tp_filter_file add car_num varchar(128) comment '车牌号',add car_type_id int(11) comment '汽车类型编码',add violation_action_id tinyint(4) comment '违规行为编码'");
		
		//二期更新，添加车牌号前缀
		//jdbcTemplate.execute("CREATE TABLE `tp_car_num_title` (`crt_id` int(11) NOT NULL auto_increment COMMENT '自增长id',`crt_num_title` varchar(20) character set utf8 default NULL COMMENT '汽车车牌号前缀',`crt_num_id` int(11) default NULL COMMENT '汽车车牌前缀编码',PRIMARY KEY  (`crt_id`)) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='汽车车牌前缀'");
		
		//三期更新，修改汽车类型表中汽车编码类型的数据类型
		//jdbcTemplate.execute("ALTER TABLE tp_car_type MODIFY ct_type_id VARCHAR(5) COMMENT'汽车类型编码'");
		//jdbcTemplate.execute("ALTER TABLE tp_filter_file MODIFY car_type_id VARCHAR(5) COMMENT'汽车类型编码'");
		
		//第六次更新，添加超速违法
		
		//第七次更新，添加了deal_time,file_index
		
		//添加user_id,修复一些脏数据有file_index但file_status=0的问题
		//上传时往tp_upload_temp添加一个字段road_name
		try{
			
			jdbcTemplate.execute("ALTER TABLE tp_filter_file ADD `user_id` int(11) default NULL COMMENT '校对图片的user_id'");
			
			
			List<TpDealLogsVO> DLlist = tpDealLogsDao.ergodic();
			for(TpDealLogsVO deal:DLlist){
				for(String file_id:deal.getFile_id().split(",")){
					int fileId = Integer.parseInt(file_id);
					TpUploadTemp tpUploadTemp = tpUploadTempDao.getByFileId(fileId);
					TpFilterFile tpFilterFile = tpFilterFileDao.getByFileId(fileId);
					if(tpFilterFile != null){
						tpFilterFile.setUser_id(deal.getUser_id());
						tpFilterFileDao.update(tpFilterFile);
					}
					tpUploadTemp.setFile_index(deal.getId());
					tpUploadTemp.setDeal_time(deal.getCreate_time());
					tpUploadTemp.setFile_status(1);
					tpUploadTemp.setCar_num(deal.getCar_num());
					tpUploadTemp.setIllegal_time(deal.getDeal_time());
					tpUploadTemp.setCar_type_name(tpCarTypeDao.getCarTypeNameById(Integer.toString(deal.getCar_type_id())));
					tpUploadTempDao.update(tpUploadTemp);
				}
			}
			successOrNot = true;
		}catch(Exception e){
			successOrNot = false;
			//result.setCode(ResultCode.FAILURE);
			//result.setMessage("已经更新系统，请不要重复更新");
			//return result;
		}
		
		//添加三个字段，迁移数据
		try{
			jdbcTemplate.execute("ALTER TABLE tp_upload_temp ADD `car_type_name` varchar(500) default NULL COMMENT '汽车类型名称'");
			jdbcTemplate.execute("ALTER TABLE tp_upload_temp ADD `car_num` varchar(128) default NULL COMMENT '汽车车牌号码'");
			jdbcTemplate.execute("ALTER TABLE tp_upload_temp ADD `illegal_time` datetime default NULL COMMENT '违法时间'");
			List<TpDealLogsVO> DLlist = tpDealLogsDao.ergodic();
			for(TpDealLogsVO deal:DLlist){
				for(String file_id:deal.getFile_id().split(",")){
					int fileId = Integer.parseInt(file_id);
					TpUploadTemp tpUploadTemp = tpUploadTempDao.getByFileId(fileId);
					tpUploadTemp.setCar_num(deal.getCar_num());
					tpUploadTemp.setIllegal_time(deal.getDeal_time());
					tpUploadTemp.setCar_type_name(tpCarTypeDao.getCarTypeNameById(Integer.toString(deal.getCar_type_id())));
					tpUploadTempDao.update(tpUploadTemp);
				}
			}
			successOrNot = true;
		}catch(Exception e){
			;
		}
		
		try{
			jdbcTemplate.execute("ALTER TABLE tp_upload_temp ADD `check_road_id` varchar(500) default NULL COMMENT '路口名称'");
			//添加了路口还需要修改路口名称:
			//增加了路口名称字段需要修改,就需要把名称也名称也tina添加进这个字段里面;
			List<TpUploadTempVO> tempList = tpUploadTempDao.listAll();
			for (TpUploadTempVO tpUploadTempVO : tempList) {
				tpUploadTempVO.setCheck_road_id(tpUploadTempVO.getRoad_id());
				tpUploadTempDao.updateCheckRoadId(tpUploadTempVO);
			}
			successOrNot = true;
		}catch(Exception e){
			successOrNot = false;
		}
		
		if(successOrNot){
			result.setCode(ResultCode.SUCCESS);
			result.setMessage("成功更新系统");
			System.out.print(">>>>>>>>>>>>更新数据库成功！"); 
			return result;
		}
		else{
			result.setCode(ResultCode.FAILURE);
			result.setMessage("已经更新系统，请不要重复更新");
			return result;
		}
	}
}