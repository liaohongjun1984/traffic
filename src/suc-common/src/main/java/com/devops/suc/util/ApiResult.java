package com.devops.suc.util;

import java.io.Serializable;

import com.idhoo.dhutil.dto.ResultCode;

/**
 * 返回值对象
 * @author wangxichun
 *
 */
public class ApiResult implements Serializable {

	private static final long serialVersionUID = -1586118647101027089L;

	public static ApiResult getSuccResult(){
		return new ApiResult(1, "", "", true);
	}
	
	public static ApiResult getSuccResult(int code){
		return getSuccResult(code,"");
	}
	
	public static ApiResult getSuccResult(String message){
		return getSuccResult(1,message);
	}
	
	public static ApiResult getSuccResult(int code,String message){
		return getSuccResult(code, message, "");
	}
	
	public static ApiResult getSuccResult(int code,String message,Object object){
		return new ApiResult(code, message, object, true);
	}
	
	public static ApiResult getFalseResult(int code,String message){
		return new ApiResult(code, message, "", false);
	}
	
	/**
	 * 返回代码
	 */
	private int code = ResultCode.FAILURE;
	
	/**
	 * 信息
	 */
	private String msg;
	
	/**
	 * 对象
	 */
	private Object object;
	
	/**
	 * 是否成功
	 */
	private boolean success = false;
	
	public ApiResult() {
	}

	public ApiResult(int code,String message,Object object,boolean success){
		this.code = code;
		this.msg = message;
		this.object = object;
		this.success = success;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
		this.success = (code == ResultCode.SUCCESS);
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

}
