package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.model.SendLog;
import com.devops.suc.vo.SendLogSearchVO;

public interface SendLogDao extends SqlMapper {

	/**
	 * 增加发送日志
	 * @param sendLog
	 */
	public void add(SendLog sendLog);
	/**
	 * 查询发送日志
	 * @param sendLog
	 * @return
	 */
	public List<SendLog> list(SendLogSearchVO vo);
	/**
	 * 统计符合记录的总数
	 * @param sendLog
	 * @return
	 */
	public int count(SendLogSearchVO vo);
	
	public SendLog get(int id);
}
