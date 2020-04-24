package com.devops.suc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.constant.SucConstant;
import com.devops.suc.dao.BusGroupDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.model.BusGroup;
import com.devops.suc.model.User;
import com.devops.suc.model.UserGroupRelation;
import com.devops.suc.service.BusGroupService;
import com.devops.suc.util.SucUtil;
import com.devops.suc.vo.BusGroupVO;
import com.devops.suc.vo.UserGroupRelationVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Row;
@Service
public class BusGroupServiceImpl implements BusGroupService {
	@Autowired
	private BusGroupDao busGroupDao;
	@Autowired
	private UserDao userDao;
	
	private String collection[] = {"0","1","2","3","4","5","6","7","8","9",
									"a","b","c","d","e","f","g","h","i","j",
									"k","l","m","n","o","p","q","r","s","t",
									"u","v","w","x","y","z"};
	
	
	@Override
	public Result list(int user_id,String user_name) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		List<UserGroupRelationVO> groups = busGroupDao.getGroupIds(user_id);
		if(groups == null || groups.size() == 0){
			result.setMessage("你目前还不属于任何小组!");
			return result;
		}
		result.setObject(this.getMinGroupId(groups));
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	/**
	 * 获取用户的顶级组织架构
	 * @param groups
	 * @return
	 */
	private List<UserGroupRelationVO> getMinGroupId(List<UserGroupRelationVO> groups){
		List<String> t = new ArrayList<String>();
		List<String> t1 = new ArrayList<String>();
		for(UserGroupRelationVO vo : groups){
			t.add(vo.getGroup_id());
		}
		for(String s:t){
			boolean ismin = true;
			for(String s1:t){
				if(s.startsWith(s1) && s.length() != s1.length()){
					ismin = false;
					break;
				}
			}
			if(ismin){
				t1.add(s);
			}
		}
		List<UserGroupRelationVO> tmp = new ArrayList<UserGroupRelationVO>();
		for(UserGroupRelationVO vo : groups){
			if(t1.contains(vo.getGroup_id())){
				tmp.add(vo);
			}
		}
		return tmp;
	}
	

	@Override
	public Result listChild(String group_id,int user_id,String user_name) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if(group_id == null || group_id.trim().length() == 0){
			return result;
		}
		List<UserGroupRelationVO> charge_groups = busGroupDao.getGroupIds(user_id);
		if(charge_groups == null || charge_groups.size() == 0){
			result.setMessage("你目前还不属于任何小组!");
			return result;
		}
		List<String> tmp = new ArrayList<String>();
		for(UserGroupRelationVO vo : charge_groups){
			if(vo.getCharge_admin() == 1)
				tmp.add(vo.getGroup_id());
		}
		if(SucUtil.isAdmin(user_name)){
			group_id = SucConstant.group_root;
		}
		Row row = new Row();
		row.put("user_id", user_id);
		row.put("group_id", group_id);
		
		List<BusGroupVO> groups = busGroupDao.listChilds(row);
		for(BusGroupVO vo : groups){
			//有管理权限
			if(this.isAdmin(user_name, tmp, vo.getGroup_id())){
				vo.setCharge_admin((short) 1);
			}else{
				vo.setCharge_admin((short) 0);
			}
		}
		result.setCode(ResultCode.SUCCESS);
		result.setObject(groups);
		return result;
	}
	/**
	 * 是否具有管理员权限
	 * @param user_name
	 * @param admins
	 * @param group_id
	 * @return
	 */
	private boolean isAdmin(String user_name,List<String> admins,String group_id){
		if(SucUtil.isAdmin(user_name)){
			return true;
		}
		for(String s : admins){
			if(group_id.startsWith(s)){
				return true;
			}
		}
		return false;
	}
	@Override
	public Result add(BusGroup vo) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		String first = "";
		String second = "";
		String group_id = "";
		BusGroup tmp = new BusGroup();
		while(tmp != null){
			first = this.collection[(int) (Math.random() * collection.length)];
			second = this.collection[(int) (Math.random() * collection.length)];
			group_id = vo.getParent_id() + first + second;
			tmp = this.busGroupDao.getBusGroupByID(group_id);
		}
		vo.setGroup_id(group_id);
		this.busGroupDao.add(vo);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("增加成功");
		return result;
	}
	@Override
	public Result update(String name,String notes,String operator,String group_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		this.busGroupDao.update(name, notes,operator,group_id);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("修改成功");
		return result;
	}
	@Override
	public Result delete(String group_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		Row row = new Row();
		row.put("group_id", group_id);
		List<BusGroupVO> bus = this.busGroupDao.listChilds(row);
		if(bus.size() > 1){
			result.setMessage("删除失败，请删除下面所有业务组，在进行删除");
			return result;
		}
		this.busGroupDao.delete(group_id);
		result.setMessage("删除成功");
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	@Override
	public Result listUser(String group_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		result.setObject(this.busGroupDao.listGroupUser(group_id));
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	@Override
	public Result addUser(String group_id, String user_ids) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		Row row = new Row();
		if(group_id.equals(SucConstant.group_root)){
			result.setMessage("根节点下不允许添加人员");
		}
		if(user_ids == null||user_ids.length() == 0){
			result.setMessage("请选择要添加人员");
		}
		row.put("group_id", group_id);
		row.put("user_list", user_ids.split(","));
		this.busGroupDao.addGroupUser(row);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result deleteUser(String group_id, String user_id) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		this.busGroupDao.deleteGroupUser(group_id, user_id);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result listNotInUser(String group_id, String user_name,
			String nick_name) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		Row row = new Row();
		row.put("group_id", group_id);
		row.put("user_name", user_name);
		row.put("nick_name", nick_name);
		result.setObject(this.userDao.getUserNotinGroupId(row));
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result setAdmin(String group_id, String user_id,boolean isAdmin) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		if(isAdmin){
			this.busGroupDao.setAdmin(group_id, user_id,"1");
		}
		else{
			this.busGroupDao.setAdmin(group_id, user_id,"0");
		}
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	
	/**
	 * 
	 * @return
	 * @author deneng.xu
	 */
	@Override
	public Result getFirGradeDep(){
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<BusGroup> list = busGroupDao.getFirGradeDep();
		
		result.setObject(list);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result getByUser(String user_name) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		User u = userDao.get(user_name);
		List<UserGroupRelation> list = busGroupDao.getByUserId(u.getUser_id());
		
		UserGroupRelation ugr = new UserGroupRelation();
		for(UserGroupRelation ug : list){
			if(ugr.getGroup_id()!=null&&ugr.getGroup_id()!=""){
				ugr.setGroup_id(ugr.getGroup_id()+","+ug.getGroup_id());
			}else {
				ugr.setGroup_id(ug.getGroup_id());
			}
		}
		result.setObject(ugr);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result listUserByGroup(String group_id) {
		
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<User> users = busGroupDao.listUserByGroup(group_id);

		result.setObject(users);
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");
		return result;
	}
	@Override
	public Result listAllSecond() {

		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		List<BusGroup> busGroups = busGroupDao.getFirGradeDep();
		
		result.setObject(busGroups);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
}
