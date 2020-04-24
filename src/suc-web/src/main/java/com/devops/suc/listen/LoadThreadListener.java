package com.devops.suc.listen;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.devops.suc.thread.BackUpTread;

public class LoadThreadListener  implements ServletContextListener  {
	private final static Logger logger  = Logger.getLogger(LoadThreadListener.class);
	@Override
	public void contextInitialized(ServletContextEvent event)  {
		try {
			new BackUpTread().start();
		} catch (Exception e) {
			logger.error("线程同步数据出错原因:"+e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

}
