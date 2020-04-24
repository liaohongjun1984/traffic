package com.devops.suc.vo;

import com.idhoo.dhutil.vo.BaseSearchVO;

public class TpFtpConfigSearchVO extends BaseSearchVO{

	/** 服务器地址 */
	private String ftp_host;
	
	public String getFtp_host() {
		return ftp_host;
	}
	
	public void setFtp_host(String ftp_host) {
		this.ftp_host = ftp_host;
	}
	
}
