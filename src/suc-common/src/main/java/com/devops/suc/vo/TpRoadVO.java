package com.devops.suc.vo;
import java.io.Serializable;


public class TpRoadVO  implements Serializable{

	
	/** 自增长ID */
	private int cr_id;
	
	/** 路口名称 */
	private String road_name;
	
	/** 路口代码 */
	private String road_code;
	
	/** 超速标志 */
	private int road_speed;
	
	/** 未下载数量 **/
	private int noDownLoadNum;
	
	public int getNoDownLoadNum() {
		return noDownLoadNum;
	}

	public void setNoDownLoadNum(int noDownLoadNum) {
		this.noDownLoadNum = noDownLoadNum;
	}

	public int getCr_id() {
		return cr_id;
	}
	
	public void setCr_id(int cr_id) {
		this.cr_id = cr_id;
	}
	
	public String getRoad_name() {
		return road_name;
	}
	
	public void setRoad_name(String road_name) {
		this.road_name = road_name;
	}

	public String getRoad_code() {
		return road_code;
	}

	public void setRoad_code(String road_code) {
		this.road_code = road_code;
	}

	public int getRoad_speed() {
		return road_speed;
	}

	public void setRoad_speed(int road_speed) {
		this.road_speed = road_speed;
	}

	
}
