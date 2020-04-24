package com.devops.suc.thread;

import com.idhoo.dhutil.constant.CommConfig;
import com.idhoo.dhutil.util.TimeUtil;



public class DatabaseBackup {
	/** MySQL安装目录的Bin目录的绝对路径 */  
    private String mysqlBinPath = ConfKit.get("mysqlBinPath");  
    /** 数据库的ip */  
    private String ip = ConfKit.get("ip");
    /** 数据库名称 */  
    private String databaseName = ConfKit.get("databaseName");
    /** 访问MySQL数据库的用户名 */  
    private String username = ConfKit.get("username");;  
    /** 访问MySQL数据库的密码 */  
    private String password = ConfKit.get("password");
    /** 数据库导出文件保存路径  */
    private String savePath = ConfKit.get("savePath");
    /** 数据库导出文件文件名  */
    private String fileName = TimeUtil.getCurDate()+".sql";
    /** 
     * 备份数据库 
     *  
     * @param output 
     *            输出流 
     * @param dbname 
     *            要备份的数据库名 
     */  
    public boolean backup() {  
       
    	StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("mysqldump").append(" --opt").append(" -h").append(ip);
        stringBuilder.append(" --user=").append(username) .append(" --password=").append(password).append(" --lock-all-tables=true");
        stringBuilder.append(" --result-file=").append(savePath + fileName).append(" --default-character-set=utf8 ").append(databaseName);
    	
        try {  
            Process process = Runtime.getRuntime().exec(stringBuilder.toString());  
            if (process.waitFor() == 0) {// 0 表示线程正常终止。
                return true;
            }  
            
        } catch (Exception e) {  
            e.printStackTrace();  
        } 
        return false;
    }  
    
    public static void main(String[] args) throws InterruptedException {
       /* if (backup("172.16.0.127", "root", "123456", "D:/backupDatabase", "2014-10-14.sql", "test")) {
            System.out.println("数据库备份成功！！！");
        } else {
            System.out.println("数据库备份失败！！！");
        }*/
    	DatabaseBackup databaseBackup = new DatabaseBackup();
    	if(databaseBackup.backup()){
    		System.out.println("数据库备份成功！！！");
        } else {
            System.out.println("数据库备份失败！！！");
        }
    }
    
    
}
