package com.devops.suc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.InfoFlowDao;
import com.devops.suc.service.InfoFlowService;
import com.devops.suc.vo.InfoFlowVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Row;
@Service
public class InfoFlowServiceImpl implements InfoFlowService {
	@Autowired
	private InfoFlowDao infoFlowDao;

	@Override
	public Result list(Row row) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<InfoFlowVO> roles = infoFlowDao.list(row);
		paginInfo.put("lists", roles);
		
		
		if(roles.size()>0){
			int totalNum = infoFlowDao.count(row);
			int totalPage = totalNum%row.getInt("size")==0?totalNum/row.getInt("size"):totalNum/row.getInt("size")+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  row.gets("page"));
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

}
