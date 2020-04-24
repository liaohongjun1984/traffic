package com.devops.suc.queue;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.devops.suc.model.Queue;
import com.devops.suc.queue.impl.EmailExecute;
import com.devops.suc.queue.impl.MobileExecute;
import com.devops.suc.queue.test.TestSystemQueue;

/**
 * 工厂类
 * @author wangxichun
 *
 */
public final class ExceutableQueueFactory {
	
	private static Logger log = Logger.getLogger(ExceutableQueueFactory.class);
	private static Map<Integer, ExecutableQueue> queues = new HashMap<Integer, ExecutableQueue>();
	
	static {
		// -- 测试queue
		queues.put(QueueType.TEST, new TestSystemQueue());
		queues.put(QueueType.EMAIL,new EmailExecute());
		queues.put(QueueType.MOBILE,new MobileExecute());
	}

	public static ExecutableQueue getExecutableQueue(Queue queue) {
		if(queue==null)
			return null;
		ExecutableQueue dealJob = queues.get(queue.getQueue_type());
		if(dealJob==null)
			log.error("没有找到匹配的处理类:"+queue.getQueue_type());
		return dealJob;
	}
}
