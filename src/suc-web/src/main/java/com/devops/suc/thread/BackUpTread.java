package com.devops.suc.thread;

public class BackUpTread extends Thread {

	@Override
	public void run() {	
		System.out.println("同步用户信息线程，线程标识："+Thread.currentThread().getName());
		//常驻进程
		while(true){
			
			System.out.println("Hello !!");
			DatabaseBackup databaseBackup = new DatabaseBackup();
	    	if(databaseBackup.backup()){
	    		System.out.println("数据库备份成功！！！");
	        } else {
	            System.out.println("数据库备份失败！！！");
	        }
			
			try {
				Thread.sleep(24*60*60*1000);
				//Thread.sleep(60*1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
			
		}
	}
	
}
