package com.devops.suc.cfg;

import org.apache.log4j.Logger;

/**
 * 服务器设置
 * 这里需要注意一下多线程环境下，线程变量通过拷贝变成临时变量的情况
 * @author liaohj@duohao001.com
 *
 */
public class JobSetting {
	
	//同时处理数据的线程数
	public final static int THREAD_COUNT = 4;
	//同时处理数据的线程数
	public final static int ALARAM_THREAD_COUNT = 1;
	
	private static Logger log = Logger.getLogger("sys");

	/**
	 * 是否关闭服务器
	 */
	public static boolean STOP_SERVER = false;
	
	/**
	 * 用户 job 线程是否在工作(启动了不一定在工作，可以在等待)
	 */
	public static boolean JOB_THREAD_WORKING = false;

	/**
	 * 设置服务器是否停止
	 * @param stop
	 */
	public static void setServerStop(boolean stop) {
		STOP_SERVER = stop;
		if (stop) {
			JOB_THREAD_WORKING = false;
		}
		
		log.info("设置服务器 stop = " + stop);
	}
	
	/**
	 * 设置线程是否启动
	 * @param start
	 */
	public static void setJobThreadWorking(boolean working) {
		JOB_THREAD_WORKING = working;
		if (working) {
			STOP_SERVER = false;
		}
		log.info("设置线程 working = " + working);
	}
}
