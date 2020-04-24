/**
 * @author: code@xiepeiyang.com
 * @date: 2016年3月26日-下午6:43:04
 */
package com.devops.suc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.devops.suc.service.TpCheckedService;
import com.devops.suc.vo.TpCheckedSearchVO;
import com.devops.suc.vo.TpCheckedVO;
import com.devops.suc.dao.TpCheckedDao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;

@Service
public class TpCheckedServiceImpl implements TpCheckedService{
	@Autowired
	private TpCheckedDao TpCheckedDao;
	@Override
	public Result list(TpCheckedSearchVO vo){
		Result result = new Result();
		int user_id = UserInfoContext.getUserId();
		vo.setUser_id(user_id);
		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<TpCheckedVO> list =  TpCheckedDao.list(vo);
		paginInfo.put("lists", list);
		if(list.size()>0){
			int totalNum  = TpCheckedDao.count(vo);
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
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	//@Override
	//public int count(TpCheckedSearchVO vo){
	//	return 1;
	//}
}
