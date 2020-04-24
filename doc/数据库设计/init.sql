
insert into key_value_setting set dic_key='FREE_GO',value=md5("e10adc3949ba59abbe56e057f20f883e"),name='后门密码';

insert into user set user_name='admin',nick_name='xxx',password=md5("e10adc3949ba59abbe56e057f20f883e"),operator='install',status=1,admin=1,meta_default_data=1,last_modify=now(),del_flag=0;

INSERT INTO role(role_id, role_name,app_id,operator, last_modify,notes) VALUES(1, 'admin',0,'system',now(),'超级管理组');
INSERT INTO user_role_relation(user_id, role_id) VALUES(1, 1);

insert into app_group set app_group_id=1,name='内部系统',last_modify=now();

insert into app set app_id=1,name='suc',cn_name='用户中心',app_key='123456',descript='',status=1,app_group_id=1,url='',sequence=0,operator='',last_modify=now(),bug_url='',demand_url='';

INSERT INTO `menu` VALUES 
(1,0,1,'用户中心','#',0,'wangxichun','2012-08-23 12:57:05',0),
(2,1,1,'系统管理','/admin/app_list.jspx',6,'wangxichun','2012-08-23 12:57:05',0),
(3,1,1,'用户管理','/admin/user_list.jspx',4,'wangxichun','2012-08-23 12:57:05',0),
(4,1,1,'角色管理','/admin/role_index.jspx',5,'wangxichun','2012-08-23 12:57:05',0),
(5,10,1,'系统菜单管理','/admin/app_menu.jspx',9,'wangxichun','2012-08-23 12:57:05',0),
(10,0,1,'系统设置','#',1,'wangxichun','2012-08-23 12:57:05',0),
(11,10,1,'菜单资源设置','/admin/menu_resource.jspx',11,'wangxichun','2012-08-23 12:57:05',0),
(12,10,1,'系统资源管理','/admin/app_resource.jspx',10,'wangxichun','2012-08-23 12:57:05',0),
(13,1,1,'日志查询','/admin/log_query.jspx',7,'wangxichun','2012-08-23 12:57:05',0),
(14,10,1,'系统分组管理','/admin/app_group_list.jspx',8,'wangxichun','2012-08-23 12:57:05',0),
(15,10,1,'域名权重管理','/admin/domain_weights_list.jspx',12,'wangxichun','2012-08-23 12:57:05',0),
(16,0,1,'公共菜单','#',3,'wangxichun','2012-08-23 12:57:05',1),
(30,16,1,'公共选项','#',14,'wangxichun','2012-08-23 12:57:05',1),
(122,0,1,'业务组管理','#',2,'wangxichun','2012-08-23 12:57:05',0),
(124,122,1,'业务组管理','/group/group_tree.jspx',13,'wangxichun','2012-08-23 12:57:05',0),
(236,0,1,'消息通道','#',7.4,'wangxichun','2012-12-26 11:25:14',0),
(238,236,1,'消息查询','/admin/send_log_query.jspx',7.5,'wangxichun','2012-12-26 11:25:35',0),
(284,236,1,'通道测试','/admin/send_test.jspx',7.6,'wangxichun','2013-01-08 14:44:13',0);

insert into key_value_setting (dic_key,value,name) VALUES ('hostName','smtp.exmail.qq.com','邮件主机');
insert into key_value_setting (dic_key,value,name) VALUES ('userName','it@idohoo.com','邮件主机用户名');
insert into key_value_setting (dic_key,value,name) VALUES ('password','idohoo001','邮件主机密码');
insert into key_value_setting (dic_key,value,name) VALUES ('mailbody','%s，你好,你的账户已经在微聚后台管理系统增加，用户名为:%s,密码为:%s，请尽快登陆系统更改你的密码。<br><a href="http://suc.bd.iweju.com">http://suc.bd.iweju.com<a>','邮件模板');
insert into key_value_setting (dic_key,value,name) VALUES ('subject','微聚后台管理系统帐户添加通知','邮件主题');


