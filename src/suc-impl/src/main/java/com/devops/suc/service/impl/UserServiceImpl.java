package com.devops.suc.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devops.suc.dao.BusGroupDao;
import com.devops.suc.dao.KeyValueSettingDao;
import com.devops.suc.dao.RoleDao;
import com.devops.suc.dao.UserDao;
import com.devops.suc.dao.UserRoleRelationDao;
import com.devops.suc.model.BusGroup;
import com.devops.suc.model.Role;
import com.devops.suc.model.User;
import com.devops.suc.model.UserRoleRelation;
import com.devops.suc.service.UserService;
import com.devops.suc.util.MailUtil;
import com.devops.suc.util.SucUtil;
import com.devops.suc.vo.UpdatePwd;
import com.devops.suc.vo.UserGroupRelationVO;
import com.devops.suc.vo.UserRoleVO;
import com.devops.suc.vo.UserSearchVO;
import com.devops.suc.vo.UserVO;
import com.idhoo.dhutil.dto.Result;
import com.idhoo.dhutil.dto.ResultCode;
import com.idhoo.dhutil.util.Authencation;
import com.idhoo.dhutil.util.MD5;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private BusGroupDao busGroupDao;
	@Autowired
	private UserRoleRelationDao userRoleRelationDao;
	@Autowired
	private KeyValueSettingDao keyValueSettingDao;	
	
	@Override
	public Result list(UserSearchVO userSearchVO) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setMessage("操作成功");

		Map <String,Object> paginInfo = new HashMap<String,Object>();
		List<UserVO> users = userDao.list(userSearchVO);
		
		Map<Integer,String> depmap = getFirGradeDepMap();
		
	   for(UserVO user : users){
			if(depmap.containsKey(user.getDepartment())){
				user.setGroup_name(depmap.get(user.getDepartment()));
			}else{
				user.setGroup_name("-");
			}
		}
		paginInfo.put("lists", users);
		
		
		if(users.size()>0){
			int totalNum = userDao.listCount(userSearchVO);
			int totalPage = totalNum%userSearchVO.getSize()==0?totalNum/userSearchVO.getSize():totalNum/userSearchVO.getSize()+1;
			
			paginInfo.put("count", totalNum);
			paginInfo.put("page",  userSearchVO.getPage());
			paginInfo.put("pageCount",totalPage);
		}else{
			paginInfo.put("count", 0);
			paginInfo.put("page",  userSearchVO.getPage());
			paginInfo.put("pageCount",0);
		}	
		result.setObject(paginInfo);
		return result;
	}

	@Override
	public User get(String userName) {
		return userDao.get(userName);
	}

	@Override
	public List<UserRoleVO> listRoleByAppId(int app_id,int user_id) {
		//通过系统ID获取角色列表
		List<Role> appRoles = roleDao.getByApp(app_id);
		
		//通过用户ID获取用户所有角色列表
		List<UserRoleRelation> urrList = userRoleRelationDao.getByUserId(user_id);
		List<Integer> contains = new ArrayList<Integer>();
		for(UserRoleRelation uur : urrList){
			contains.add(uur.getRole_id());
		}
		
		List<UserRoleVO> urList = new LinkedList<UserRoleVO>();
		for(Role role : appRoles){
			UserRoleVO ur = new UserRoleVO();
			ur.setChecked(contains.contains(role.getRole_id()));
			ur.setRole_id(role.getRole_id());
			ur.setRole_name(role.getRole_name());
			ur.setNotes(role.getNotes());
			urList.add(ur);
		}
		return urList;
	}

	@Override
	public Result userRole(int user_id, int role_id, boolean checked) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		UserRoleRelation vo = new UserRoleRelation();
		vo.setUser_id(user_id);
		vo.setRole_id(role_id);
		
		if(checked){
			userRoleRelationDao.save(vo);
		}else{
			userRoleRelationDao.remove(vo);
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result save(User user) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		User userOld = userDao.get(user.getUser_name());
		if(userOld!=null&&userOld.getUser_id()!=user.getUser_id()){
			result.setMessage("系统已经存在帐号："+user.getUser_name());
			return result;
		}
		
		String passwd = SucUtil.genRandomNum(8);
		user.setPassword(passwd);
		
		if(user.getUser_id()==0){
			user.setMeta_default_data((short)1);
			user.setAdmin((short)1);
			user.setPassword(MD5.getMD5(user.getPassword()));
			//状态设置为初始化状态
			user.setStatus((short)3);
			userDao.save(user);
			
			String hostName = keyValueSettingDao.get("hostName").getValue();
			String userName = keyValueSettingDao.get("userName").getValue();
			String password = keyValueSettingDao.get("password").getValue();
			String mailbody = keyValueSettingDao.get("mailbody").getValue();
			String subject = keyValueSettingDao.get("subject").getValue();
			
			try {
				MailUtil.sendMail(hostName,userName,password,String.format(mailbody,user.getNick_name(), user.getUser_name(),passwd), user.getEmail(), subject);
			} catch (Exception e) {
				e.printStackTrace();
				result.setMessage("新增用户发送邮件给用户失败，无法通知用户登录密码，登录密码为："+passwd);
				result.setCode(ResultCode.FAILURE);
				return result;
			}
			
			result.setMessage("新增用户成功，登录密码为："+passwd);
			result.setCode(ResultCode.SUCCESS);
		}else{
			user.setMeta_default_data((short)1);
			user.setAdmin((short)1);
			//状态设置为初始化状态
			user.setStatus((short)3);
			userDao.update(user);
			result.setCode(ResultCode.SUCCESS);			
		}
		
		return result;
	}

	@Override
	public Result update(User user) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);
		
		User userOld = userDao.get(user.getUser_name());
		if(userOld!=null&&userOld.getUser_id()!=user.getUser_id()){
			result.setMessage("系统已经存在帐号："+user.getUser_name());
		}else{
			userDao.update(user);
			result.setCode(ResultCode.SUCCESS);
		}
		
		return result;
	}

	@Override
	public Result list(String user_name) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(this.userDao.getUsers(user_name));
		return result;
	}

	@Override
	public Result listByNickName(String nick_name) {
		Result result = new Result();
		result.setCode(ResultCode.SUCCESS);
		result.setObject(this.userDao.getUsersByNickName(nick_name));
		return result;
	}
	
	private Map<Integer,String> groupData(){
		Map<Integer,String> data = new HashMap<Integer,String>();
		List<UserGroupRelationVO> vos = this.busGroupDao.list();
		for(UserGroupRelationVO vo:vos){
			if(data.containsKey(vo.getUser_id())){
				data.put(vo.getUser_id(), data.get(vo.getUser_id()) + "," + vo.getName());
			}else{
				data.put(vo.getUser_id(), vo.getName());
			}
		}
		return data;
	}
	
	//added by deneng.xu
	private Map<Integer,String> getFirGradeDepMap(){
		Map<Integer,String> data = new HashMap<Integer,String>();
		List<BusGroup> list = this.busGroupDao.getFirGradeDep();
		for(BusGroup bg:list){
			data.put(bg.getId(), bg.getName());
		}
		return data;
	}
	

	@Override
	public List<User> getAllUser() {
		return userDao.getAllUser();
	}

	@Override
	public Result check(String userName, String userPasswd,HttpServletResponse response, HttpServletRequest request) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		User user = this.get(userName);
		if(user == null){
			result.setMessage("用户不存在，请核对");
			return result;
		}
		if(!user.getPassword().equals(MD5.getMD5(userPasswd))){
			result.setMessage("密码不正确，请核对");
			return result;
		}
		Authencation auth = new Authencation(request, response);
		
		auth.saveUserName(user.getUser_id(), user.getUser_name(),user.getNick_name());
		result.setObject(user);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result updatePwd(UpdatePwd updatePwd) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		if(!updatePwd.getNew_pwd().equals(updatePwd.getNew_pwd1())){
			result.setMessage("新设置的密码，两次输入不对，请重新输入.");
			return result;
		}
		
		User user = userDao.get(updatePwd.getUsername());
		if(user == null){
			result.setMessage("用户不存在，请核对");
			return result;
		}		
		if(!user.getPassword().equals(MD5.getMD5(updatePwd.getOld_pwd()))){
			result.setMessage("原密码不正确，请核对");
			return result;
		}		
		updatePwd.setNew_pwd(MD5.getMD5(updatePwd.getNew_pwd()));
		userDao.updatePwd(updatePwd);
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}

	@Override
	public Result updateInfo(User user) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		User userOld = this.get(user.getUser_name());
		if(userOld == null){
			result.setMessage("用户不存在，请核对");
			return result;
		}		
		userDao.updateInfo(user);
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(MD5.getMD5(""));
	}
	
	/**
	 * added by deneng.xu
	 */
	@Override
	public Result updateUserPwd(UpdatePwd updatePwd) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		String passwd = SucUtil.genRandomNum(8);
		
		User user = userDao.get(updatePwd.getUsername());
		if(user == null){
			result.setMessage("用户不存在，请核对");
			return result;
		}		
		updatePwd.setNew_pwd(MD5.getMD5(passwd));
		userDao.updatePwd(updatePwd);
				
		String hostName = keyValueSettingDao.get("hostName").getValue();
		String userName = keyValueSettingDao.get("userName").getValue();
		String password = keyValueSettingDao.get("password").getValue();
		String mailbody = keyValueSettingDao.get("mailbody").getValue();
		String subject  = "用户密码重置通知邮件";
		
		try {
			MailUtil.sendMail(hostName,userName,password,String.format(mailbody,user.getNick_name(), user.getUser_name(),passwd), user.getEmail(), subject);
		} catch (Exception e) {
			e.printStackTrace();
			result.setMessage("用户密码重置发送邮件给用户失败，无法通知用户登录密码，登录密码为："+passwd);
			result.setCode(ResultCode.FAILURE);
			return result;
		}	
		result.setMessage("用户密码重置成功，登录密码为："+passwd);
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	
	/**
	 * added by deneng.xu
	 */
	@Override
	public Result deleteUserById(User user) {
		Result result = new Result();
		result.setCode(ResultCode.FAILURE);

		if(user!=null&&user.getUser_id()>0){
			userDao.delete(user.getUser_id());
		}else{
			result.setMessage("用户id为空！");
			return result;
		}
		
		result.setCode(ResultCode.SUCCESS);
		return result;
	}
	

}
