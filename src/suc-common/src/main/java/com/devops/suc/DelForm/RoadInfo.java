package com.devops.suc.DelForm;

import java.util.List;

import com.devops.suc.vo.TpDealLogsVO;

public class RoadInfo {

	private String roadName;//路口名
	List<TpDealLogsVO> delLogList;//违法行为
	private int totalNum;
	
	public String getRoadName() {
		return roadName;
	}
	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	public List<TpDealLogsVO> getDelLogList() {
		return delLogList;
	}
	public void setDelLogList(List<TpDealLogsVO> delLogList) {
		this.delLogList = delLogList;
	}
	public int getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}
}
