package com.devops.suc.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.coobird.thumbnailator.Thumbnails;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.devops.suc.service.FileService;
import com.idhoo.dhutil.constant.CommConfig;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.resource.MethodResourceDesc;
import com.idhoo.dhutil.util.FileUtil;

@Controller
public class FileController{
	
	
	@Autowired 
	private FileService fileservice;
	
	@MethodResourceDesc(name = "文件上传")
	@RequestMapping(value = "/file/uploadFile.do")
	@ResponseBody	
	public Result uploadFile(HttpServletRequest request,int road_id){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setMessage(null);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		@SuppressWarnings("rawtypes")
		Iterator iter  = multipartRequest.getFileNames();  
		InputStream in = null;
		
		   try {
			   while(iter.hasNext()){
					 String param = (String) iter.next();  
					 CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile(param); 
					 in = file.getFileItem().getInputStream();
					 String oriFileName = file.getOriginalFilename();
					 result = fileservice.uploadFile(oriFileName, in, file.getSize(),CommConfig.get("upload_dir"),road_id);
					 in.close();	 
				    }
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		finally{
			if(in!=null)
				try{
					in.close();}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return result;
	}
	
	@MethodResourceDesc(name = "查看图片文件")
	@RequestMapping(value = "/file/imgFileView.do")
	@ResponseBody	
	public void imgFileView(HttpServletRequest request,HttpServletResponse response,String fileName){
		
		ServletOutputStream stream 	=  null;
		BufferedInputStream fif =  null;
		try {
			String[] strArr = fileName.split("/");
			if(strArr.length!=4){
				return;
			}
			String year  = strArr[0];
			String month = strArr[1];
			String day   = strArr[2];
			String fName = strArr[3];
			
			String filePath = year+File.separator+month+File.separator+day;
			String realFileName = CommConfig.get("upload_dir")+File.separator+"udata"+File.separator+filePath+File.separator+fName;
			System.out.println(realFileName);
			File file = new File(realFileName);
			if(!file.exists()){
				return;
			}
			stream = response.getOutputStream();
			response.reset();
			response.setContentType("image/jpeg");
			response.setHeader("Content-Length", String.valueOf(file.length()));
			fif = new BufferedInputStream(new FileInputStream(file));
			int d;
			byte[] buf = new byte[10240];
			while ((d = fif.read(buf)) != -1) {
				stream.write(buf, 0, d);
			}
			stream.flush();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (stream != null) {
					stream.close();
				}
				if (fif != null) {
					fif.close();
				}
				
			} catch (Exception e11) {
			}
		}
	}
	
	@MethodResourceDesc(name = "图片缩略")
	@RequestMapping(value = "/file/Thumbnails.do")
	@ResponseBody	
	public void Thumbnails(HttpServletRequest request,HttpServletResponse response,String fileName){
		
		ServletOutputStream stream 	=  null;
		BufferedInputStream fif =  null;
		try {
			String[] strArr = fileName.replaceAll("/udata/", "").split("/");
			if(strArr.length!=4){
				return;
			}
			String year  = strArr[0];
			String month = strArr[1];
			String day   = strArr[2];
			String fName = strArr[3];
			
			String filePath = year+File.separator+month+File.separator+day;
			String realFileName = CommConfig.get("upload_dir")+File.separator+"udata"+File.separator+filePath+File.separator+fName;
			System.out.println(realFileName);
			File file = new File(realFileName);
			if(!file.exists()){
				return;
			}
			File outImageFile = null;
			//获取图片的大小
			String width  = request.getParameter("width");
			String height = request.getParameter("height");
			//进行图片压缩处理
			if(width!=null&&!"".equals(width)&&height!=null&&!"".equals(height)){
				String smallFileName = realFileName+"_"+width+"X"+height+FileUtil.getFilePrex(realFileName);
				File smallFile = new File(smallFileName);
				if(smallFile.exists()){
					outImageFile = smallFile;
				}else{
					Thumbnails.of(file).size(Integer.parseInt(width), Integer.parseInt(height)).toFile(smallFileName);
					outImageFile = new File(smallFileName);
				}
			}else{
				outImageFile = file;
			}
			stream = response.getOutputStream();
			response.reset();
			response.setContentType("image/jpeg");
			response.setHeader("Content-Length", String.valueOf(outImageFile.length()));
			fif = new BufferedInputStream(new FileInputStream(outImageFile));
			int d;
			byte[] buf = new byte[10240];
			while ((d = fif.read(buf)) != -1) {
				stream.write(buf, 0, d);
			}
			stream.flush();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (stream != null) {
					stream.close();
				}
				if (fif != null) {
					fif.close();
				}
				
			} catch (Exception e11) {
			}
		}
	}	
	@MethodResourceDesc(name = "查看文件")
	@RequestMapping(value = "/file/fileView.do")
	@ResponseBody	
	public void fileView(HttpServletRequest request,HttpServletResponse response,String fileName){
		
		ServletOutputStream stream 	=  null;
		BufferedInputStream fif =  null;
		try {
			String[] strArr = fileName.split("/");
			if(strArr.length!=4){
				return;
			}
			String year  = strArr[0];
			String month = strArr[1];
			String day   = strArr[2];
			String fName = strArr[3];
			
			String filePath = year+File.separator+month+File.separator+day;
			String realFileName = CommConfig.get("upload_dir")+File.separator+"udata"+File.separator+filePath+File.separator+fName;
			System.out.println(realFileName);
			File file = new File(realFileName);
			if(!file.exists()){
				return;
			}
			stream = response.getOutputStream();
			response.reset();
			String lastName = realFileName.substring(realFileName.indexOf(".")+1, realFileName.length());
			if(lastName.equals("jpeg") || lastName.equals("jpg")){
				response.setContentType("image/jpeg");
			}else if(lastName.equals("pdf")){
				response.setContentType("application/pdf");
			}else if(lastName.equals("gif")){
				response.setContentType("image/gif");
			}else if(lastName.equals("tiff")){
				response.setContentType("image/tif");
			}else if(lastName.equals("txt")){
				response.setContentType("text/plain");
			}else if(lastName.equals("xml")){
				response.setContentType("text/xml");
			}else if(lastName.equals("xls")){
				response.setContentType("application/vnd.ms-excel");
			}
			response.setHeader("Content-Length", String.valueOf(file.length()));
			fif = new BufferedInputStream(new FileInputStream(file));
			int d;
			byte[] buf = new byte[10240];
			while ((d = fif.read(buf)) != -1) {
				stream.write(buf, 0, d);
			}
			stream.flush();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (stream != null) {
					stream.close();
				}
				if (fif != null) {
					fif.close();
				}
				
			} catch (Exception e11) {
			}
		}
	}

}
