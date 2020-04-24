package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpUploadTempSearchVO extends BaseSearchVO{

	/** 所属用户ID */
	private int user_id;
	/** 所属用户名称 */
	private String user_name;
	
	/** 所属用户ID */
	private int road_id;
	
	private int file_status;
	
	private int file_index;
	
	public void setFile_index(int file_index){
		this.file_index = file_index;
	}
	
	public int getFile_index(){
		return file_index;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getFile_status() {
		return file_status;
	}

	public void setFile_status(int file_status) {
		this.file_status = file_status;
	}

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
	}
	
}
