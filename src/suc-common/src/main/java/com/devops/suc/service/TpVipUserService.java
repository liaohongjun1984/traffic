package com.devops.suc.service;

import com.devops.suc.vo.TpVipUserSearchVO;
import com.devops.suc.vo.TpVipUserVO;
import com.idhoo.dhutil.dto.Result;

public interface TpVipUserService {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public Result list(TpVipUserSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public Result get(int id);
	
	/**
	 * 插入记录
	 * @param vo
	 */
	public Result save(TpVipUserVO vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public Result delete(int id);

	/**
	 * 姓名下拉提示
	 * @param userName
	 * @return
	 */
	public Result likeUserName(String userName);

	/**
	 * 车牌号下拉提示
	 * @param carNo
	 * @return
	 */
	public Result likeCarNo(String carNo);

	/**
	 * 导出重要人物管理
	 * @param svo
	 * @return
	 */
	public Result exportVip(TpVipUserSearchVO svo);
}
