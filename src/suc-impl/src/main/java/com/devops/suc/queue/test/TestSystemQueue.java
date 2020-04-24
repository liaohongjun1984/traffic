package com.devops.suc.queue.test;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.devops.suc.model.Queue;
import com.devops.suc.queue.ExecutableQueue;
import com.devops.suc.queue.SystemQueueDemoHelper;
/**
 * 
 * @author wangxichun
 *
 */
public class TestSystemQueue extends ExecutableQueue {

	private final static Logger log  = Logger.getLogger(TestSystemQueue.class);
	
	@Override
	public int execute(Queue queue) {
		return SystemQueueDemoHelper.getInstance().testQueue();
	}
	
	public static void main(String[] args) {
		List<String> result=new ArrayList<String>();
		String string = "a湘b</test>c<test>d-</test>e";
		Pattern p = Pattern.compile(".*?(湘.*?)-",Pattern.DOTALL);
		Matcher m = p.matcher(string);
		while(m.find()){
			result.add(m.group(1));
			System.out.println(m.group(1));
		}
		for(String s1:result){
			//System.out.println(s1);
		}
	}

}
