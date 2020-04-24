package com.devops.suc.queue;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.devops.suc.cfg.QueueSetting;
import com.devops.suc.dao.QueueConfigDao;

/**
 * 初始化线程 servlet
 * @author wangxichun
 *
 */
@SuppressWarnings("serial")
public class SucThreadServlet extends HttpServlet {

	
	private final static Logger log = Logger.getLogger(SucThreadServlet.class);
	
	private Thread[] threads = null;
	
	protected QueueConfigDao queueConfigDao;
	
	public SucThreadServlet() {
	}

	@Override
	public void destroy() {
		super.destroy();
		
		// 设置停止线程的标志
		QueueSetting.setServerStop(true);

		if (threads != null) {
			for (int i=0; i < threads.length; i++) {
				if (threads[i].isAlive()) {
					try {
						// 等待100ms
						threads[i].join(100L);
					} catch (InterruptedException e) {
					}
				}
			} // end for
		}
		// 关闭log4j
		LogManager.shutdown();
	}

	@Override
	public void init() throws ServletException {
		
		String[] queueIndexs = new String[]{"0","1","2","3","4","5"};
		int len = 0;
		len = queueIndexs.length;
		if(len == 0){
			log.info("get server queue config error! len = 0");
			return;
		}
		super.init();
		try{
			
		
		// 1. 启动普通 job 线程
		final int JOB_COUNT_PER_LOOP = 200; // 每个循环读的任务数量,可以根据实际情况调整

		threads = new Thread[len];
		for (int i=0; i < len; i++) {
			String index  = queueIndexs[i];
			log.info("QueueThread index ===="+index);
			threads[i] = new QueueThread(Integer.parseInt(index), JOB_COUNT_PER_LOOP);
		}
		log.info("threads.length====="+threads.length);
		for (int i=0; i < threads.length; i++) {
			threads[i].start();
		}

		// start
		QueueSetting.setJobThreadWorking(true);
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
