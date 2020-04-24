package com.devops.suc.cfg;

import org.apache.log4j.Logger;

/**
 * 服务器设置
 * @author wangxichun
 *
 */
public class QueueSetting {
	
	private static Logger log = Logger.getLogger(QueueSetting.class);

	/**
	 * 是否关闭服务器
	 */
	public static boolean STOP_SERVER = false;
	
	/**
	 * 用户 queu 线程是否在工作(启动了不一定在工作，可以在等待)
	 */
	public static boolean QUEUE_THREAD_WORKING = false;

	/**
	 * 设置服务器是否停止
	 * @param stop
	 */
	public static void setServerStop(boolean stop) {
		STOP_SERVER = stop;
		if (stop) {
			QUEUE_THREAD_WORKING = false;
		}
		
		log.info("设置服务器 stop = " + stop);
	}
	
	/**
	 * 设置线程是否启动
	 * @param start
	 */
	public static void setJobThreadWorking(boolean working) {
		QUEUE_THREAD_WORKING = working;
		if (working) {
			STOP_SERVER = false;
		}
		log.info("设置线程 working = " + working);
	}
}
