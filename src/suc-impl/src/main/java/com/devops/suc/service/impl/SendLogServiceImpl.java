package com.devops.suc.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.SendLogDao;
import com.devops.suc.model.Queue;
import com.devops.suc.model.SendLog;
import com.devops.suc.queue.QueueType;
import com.devops.suc.service.QueueService;
import com.devops.suc.service.SendLogService;
import com.devops.suc.vo.SendLogSearchVO;
import com.idhoo.dhutil.context.UserInfoContext;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
@Service
public class SendLogServiceImpl implements SendLogService {
	@Autowired
	private SendLogDao sendLogDao;
	@Autowired
	private QueueService queueService;

	@Override
	public Result list(SendLogSearchVO vo) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<SendLog> logs = sendLogDao.list(vo);
		paginInfo.put("lists", logs);
		
		
		if(logs.size()>0){
			int totalNum = sendLogDao.count(vo);
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
	public byte[] export(int id) {
		SendLog vo = sendLogDao.get(id);
		if(vo == null){
			return null;
		}
		return vo.getMessage().getBytes();
	}

	@Override
	public Result test(Queue queue) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		queue.setExecute_time(new Date());
		queue.setCreate_admin(UserInfoContext.getUserName());
		try{
			if(queue.getQueue_type() == QueueType.EMAIL){
//				QueueHelper.addEMailQueue(queue.getRecipient(), queue.getCc(), queue.getSubject(), queue.getMessage(),date);
			}
			if(queue.getQueue_type() == QueueType.YY_GROUP){
				queueService.addQueue(queue);
				//QueueHelper.addYyGroupQueue(queue.getRecipient(), queue.getRecipient(), queue.getSubject(), queue.getMessage(), date, "");
			}
			if(queue.getQueue_type() == QueueType.MOBILE){
				queueService.addQueue(queue);
				//QueueHelper.addMobileQueue(queue.getRecipient(), queue.getRecipient(), queue.getSubject(), queue.getMessage(), date, "");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
