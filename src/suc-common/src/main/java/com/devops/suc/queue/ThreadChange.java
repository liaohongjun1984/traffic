package com.devops.suc.queue;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.devops.suc.logic.queue.QueueStrategy;
/**
 * <p>记录线程数据的变化</p>
 * 
 * 一个 queue 的执行，可能会增加新的 queue，
 * 或删除现有的 queue，
 * 因为线程一次读取 N 个 queue，
 * 这些新增、删除的 queue，可能影响执行顺序
 * 因此必须记录哪些被删除，哪些被新增
 * 当在执行第 M (M <= N) 个 queue 的时候，如果删除的 queue 在已有的 N 个 queue 中
 * 或新增的 queue 的执行时间比第 N 个 queue 的执行时间早，
 * 必须重新读取新的 N 个 queue
 * 以保证 queue 的执行顺序
 * 
 * Note: 此方法能改善在囤积了很多 queue 时 queue 的执行次序，但是并非 100% 保证。
 *       只有单线程可以保证所有的事件严格按顺序执行。
 * @author wangxichun
 *
 */
public class ThreadChange {
	
	private static Logger log = Logger.getLogger(ThreadChange.class);

	//private static long[] DELETED_queueS = new long[QueueStrategy.THREAD_COUNT];
	
	/** 被删除的 queue id ，结构 Map<threadIndex, Map<queueId, true>> */
	private static Map<Integer, Map<Long, Boolean>> DELETED_QUEUE_IDS = new HashMap<Integer, Map<Long,Boolean>>(); 
	
	/** 新增的 queue 的执行，如果有多个新增的 queue，每个线程只记录最小值的那个 */
	private static long[] ADDED_queue_EXEC_TIME = new long[QueueStrategy.THREAD_COUNT];
	
	static {
		// 初始化 map
		for (int i=0; i < QueueStrategy.THREAD_COUNT; i++) {
			// 使用支持同步的 map
			Map<Long, Boolean> threadMap = new ConcurrentHashMap<Long, Boolean>(128);
			DELETED_QUEUE_IDS.put(i, threadMap);
		}
	}
	
	/**
	 * 设置被删除的 queue ID
	 * @param threadIndex - 线程 Index
	 * @param queueId - queue ID
	 */
	public static void setDeletedQueue(int threadIndex, long queueId) {
		if (threadIndex >= 0 && threadIndex < QueueStrategy.THREAD_COUNT) {
			Map<Long, Boolean> threadMap = DELETED_QUEUE_IDS.get(threadIndex);
			if (threadMap.size() < 1024) {
				threadMap.put(queueId, Boolean.TRUE);
			}
			else {
				log.error("Too many queues in thread " + threadIndex);
			}
			//DELETED_queueS[threadIndex] = queueId;
		}
	}
	
	/**
	 * 设置新 queue 的执行时间
	 * @param threadIndex - 线程 index
	 * @param time - 执行时间
	 */
	public static void setNewQueueExecuteTime(int threadIndex, long time) {
		if (threadIndex >= 0 && threadIndex < ADDED_queue_EXEC_TIME.length) {
			if (ADDED_queue_EXEC_TIME[threadIndex] == 0 || time < ADDED_queue_EXEC_TIME[threadIndex]) {
				// 覆盖，取值比较小的一个
				ADDED_queue_EXEC_TIME[threadIndex] = time;
			}
		}
	}
	
//	/**
//	 * 获得被删除的 queue
//	 * @param threadIndex - 线程 index
//	 * @return 返回queue ID 或 0
//	 */
//	public static long getDeletedqueue(int threadIndex) {
//		if (threadIndex >= 0 && threadIndex < DELETED_queueS.length) {
//			return DELETED_queueS[threadIndex];
//		}
//		return 0L;
//	}
	
	/**
	 * 某 queue 是否已被删除
	 * @param threadIndex - 线程index
	 * @param queueId - queue ID
	 * @return true or false
	 */
	public static boolean isQueueDeleted(int threadIndex, long queueId) {
		if (threadIndex >= 0 && threadIndex < QueueStrategy.THREAD_COUNT) {
			Map<Long, Boolean> threadMap = DELETED_QUEUE_IDS.get(threadIndex);
			return threadMap.containsKey(queueId);
		}
		return false;
	}
	
	/**
	 * 删除 queue id
	 * @param threadIndex - 线程index
	 * @param queueId - queue ID
	 */
	public static void removequeueId(int threadIndex, long queueId) {
		if (threadIndex >= 0 && threadIndex < QueueStrategy.THREAD_COUNT) {
			Map<Long, Boolean> threadMap = DELETED_QUEUE_IDS.get(threadIndex);
			if (threadMap.containsKey(queueId)) {
				threadMap.remove(queueId);
			}
		}
	}
	
	/**
	 * 获得新 queue 的执行时间
	 * @param threadIndex - 线程 index
	 * @return 返回执行时间或 0
	 */
	public static long getNewQueueExecuteTime(int threadIndex) {
		if (threadIndex >= 0 && threadIndex < ADDED_queue_EXEC_TIME.length) {
			return ADDED_queue_EXEC_TIME[threadIndex];
		}
		return 0;
	}
	
	/**
	 * 清空信息
	 * @param threadIndex - 线程 index
	 */
	public static void clear(int threadIndex) {
		if (threadIndex >= 0 && threadIndex < QueueStrategy.THREAD_COUNT) {
			ADDED_queue_EXEC_TIME[threadIndex] = 0;
			Map<Long, Boolean> threadMap = DELETED_QUEUE_IDS.get(threadIndex);
			if (threadMap.size() > 0)
				threadMap.clear();
		}
	}
	
	/**
	 * 清空 queue 执行时间的信息
	 * @param threadIndex - 线程 index
	 */
	public static void clearExecuteTime(int threadIndex) {
		if (threadIndex >= 0 && threadIndex < QueueStrategy.THREAD_COUNT) {
			ADDED_queue_EXEC_TIME[threadIndex] = 0;
		}
	}
}
