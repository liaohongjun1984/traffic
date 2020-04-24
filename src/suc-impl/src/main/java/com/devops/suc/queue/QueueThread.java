package com.devops.suc.queue;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.devops.suc.cfg.QueueSetting;
import com.devops.suc.logic.queue.QueueStrategy;
import com.devops.suc.model.Queue;
import com.devops.suc.service.QueueService;
import com.idhoo.dhutil.spring.SpringContextUtil;

/**
 * queue 线程
 * @author wangxichun
 *
 */
@Component
public class QueueThread extends Thread {
	
	protected Logger log;

	/** 每次循环读取的 queue 数量 */
	protected int maxTasks;
	
	protected QueueService queueService;
	
//	protected QueueConfigDao queueConfigDao;
	
	/** 线程的 index */
	protected int threadIndex = 0;
	
	/** 已启动的线程 index */
	private static Map<Integer, Boolean> startedThread = new HashMap<Integer, Boolean>();
	
	public QueueThread(int threadIndex, int maxTasks) {

//		if (maxTasks < 1) {
//			maxTasks = 1;
//		}
		
		if (maxTasks < 10) {
			maxTasks = 50;
		}
		if (maxTasks > 1000) {
			maxTasks = 1000;
		}

		this.maxTasks = maxTasks;
		this.threadIndex = threadIndex;
		if (!QueueStrategy.isValidThreadIndex(threadIndex) || startedThread.containsKey(threadIndex)) {
			throw new IllegalArgumentException("threadIndex");
		}
		
		// 记录此线程已启动
		startedThread.put(threadIndex, Boolean.TRUE);

		// 初始化
		init();
		
		log = Logger.getLogger(QueueThread.class);
	}
	
	/**
	 * 初始化
	 */
	protected void init() {
		queueService = (QueueService) SpringContextUtil.getBean("queueService");
//		queueConfigDao = (QueueConfigDao) SpringContextUtil.getBean("queueConfigDao");
	}

	@Override
	public void run() {
		log.info("Starting thread: " + threadIndex);
		
		while (!QueueSetting.STOP_SERVER) {
			// Note: 只有 STOP_SERVER 标志可以终止线程
			try {
				log.info("Starting thread: " + threadIndex);
				runNormal();
			}
			catch (Exception e) {
				// 保证不会因为 exception 终止线程
				e.printStackTrace();
				try {
					Thread.sleep(1500);
				} catch (InterruptedException e1) {
				}
			}
		}
		
		// 停止
		log.info("Stopping thread: " + threadIndex);

	}

