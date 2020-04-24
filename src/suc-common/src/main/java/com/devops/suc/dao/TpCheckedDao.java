/**
 * @author: code@xiepeiyang.com
 * @date: 2016年3月26日-下午5:56:40
 */
package com.devops.suc.dao;

import java.util.List;

//import com.devops.suc.model.TpChecked;
import com.devops.suc.vo.TpCheckedVO;
import com.devops.suc.vo.TpCheckedSearchVO;
import com.devops.suc.model.TpChecked;

public interface TpCheckedDao extends SqlMapper {
	/**
	 * 根据搜索条件返回列表
	 */
	public List<TpCheckedVO> list(TpCheckedSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 */
	public int count(TpCheckedSearchVO vo);
	
	public void insert(TpChecked vo);
}
