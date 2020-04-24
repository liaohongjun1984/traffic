package com.devops.suc.vo;
import java.io.Serializable;


public class TpEqualLogVO  implements Serializable{

	
	/** id */
	private int id;
	
	/** 重要人物ID */
	private int vp_id;
	
	/** 姓名 */
	private String user_name;
	
	/** 车牌号 */
	private String car_no;
	
	/** 时间 */
	private String create_time;
	
	/** 方式 */
	private int equal_type;
	
	private String action_name;
	
	/** 路口 */
	private int road_id;
	
	private String road_name;
	
	private String road_code;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getVp_id() {
		return vp_id;
	}
	
	public void setVp_id(int vp_id) {
		this.vp_id = vp_id;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getCar_no() {
		return car_no;
	}
	
	public void setCar_no(String car_no) {
		this.car_no = car_no;
	}
	
	public String getCreate_time() {
		return create_time;
	}
	
	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}
	
	public int getEqual_type() {
		return equal_type;
	}
	
	public void setEqual_type(int equal_type) {
		this.equal_type = equal_type;
	}

	public int getRoad_id() {
		return road_id;
	}

	public void setRoad_id(int road_id) {
		this.road_id = road_id;
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

	public String getAction_name() {
		return action_name;
	}

	public void setAction_name(String action_name) {
		this.action_name = action_name;
	}
	
}
