package com.devops.suc.vo;
import java.io.Serializable;


public class TpUploadTempVO  implements Serializable{

	
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
	
	/** 图片状态 0未处理 1已处理 */
	private int file_status;
	
	/** 路口id */
	private int road_id;
	/** 所属路口name */
	private int check_road_id;

	/** 索引file_index */
	private int file_index;
	
	/** 违法时间 **/
	private String illegal_time;
	
	/** 汽车类型 **/
	private String car_type_name;
	
	/** 车牌号码 **/
	private String car_num;
	
	public String getIllegal_time() {
		return illegal_time;
	}

	public void setIllegal_time(String illegal_time) {
		this.illegal_time = illegal_time;
	}

	public String getCar_type_name() {
		return car_type_name;
	}

	public void setCar_type_name(String car_type_name) {
		this.car_type_name = car_type_name;
	}

	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}

	public int getFile_index(){
		return file_index;
	}
	
	public void setFile_index(int file_index){
		this.file_index = file_index;	
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

	public int getCheck_road_id() {
		return check_road_id;
	}

	public void setCheck_road_id(int check_road_id) {
		this.check_road_id = check_road_id;
	}
	
}
