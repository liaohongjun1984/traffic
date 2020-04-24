package com.devops.suc.vo;

import com.devops.suc.model.Menu;

public class MenuVO extends Menu{

	private boolean checked;

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
}
