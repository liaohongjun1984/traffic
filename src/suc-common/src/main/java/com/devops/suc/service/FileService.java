package com.devops.suc.service;

import java.io.InputStream;

import com.idhoo.dhutil.dto.Result;

public interface FileService {
	
	/**
	 * 文件上传处理
	 * @param oriFileName
	 * @param in
	 * @param size
	 * @param uploadFilePath
	 * @return
	 */
	public Result uploadFile(String oriFileName, InputStream in, long size,String uploadFilePath,int road_id) ;

	public Result uploadFileExtend(String oriFileName, InputStream in,long size, String uploadFilePath);
	

}
