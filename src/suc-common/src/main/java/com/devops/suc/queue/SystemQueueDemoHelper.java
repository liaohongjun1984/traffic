package com.devops.suc.queue;

import java.util.Date;
import java.util.GregorianCalendar;

import org.springframework.beans.factory.annotation.Autowired;

import com.devops.suc.handler.QueueHandler;
import com.devops.suc.model.Queue;
import com.idhoo.dhutil.dto.ResultCode;

/**
 * 系统
 * @author wangxichun
 *
 */
public class SystemQueueDemoHelper {
	
	@Autowired
	private QueueHandler queueHandler;
	
    private static SystemQueueDemoHelper instance = null;
    
    private SystemQueueDemoHelper() {  
    }
    synchronized public static SystemQueueDemoHelper getInstance() { 
        if (instance == null) {
        	instance = new SystemQueueDemoHelper();
        }
      return instance;  
    }
	
	public int testQueue() {
		Queue queue = new Queue();
		// 先删除以前队列JOB
		
		long i = queueHandler.addQueue(queue);
		System.out.println(i);
		return ResultCode.SUCCESS;
	}
	
	public static Date getTestJobTime() {
		GregorianCalendar calendar = new GregorianCalendar();
		calendar.setTime(new Date());
//		calendar.add(GregorianCalendar.DATE, 0);
//		calendar.set(GregorianCalendar.HOUR_OF_DAY, 0);
		calendar.add(GregorianCalendar.MINUTE, +1);
//		calendar.set(GregorianCalendar.SECOND, 60);
		calendar.set(GregorianCalendar.MILLISECOND, 0);
		return calendar.getTime();
	}
}
