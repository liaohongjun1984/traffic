package com.devops.suc.vo;
import java.io.Serializable;


public class TpFillFileVO  implements Serializable{

	
	/** id */
	private int id;
	
	/** 所属用户名称 */
	private String user_name;
	
	/** 所属用户ID */
	private int user_id;
	
	/** 文件名 */
	private String file_name;
	
	/** 图片存储地址 */
	private String file_addr;
	
	/** 创建时间 */
	private String create_time;
	
	/** 超速标准值 */
	private String sp_standard;
	
	/** 超速实测值 */
	private String sp_measured;
	
	/** 超速公里米数 */
	private String sp_place_metre;
	
	/** 超速公里数 */
	private String sp_kilometers;
	public String getSp_standard() {
		return sp_standard;
	}

	public void setSp_standard(String sp_standard) {
		this.sp_standard = sp_standard;
	}

	public String getSp_measured() {
		return sp_measured;
	}

	public void setSp_measured(String sp_measured) {
		this.sp_measured = sp_measured;
	}

	public String getSp_place_metre() {
		return sp_place_metre;
	}

	public void setSp_place_metre(String sp_place_metre) {
		this.sp_place_metre = sp_place_metre;
	}

	public String getSp_kilometers() {
		return sp_kilometers;
	}

	public void setSp_kilometers(String sp_kilometers) {
		this.sp_kilometers = sp_kilometers;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
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
	
	public String getFile_name() {
		return file_name;
	}
	
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
	public String getFile_addr() {
		return file_addr;
	}
	
	public void setFile_addr(String file_addr) {
		this.file_addr = file_addr;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	
}
