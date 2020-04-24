package com.devops.suc.logic.queue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.TreeSet;

import com.devops.suc.vo.QueueIndexVO;
/**
 * 
 * @author wangxichun
 *
 */
public class QueueHelper {
	/**
	 * 取得队列最小JOB
	 * @param lists
	 * @return
	 */
	public static int getMinJob(List<QueueIndexVO> lists){
		TreeSet<QueueIndexVO> treeSet = new TreeSet<QueueIndexVO>(new Comparator<QueueIndexVO>() {
		    @Override
		    public int compare(QueueIndexVO o1, QueueIndexVO o2) {
		        return o1.getCount() > o2.getCount() ? 1 : -1;
		    }
		});
		treeSet.addAll(lists);
		return treeSet.first().getIndex();
	}
	
	public static void main(String[] args) throws IOException,InterruptedException {
		
		List<QueueIndexVO> lists = new ArrayList<QueueIndexVO>();
		QueueIndexVO vo = new QueueIndexVO();
		
		vo.setIndex(1);
		vo.setCount(0);
		lists.add(vo);
		
		vo = new QueueIndexVO();
		vo.setIndex(2);
		vo.setCount(0);
		lists.add(vo);
		
		vo = new QueueIndexVO();
		vo.setIndex(3);
		vo.setCount(10);
		lists.add(vo);
		
		vo = new QueueIndexVO();
		vo.setIndex(4);
		vo.setCount(300);
		lists.add(vo);
		
		vo = new QueueIndexVO();
		vo.setIndex(4);
		vo.setCount(500);
		lists.add(vo);
		
		System.out.println(getMinJob(lists));
	}
}
