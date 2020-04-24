package com.devops.suc.constant;

public class OpTypeConstant {
	/**
	 * 订购
	 */
	public static int PURCHASE=0;
	/**
	 * 暂停
	 */
	public static int SUSPEND=1;
	/**
	 * 暂停恢复
	 */
	public static int RESUME=2;
	/**
	 * 退订
	 */
	public static int EXIT=3;
	/**
	 * 退定该SP的所有产品和套餐
	 */
	public static int EXIT_ALL_PRODUCT=4;
	/**
	 * 暂停该SP的所有产品和套餐
	 */
	public static int RESUME_ALL_PRODUCT=5;
}
