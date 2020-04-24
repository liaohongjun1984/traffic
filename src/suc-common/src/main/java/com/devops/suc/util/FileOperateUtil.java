package com.devops.suc.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.idhoo.dhutil.constant.CommConfig;

public class FileOperateUtil {

    /** 
     * 下载 
     */  
    public static void download(HttpServletRequest request,  
            HttpServletResponse response, String fileAddr,  
            String realName) throws Exception {  
        response.setContentType("text/html;charset=UTF-8");  
        request.setCharacterEncoding("UTF-8");  
        BufferedInputStream bis = null;  
        BufferedOutputStream bos = null;  
  
        String downLoadPath = CommConfig.get("upload_dir")+fileAddr;
        //String downLoadPath = "c:/temp/udata/2015/05/27/5cc6d970-db13-40c4-a629-38fe1f430934.png";
        
        long fileLength = new File(downLoadPath).length();  
  
        response.setContentType("application/octet-stream");  
        response.setHeader("Content-disposition", "attachment; filename="  
                + new String(realName.getBytes("utf-8"), "ISO8859-1"));  
        response.setHeader("Content-Length", String.valueOf(fileLength));  
  
        bis = new BufferedInputStream(new FileInputStream(downLoadPath));  
        bos = new BufferedOutputStream(response.getOutputStream());  
        byte[] buff = new byte[2048];  
        int bytesRead;  
        //byte[] buff = (byte[])result.getObject();
		//response.getOutputStream().write(buff, 0, buff.length);
        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
            bos.write(buff, 0, bytesRead);  
        }  
        bis.close();  
        bos.close();  
    }  
    
    private File[] fileArr;
    public String execute(HttpServletResponse response) throws Exception {
        //logger.debug(this.getClass() + " execute");
        fileArr = new File[2];
        File f1 = new File("c:/temp/udata/2015/05/27/5cc6d970-db13-40c4-a629-38fe1f430934.png");
        File f2 = new File("c:/temp/udata/2015/05/26/8ac23fd4-4d59-4959-ad5f-c844715952d6.jpg");
         
        fileArr[0] = f1;
        fileArr[1] = f2;
         
        for(File f : fileArr){
            String fileName = f.getName();
            //HttpServletResponse response = ServletActionContext.getResponse();
//            response.reset();
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
 
            response.setContentType("application/octet-stream");
 
             
            InputStream in = new FileInputStream(f);
            int i;
            OutputStream out = response.getOutputStream();
             
            try{
                while ((i = in.read()) != -1) {
                    out.write(i);
                }
                out.flush();
                in.close();
                out.close();
            }catch(Exception ex){
                //logger.debug(ex);
            }
        }
         
        return "SUCCESS";
    }
    
}
