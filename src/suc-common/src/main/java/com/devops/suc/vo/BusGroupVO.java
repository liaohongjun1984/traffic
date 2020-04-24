package com.devops.suc.vo;

import com.devops.suc.model.BusGroup;

public class BusGroupVO extends BusGroup {
	
	private short charge_admin = 0;

	public short getCharge_admin() {
		return charge_admin;
	}

	public void setCharge_admin(short charge_admin) {
		this.charge_admin = charge_admin;
	}
	

}
