package com.devops.suc.service.impl;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.TpCarTypeDao;
import com.devops.suc.dao.TpVipUserDao;
import com.devops.suc.model.TpCarType;
import com.devops.suc.model.TpVipUser;
import com.devops.suc.service.TpVipUserService;
import com.devops.suc.vo.TpCarTypeSearchVO;
import com.devops.suc.vo.TpVipUserSearchVO;
import com.devops.suc.vo.TpVipUserVO;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.ExportUtil;
import com.idhoo.dhutil.util.TimeUtil;


@Service
public class TpVipUserServiceImpl implements TpVipUserService {
	
	@Autowired
	private TpVipUserDao tpVipUserDao;

	@Autowired
	private TpCarTypeDao tpCarTypeDao;

	@Override
	public Result list(TpVipUserSearchVO vo) {
	
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpVipUserVO> list =  tpVipUserDao.list(vo);
		List<TpVipUserVO> fillList = new ArrayList<TpVipUserVO>();
		for(TpVipUserVO tvo:list){
			//汽车类型
			int car_type_id = tvo.getCar_type();
			TpCarType tpCarType = tpCarTypeDao.get(car_type_id);
			tvo.setCar_type_name(tpCarType.getCt_type_name());
			fillList.add(tvo);
		}
		paginInfo.put("lists", list);
		
		if(list.size()>0){
			int totalNum  = tpVipUserDao.count(vo);
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
		
		result.setObject(tpVipUserDao.get(id));
		return result;
	}

	@Override
	public Result save(TpVipUserVO vo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		if(vo.getId() > 0){
			TpVipUser updateModel = tpVipUserDao.get(vo.getId());
			BeanUtils.copyProperties(vo, updateModel);			
			
			updateModel.setModify_user(UserInfoContext.getUserName());
			updateModel.setModify_time(TimeUtil.getCurDateTime());
			
			tpVipUserDao.update(updateModel);
		}else{
			TpVipUser addModel = new TpVipUser();
			BeanUtils.copyProperties(vo, addModel);		
				
			addModel.setCreate_user(UserInfoContext.getUserName());
			addModel.setCreate_time(TimeUtil.getCurDateTime());
			addModel.setModify_user(UserInfoContext.getUserName());
			addModel.setModify_time(TimeUtil.getCurDateTime());
			
			tpVipUserDao.insert(addModel);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}


	@Override
	public Result delete(int id) {
			
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		tpVipUserDao.delete(id);
		
		result.setCode(ResultCode.SUCCESS);
		return result;	
	}

	@Override
	public Result likeUserName(String userName) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<TpVipUser> vips = tpVipUserDao.likeUserName(userName);
		
		result.setObject(vips);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result likeCarNo(String carNo) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<TpVipUser> vips = tpVipUserDao.likeCarNo(carNo);
		
		result.setObject(vips);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result exportVip(TpVipUserSearchVO svo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setMessage("操作成功！");
		
		List<TpVipUserVO> list = tpVipUserDao.list(svo);
		
		String[] column = new String[]{
				"姓名","性别","职务","车牌号","车辆类型",
				"创建人","创建时间","过期时间","修改人","修改时间"
		};
		List<List<String>> listData = new ArrayList<List<String>>(list.size());
		int car_type_id;
		TpCarType tpCarType;
		for(TpVipUserVO vo:list){
			List<String> listInfo = new ArrayList<String>();
			//姓名
			listInfo.add(vo.getUser_name());
			//性别
			switch (vo.getSex()) {
			case 0: listInfo.add("未选择性别"); break;
			case 1: listInfo.add("男"); break;
			case 2: listInfo.add("女"); break;
			}
			//职务
			listInfo.add(vo.getPosition());
			//车牌号
			listInfo.add(vo.getCar_no());
			//车辆类型
			car_type_id = vo.getCar_type();
			tpCarType = tpCarTypeDao.get(car_type_id);
			vo.setCar_type_name(tpCarType.getCt_type_name());
			listInfo.add(vo.getCar_type_name());
			//创建人
			listInfo.add(vo.getCreate_user());
			//创建时间
			listInfo.add(vo.getCreate_time());
			//过期时间
			listInfo.add(vo.getExpired_time());
			//修改人
			listInfo.add(vo.getModify_user());
			//修改时间
			listInfo.add(vo.getModify_time());
			
			listData.add(listInfo);
		}
		result.setObject(ExportUtil.exportServer(listData, column, ""));
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
}
