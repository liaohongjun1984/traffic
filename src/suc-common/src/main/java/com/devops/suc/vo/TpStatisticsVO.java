package com.devops.suc.vo;
import java.io.Serializable;


public class TpStatisticsVO  implements Serializable{

	
	/** 自增长ID */
	private int cr_id;
	
	/** 上传数 */
	private int up_num;
	
	/** 已核对 */
	private int checked;
	
	/** 无效 */
	private int invalid;
	
	/** 创建时间 */
	private String date;
	
	/** 操作人ID */
	private int user_id;
	
	/** 操作人name */
	private String user_name;
	
	public int getCr_id() {
		return cr_id;
	}
	
	public void setCr_id(int cr_id) {
		this.cr_id = cr_id;
	}
	
	public int getChecked() {
		return checked;
	}
	
	public void setChecked(int checked) {
		this.checked = checked;
	}
	
	public int getInvalid() {
		return invalid;
	}
	
	public void setInvalid(int invalid) {
		this.invalid = invalid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUp_num() {
		return up_num;
	}

	public void setUp_num(int up_num) {
		this.up_num = up_num;
	}
	
}
