package com.devops.suc.dao;

import java.util.List;

import com.devops.suc.vo.TpUploadTempVO;
import com.devops.suc.model.TpUploadTemp;
import com.devops.suc.vo.TpUploadTempSearchVO;

public interface TpUploadTempDao extends SqlMapper {
	
	/**
	 * 根据搜索条件返回列表
	 * @param svo
	 * @return
	 */
	public List<TpUploadTempVO> list(TpUploadTempSearchVO vo);

	/**
	 * 根据路口名称返回列表
	 * @param vo
	 * @return
	 */
	public List<TpUploadTempVO> listByRoad(TpUploadTempSearchVO vo);
	
	/**
	 * 根据已经核对返回列表
	 * @param svo
	 * @return
	 */
	
	public List<TpUploadTempVO> Downlist(TpUploadTempSearchVO vo);
		
	/**
	 * 根据搜索条件返回列表总数
	 * @param svo
	 * @return
	 */
	public int count(TpUploadTempSearchVO vo);
	
	public int countDownList(TpUploadTempSearchVO vo);
	
	/**
	 * 根据主键id获取单条记录
	 * @param id
	 * @return
	 */
	public TpUploadTemp get(int id);
	
	public TpUploadTemp getByFileId(int file_id);
	
	public TpUploadTemp getByRoadId(int road_id);
	/**
	 * 插入记录
	 * @param vo
	 */
	public void insert(TpUploadTemp vo);
	
	/**
	 * 更新记录
	 * @param vo
	 */
	public void update(TpUploadTemp vo);
	
	/**
	 * 根据主键id删除记录
	 * @param id
	 */
	public void delete(int id);
	
	public void deleteFile_index(int id);

	public void batchUpdateFileStatus(List<Integer> fileIds);
	
	public void updateFileStatus(int status,int check_road_id,int id);
	
	public void recoverFileStatus(List<Integer> fileIds);
	
	public void updateIndex(int id,int file_id);
	
	public void updateDeal_time(String deal_time,int file_id);
	
	public void recoverDeal_time(List<Integer> fileIds);
	
	public List<TpUploadTempVO> DownPicByIndex(TpUploadTempSearchVO vo);

	public void updateStatus(int file_id);
	
	public void updateIllegal_time(String illegal_time,int file_id);
	
	public void updateCar_num(String car_num,int file_id);
	
	public void updateCar_type_name(String car_name,int file_id);
	
	public int checkFileRep(String oriFileName);
	
	public void updateSystem();
	
	public List<TpUploadTempVO> ergodic();

	public List<TpUploadTempVO> listAll();

	public void updateCheckRoadId(TpUploadTempVO tpUploadTempVO);

}
