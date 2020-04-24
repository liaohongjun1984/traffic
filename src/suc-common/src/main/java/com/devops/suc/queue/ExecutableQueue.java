package com.devops.suc.queue;

import com.devops.suc.model.Queue;

/**
 *  Queue 定义
 * 子类不能有变量
 * @author wangxichun
 *
 */
public abstract class ExecutableQueue {

	/**
	 * 执行任务
	 */
	public abstract int execute(Queue queue);
	
}
