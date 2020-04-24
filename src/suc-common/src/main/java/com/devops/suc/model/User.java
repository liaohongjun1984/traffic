package com.devops.suc.model;

/**
 * <pre>
 * Title:
 * Description: 
 * </pre>
 * @author wangxc  wangxc@yuchengtech.com
 * @version 1.00.00
 * <pre>
 * 
 * </pre>
 */
 
public class User implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3440127728615153619L;

	/**邮箱地址*/

	private String email;

	/**yy号*/

	private String yy_no;

	/**部门*/

	private int department;

	/**是否是基本用户，0-不是，1-是,不可以删除*/

	private short meta_default_data;

	/**修改时间*/

	private java.util.Date last_modify;

	/**工作号*/

	private String work_no;

	/**移动电话*/

	private String mobile_no;

	/**管理员状态，0-正常,1-冻结*/

	private short status;

	/**操作员ID*/

	private String operator;

	/**密码*/

	private String password;

	/**真实姓名*/

	private String nick_name;

	/**管理员登录名，多玩通行证*/

	private String user_name;

	/**流水号*/

	private int user_id;

	private short admin;
	
	public short getAdmin() {
		return admin;
	}

	public void setAdmin(short admin) {
		this.admin = admin;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getYy_no() {
		return yy_no;
	}

	public void setYy_no(String yy_no) {
		this.yy_no = yy_no;
	}

	public int getDepartment() {
		return department;
	}

	public void setDepartment(int department) {
		this.department = department;
	}

	public short getMeta_default_data() {
		return meta_default_data;
	}

	public void setMeta_default_data(short meta_default_data) {
		this.meta_default_data = meta_default_data;
	}

	public java.util.Date getLast_modify() {
		return last_modify;
	}

	public void setLast_modify(java.util.Date last_modify) {
		this.last_modify = last_modify;
	}

	public String getWork_no() {
		return work_no;
	}

	public void setWork_no(String work_no) {
		this.work_no = work_no;
	}

	public String getMobile_no() {
		return mobile_no;
	}

	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}

	public short getStatus() {
		return status;
	}

	public void setStatus(short status) {
		this.status = status;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
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

	
	
}