	/**
	 * 用于单线程
	 */
	protected void runNormal() {
		
		StringBuilder errorBuffer = new StringBuilder(128);
		// 记录 queue 的重试次数
		Map<String, Integer> retryQueueIdMap = new HashMap<String, Integer>();
		long lastRetryTime = 0;
		while (!QueueSetting.STOP_SERVER) {
			while (QueueSetting.QUEUE_THREAD_WORKING) {
				try{
				
					// 每次读取一个 Queue 队列，按时间顺序 ( time <= now)
					List<Queue> queues = queueService.getEarliestQueues(this.threadIndex, this.maxTasks);
					if (queues != null && queues.size() > 0) {
						// 每次都重置信息，避免 ThreadChange 的数据膨胀
						ThreadChange.clear(this.threadIndex);
						long now = System.currentTimeMillis();
						if (lastRetryTime > 0 && retryQueueIdMap.size() > 0 && now - lastRetryTime >= 600000L) {
							// 10 分钟清除一次记录
							retryQueueIdMap.clear();
						}
		
						// 取得最后一个 Queue 的执行时间
						Queue lastQueue = queues.get(queues.size() - 1);
						long lastQueueExecTime = lastQueue.getExecute_time().getTime();
						for (Queue queue : queues) {
							if (!QueueSetting.QUEUE_THREAD_WORKING) {
								break;
							}
		
							if (ThreadChange.isQueueDeleted(this.threadIndex, queue.getQueue_id())) {
								// 如果 queue 已被删除 跳过
								continue;
							}
							
							// 清新增 queue 的执行时间
							ThreadChange.clearExecuteTime(this.threadIndex);
		
							try {
								if (log.isDebugEnabled()) {
									log.debug("thread " + this.threadIndex + ": executing Queue " + queue.getQueue_id() + " ...");
								}
								log.info("thread " + this.threadIndex + ": executing Queue " + queue.getQueue_id() + " ...");
								queue.setQueue_index(this.threadIndex);
								//执行自定义Queue具体方法
								ExecutableQueue execQueue = ExceutableQueueFactory.getExecutableQueue(queue);
								if (execQueue != null) {
									// 1. 执行 Queue
									int result = execQueue.execute(queue);
									
									// 2. 记录结果
									log.info("normalQueue:"+queue.toString() + ", result: " + result);
									// 3. 增加完成的 Queue 记录
								}
								
								long newExecTime = ThreadChange.getNewQueueExecuteTime(threadIndex);
								if (newExecTime > 0 && newExecTime < lastQueueExecTime) {
									// 新的执行时间比本次队列最后一个 Queue 的时间要早, 中断，重新装载队列
									break;
								}
		
							} catch (Exception e) {
								e.printStackTrace();
								// 记录 Exception
								errorBuffer.setLength(0);
								errorBuffer
									.append("normalQueue thread index: ").append(threadIndex)
									.append(queue.toString());
								log.error("EXCEPTION in Queue: " + errorBuffer.toString(), e);
								
								// 重新放入 Queue 表
								if (e instanceof IllegalArgumentException) {
									// QueueHandlerImpl 抛出的 IllegalArgumentException 不处理
									log.info("Drop this Queue ... (IllegalArgumentException)");
								}
								else {
									// 注：不能用 QueueId 做 key
									String key = queue.getQueue_id() + "/" + this.threadIndex;
									Integer retryTimes = retryQueueIdMap.get(key);
									if (retryTimes == null || retryTimes.intValue() < 5) {
										// 重试次数加 1
										retryTimes = (retryTimes == null ? Integer.valueOf(1) : retryTimes.intValue() + 1);
										retryQueueIdMap.put(key, retryTimes);
										
										// 前 2次，4.2 秒后执行
										//  (注：失败的时候，重试读取结果 8次，每次间隔 1.5s。 4.2s 的间隔应该可以整个重试期间，Queue 最多能被执行2次)
										long afterMilliSeconds = 4200L;
										if (retryTimes.intValue() > 2) {
											// 超过 2 次，隔 11 秒执行
											afterMilliSeconds = 11000L;
										}
										
										// 11 秒后重试
										queue.setExecute_time(new Date(System.currentTimeMillis() + afterMilliSeconds));
										log.info("Retry this Queue, times: " + retryTimes + ", run at " + queue.getExecute_time().getTime());
										// 保存
										queue.setLast_modify(queue.getExecute_time());
										try {
											queueService.addQueue(queue);
										} catch (RuntimeException re) {
											log.error("Try to add Queue error!!!", re);
											retryQueueIdMap.put(key, 5);
										}
									}
								}
		
							}
							finally {
								queueService.deleteQueue(this.threadIndex, queue.getQueue_id()); // 删除 Queue
							}
						}
						
						//
						// Note: 出 Exception 继续往下跑
						//
					}else{
						// 无 Queue, sleep 100ms
						try {
							Thread.sleep(1000L);
						} catch (InterruptedException e) {
						}
					}
				}catch(Exception e){
					e.printStackTrace();
					log.error("EXCEPTION in thread,error ",e);
				}
			}
			
			try {
				// Queue 线程未开始工作，sleep 250ms
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				
			}
		}
	}
	
}
