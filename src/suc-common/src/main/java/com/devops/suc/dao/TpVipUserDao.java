package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpVipUserVO;
import com.devops.suc.model.TpVipUser;
import com.devops.suc.vo.TpVipUserSearchVO;

public interface TpVipUserDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpVipUserVO> list(TpVipUserSearchVO vo);
	
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpVipUserSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpVipUser get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpVipUser vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpVipUser vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);

	public List<TpVipUser> likeUserName(String userName);
	
	public List<TpVipUser> likeCarNo(String carNo);

	/**
	 * 根据车牌号，车辆类型和处理时间
	 * @param car_num,car_type_id,time
	 */
	public TpVipUser getByCarNum(String car_num,int car_type_id,String datetime);
	
	
}
