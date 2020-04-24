package com.devops.suc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.handler.QueueHandler;
import com.devops.suc.model.Queue;
import com.devops.suc.service.QueueService;
/**
 * 队列
 * @author wangxichun
 *
 */
@Service("queueService")
public class QueueServiceImpl implements QueueService {

	@Autowired
	private QueueHandler queueHandler;
	
	@Override
	public long addQueue(Queue queue) {
		return queueHandler.addQueue(queue);
	}

	@Override
	public void deleteQueue(int threadIndex, long queueId) {
		queueHandler.deleteQueue(queueId, threadIndex);
		
	}

	@Override
	public List<Queue> getEarliestQueues(int threadIndex, int count) {
		return queueHandler.listQueueByTime(threadIndex, count);
	}

}
