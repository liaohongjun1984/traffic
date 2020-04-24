package com.devops.suc.util;

import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.icu.text.SimpleDateFormat;

public class ZipUtils {  
	  
    private String fileName;  
    
    private static int increateNum = 0;
   
    public void zipFile(File[] subs, String baseName, ZipOutputStream zos) throws IOException {         
		for (int i = 0; i < subs.length; i++) {
			File f = subs[i];
			zos.putNextEntry(new ZipEntry(baseName + f.getName()));
			FileInputStream fis = new FileInputStream(f);
			byte[] buffer = new byte[1024];
			int r = 0;
			while ((r = fis.read(buffer)) != -1) {
				zos.write(buffer, 0, r);
			}
			fis.close();
		}
		zos.flush();
		zos.close();
     }   
    
    public static void downLoad(HttpServletRequest request,HttpServletResponse response) throws IOException{
    	SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd_hhMMss");  
        response.setHeader("Content-disposition","attachment;filename=TP"+f.format(new Date())+".zip");      
          
        ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());  
        File[] files = new File[3];  
        for(int i=0; i<3; i++){  
            files[i]=new File("c:/temp/udata/2015/05/30/67fbf783-bd20-4881-a777-f2689f4e87de.jpg");    
        }   
        ZipUtils zipUtil = new ZipUtils();  
        zipUtil.zipFile(files,"JmsFiles/", zos);       
        zos.flush();       
        zos.close(); 
    }
      
    public String getZipFileName() {  
        return fileName;  
    }  
  
    public void setZipFileName(String fileName) {     
        this.fileName = fileName+new Date().getTime()+".zip";  
    }  
    
    
    //文件名重写
    public static File renameFile(String file, String toFile) {

    	File toBeRenamed = new File(file);
    	//检查要重命名的文件是否存在，是否是文件
    	if (!toBeRenamed.exists() || toBeRenamed.isDirectory()) {

    	System.out.println("File does not exist: " + file);
    	return null;
    	}

    	File newFile = new File(toFile);

    	//修改文件名
    	if (toBeRenamed.renameTo(newFile)) {
    	System.out.println("File has been renamed.");
    	} else {
    	System.out.println("Error renmaing file");
    	}
    	return newFile;
    	}
    
    //分割字符串得到文件名
    public static String splitStr(String sourceStr){
    	String targetStr = "";
    	String[] sourceStrArray = sourceStr.split("/");
        for (int i = 0; i < sourceStrArray.length-1; i++) {
        	targetStr += sourceStrArray[i]+"/";
        }
        return targetStr;
    }
    
    public static boolean compressPic(String srcFilePath, String descFilePath)  
    {  
        File file = null;  
        BufferedImage src = null;  
        FileOutputStream out = null;  
        ImageWriter imgWrier;  
        ImageWriteParam imgWriteParams;  
  
        // 指定写图片的方式为 jpg  
        imgWrier = ImageIO.getImageWritersByFormatName("jpg").next();  
        imgWriteParams = new javax.imageio.plugins.jpeg.JPEGImageWriteParam(null);  
        // 要使用压缩，必须指定压缩方式为MODE_EXPLICIT  
        imgWriteParams.setCompressionMode(imgWriteParams.MODE_EXPLICIT);  
        // 这里指定压缩的程度，参数qality是取值0~1范围内，  
        imgWriteParams.setCompressionQuality((float)0.6);  
        imgWriteParams.setProgressiveMode(imgWriteParams.MODE_DISABLED);  
        ColorModel colorModel = ColorModel.getRGBdefault();  
        // 指定压缩时使用的色彩模式  
        imgWriteParams.setDestinationType(new javax.imageio.ImageTypeSpecifier(colorModel, colorModel  
                .createCompatibleSampleModel(16, 16)));  
  
        try  
        {  
            if(srcFilePath == "" || srcFilePath == null)  
            {  
                return false;  
            }  
            else  
            {  
                file = new File(srcFilePath);  
                src = ImageIO.read(file);  
                out = new FileOutputStream(descFilePath);  
  
                imgWrier.reset();  
                // 必须先指定 out值，才能调用write方法, ImageOutputStream可以通过任何 OutputStream构造  
                imgWrier.setOutput(ImageIO.createImageOutputStream(out));  
                // 调用write方法，就可以向输入流写图片  
                imgWrier.write(null, new IIOImage(src, null, null), imgWriteParams);  
                out.flush();  
                out.close();  
            }  
        }  
        catch(Exception e)  
        {  
            e.printStackTrace();  
            return false;  
        }  
        return true;  
    }  

    public static synchronized String getFileId(){
    	increateNum++;
    	if(increateNum > 500){
    		increateNum = 0;
    	}
    	return String.valueOf(increateNum);
    }
      
}  
