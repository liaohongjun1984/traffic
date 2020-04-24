package com.devops.suc.logic.queue;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.devops.suc.dao.QueueDao;
import com.devops.suc.vo.QueueIndexVO;

/**
 *  Queue 分配策略
 * @author wangxichun
 *
 */
@Component("queueStrategy")
public class QueueStrategy {
	
	
	/** queue1Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue1Dao;
	
	/** queue2Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue2Dao;
	
	/** queue3Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue3Dao;

	/** queue4Dao 表的 queue, Note: 不要直接使用，使用 getDao(queue) 函数获得 queue */
	@Autowired
	private QueueDao queue4Dao;

	/** queue5Dao 表的 queue, Note: 不要直接使用，使用 getDao(job) 函数获得 dao */
	@Autowired
	private QueueDao queue5Dao;
	
	/** queue6Dao 表的 queue, Note: 不要直接使用，使用 getDao(job) 函数获得 dao */
	@Autowired
	private QueueDao queue6Dao;
	
	/**
	 * job 线程的数量,与job表对应(如job1,job2,jobn...等)
	 */
	public static final int THREAD_COUNT = 6;

	/**
	 * 获得处理 job 的 DAO
	 * @param index
	 * @return
	 */
	protected QueueDao getDao(int index) {
		if (index == 0) {
			return queue1Dao;
		}
		if (index == 1) {
			return queue2Dao;
		}
		if (index == 2) {
			return queue3Dao;
		}
		if (index == 3) {
			return queue4Dao;
		}
		if (index == 4) {
			return queue5Dao;
		}
		if (index == 5) {
			return queue6Dao;
		}
		return null;
	}

	
	/**
	 * 获得 job 分配的 index
	 * @param toolsName
	 * @return
	 */
	public int getJobIndex() {
		int job_index  = getMinJob();
		return (job_index-1);
	}
	
	/**
	 * 判断线程的 index 是否有效
	 * @param index
	 * @return
	 */
	public static boolean isValidThreadIndex(int index) {
		return (index >=0 && index < THREAD_COUNT);
	}
	
	protected int getMinJob() {
		List<QueueIndexVO> lists = new ArrayList<QueueIndexVO>();
		for(int i=0;i<THREAD_COUNT;i++){
			QueueDao dao =  getDao(i);
			int count = dao.count();
			QueueIndexVO vo = new QueueIndexVO();
			vo.setIndex(i+1);
			vo.setCount(count);
			lists.add(vo);
		}
		return QueueHelper.getMinJob(lists);
	}
}
