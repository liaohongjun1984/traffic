package com.devops.suc.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.DomainWeightsDao;
import com.devops.suc.model.DomainWeights;
import com.devops.suc.service.DomainWeightsService;
import com.devops.suc.vo.DomainWeightsSearchVO;
import com.devops.suc.vo.DomainWeightsVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;

/**
 * 
 * @author liyongquan
 * 
 */
@Service
public class DomainWeightsServiceImpl implements DomainWeightsService {

	@Autowired
	private DomainWeightsDao domainWeightsDao;

	/**
	 * 按条件搜索域名权重
	 * 
	 * @param domainWeightsSearchVO
	 *            --查询条件
	 * @return
	 */
	@Override
	public Result list(DomainWeightsSearchVO domainWeightsSearchVO) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map<String, Object> paginInfo = new HashMap<String, Object>();
		List<DomainWeightsVO> domainWeightss = domainWeightsDao
				.list(domainWeightsSearchVO);
		paginInfo.put("lists", domainWeightss);

		if (domainWeightss.size() > 0) {
			int totalNum = domainWeightsDao.listCount(domainWeightsSearchVO);
			int totalPage = totalNum % domainWeightsSearchVO.getSize() == 0 ? totalNum
					/ domainWeightsSearchVO.getSize()
					: totalNum / domainWeightsSearchVO.getSize() + 1;

			paginInfo.put("count", totalNum);
			paginInfo.put("page", domainWeightsSearchVO.getPage());
			paginInfo.put("pageCount", totalPage);
		} else {
			paginInfo.put("count", 0);
			paginInfo.put("page", domainWeightsSearchVO.getPage());
			paginInfo.put("pageCount", 0);
		}
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public Result listAll(DomainWeights domainWeights) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		List<DomainWeights> list = domainWeightsDao.listAll(domainWeights);
		result.setObject(list);
		return result;
	}

	/**
	 * 根据系统id查找记录
	 * 
	 * @param app_id
	 *            --系统id
	 * @return
	 */
	@Override
	public Result listByAppId(int app_id) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		List<DomainWeights> domainWeightss = domainWeightsDao.listByAppId(app_id);
		result.setObject(domainWeightss);
		return result;
	}

	@Override
	public Result get(int id) {
		Result result = new Result();
		DomainWeights vo = domainWeightsDao.get(id);
		result.setObject(vo);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result insert(DomainWeights domainWeights) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<DomainWeights> weights = domainWeightsDao.listAll(domainWeights);
		if (weights != null && weights.size() > 0) {
			result.setMessage(String.format("系统：%d和域名：%s的对应关系已经存在",
					domainWeights.getApp_id(), domainWeights.getHost()));
		} else {
			domainWeightsDao.insert(domainWeights);
			result.setCode(ResultCode.SUCCESS);
		}
		return result;
	}

	@Override
	public Result update(DomainWeights domainWeights) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<DomainWeights> weights = domainWeightsDao.listAll(domainWeights);
		if (weights != null && weights.size() > 0
				&& weights.get(0).getId() != domainWeights.getId()) {
			result.setMessage(String.format("系统：%d和域名：%s的对应关系已经存在",
					domainWeights.getApp_id(), domainWeights.getHost()));
		} else {
			domainWeightsDao.update(domainWeights);
			result.setCode(ResultCode.SUCCESS);
		}
		return result;
	}

	@Override
	public Result delete(int id) {
		Result result = new Result();
		domainWeightsDao.delete(id);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result list(String host) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(this.domainWeightsDao.listByHost(host));
		return result;
	}

	@Override
	public List<DomainWeights> getDomainByAppId(int app_id) {
		List<DomainWeights> domainWeightss = domainWeightsDao.listByAppId(app_id);
		return domainWeightss;
	}

}
