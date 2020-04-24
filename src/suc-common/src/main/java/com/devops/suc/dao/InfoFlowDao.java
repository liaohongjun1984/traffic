package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.InfoFlowVO;
import com.idhoo.dhutil.util.Row;

public interface InfoFlowDao extends SqlMapper{
	
	public List<InfoFlowVO> list(Row row);
	
	public int count(Row row);
}
