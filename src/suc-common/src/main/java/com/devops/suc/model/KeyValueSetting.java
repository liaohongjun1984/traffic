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
 
public class KeyValueSetting{

	// Fields

	/**显示名称*/

	private String name;

	/**值*/

	private String value;

	/**字典名称*/

	private String dicKey;

	/**流水号*/

	private Integer id;

	// Property accessors

	public String getName(){

		return this.name;
	}

	public void setName(String name){

		 this.name = name;
	}

	public String getValue(){

		return this.value;
	}

	public void setValue(String value){

		 this.value = value;
	}

	public String getDicKey(){

		return this.dicKey;
	}

	public void setDicKey(String dicKey){

		 this.dicKey = dicKey;
	}

	public Integer getId(){

		return this.id;
	}

	public void setId(Integer id){

		 this.id = id;
	}

}