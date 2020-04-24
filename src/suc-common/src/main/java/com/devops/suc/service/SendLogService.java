package com.devops.suc.service;

import com.devops.suc.model.Queue;
import com.devops.suc.vo.SendLogSearchVO;
import com.idhoo.dhutil.dto.Result;

public interface SendLogService {
	public Result list(SendLogSearchVO vo);

	public byte[] export(int id);

	public Result test(Queue queue);

}
