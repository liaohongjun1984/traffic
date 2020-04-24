/*
Navicat MySQL Data Transfer

Source Server         : mycon
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : traf

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-11-24 09:51:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `cn_name` varchar(30) DEFAULT NULL COMMENT '中文名称,显示名称',
  `app_key` varchar(50) DEFAULT NULL COMMENT '系统连接上来密码',
  `descript` text COMMENT '系统描述',
  `status` tinyint(4) DEFAULT '1' COMMENT '是否可用,1可用，2不可用',
  `app_group_id` int(11) DEFAULT NULL COMMENT '应用分类,1运维系统，2 运维内部系统',
  `url` varchar(500) DEFAULT NULL COMMENT '访问url',
  `sequence` double DEFAULT NULL COMMENT '排序',
  `operator` varchar(20) NOT NULL COMMENT '操作者',
  `last_modify` datetime DEFAULT NULL COMMENT '更新时间',
  `bug_url` varchar(500) DEFAULT NULL COMMENT '报bug url',
  `demand_url` varchar(500) DEFAULT NULL COMMENT '提需求url',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='应用系统信息';

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES ('1', 'traffic', '交通违章智能分析系统', '123456', '交通违章智能分析系统', '1', '1', '交通违章智能分析系统', '0', 'liaohj', '2015-05-07 22:20:02', '', '');

-- ----------------------------
-- Table structure for app_group
-- ----------------------------
DROP TABLE IF EXISTS `app_group`;
CREATE TABLE `app_group` (
  `app_group_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `last_modify` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`app_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='应用系统信息';

-- ----------------------------
-- Records of app_group
-- ----------------------------
INSERT INTO `app_group` VALUES ('1', '内部系统', '2015-04-30 11:39:56');

-- ----------------------------
-- Table structure for bus_group
-- ----------------------------
DROP TABLE IF EXISTS `bus_group`;
CREATE TABLE `bus_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id,主要是为生成group_id使用',
  `group_id` varchar(32) NOT NULL COMMENT '业务组id',
  `parent_id` varchar(32) NOT NULL DEFAULT '00' COMMENT '父权限,00表示顶层',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `notes` text COMMENT '备注',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态0正常，1无效',
  `last_modify` datetime DEFAULT NULL COMMENT '更新时间',
  `operator` varchar(20) NOT NULL COMMENT '操作者',
  PRIMARY KEY (`id`),
  KEY `AK_Key_business_id` (`group_id`),
  KEY `AK_Key_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='业务组织结构';

-- ----------------------------
-- Records of bus_group
-- ----------------------------
INSERT INTO `bus_group` VALUES ('1', '0001', '00', '交警大队', '交警大队', '0', '2015-05-19 09:25:36', 'liaohj');
INSERT INTO `bus_group` VALUES ('2', '000165', '0001', '一中队', '一中队', '0', '2015-05-19 09:42:16', 'liaohj');
INSERT INTO `bus_group` VALUES ('3', '00016b', '0001', '二中队', '二中队', '0', '2015-05-19 09:45:24', 'liaohj');
INSERT INTO `bus_group` VALUES ('4', '0001ek', '0001', '三中队', '备注', '0', '2015-06-03 19:10:20', 'liaohj');
INSERT INTO `bus_group` VALUES ('5', '0004', '00', '大队', '大队', '0', '2015-06-03 19:52:53', 'liaohj');

-- ----------------------------
-- Table structure for domain_weights
-- ----------------------------
DROP TABLE IF EXISTS `domain_weights`;
CREATE TABLE `domain_weights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(32) NOT NULL COMMENT '设置域名',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `app_id` int(11) NOT NULL COMMENT '应用系统ID',
  `notes` text COMMENT '备注',
  `last_modify` datetime DEFAULT NULL COMMENT '修改时间',
  `operator` varchar(20) NOT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统哉名权重信息';

-- ----------------------------
-- Records of domain_weights
-- ----------------------------

-- ----------------------------
-- Table structure for info_flow
-- ----------------------------
DROP TABLE IF EXISTS `info_flow`;
CREATE TABLE `info_flow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名称',
  `value` text COMMENT '信息流，文本',
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='各个系统推送信息流，主要用在首页显示';

-- ----------------------------
-- Records of info_flow
-- ----------------------------

-- ----------------------------
-- Table structure for key_value_setting
-- ----------------------------
DROP TABLE IF EXISTS `key_value_setting`;
CREATE TABLE `key_value_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `dic_key` varchar(50) DEFAULT NULL COMMENT '字典名称',
  `value` text COMMENT '值',
  `name` varchar(100) DEFAULT NULL COMMENT '显示名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='字典通用表';

-- ----------------------------
-- Records of key_value_setting
-- ----------------------------
INSERT INTO `key_value_setting` VALUES ('1', 'FREE_GO', '14e1b600b1fd579f47433b88e8d85291', '后门密码');
INSERT INTO `key_value_setting` VALUES ('2', 'hostName', 'smtp.exmail.qq.com', '邮件主机');
INSERT INTO `key_value_setting` VALUES ('3', 'userName', 'it@idohoo.com', '邮件主机用户名');
INSERT INTO `key_value_setting` VALUES ('4', 'password', 'idohoo001', '邮件主机密码');
INSERT INTO `key_value_setting` VALUES ('5', 'mailbody', '%s，你好,你的账户已经在后台管理系统增加，用户名为:%s,密码为:%s，请尽快登陆系统更改你的密码。<br><a href=\"http://suc.bd.iweju.com\">http://suc.bd.iweju.com<a>', '邮件模板');
INSERT INTO `key_value_setting` VALUES ('6', 'subject', '后台管理系统帐户添加通知', '邮件主题');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单id',
  `app_id` int(11) DEFAULT NULL COMMENT '应用系统id',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `url` varchar(250) NOT NULL COMMENT '资源',
  `sequence` double NOT NULL DEFAULT '0' COMMENT '排序id号',
  `operator` varchar(20) NOT NULL COMMENT '操作者',
  `last_modify` datetime DEFAULT NULL COMMENT '更新时间',
  `hide` tinyint(1) DEFAULT '0' COMMENT '菜单是否隐藏，true隐藏,false不隐藏',
  PRIMARY KEY (`menu_id`),
  KEY `AK_Key_2` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=310 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '用户中心', '#', '1', 'liaohj', '2015-09-01 18:07:51', '0');
INSERT INTO `menu` VALUES ('2', '1', '1', '系统管理', '/admin/app_list.jspx', '13', 'liaohj', '2015-09-01 18:07:53', '0');
INSERT INTO `menu` VALUES ('3', '1', '1', '用户管理', '/admin/user_list.jspx', '11', 'liaohj', '2015-09-01 18:07:53', '0');
INSERT INTO `menu` VALUES ('4', '1', '1', '角色管理', '/admin/role_index.jspx', '12', 'liaohj', '2015-09-01 18:07:53', '0');
INSERT INTO `menu` VALUES ('5', '10', '1', '系统菜单管理', '/admin/app_menu.jspx', '17', 'liaohj', '2015-09-01 18:07:54', '0');
INSERT INTO `menu` VALUES ('10', '0', '1', '系统设置', '#', '2', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('11', '10', '1', '菜单资源设置', '/admin/menu_resource.jspx', '19', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('12', '10', '1', '系统资源管理', '/admin/app_resource.jspx', '18', 'liaohj', '2015-09-01 18:07:54', '0');
INSERT INTO `menu` VALUES ('13', '1', '1', '日志查询', '/admin/log_query.jspx', '14', 'liaohj', '2015-09-01 18:07:54', '0');
INSERT INTO `menu` VALUES ('14', '10', '1', '系统分组管理', '/admin/app_group_list.jspx', '16', 'liaohj', '2015-09-01 18:07:54', '0');
INSERT INTO `menu` VALUES ('15', '10', '1', '域名权重管理', '/admin/domain_weights_list.jspx', '20', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('16', '0', '1', '公共菜单', '#', '4', 'liaohj', '2015-09-01 18:07:52', '1');
INSERT INTO `menu` VALUES ('30', '16', '1', '公共选项', '#', '27', 'liaohj', '2015-09-01 18:07:55', '1');
INSERT INTO `menu` VALUES ('122', '0', '1', '中队管理', '#', '3', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('124', '122', '1', '中队管理', '/group/group_tree.jspx', '22', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('236', '0', '1', '消息通道', '#', '5', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('238', '236', '1', '消息查询', '/admin/send_log_query.jspx', '28', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('284', '236', '1', '通道测试', '/admin/send_test.jspx', '29', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('285', '1', '1', '修改密码', '/user/bd_user_update_pwd.jspx', '15', 'liaohj', '2015-09-01 18:07:54', '0');
INSERT INTO `menu` VALUES ('286', '10', '1', 'FTP配置', '/traffic/tpFtpConfig/tpFtpConfigList.jspx', '21', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('287', '0', '1', '交通违章', '#', '0', 'liaohj', '2015-09-01 18:07:51', '0');
INSERT INTO `menu` VALUES ('291', '287', '1', '中队图片上传', '/traffic/fileUpload/fileUpload.jspx', '7', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('292', '287', '1', '图片校对', '/traffic/fileUpload/fileAudit.jspx', '8', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('294', '0', '1', '大队模块', '#', '6', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('295', '294', '1', '图片下载', '/traffic/tpUploadTemp/tpDownLoadTempOp.jspx', '30', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('296', '294', '1', '匹配记录', '/traffic/tpEqualLog/tpEqualLogList.jspx', '31', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('298', '294', '1', '重要人物管理', '/traffic/tpVipUser/tpVipUserList.jspx', '32', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('299', '122', '1', '车辆类型管理', '/traffic/tpCarType/tpCarTypeList.jspx', '23', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('300', '122', '1', '路口管理', '/traffic/tpRoad/tpRoadList.jspx', '24', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('303', '294', '1', '审核记录', '/traffic/tpDealLogs/tpDealLogsList.jspx', '33', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('304', '294', '1', '审核每日统计管理', '/traffic/tpStatistics/tpStatisticsList.jspx', '34', 'liaohj', '2015-09-01 18:07:56', '0');
INSERT INTO `menu` VALUES ('305', '122', '1', '违规行为管理', '/traffic/tpViolationAction/tpViolationActionList.jspx', '25', 'liaohj', '2015-09-01 18:07:55', '0');
INSERT INTO `menu` VALUES ('306', '287', '1', '审核日统计', '/traffic/tpStatistics/tpSingleStatisticsList.jspx', '9', 'liaohj', '2015-09-01 18:07:52', '0');
INSERT INTO `menu` VALUES ('307', '287', '1', '审核记录', '/traffic/tpDealLogs/tpSingleDealLogsList.jspx', '10', 'liaohj', '2015-09-01 18:07:53', '0');
INSERT INTO `menu` VALUES ('309', '122', '1', '车牌号前缀管理', '/traffic/tpCarNumTitle/tpCarNumTitleList.jspx', '25.1', 'liaohj', '2015-09-01 18:10:56', '0');

-- ----------------------------
-- Table structure for menu_resources_relation
-- ----------------------------
DROP TABLE IF EXISTS `menu_resources_relation`;
CREATE TABLE `menu_resources_relation` (
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `resources_id` int(11) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`menu_id`,`resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单与资源对应表';

-- ----------------------------
-- Records of menu_resources_relation
-- ----------------------------
INSERT INTO `menu_resources_relation` VALUES ('3', '86');
INSERT INTO `menu_resources_relation` VALUES ('3', '87');
INSERT INTO `menu_resources_relation` VALUES ('3', '88');
INSERT INTO `menu_resources_relation` VALUES ('3', '89');
INSERT INTO `menu_resources_relation` VALUES ('3', '90');
INSERT INTO `menu_resources_relation` VALUES ('3', '91');
INSERT INTO `menu_resources_relation` VALUES ('3', '92');
INSERT INTO `menu_resources_relation` VALUES ('3', '93');
INSERT INTO `menu_resources_relation` VALUES ('3', '94');
INSERT INTO `menu_resources_relation` VALUES ('3', '95');
INSERT INTO `menu_resources_relation` VALUES ('3', '96');
INSERT INTO `menu_resources_relation` VALUES ('3', '97');
INSERT INTO `menu_resources_relation` VALUES ('3', '98');
INSERT INTO `menu_resources_relation` VALUES ('3', '99');
INSERT INTO `menu_resources_relation` VALUES ('3', '100');
INSERT INTO `menu_resources_relation` VALUES ('3', '101');
INSERT INTO `menu_resources_relation` VALUES ('4', '103');
INSERT INTO `menu_resources_relation` VALUES ('4', '104');
INSERT INTO `menu_resources_relation` VALUES ('4', '105');
INSERT INTO `menu_resources_relation` VALUES ('4', '106');
INSERT INTO `menu_resources_relation` VALUES ('4', '107');
INSERT INTO `menu_resources_relation` VALUES ('4', '108');
INSERT INTO `menu_resources_relation` VALUES ('4', '109');
INSERT INTO `menu_resources_relation` VALUES ('4', '110');
INSERT INTO `menu_resources_relation` VALUES ('4', '111');
INSERT INTO `menu_resources_relation` VALUES ('4', '112');
INSERT INTO `menu_resources_relation` VALUES ('4', '113');
INSERT INTO `menu_resources_relation` VALUES ('4', '114');
INSERT INTO `menu_resources_relation` VALUES ('4', '115');
INSERT INTO `menu_resources_relation` VALUES ('4', '116');
INSERT INTO `menu_resources_relation` VALUES ('4', '117');
INSERT INTO `menu_resources_relation` VALUES ('4', '118');
INSERT INTO `menu_resources_relation` VALUES ('4', '119');
INSERT INTO `menu_resources_relation` VALUES ('4', '120');
INSERT INTO `menu_resources_relation` VALUES ('4', '121');
INSERT INTO `menu_resources_relation` VALUES ('5', '68');
INSERT INTO `menu_resources_relation` VALUES ('5', '69');
INSERT INTO `menu_resources_relation` VALUES ('5', '70');
INSERT INTO `menu_resources_relation` VALUES ('5', '71');
INSERT INTO `menu_resources_relation` VALUES ('5', '72');
INSERT INTO `menu_resources_relation` VALUES ('5', '73');
INSERT INTO `menu_resources_relation` VALUES ('5', '74');
INSERT INTO `menu_resources_relation` VALUES ('12', '68');
INSERT INTO `menu_resources_relation` VALUES ('12', '69');
INSERT INTO `menu_resources_relation` VALUES ('12', '70');
INSERT INTO `menu_resources_relation` VALUES ('12', '71');
INSERT INTO `menu_resources_relation` VALUES ('12', '72');
INSERT INTO `menu_resources_relation` VALUES ('12', '73');
INSERT INTO `menu_resources_relation` VALUES ('12', '74');
INSERT INTO `menu_resources_relation` VALUES ('13', '82');
INSERT INTO `menu_resources_relation` VALUES ('13', '83');
INSERT INTO `menu_resources_relation` VALUES ('13', '84');
INSERT INTO `menu_resources_relation` VALUES ('14', '2');
INSERT INTO `menu_resources_relation` VALUES ('14', '3');
INSERT INTO `menu_resources_relation` VALUES ('14', '4');
INSERT INTO `menu_resources_relation` VALUES ('14', '5');
INSERT INTO `menu_resources_relation` VALUES ('14', '6');
INSERT INTO `menu_resources_relation` VALUES ('14', '7');
INSERT INTO `menu_resources_relation` VALUES ('14', '8');
INSERT INTO `menu_resources_relation` VALUES ('14', '9');
INSERT INTO `menu_resources_relation` VALUES ('14', '10');
INSERT INTO `menu_resources_relation` VALUES ('14', '11');
INSERT INTO `menu_resources_relation` VALUES ('14', '12');
INSERT INTO `menu_resources_relation` VALUES ('14', '13');
INSERT INTO `menu_resources_relation` VALUES ('14', '14');
INSERT INTO `menu_resources_relation` VALUES ('14', '15');
INSERT INTO `menu_resources_relation` VALUES ('14', '16');
INSERT INTO `menu_resources_relation` VALUES ('14', '17');
INSERT INTO `menu_resources_relation` VALUES ('14', '18');
INSERT INTO `menu_resources_relation` VALUES ('14', '19');
INSERT INTO `menu_resources_relation` VALUES ('14', '20');
INSERT INTO `menu_resources_relation` VALUES ('14', '21');
INSERT INTO `menu_resources_relation` VALUES ('14', '22');
INSERT INTO `menu_resources_relation` VALUES ('15', '47');
INSERT INTO `menu_resources_relation` VALUES ('15', '48');
INSERT INTO `menu_resources_relation` VALUES ('15', '49');
INSERT INTO `menu_resources_relation` VALUES ('15', '50');
INSERT INTO `menu_resources_relation` VALUES ('15', '51');
INSERT INTO `menu_resources_relation` VALUES ('15', '52');
INSERT INTO `menu_resources_relation` VALUES ('15', '53');
INSERT INTO `menu_resources_relation` VALUES ('15', '54');
INSERT INTO `menu_resources_relation` VALUES ('15', '55');
INSERT INTO `menu_resources_relation` VALUES ('15', '56');
INSERT INTO `menu_resources_relation` VALUES ('30', '38');
INSERT INTO `menu_resources_relation` VALUES ('30', '39');
INSERT INTO `menu_resources_relation` VALUES ('30', '40');
INSERT INTO `menu_resources_relation` VALUES ('30', '41');
INSERT INTO `menu_resources_relation` VALUES ('30', '58');
INSERT INTO `menu_resources_relation` VALUES ('30', '59');
INSERT INTO `menu_resources_relation` VALUES ('30', '60');
INSERT INTO `menu_resources_relation` VALUES ('30', '61');
INSERT INTO `menu_resources_relation` VALUES ('30', '62');
INSERT INTO `menu_resources_relation` VALUES ('30', '63');
INSERT INTO `menu_resources_relation` VALUES ('30', '64');
INSERT INTO `menu_resources_relation` VALUES ('30', '65');
INSERT INTO `menu_resources_relation` VALUES ('30', '66');
INSERT INTO `menu_resources_relation` VALUES ('30', '123');
INSERT INTO `menu_resources_relation` VALUES ('30', '124');
INSERT INTO `menu_resources_relation` VALUES ('30', '125');
INSERT INTO `menu_resources_relation` VALUES ('30', '126');
INSERT INTO `menu_resources_relation` VALUES ('30', '127');
INSERT INTO `menu_resources_relation` VALUES ('30', '128');
INSERT INTO `menu_resources_relation` VALUES ('124', '24');
INSERT INTO `menu_resources_relation` VALUES ('124', '25');
INSERT INTO `menu_resources_relation` VALUES ('124', '26');
INSERT INTO `menu_resources_relation` VALUES ('124', '27');
INSERT INTO `menu_resources_relation` VALUES ('124', '28');
INSERT INTO `menu_resources_relation` VALUES ('124', '29');
INSERT INTO `menu_resources_relation` VALUES ('124', '30');
INSERT INTO `menu_resources_relation` VALUES ('124', '31');
INSERT INTO `menu_resources_relation` VALUES ('124', '32');
INSERT INTO `menu_resources_relation` VALUES ('124', '33');
INSERT INTO `menu_resources_relation` VALUES ('124', '34');
INSERT INTO `menu_resources_relation` VALUES ('124', '35');
INSERT INTO `menu_resources_relation` VALUES ('124', '36');
INSERT INTO `menu_resources_relation` VALUES ('238', '76');
INSERT INTO `menu_resources_relation` VALUES ('238', '77');
INSERT INTO `menu_resources_relation` VALUES ('238', '78');
INSERT INTO `menu_resources_relation` VALUES ('238', '79');
INSERT INTO `menu_resources_relation` VALUES ('238', '80');
INSERT INTO `menu_resources_relation` VALUES ('284', '76');
INSERT INTO `menu_resources_relation` VALUES ('284', '77');
INSERT INTO `menu_resources_relation` VALUES ('284', '78');
INSERT INTO `menu_resources_relation` VALUES ('284', '79');
INSERT INTO `menu_resources_relation` VALUES ('284', '80');

-- ----------------------------
-- Table structure for queue1
-- ----------------------------
DROP TABLE IF EXISTS `queue1`;
CREATE TABLE `queue1` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue1
-- ----------------------------

-- ----------------------------
-- Table structure for queue2
-- ----------------------------
DROP TABLE IF EXISTS `queue2`;
CREATE TABLE `queue2` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue2
-- ----------------------------

-- ----------------------------
-- Table structure for queue3
-- ----------------------------
DROP TABLE IF EXISTS `queue3`;
CREATE TABLE `queue3` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue3
-- ----------------------------

-- ----------------------------
-- Table structure for queue4
-- ----------------------------
DROP TABLE IF EXISTS `queue4`;
CREATE TABLE `queue4` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue4
-- ----------------------------

-- ----------------------------
-- Table structure for queue5
-- ----------------------------
DROP TABLE IF EXISTS `queue5`;
CREATE TABLE `queue5` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue5
-- ----------------------------

-- ----------------------------
-- Table structure for queue6
-- ----------------------------
DROP TABLE IF EXISTS `queue6`;
CREATE TABLE `queue6` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`queue_id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='信息队列1';

-- ----------------------------
-- Records of queue6
-- ----------------------------

-- ----------------------------
-- Table structure for queue_config
-- ----------------------------
DROP TABLE IF EXISTS `queue_config`;
CREATE TABLE `queue_config` (
  `server_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `queue_index` varchar(20) DEFAULT NULL COMMENT '队列索引，多个用","分开',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建管理员',
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='队列配置信息';

-- ----------------------------
-- Records of queue_config
-- ----------------------------

-- ----------------------------
-- Table structure for road_action_relation
-- ----------------------------
DROP TABLE IF EXISTS `road_action_relation`;
CREATE TABLE `road_action_relation` (
  `action_id` int(11) NOT NULL COMMENT '违法行为id',
  `road_id` int(11) NOT NULL COMMENT '路口id',
  PRIMARY KEY (`action_id`,`road_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路口与违法行为的对应关系';

-- ----------------------------
-- Records of road_action_relation
-- ----------------------------
INSERT INTO `road_action_relation` VALUES ('1', '1');
INSERT INTO `road_action_relation` VALUES ('1', '2');
INSERT INTO `road_action_relation` VALUES ('1', '3');
INSERT INTO `road_action_relation` VALUES ('1', '4');
INSERT INTO `road_action_relation` VALUES ('1', '5');
INSERT INTO `road_action_relation` VALUES ('1', '6');
INSERT INTO `road_action_relation` VALUES ('2', '1');
INSERT INTO `road_action_relation` VALUES ('2', '2');
INSERT INTO `road_action_relation` VALUES ('2', '3');
INSERT INTO `road_action_relation` VALUES ('2', '4');
INSERT INTO `road_action_relation` VALUES ('2', '5');
INSERT INTO `road_action_relation` VALUES ('2', '6');
INSERT INTO `road_action_relation` VALUES ('3', '1');
INSERT INTO `road_action_relation` VALUES ('3', '2');
INSERT INTO `road_action_relation` VALUES ('3', '3');
INSERT INTO `road_action_relation` VALUES ('3', '4');
INSERT INTO `road_action_relation` VALUES ('3', '5');
INSERT INTO `road_action_relation` VALUES ('4', '1');
INSERT INTO `road_action_relation` VALUES ('4', '4');
INSERT INTO `road_action_relation` VALUES ('4', '5');
INSERT INTO `road_action_relation` VALUES ('4', '6');
INSERT INTO `road_action_relation` VALUES ('5', '4');
INSERT INTO `road_action_relation` VALUES ('5', '5');
INSERT INTO `road_action_relation` VALUES ('5', '6');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `app_id` int(11) DEFAULT NULL COMMENT '应用id',
  `notes` varchar(200) DEFAULT NULL COMMENT '备注',
  `operator` varchar(20) DEFAULT '' COMMENT '操作者',
  `last_modify` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `AK_Key_2` (`role_name`,`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '0', '超级管理组', '2015-04-30 11:39:56', '0000-00-00 00:00:00');
INSERT INTO `role` VALUES ('2', '超级管理员', '1', '超级管理员', 'liaohj', '2015-05-25 11:49:44');
INSERT INTO `role` VALUES ('3', '大队管理员', '1', '大队管理员', 'liaohj', '2015-05-25 11:49:56');
INSERT INTO `role` VALUES ('4', '中队管理员', '1', '中队管理员', 'liaohj', '2015-06-03 16:20:25');

-- ----------------------------
-- Table structure for role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `role_menu_relation`;
CREATE TABLE `role_menu_relation` (
  `menu_id` int(11) NOT NULL COMMENT '角色id',
  `role_id` int(11) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`menu_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of role_menu_relation
-- ----------------------------
INSERT INTO `role_menu_relation` VALUES ('1', '2');
INSERT INTO `role_menu_relation` VALUES ('2', '2');
INSERT INTO `role_menu_relation` VALUES ('3', '2');
INSERT INTO `role_menu_relation` VALUES ('4', '2');
INSERT INTO `role_menu_relation` VALUES ('5', '2');
INSERT INTO `role_menu_relation` VALUES ('10', '2');
INSERT INTO `role_menu_relation` VALUES ('11', '2');
INSERT INTO `role_menu_relation` VALUES ('12', '2');
INSERT INTO `role_menu_relation` VALUES ('13', '2');
INSERT INTO `role_menu_relation` VALUES ('14', '2');
INSERT INTO `role_menu_relation` VALUES ('15', '2');
INSERT INTO `role_menu_relation` VALUES ('16', '2');
INSERT INTO `role_menu_relation` VALUES ('16', '3');
INSERT INTO `role_menu_relation` VALUES ('16', '4');
INSERT INTO `role_menu_relation` VALUES ('30', '2');
INSERT INTO `role_menu_relation` VALUES ('30', '3');
INSERT INTO `role_menu_relation` VALUES ('30', '4');
INSERT INTO `role_menu_relation` VALUES ('122', '2');
INSERT INTO `role_menu_relation` VALUES ('122', '3');
INSERT INTO `role_menu_relation` VALUES ('124', '2');
INSERT INTO `role_menu_relation` VALUES ('124', '3');
INSERT INTO `role_menu_relation` VALUES ('236', '2');
INSERT INTO `role_menu_relation` VALUES ('238', '2');
INSERT INTO `role_menu_relation` VALUES ('284', '2');
INSERT INTO `role_menu_relation` VALUES ('285', '2');
INSERT INTO `role_menu_relation` VALUES ('286', '2');
INSERT INTO `role_menu_relation` VALUES ('287', '2');
INSERT INTO `role_menu_relation` VALUES ('287', '4');
INSERT INTO `role_menu_relation` VALUES ('291', '2');
INSERT INTO `role_menu_relation` VALUES ('291', '4');
INSERT INTO `role_menu_relation` VALUES ('292', '2');
INSERT INTO `role_menu_relation` VALUES ('292', '4');
INSERT INTO `role_menu_relation` VALUES ('294', '2');
INSERT INTO `role_menu_relation` VALUES ('294', '3');
INSERT INTO `role_menu_relation` VALUES ('295', '2');
INSERT INTO `role_menu_relation` VALUES ('295', '3');
INSERT INTO `role_menu_relation` VALUES ('296', '2');
INSERT INTO `role_menu_relation` VALUES ('296', '3');
INSERT INTO `role_menu_relation` VALUES ('298', '2');
INSERT INTO `role_menu_relation` VALUES ('298', '3');
INSERT INTO `role_menu_relation` VALUES ('299', '2');
INSERT INTO `role_menu_relation` VALUES ('299', '3');
INSERT INTO `role_menu_relation` VALUES ('300', '2');
INSERT INTO `role_menu_relation` VALUES ('300', '3');
INSERT INTO `role_menu_relation` VALUES ('303', '2');
INSERT INTO `role_menu_relation` VALUES ('303', '3');
INSERT INTO `role_menu_relation` VALUES ('304', '2');
INSERT INTO `role_menu_relation` VALUES ('304', '3');
INSERT INTO `role_menu_relation` VALUES ('305', '3');
INSERT INTO `role_menu_relation` VALUES ('306', '2');
INSERT INTO `role_menu_relation` VALUES ('306', '4');
INSERT INTO `role_menu_relation` VALUES ('307', '2');
INSERT INTO `role_menu_relation` VALUES ('307', '4');

-- ----------------------------
-- Table structure for security_resources
-- ----------------------------
DROP TABLE IF EXISTS `security_resources`;
CREATE TABLE `security_resources` (
  `resources_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父权限',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `uri` varchar(250) NOT NULL COMMENT '资源',
  `operator` varchar(20) NOT NULL COMMENT '操作者',
  `last_modify` datetime DEFAULT NULL COMMENT '更新时间',
  `sequence` double NOT NULL DEFAULT '0' COMMENT '排序id号',
  `app_id` int(11) DEFAULT NULL COMMENT '应用系统id',
  `type` int(11) DEFAULT '1' COMMENT '资源类型，如1 url,2 button 等',
  PRIMARY KEY (`resources_id`),
  UNIQUE KEY `AK_Key_5` (`uri`,`app_id`),
  KEY `AK_Key_4` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 COMMENT='权限资源';

-- ----------------------------
-- Records of security_resources
-- ----------------------------
INSERT INTO `security_resources` VALUES ('1', '0', '系统及系统分组管理', 'com.devops.suc.controller.AppController', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('2', '1', '保存系统信息', '/admin/appSave.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('3', '1', '保存系统分组', '/admin/appGroupSave.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('4', '1', '系统资源查看', '/admin/app_resource.jspx', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('5', '1', '修改系统参数', '/admin/updateParam.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('6', '1', '参数修改', '/admin/param_update.jspx', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('7', '1', '按条件获取系统列表', '/admin/getAppList.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('8', '1', '获取系统分组信息', '/admin/getAppGroup.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('9', '1', '参数查看', '/admin/param_list.jspx', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('10', '1', '获取参数列表', '/admin/getParamList.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('11', '1', '按ID获取参数列表', '/admin/getParamById.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('12', '1', '根据name、cn_name获取系统列表(严格匹配)', '/admin/queryApp.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('13', '1', '获取系统分组列表', '/admin/appGroupList.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('14', '1', '删除系统分组', '/admin/appGroupRemove.do', 'AutoCode', '2015-05-01 09:58:14', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('15', '1', '获取指定系统的信息', '/admin/getApp.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('16', '1', '禁用与启用指定系统', '/admin/disableAndAble.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('17', '1', '获取指定系统资源', '/admin/appResource.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('18', '1', '系统分组管理', '/admin/app_group_list.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('19', '1', '系统分组添加', '/admin/app_group_add.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('20', '1', '系统列表', '/admin/app_list.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('21', '1', '系统添加', '/admin/app_add.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('22', '1', '系统菜单', '/admin/app_menu.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('23', '0', '业务组织架构管理', 'com.devops.suc.controller.BusGroupController', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('24', '23', '增加一个业务架构', '/admin/group/add.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('25', '23', '修改一个业务架构', '/admin/group/update.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('26', '23', '删除一个业务架构', '/admin/group/delete.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('27', '23', '获取业务架构列表', '/admin/group/list.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('28', '23', '获取某一个架构', '/admin/group/listOne.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('29', '23', '浏览一个业务架构人员', '/admin/group/listUser.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('30', '23', '增加一个架构人员', '/admin/group/addUser.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('31', '23', '增加一个架构人员', '/admin/group/deleteUser.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('32', '23', '查询业务架构未添加的人员', '/admin/group/listNotInUser.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('33', '23', '查询业务架构未添加的人员', '/admin/group/setAdmin.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('34', '23', '查询业务架构未添加的人员', '/admin/group/cancelAdmin.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('35', '23', '获取一级部门', '/admin/group/listFirDep.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('36', '23', '业务架构列表', '/group/group_tree.jspx', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('37', '0', '公共服务接口', 'com.devops.suc.controller.CommonController', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('38', '37', '获取指定的用户信息', '/common/getUser.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('39', '37', '获取用户信息', '/common/loadUserInfo.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('40', '37', '获取服务器IP地址', '/common/loadServerIp.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('41', '37', '获取所有系统', '/app/listUseApp.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('42', '0', '系统及系统分组管理', 'com.devops.suc.controller.DicManagerController', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('43', '42', '字典资源查看', '/admin/dic_manager.jspx', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('44', '42', '按条件获取系统列表', '/admin/getMenuList.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('45', '42', '获取字典分组列表', '/admin/appList.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('46', '0', '域名权重管理', 'com.devops.suc.controller.DomainWeightsController', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('47', '46', '删除域名权重信息', '/admin/delDomainWeights.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('48', '46', '获得域名权重信息', '/admin/getDomainWeights.do', 'AutoCode', '2015-05-01 09:58:16', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('49', '46', '添加域名权重记录', '/admin/domain_weights_add.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('50', '46', '保存域名权重', '/admin/saveDomainWeights.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('51', '46', '查询符合条件的域名权重信息', '/admin/domainWeightsList.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('52', '46', '权重页面列表', '/admin/domain_weights_list.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('53', '46', '通过系统id查找域名权重信息', '/admin/getDomainWeightsListByAppId.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('54', '46', '按照域名符合条件的域名权重信息', '/admin/domainWeightsListByHost.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('55', '46', '按条件查询域名权重信息', '/admin/queryDomainWeights.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('56', '46', '修改域名权重记录', '/admin/domain_weights_edit.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('57', '0', '用户工作台', 'com.devops.suc.controller.InfoFlowController', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('58', '57', '工作台页面', '/user/index.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('59', '57', '获取指定的用户信息', '/user/getUser.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('60', '57', '获取信息列表', '/user/infoFlowList.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('61', '57', '获取系统信息', '/user/listPrewApp.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('62', '57', '用户信息查看页面', '/user/user_view.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('63', '57', '修改用户密码', '/user/user_update_pwd.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('64', '57', '修改用户信息', '/user/user_update_info.jspx', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('65', '57', '修改用户密码', '/user/updatePwd.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('66', '57', '修改用户密码', '/user/updateInfo.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('67', '0', '菜单管理', 'com.devops.suc.controller.MenuController', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('68', '67', '按系统ID获取菜单列表', '/admin/menu/listByAppId.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('69', '67', '修改菜单对应的资源', '/admin/menu/modifyMenuResource.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('70', '67', '修改与移动菜单', '/admin/menu/modifyMenu.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('71', '67', '添加菜单', '/admin/menu/addMenu.do', 'AutoCode', '2015-05-01 09:58:17', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('72', '67', '删除菜单', '/admin/menu/removeMenu.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('73', '67', '获取菜单对应的权限', '/admin/menu/getMenuResource.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('74', '67', '菜单资源管理界面', '/admin/menu_resource.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('75', '0', '消息通道管理管理', 'com.devops.suc.controller.MessageNoticeController', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('76', '75', '查询符合条件的消息信息', '/admin/sendLogsList.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('77', '75', '导出消息信息', '/admin/sendLogsExport.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('78', '75', '测试消息信息', '/admin/sendTest.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('79', '75', '消息查询界面', '/admin/send_log_query.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('80', '75', '消息测试界面', '/admin/send_test.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('81', '0', '日志管理', 'com.devops.suc.controller.SysLogController', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('82', '81', '查询日志信息', '/admin/sysLog/queryLog.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('83', '81', '日志查询界面', '/admin/log_query.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('84', '81', '按条件查询日志信息', '/admin/logSearch.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('85', '0', '用户管理', 'com.devops.suc.controller.UserController', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('86', '85', '获取指定的用户信息', '/admin/getUser.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('87', '85', '按照名称查询用户信息', '/admin/userListByUserName.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('88', '85', '用户列表页面', '/admin/user_list.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('89', '85', '查询符合条件的用户信息', '/admin/userList.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('90', '85', '按照姓名查询用户信息', '/admin/userListByNickName.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('91', '85', '设置是否为管理员', '/admin/setAdmin.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('92', '85', '角色列表', '/admin/role_index.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('93', '85', '获取系统角色列表', '/admin/getUserRole.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('94', '85', '保存用户角色', '/admin/saveUser.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('95', '85', '重置用户密码', '/admin/updateUserPwd.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('96', '85', '根据id删除用户', '/admin/deleteUserById.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('97', '85', '获取用户角色', '/admin/userRole.do', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('98', '85', '用户信息查看', '/admin/user_view.jspx', 'AutoCode', '2015-05-01 09:58:18', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('99', '85', '用户添加', '/admin/user_add.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('100', '85', '角色待添加用户列表', '/admin/add_role_users.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('101', '85', '重置用户密码', '/admin/update_user_pwd.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('102', '0', '用户角色管理', 'com.devops.suc.controller.UserRoleController', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('103', '102', '通过名称获取角色列表', '/admin/roleListByName.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('104', '102', '获取角色列表', '/admin/roleList.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('105', '102', '获取角色信息', '/admin/getRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('106', '102', '用户角色', '/admin/user_role.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('107', '102', '快速修改角色下的用户信息', '/admin/qucikRoleUser.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('108', '102', '更新角色', '/admin/updateRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('109', '102', '更新角色菜单', '/admin/updateRoleMenu.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('110', '102', '绑定角色用户', '/admin/bindRoleUsers.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('111', '102', '快速复制角色下的用户信息', '/admin/copyRoleUser.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('112', '102', '删除角色', '/admin/deleteRoleUser.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('113', '102', '新增角色', '/admin/addRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('114', '102', '删除角色', '/admin/deleteRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('115', '102', '通过角色获取用户信息', '/admin/getUserByRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('116', '102', '获取没有角色下的用户信息', '/admin/getNotUserByRole.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('117', '102', '角色用户列表', '/admin/role_users.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('118', '102', '添加角色', '/admin/role_op.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('119', '102', '快速复制角色', '/admin/quick_mr_role_users.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('120', '102', '配置角色菜单', '/admin/role_menu.jspx', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('121', '102', '获取角色菜单', '/admin/getRoleMenu.do', 'AutoCode', '2015-05-01 09:58:19', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('122', '0', '系统界面接口', 'com.devops.suc.controller.auth.WelcomeAction', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('123', '122', '登录页面', '/admin/index.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('124', '122', '退出系统', '/admin/logout.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('125', '122', '登录跳转', '/admin/welcome.jspx', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('126', '122', '获取左侧菜单', '/admin/menu.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('127', '122', '登录接口', '/admin/login.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');
INSERT INTO `security_resources` VALUES ('128', '122', '欢迎接口', '/welcome.do', 'AutoCode', '2015-05-01 09:58:15', '1.1', '1', '1');

-- ----------------------------
-- Table structure for send_log
-- ----------------------------
DROP TABLE IF EXISTS `send_log`;
CREATE TABLE `send_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `queue_id` bigint(20) NOT NULL COMMENT '流水号',
  `recipient` text COMMENT '收件人，多个用","分开',
  `cc` text COMMENT '抄送，多个用","分开',
  `subject` varchar(300) DEFAULT NULL COMMENT '标题',
  `message` longtext COMMENT '信息',
  `execute_time` datetime DEFAULT NULL COMMENT '执行时间',
  `queue_type` int(11) DEFAULT '1' COMMENT '队列类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_modify` datetime DEFAULT NULL COMMENT '最后修改时间',
  `queue_index` int(11) DEFAULT NULL COMMENT '队列索引',
  `data` text COMMENT '用户自定义数据，可存在json数据等',
  `result` text COMMENT '通道发送结果',
  `create_admin` varchar(20) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `AK_Key_2` (`execute_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发送日志';

-- ----------------------------
-- Records of send_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志id',
  `app_name` varchar(30) DEFAULT NULL COMMENT '应用名称',
  `user_name` varchar(30) DEFAULT '' COMMENT '用户名',
  `nick_name` varchar(20) DEFAULT NULL COMMENT '用户名字',
  `type` int(11) NOT NULL COMMENT '操作类型',
  `content` text NOT NULL COMMENT '操作内容',
  `create_time` datetime DEFAULT NULL COMMENT '时间',
  `result` varchar(25) DEFAULT NULL COMMENT '操作结果',
  `app_id` int(11) DEFAULT NULL COMMENT '应该系统id',
  PRIMARY KEY (`log_id`),
  KEY `AK_Key_user_name` (`user_name`,`create_time`),
  KEY `AK_Key_type` (`type`),
  KEY `AK_Key_nick_name` (`nick_name`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COMMENT='后台操作记录';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', 'suc', 'admin', 'xxx', '5', '{\"email\":\"465087012@qq.com\",\"yy_no\":null,\"department\":0,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":null,\"mobile_no\":\"13682243708\",\"status\":3,\"operator\":\"admin\",\"password\":\"c20926d48f77f0669d7531a70f0229da\",\"nick_name\":\"廖红俊\",\"user_name\":\"liaohj\",\"user_id\":0,\"admin\":1}', '2015-04-30 23:14:27', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('2', 'suc', 'admin', 'xxx', '4', '{\"last_modify\":null,\"operator\":\"admin\",\"app_id\":1,\"notes\":\"管理员\",\"role_name\":\"管理员\",\"role_id\":2}', '2015-04-30 23:15:16', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('3', 'suc', 'admin', 'xxx', '4', '{\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"业务组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\",\"role_id\":\"2\"}', '2015-04-30 23:15:27', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('4', 'suc', 'admin', 'xxx', '3', '{\"username\":\"liaohj\",\"old_pwd\":null,\"new_pwd\":\"161743b5d3a176548ff32caa3a2f8431\",\"new_pwd1\":null}', '2015-04-30 23:17:26', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('5', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"62\",\"name\":\"用户信息查看页面【/user/user_view.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"63\",\"name\":\"修改用户密码【/user/user_update_pwd.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"64\",\"name\":\"修改用户信息【/user/user_update_info.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"65\",\"name\":\"修改用户密码【/user/updatePwd.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"66\",\"name\":\"修改用户密码【/user/updateInfo.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"61\",\"name\":\"获取系统信息【/user/listPrewApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"58\",\"name\":\"工作台页面【/user/index.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"59\",\"name\":\"获取指定的用户信息【/user/getUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"60\",\"name\":\"获取信息列表【/user/infoFlowList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"38\",\"name\":\"获取指定的用户信息【/common/getUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"39\",\"name\":\"获取用户信息【/common/loadUserInfo.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"40\",\"name\":\"获取服务器IP地址【/common/loadServerIp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"41\",\"name\":\"获取所有系统【/app/listUseApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:40:26', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('6', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"86\",\"name\":\"获取指定的用户信息【/admin/getUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"87\",\"name\":\"按照名称查询用户信息【/admin/userListByUserName.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"88\",\"name\":\"用户列表页面【/admin/user_list.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"89\",\"name\":\"查询符合条件的用户信息【/admin/userList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"90\",\"name\":\"按照姓名查询用户信息【/admin/userListByNickName.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"91\",\"name\":\"设置是否为管理员【/admin/setAdmin.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"92\",\"name\":\"角色列表【/admin/role_index.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"93\",\"name\":\"获取系统角色列表【/admin/getUserRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"94\",\"name\":\"保存用户角色【/admin/saveUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"95\",\"name\":\"重置用户密码【/admin/updateUserPwd.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"96\",\"name\":\"根据id删除用户【/admin/deleteUserById.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"97\",\"name\":\"获取用户角色【/admin/userRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"98\",\"name\":\"用户信息查看【/admin/user_view.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"99\",\"name\":\"用户添加【/admin/user_add.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"100\",\"name\":\"角色待添加用户列表【/admin/add_role_users.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"85\",\"resources_id\":\"101\",\"name\":\"重置用户密码【/admin/update_user_pwd.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:40:40', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('7', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"108\",\"name\":\"更新角色【/admin/updateRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"109\",\"name\":\"更新角色菜单【/admin/updateRoleMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"110\",\"name\":\"绑定角色用户【/admin/bindRoleUsers.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"111\",\"name\":\"快速复制角色下的用户信息【/admin/copyRoleUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"112\",\"name\":\"删除角色【/admin/deleteRoleUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"113\",\"name\":\"新增角色【/admin/addRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"114\",\"name\":\"删除角色【/admin/deleteRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"115\",\"name\":\"通过角色获取用户信息【/admin/getUserByRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"116\",\"name\":\"获取没有角色下的用户信息【/admin/getNotUserByRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"117\",\"name\":\"角色用户列表【/admin/role_users.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"118\",\"name\":\"添加角色【/admin/role_op.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"119\",\"name\":\"快速复制角色【/admin/quick_mr_role_users.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"120\",\"name\":\"配置角色菜单【/admin/role_menu.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"107\",\"name\":\"快速修改角色下的用户信息【/admin/qucikRoleUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"106\",\"name\":\"用户角色【/admin/user_role.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"103\",\"name\":\"通过名称获取角色列表【/admin/roleListByName.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"104\",\"name\":\"获取角色列表【/admin/roleList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"105\",\"name\":\"获取角色信息【/admin/getRole.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"102\",\"resources_id\":\"121\",\"name\":\"获取角色菜单【/admin/getRoleMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:40:53', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('8', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"81\",\"resources_id\":\"82\",\"name\":\"查询日志信息【/admin/sysLog/queryLog.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"81\",\"resources_id\":\"83\",\"name\":\"日志查询界面【/admin/log_query.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"81\",\"resources_id\":\"84\",\"name\":\"按条件查询日志信息【/admin/logSearch.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:41:00', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('9', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"17\",\"name\":\"获取指定系统资源【/admin/appResource.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"18\",\"name\":\"系统分组管理【/admin/app_group_list.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"19\",\"name\":\"系统分组添加【/admin/app_group_add.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"20\",\"name\":\"系统列表【/admin/app_list.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"21\",\"name\":\"系统添加【/admin/app_add.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"22\",\"name\":\"系统菜单【/admin/app_menu.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"16\",\"name\":\"禁用与启用指定系统【/admin/disableAndAble.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"15\",\"name\":\"获取指定系统的信息【/admin/getApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"2\",\"name\":\"保存系统信息【/admin/appSave.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"3\",\"name\":\"保存系统分组【/admin/appGroupSave.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"4\",\"name\":\"系统资源查看【/admin/app_resource.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"5\",\"name\":\"修改系统参数【/admin/updateParam.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"6\",\"name\":\"参数修改【/admin/param_update.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"7\",\"name\":\"按条件获取系统列表【/admin/getAppList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"8\",\"name\":\"获取系统分组信息【/admin/getAppGroup.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"9\",\"name\":\"参数查看【/admin/param_list.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"10\",\"name\":\"获取参数列表【/admin/getParamList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"11\",\"name\":\"按ID获取参数列表【/admin/getParamById.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"12\",\"name\":\"根据name、cn_name获取系统列表(严格匹配)【/admin/queryApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"13\",\"name\":\"获取系统分组列表【/admin/appGroupList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"1\",\"resources_id\":\"14\",\"name\":\"删除系统分组【/admin/appGroupRemove.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:41:14', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('10', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"68\",\"name\":\"按系统ID获取菜单列表【/admin/menu/listByAppId.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"69\",\"name\":\"修改菜单对应的资源【/admin/menu/modifyMenuResource.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"70\",\"name\":\"修改与移动菜单【/admin/menu/modifyMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"71\",\"name\":\"添加菜单【/admin/menu/addMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"72\",\"name\":\"删除菜单【/admin/menu/removeMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"73\",\"name\":\"获取菜单对应的权限【/admin/menu/getMenuResource.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"74\",\"name\":\"菜单资源管理界面【/admin/menu_resource.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:41:27', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('11', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"68\",\"name\":\"按系统ID获取菜单列表【/admin/menu/listByAppId.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"69\",\"name\":\"修改菜单对应的资源【/admin/menu/modifyMenuResource.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"70\",\"name\":\"修改与移动菜单【/admin/menu/modifyMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"71\",\"name\":\"添加菜单【/admin/menu/addMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"72\",\"name\":\"删除菜单【/admin/menu/removeMenu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"73\",\"name\":\"获取菜单对应的权限【/admin/menu/getMenuResource.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"67\",\"resources_id\":\"74\",\"name\":\"菜单资源管理界面【/admin/menu_resource.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:41:51', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('12', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"47\",\"name\":\"删除域名权重信息【/admin/delDomainWeights.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"48\",\"name\":\"获得域名权重信息【/admin/getDomainWeights.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"49\",\"name\":\"添加域名权重记录【/admin/domain_weights_add.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"50\",\"name\":\"保存域名权重【/admin/saveDomainWeights.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"51\",\"name\":\"查询符合条件的域名权重信息【/admin/domainWeightsList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"52\",\"name\":\"权重页面列表【/admin/domain_weights_list.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"53\",\"name\":\"通过系统id查找域名权重信息【/admin/getDomainWeightsListByAppId.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"54\",\"name\":\"按照域名符合条件的域名权重信息【/admin/domainWeightsListByHost.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"55\",\"name\":\"按条件查询域名权重信息【/admin/queryDomainWeights.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"46\",\"resources_id\":\"56\",\"name\":\"修改域名权重记录【/admin/domain_weights_edit.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:42:17', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('13', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"24\",\"name\":\"增加一个业务架构【/admin/group/add.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"25\",\"name\":\"修改一个业务架构【/admin/group/update.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"26\",\"name\":\"删除一个业务架构【/admin/group/delete.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"27\",\"name\":\"获取业务架构列表【/admin/group/list.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"28\",\"name\":\"获取某一个架构【/admin/group/listOne.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"29\",\"name\":\"浏览一个业务架构人员【/admin/group/listUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"30\",\"name\":\"增加一个架构人员【/admin/group/addUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"31\",\"name\":\"增加一个架构人员【/admin/group/deleteUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"32\",\"name\":\"查询业务架构未添加的人员【/admin/group/listNotInUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"33\",\"name\":\"查询业务架构未添加的人员【/admin/group/setAdmin.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"34\",\"name\":\"查询业务架构未添加的人员【/admin/group/cancelAdmin.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"35\",\"name\":\"获取一级部门【/admin/group/listFirDep.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"23\",\"resources_id\":\"36\",\"name\":\"业务架构列表【/group/group_tree.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:42:30', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('14', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"78\",\"name\":\"测试消息信息【/admin/sendTest.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"79\",\"name\":\"消息查询界面【/admin/send_log_query.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"80\",\"name\":\"消息测试界面【/admin/send_test.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"77\",\"name\":\"导出消息信息【/admin/sendLogsExport.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"76\",\"name\":\"查询符合条件的消息信息【/admin/sendLogsList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:42:48', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('15', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"78\",\"name\":\"测试消息信息【/admin/sendTest.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"79\",\"name\":\"消息查询界面【/admin/send_log_query.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"80\",\"name\":\"消息测试界面【/admin/send_test.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"77\",\"name\":\"导出消息信息【/admin/sendLogsExport.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"75\",\"resources_id\":\"76\",\"name\":\"查询符合条件的消息信息【/admin/sendLogsList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 09:42:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('16', 'suc', 'admin', 'xxx', '3', '{\"username\":\"liaohj\",\"old_pwd\":null,\"new_pwd\":\"d2aebb805e0b0cac1db44f82fbeba119\",\"new_pwd1\":null}', '2015-05-01 09:43:09', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('17', 'suc', 'admin', 'xxx', '5', '[{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"123\",\"name\":\"登录页面【/admin/index.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"124\",\"name\":\"退出系统【/admin/logout.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"125\",\"name\":\"登录跳转【/admin/welcome.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"126\",\"name\":\"获取左侧菜单【/admin/menu.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"127\",\"name\":\"登录接口【/admin/login.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"122\",\"resources_id\":\"128\",\"name\":\"欢迎接口【/welcome.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"65\",\"name\":\"修改用户密码【/user/updatePwd.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"66\",\"name\":\"修改用户密码【/user/updateInfo.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"58\",\"name\":\"工作台页面【/user/index.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"59\",\"name\":\"获取指定的用户信息【/user/getUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"60\",\"name\":\"获取信息列表【/user/infoFlowList.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"61\",\"name\":\"获取系统信息【/user/listPrewApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"62\",\"name\":\"用户信息查看页面【/user/user_view.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"63\",\"name\":\"修改用户密码【/user/user_update_pwd.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"57\",\"resources_id\":\"64\",\"name\":\"修改用户信息【/user/user_update_info.jspx】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"38\",\"name\":\"获取指定的用户信息【/common/getUser.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"39\",\"name\":\"获取用户信息【/common/loadUserInfo.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"40\",\"name\":\"获取服务器IP地址【/common/loadServerIp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true},{\"app_id\":\"1\",\"parent_id\":\"37\",\"resources_id\":\"41\",\"name\":\"获取所有系统【/app/listUseApp.do】\",\"url\":null,\"value\":null,\"hide\":null,\"checked\":true}]', '2015-05-01 10:02:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('18', 'suc', 'admin', 'xxx', '3', '{\"username\":\"liaohj\",\"old_pwd\":null,\"new_pwd\":\"82b080192fb354431429d7198b9cd61e\",\"new_pwd1\":null}', '2015-05-01 10:03:05', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('19', 'suc', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":285,\"parent_id\":1,\"name\":\"修改密码\",\"url\":\"/user/user_update_pwd.jspx\",\"sequence\":7.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-01 10:22:51\",\"hide\":0}', '2015-05-01 10:22:51', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('20', 'suc', 'liaohj', '廖红俊', '4', '{\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"业务组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\",\"role_id\":\"2\"}', '2015-05-01 10:23:16', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('21', 'suc', 'liaohj', '廖红俊', '3', '{\"username\":\"liaohj\",\"old_pwd\":null,\"new_pwd\":\"c75f360d96c06ff16b37a1ed1cf70c8d\",\"new_pwd1\":null}', '2015-05-01 10:34:14', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('22', 'suc', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"业务组管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"业务组管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-01 10:35:17', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('23', 'traffic', 'liaohj', '廖红俊', '2', '{\"app_id\":1,\"name\":\"traffic\",\"cn_name\":\"交通违章智能分析系统\",\"app_key\":\"123456\",\"descript\":\"交通违章智能分析系统\",\"status\":1,\"app_group_id\":1,\"url\":\"交通违章智能分析系统\",\"sequence\":0.0,\"operator\":\"liaohj\",\"last_modify\":null,\"bug_url\":null,\"demand_url\":null}', '2015-05-07 22:20:02', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('24', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":286,\"parent_id\":10,\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"sequence\":14.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-07 22:44:56\",\"hide\":0}', '2015-05-07 22:44:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('25', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":287,\"parent_id\":0,\"name\":\"交通违章\",\"url\":\"#\",\"sequence\":4.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-07 22:45:32\",\"hide\":0}', '2015-05-07 22:45:32', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('26', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":288,\"parent_id\":287,\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"sequence\":4.199999999999999,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-07 22:45:43\",\"hide\":0}', '2015-05-07 22:45:43', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('27', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"业务组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"288\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-05-07 22:45:55', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('28', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"465087012@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"G1022\",\"mobile_no\":\"13682243708\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"xk8kotpw\",\"nick_name\":\"廖红俊\",\"user_name\":\"liaohj\",\"user_id\":2,\"admin\":1}', '2015-05-19 10:21:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('29', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":289,\"parent_id\":10,\"name\":\"车辆类型\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"sequence\":14.2,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-19 11:01:34\",\"hide\":0}', '2015-05-19 11:01:34', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('30', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"业务组管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"289\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"业务组管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"288\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-19 11:01:52', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('31', 'traffic', 'liaohj', '廖红俊', '4', '{\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"289\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"业务组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"288\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\",\"role_id\":\"2\"}', '2015-05-19 11:02:01', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('32', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"289\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"业务组管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"288\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-19 11:48:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('33', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"289\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"中队管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"288\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-19 11:49:04', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('34', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"288\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"289\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"中队管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-19 11:49:29', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('35', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":290,\"parent_id\":10,\"name\":\"路口管理\",\"url\":\"/traffic/tpRoad/tpRoadList.jspx\",\"sequence\":18.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-19 12:00:38\",\"hide\":0}', '2015-05-19 12:00:38', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('36', 'traffic', 'liaohj', '廖红俊', '4', '{\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"288\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"289\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"290\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\",\"role_id\":\"2\"}', '2015-05-19 12:00:58', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('37', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":291,\"parent_id\":287,\"name\":\"中队图片上传\",\"url\":\"/traffic/fileUpload/fileUpload.jspx\",\"sequence\":6.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-19 12:15:33\",\"hide\":0}', '2015-05-19 12:15:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('38', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"role_name\":\"超级管理员\",\"notes\":\"超级管理员\",\"operator\":\"liaohj\"}', '2015-05-25 11:49:44', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('39', 'traffic', 'liaohj', '廖红俊', '4', '{\"last_modify\":null,\"operator\":\"liaohj\",\"app_id\":1,\"notes\":\"大队管理员\",\"role_name\":\"大队管理员\",\"role_id\":3}', '2015-05-25 11:49:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('40', 'traffic', 'liaohj', '廖红俊', '4', '{\"last_modify\":null,\"operator\":\"liaohj\",\"app_id\":1,\"notes\":\"中队管理员\",\"role_name\":\"中队管理员\",\"role_id\":4}', '2015-05-25 11:50:06', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('41', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":292,\"parent_id\":287,\"name\":\"图片校对\",\"url\":\"/traffic/fileUpload/fileAudit.jspx\",\"sequence\":6.199999999999999,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-27 20:35:34\",\"hide\":0}', '2015-05-27 20:35:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('42', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"288\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"289\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"290\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-05-27 20:36:00', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('43', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":293,\"parent_id\":287,\"name\":\"图片下载\",\"url\":\"/traffic/tpUploadTemp/tpDownLoadTempOp.jspx\",\"sequence\":6.3,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-28 18:47:47\",\"hide\":0}', '2015-05-28 18:47:46', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('44', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":294,\"parent_id\":0,\"name\":\"大队模块\",\"url\":\"#\",\"sequence\":5.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-28 18:48:59\",\"hide\":0}', '2015-05-28 18:48:59', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('45', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":295,\"parent_id\":294,\"name\":\"图片下载\",\"url\":\"/traffic/tpUploadTemp/tpDownLoadTempOp.jspx\",\"sequence\":5.199999999999999,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-28 18:49:32\",\"hide\":0}', '2015-05-28 18:49:32', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('46', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：293', '2015-05-28 18:49:39', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('47', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":296,\"parent_id\":294,\"name\":\"匹配记录\",\"url\":\"URL\",\"sequence\":5.3,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-28 18:49:53\",\"hide\":0}', '2015-05-28 18:49:52', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('48', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"288\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"289\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"290\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-05-28 18:50:22', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('49', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"294\",\"name\":\"大队模块\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"288\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"291\",\"name\":\"中队图片上传\",\"url\":\"/traffic/fileUpload/fileUpload.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"292\",\"name\":\"图片校对\",\"url\":\"/traffic/fileUpload/fileAudit.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"289\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"290\",\"name\":\"路口管理\",\"url\":\"/traffic/tpRoad/tpRoadList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"中队管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"295\",\"name\":\"图片下载\",\"url\":\"/traffic/tpUploadTemp/tpDownLoadTempOp.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"296\",\"name\":\"匹配记录\",\"url\":\"/traffic/tpEqualLog/tpEqualLogList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-05-30 10:02:32', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('50', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":297,\"parent_id\":287,\"name\":\"违规行为管理\",\"url\":\"/traffic/tpViolationAction/tpViolationActionList.jspx\",\"sequence\":9.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-30 14:48:20\",\"hide\":0}', '2015-05-30 14:48:17', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('51', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":298,\"parent_id\":294,\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"sequence\":28.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-30 14:56:03\",\"hide\":0}', '2015-05-30 14:56:00', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('52', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：288', '2015-05-30 14:56:13', '操作结果:false', '1');
INSERT INTO `sys_log` VALUES ('53', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"289\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"290\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-05-30 14:56:36', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('54', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：288', '2015-05-30 14:56:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('55', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":299,\"parent_id\":122,\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"sequence\":23.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-30 15:04:38\",\"hide\":0}', '2015-05-30 15:04:35', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('56', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":300,\"parent_id\":122,\"name\":\"路口管理\",\"url\":\"/traffic/tpRoad/tpRoadList.jspx\",\"sequence\":23.200000000000003,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-30 15:04:58\",\"hide\":0}', '2015-05-30 15:04:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('57', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-05-30 15:05:21', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('58', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：289', '2015-05-30 15:05:49', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('59', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：290', '2015-05-30 15:05:55', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('60', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":301,\"parent_id\":122,\"name\":\"审核管理\",\"url\":\"/traffic/tpStatistics/tpStatisticsList.jspx\",\"sequence\":23.3,\"operator\":\"liaohj\",\"last_modify\":\"2015-05-31 23:14:44\",\"hide\":0}', '2015-05-31 23:14:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('61', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"294\",\"name\":\"大队模块\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"291\",\"name\":\"中队图片上传\",\"url\":\"/traffic/fileUpload/fileUpload.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"292\",\"name\":\"图片校对\",\"url\":\"/traffic/fileUpload/fileAudit.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"297\",\"name\":\"违规行为管理\",\"url\":\"/traffic/tpViolationAction/tpViolationActionList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"中队管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"299\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"300\",\"name\":\"路口管理\",\"url\":\"/traffic/tpRoad/tpRoadList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"301\",\"name\":\"审核每日统计管理\",\"url\":\"/traffic/tpStatistics/tpStatisticsList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"295\",\"name\":\"图片下载\",\"url\":\"/traffic/tpUploadTemp/tpDownLoadTempOp.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"296\",\"name\":\"匹配记录\",\"url\":\"/traffic/tpEqualLog/tpEqualLogList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"298\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-06-01 13:01:10', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('62', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":302,\"parent_id\":122,\"name\":\"审核记录\",\"url\":\"/traffic/tpDealLogs/tpDealLogsList.jspx\",\"sequence\":24.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-06-01 13:01:29\",\"hide\":0}', '2015-06-01 13:01:29', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('63', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":303,\"parent_id\":294,\"name\":\"审核记录\",\"url\":\"/traffic/tpDealLogs/tpDealLogsList.jspx\",\"sequence\":30.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-06-01 13:10:00\",\"hide\":0}', '2015-06-01 13:09:59', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('64', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：302', '2015-06-01 13:10:26', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('65', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 13:11:23', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('66', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"4\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"301\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 13:11:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('67', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"903308590@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"123\",\"mobile_no\":\"123\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"19972aa4c242de0a495b3628e9ecef2c\",\"nick_name\":\"limh\",\"user_name\":\"limh\",\"user_id\":0,\"admin\":1}', '2015-06-01 13:13:12', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('68', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"903308590@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"123\",\"mobile_no\":\"123\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"39e2922dd5a74ff161239836368baa4e\",\"nick_name\":\"liminghai\",\"user_name\":\"liminghai\",\"user_id\":0,\"admin\":1}', '2015-06-01 13:14:47', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('69', 'traffic', 'limh', 'limh', '5', '{\"app_id\":1,\"menu_id\":304,\"parent_id\":294,\"name\":\"审核每日统计管理\",\"url\":\"/traffic/tpStatistics/tpStatisticsList.jspx\",\"sequence\":30.200000000000003,\"operator\":\"limh\",\"last_modify\":\"2015-06-01 13:56:10\",\"hide\":0}', '2015-06-01 13:56:09', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('70', 'traffic', 'limh', 'limh', '5', '删除的菜单ID：301', '2015-06-01 13:56:18', '操作结果:false', '1');
INSERT INTO `sys_log` VALUES ('71', 'traffic', 'limh', 'limh', '4', '{\"role_id\":\"4\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 13:56:32', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('72', 'traffic', 'limh', 'limh', '5', '删除的菜单ID：301', '2015-06-01 13:56:47', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('73', 'traffic', 'liminghai', 'liminghai', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"limh\",\"user_id\":0,\"admin\":2}', '2015-06-01 15:12:30', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('74', 'traffic', 'liminghai', 'liminghai', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"liminghai\",\"user_id\":0,\"admin\":2}', '2015-06-01 15:12:35', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('75', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:26:39', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('76', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:26:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('77', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"4\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:26:58', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('78', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"297\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:27:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('79', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"liaohj\",\"user_id\":0,\"admin\":2}', '2015-06-01 15:27:59', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('80', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"465087012@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"G1022\",\"mobile_no\":\"13682243708\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"5ho1o2af\",\"nick_name\":\"廖红俊\",\"user_name\":\"liaohj\",\"user_id\":2,\"admin\":1}', '2015-06-01 15:28:19', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('81', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"liaohj\",\"user_id\":0,\"admin\":2}', '2015-06-01 15:30:43', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('82', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:32:36', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('83', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"123\",\"yy_no\":null,\"department\":2,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":\"123\",\"mobile_no\":\"123\",\"status\":0,\"operator\":\"liaohj\",\"password\":null,\"nick_name\":\"admin\",\"user_name\":\"admin\",\"user_id\":0,\"admin\":0}', '2015-06-01 15:33:18', '操作结果:false', '1');
INSERT INTO `sys_log` VALUES ('84', 'traffic', 'admin', 'xxx', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-01 15:35:12', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('85', 'traffic', 'admin', 'xxx', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-02 00:07:11', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('86', 'traffic', 'admin', 'xxx', '4', '{\"role_id\":\"4\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-02 00:07:34', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('87', 'traffic', 'admin', 'xxx', '5', '{\"app_id\":1,\"menu_id\":305,\"parent_id\":122,\"name\":\"违规行为管理\",\"url\":\"/traffic/tpViolationAction/tpViolationActionList.jspx\",\"sequence\":23.1,\"operator\":\"admin\",\"last_modify\":\"2015-06-02 00:08:14\",\"hide\":0}', '2015-06-02 00:08:14', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('88', 'traffic', 'admin', 'xxx', '5', '删除的菜单ID：297', '2015-06-02 00:08:22', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('89', 'traffic', 'admin', 'xxx', '5', '{\"app_id\":1,\"menu_id\":306,\"parent_id\":287,\"name\":\"审核日统计\",\"url\":\"/traffic/tpStatistics/tpSingleStatisticsList.jspx\",\"sequence\":8.1,\"operator\":\"admin\",\"last_modify\":\"2015-06-02 00:09:00\",\"hide\":0}', '2015-06-02 00:09:00', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('90', 'traffic', 'admin', 'xxx', '5', '{\"app_id\":1,\"menu_id\":307,\"parent_id\":287,\"name\":\"审核记录\",\"url\":\"/traffic/tpDealLogs/tpSingleDealLogsList.jspx\",\"sequence\":8.2,\"operator\":\"admin\",\"last_modify\":\"2015-06-02 00:09:38\",\"hide\":0}', '2015-06-02 00:09:39', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('91', 'traffic', 'admin', 'xxx', '4', '{\"role_id\":\"4\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"306\\\",\\\"name\\\":\\\"审核日统计\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"307\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-02 00:09:50', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('92', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"4\",\"role_name\":\"中队管理员\",\"notes\":\"中队管理员\",\"operator\":\"liaohj\"}', '2015-06-03 16:20:25', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('93', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"111\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"111111\",\"mobile_no\":\"11234567890\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"ebea6a05eda52ff5b3d802e6ed4f60ef\",\"nick_name\":\"一中队\",\"user_name\":\"一中队\",\"user_id\":0,\"admin\":1}', '2015-06-03 17:13:51', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('94', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"一中队\",\"old_pwd\":null,\"new_pwd\":\"aadfd024bad47b4402b678c452a2ff6b\",\"new_pwd1\":null}', '2015-06-03 17:14:22', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('95', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"一中队\",\"old_pwd\":null,\"new_pwd\":\"f2e5801c162544d303fee3619ec64054\",\"new_pwd1\":null}', '2015-06-03 17:15:39', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('96', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"一中队\",\"old_pwd\":null,\"new_pwd\":\"a1890afa5d28d6deac2b861cc2342ed5\",\"new_pwd1\":null}', '2015-06-03 17:15:44', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('97', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"一中队\",\"user_id\":0,\"admin\":2}', '2015-06-03 17:16:57', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('98', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"3\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"305\\\",\\\"name\\\":\\\"违规行为管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-03 17:27:13', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('99', 'traffic', 'liaohj', '廖红俊', '4', '{\"role_id\":\"2\",\"data\":\"[{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"291\\\",\\\"name\\\":\\\"中队图片上传\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"292\\\",\\\"name\\\":\\\"图片校对\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"306\\\",\\\"name\\\":\\\"审核日统计\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"287\\\",\\\"menu_id\\\":\\\"307\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"3\\\",\\\"name\\\":\\\"用户管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"4\\\",\\\"name\\\":\\\"角色管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"2\\\",\\\"name\\\":\\\"系统管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"13\\\",\\\"name\\\":\\\"日志查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"1\\\",\\\"menu_id\\\":\\\"285\\\",\\\"name\\\":\\\"修改密码\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"14\\\",\\\"name\\\":\\\"系统分组管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"5\\\",\\\"name\\\":\\\"系统菜单管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"12\\\",\\\"name\\\":\\\"系统资源管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"11\\\",\\\"name\\\":\\\"菜单资源设置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"15\\\",\\\"name\\\":\\\"域名权重管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"10\\\",\\\"menu_id\\\":\\\"286\\\",\\\"name\\\":\\\"FTP配置\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"124\\\",\\\"name\\\":\\\"中队管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"299\\\",\\\"name\\\":\\\"车辆类型管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"122\\\",\\\"menu_id\\\":\\\"300\\\",\\\"name\\\":\\\"路口管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"238\\\",\\\"name\\\":\\\"消息查询\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"236\\\",\\\"menu_id\\\":\\\"284\\\",\\\"name\\\":\\\"通道测试\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"295\\\",\\\"name\\\":\\\"图片下载\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"296\\\",\\\"name\\\":\\\"匹配记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"298\\\",\\\"name\\\":\\\"重要人物管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"303\\\",\\\"name\\\":\\\"审核记录\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true},{\\\"app_id\\\":\\\"1\\\",\\\"parent_id\\\":\\\"294\\\",\\\"menu_id\\\":\\\"304\\\",\\\"name\\\":\\\"审核每日统计管理\\\",\\\"url\\\":\\\"null\\\",\\\"value\\\":null,\\\"hide\\\":\\\"0\\\",\\\"checked\\\":true}]\"}', '2015-06-06 10:09:35', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('100', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"123@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"111\",\"mobile_no\":\"13600000000\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"6a306b7279df9ea433473cb3fcd8df81\",\"nick_name\":\"大队测试\",\"user_name\":\"dd_test\",\"user_id\":0,\"admin\":1}', '2015-08-17 10:28:46', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('101', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"dd_test\",\"old_pwd\":null,\"new_pwd\":\"3fc8fa617f2d3ea3b2568e8fed7a1533\",\"new_pwd1\":null}', '2015-08-17 10:28:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('102', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"132@qq.com\",\"yy_no\":null,\"department\":3,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"222\",\"mobile_no\":\"13500000000\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"3036e93cbbc183580574c62fda69543a\",\"nick_name\":\"中队测试\",\"user_name\":\"zd_test\",\"user_id\":0,\"admin\":1}', '2015-08-17 10:29:44', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('103', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"zd_test\",\"old_pwd\":null,\"new_pwd\":\"b64bf918a14b62a4a2414d08711efcc2\",\"new_pwd1\":null}', '2015-08-17 10:29:48', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('104', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"dd_test\",\"user_id\":0,\"admin\":2}', '2015-08-17 10:32:03', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('105', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"zd_test\",\"user_id\":0,\"admin\":2}', '2015-08-17 10:32:09', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('106', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"liaohj\",\"user_id\":0,\"admin\":1}', '2015-08-17 10:32:12', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('107', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"zd_test\",\"user_id\":0,\"admin\":1}', '2015-08-17 10:37:49', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('108', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"zd_test\",\"user_id\":0,\"admin\":2}', '2015-08-17 10:38:34', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('109', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"dd_test\",\"user_id\":0,\"admin\":1}', '2015-08-17 14:26:35', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('110', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":308,\"parent_id\":122,\"name\":\"车牌号前缀管理\",\"url\":\"/traffic/tpCarNumTitle/tpCarNumTitleList.jspx\",\"sequence\":23.200000000000003,\"operator\":\"liaohj\",\"last_modify\":\"2015-09-01 18:07:11\",\"hide\":0}', '2015-09-01 18:07:16', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('111', 'traffic', 'liaohj', '廖红俊', '5', '[{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"287\",\"name\":\"交通违章\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"1\",\"name\":\"用户中心\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"10\",\"name\":\"系统设置\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"122\",\"name\":\"中队管理\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"16\",\"name\":\"公共菜单\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"236\",\"name\":\"消息通道\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"0\",\"menu_id\":\"294\",\"name\":\"大队模块\",\"url\":\"#\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"291\",\"name\":\"中队图片上传\",\"url\":\"/traffic/fileUpload/fileUpload.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"292\",\"name\":\"图片校对\",\"url\":\"/traffic/fileUpload/fileAudit.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"306\",\"name\":\"审核日统计\",\"url\":\"/traffic/tpStatistics/tpSingleStatisticsList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"287\",\"menu_id\":\"307\",\"name\":\"审核记录\",\"url\":\"/traffic/tpDealLogs/tpSingleDealLogsList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"3\",\"name\":\"用户管理\",\"url\":\"/admin/user_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"4\",\"name\":\"角色管理\",\"url\":\"/admin/role_index.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"2\",\"name\":\"系统管理\",\"url\":\"/admin/app_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"13\",\"name\":\"日志查询\",\"url\":\"/admin/log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"1\",\"menu_id\":\"285\",\"name\":\"修改密码\",\"url\":\"/user/bd_user_update_pwd.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"14\",\"name\":\"系统分组管理\",\"url\":\"/admin/app_group_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"5\",\"name\":\"系统菜单管理\",\"url\":\"/admin/app_menu.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"12\",\"name\":\"系统资源管理\",\"url\":\"/admin/app_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"11\",\"name\":\"菜单资源设置\",\"url\":\"/admin/menu_resource.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"15\",\"name\":\"域名权重管理\",\"url\":\"/admin/domain_weights_list.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"10\",\"menu_id\":\"286\",\"name\":\"FTP配置\",\"url\":\"/traffic/tpFtpConfig/tpFtpConfigList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"124\",\"name\":\"中队管理\",\"url\":\"/group/group_tree.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"299\",\"name\":\"车辆类型管理\",\"url\":\"/traffic/tpCarType/tpCarTypeList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"300\",\"name\":\"路口管理\",\"url\":\"/traffic/tpRoad/tpRoadList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"305\",\"name\":\"违规行为管理\",\"url\":\"/traffic/tpViolationAction/tpViolationActionList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"122\",\"menu_id\":\"308\",\"name\":\"车牌号前缀管理\",\"url\":\"/traffic/tpCarNumTitle/tpCarNumTitleList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"16\",\"menu_id\":\"30\",\"name\":\"公共选项\",\"url\":\"#\",\"value\":null,\"hide\":\"1\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"238\",\"name\":\"消息查询\",\"url\":\"/admin/send_log_query.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"236\",\"menu_id\":\"284\",\"name\":\"通道测试\",\"url\":\"/admin/send_test.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"295\",\"name\":\"图片下载\",\"url\":\"/traffic/tpUploadTemp/tpDownLoadTempOp.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"296\",\"name\":\"匹配记录\",\"url\":\"/traffic/tpEqualLog/tpEqualLogList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"298\",\"name\":\"重要人物管理\",\"url\":\"/traffic/tpVipUser/tpVipUserList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"303\",\"name\":\"审核记录\",\"url\":\"/traffic/tpDealLogs/tpDealLogsList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false},{\"app_id\":\"1\",\"parent_id\":\"294\",\"menu_id\":\"304\",\"name\":\"审核每日统计管理\",\"url\":\"/traffic/tpStatistics/tpStatisticsList.jspx\",\"value\":null,\"hide\":\"0\",\"checked\":false}]', '2015-09-01 18:07:57', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('112', 'traffic', 'liaohj', '廖红俊', '5', '删除的菜单ID：308', '2015-09-01 18:10:39', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('113', 'traffic', 'liaohj', '廖红俊', '5', '{\"app_id\":1,\"menu_id\":309,\"parent_id\":122,\"name\":\"车牌号前缀管理\",\"url\":\"/traffic/tpCarNumTitle/tpCarNumTitleList.jspx\",\"sequence\":25.1,\"operator\":\"liaohj\",\"last_modify\":\"2015-09-01 18:10:52\",\"hide\":0}', '2015-09-01 18:10:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('114', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1522802691@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"110120\",\"mobile_no\":\"15289063451\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"b1bc8ed3e2b8dc2ff98b0f3e144e8257\",\"nick_name\":\"sumh\",\"user_name\":\"sumh\",\"user_id\":0,\"admin\":1}', '2015-09-14 11:37:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('115', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"sumh\",\"old_pwd\":null,\"new_pwd\":\"a90560c1752ddc8b585bfae56ba501cc\",\"new_pwd1\":null}', '2015-09-14 11:53:55', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('116', 'traffic', 'liaohj', '廖红俊', '3', '{}', '2015-09-14 11:54:10', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('117', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1522802598@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"11022\",\"mobile_no\":\"15236457541\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"5d55484f56dd27ad34c29b3272384a2e\",\"nick_name\":\"苏01\",\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 11:55:17', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('118', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1522802598@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"11022\",\"mobile_no\":\"15236457541\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"af1lu0ai\",\"nick_name\":\"苏01\",\"user_name\":\"smh\",\"user_id\":9,\"admin\":1}', '2015-09-14 11:55:26', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('119', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh\",\"old_pwd\":null,\"new_pwd\":\"5b8f4262f4d4710f6f28e5c1f3e48ebe\",\"new_pwd1\":null}', '2015-09-14 11:55:48', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('120', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh\",\"old_pwd\":null,\"new_pwd\":\"230a5bda260d105f774e4fd4e3776328\",\"new_pwd1\":null}', '2015-09-14 11:56:20', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('121', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 12:00:11', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('122', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 12:00:12', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('123', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 12:00:13', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('124', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 12:00:15', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('125', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 12:00:16', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('126', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh\",\"old_pwd\":null,\"new_pwd\":\"33d566bccff71ffe0b0688efe533f1ae\",\"new_pwd1\":null}', '2015-09-14 12:00:18', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('127', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 12:04:04', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('128', 'traffic', 'smh', '苏01', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 12:04:55', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('129', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1014543114@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1200\",\"mobile_no\":\"15826457541\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"48dd052ff94cc392c1cec8fe98ae03db\",\"nick_name\":\"苏02\",\"user_name\":\"smh02\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:39:59', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('130', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1014543114@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1200\",\"mobile_no\":\"15826457541\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"iyqzbzxt\",\"nick_name\":\"一中队测试02\",\"user_name\":\"smh02\",\"user_id\":10,\"admin\":1}', '2015-09-14 13:40:45', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('131', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1522802598@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"11022\",\"mobile_no\":\"15236457541\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"3t3abmd6\",\"nick_name\":\"一中队测试01\",\"user_name\":\"smh\",\"user_id\":9,\"admin\":1}', '2015-09-14 13:41:01', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('132', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:41:30', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('133', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh02\",\"old_pwd\":null,\"new_pwd\":\"a88eb5fd0b09df4c8827e83748cb0e13\",\"new_pwd1\":null}', '2015-09-14 13:41:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('134', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh02\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:42:14', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('135', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh\",\"old_pwd\":null,\"new_pwd\":\"9610a1ff7df156d33b5b86d8dd92b7b5\",\"new_pwd1\":null}', '2015-09-14 13:42:18', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('136', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:42:26', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('137', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh02\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:42:29', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('138', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh02\",\"old_pwd\":null,\"new_pwd\":\"38e6c13f203d4b9bfbcb3821e5b67afa\",\"new_pwd1\":null}', '2015-09-14 13:42:41', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('139', 'traffic', 'smh02', '一中队测试02', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh02\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:43:55', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('140', 'traffic', 'smh02', '一中队测试02', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:43:57', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('141', 'traffic', 'smh02', '一中队测试02', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh02\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:45:25', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('142', 'traffic', 'smh02', '一中队测试02', '3', '{\"username\":\"smh02\",\"old_pwd\":null,\"new_pwd\":\"5bb198c09345a29cd516a1ff05c2c22c\",\"new_pwd1\":null}', '2015-09-14 13:45:40', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('143', 'traffic', 'smh02', '一中队测试02', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh02\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:46:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('144', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"smh\",\"old_pwd\":null,\"new_pwd\":\"c959dd846845ece0c7796d8ebf825045\",\"new_pwd1\":null}', '2015-09-14 13:47:12', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('145', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:47:33', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('146', 'traffic', 'smh', '一中队测试01', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"smh\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:48:03', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('147', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1234@qq.com\",\"yy_no\":null,\"department\":3,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1234\",\"mobile_no\":\"1234\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"dd56697b832b26cc220354aac0103f93\",\"nick_name\":\"二中队测试03\",\"user_name\":\"ssssuu\",\"user_id\":0,\"admin\":1}', '2015-09-14 13:50:30', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('148', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"ssssuu\",\"old_pwd\":null,\"new_pwd\":\"21ba088d29cdedfb8c510c03a8348518\",\"new_pwd1\":null}', '2015-09-14 13:51:05', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('149', 'traffic', 'ssssuu', '二中队测试03', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"ssssuu\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:51:56', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('150', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1234@qq.com\",\"yy_no\":null,\"department\":3,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1234\",\"mobile_no\":\"1234\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"obxjmk8v\",\"nick_name\":\"二中队测试03\",\"user_name\":\"ssssuu\",\"user_id\":11,\"admin\":1}', '2015-09-14 13:53:14', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('151', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1234@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1234\",\"mobile_no\":\"1234\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"nstf0n1s\",\"nick_name\":\"一大队测试03\",\"user_name\":\"ssssuu\",\"user_id\":11,\"admin\":1}', '2015-09-14 13:54:40', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('152', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"1234@qq.com\",\"yy_no\":null,\"department\":2,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1234\",\"mobile_no\":\"1234\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"plsapfrt\",\"nick_name\":\"大队测试03\",\"user_name\":\"ssssuu\",\"user_id\":11,\"admin\":1}', '2015-09-14 13:55:20', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('153', 'traffic', 'ssssuu', '大队测试03', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"ssssuu\",\"user_id\":0,\"admin\":2}', '2015-09-14 13:55:49', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('154', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"123@qq.com\",\"yy_no\":null,\"department\":3,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"1234\",\"mobile_no\":\"18209784562\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"8418098b8c08ae541517f044bc92cf71\",\"nick_name\":\"二中队测试01\",\"user_name\":\"ceshi\",\"user_id\":0,\"admin\":1}', '2015-09-14 17:28:27', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('155', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"ceshi\",\"old_pwd\":null,\"new_pwd\":\"0b4782ac72e4201032caf8c6b8d64c66\",\"new_pwd1\":null}', '2015-09-14 17:28:38', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('156', 'traffic', 'ceshi', '二中队测试01', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"ceshi\",\"user_id\":0,\"admin\":2}', '2015-09-14 17:29:46', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('157', 'traffic', 'liaohj', '廖红俊', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"dd_test\",\"user_id\":0,\"admin\":2}', '2015-09-15 09:30:51', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('158', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"liaohj\",\"old_pwd\":null,\"new_pwd\":\"5d2518907f12a47b4dea5616c599d34d\",\"new_pwd1\":null}', '2015-09-15 09:31:09', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('159', 'traffic', 'liaohj', '廖红俊', '5', '{\"email\":\"12345@qq.com\",\"yy_no\":null,\"department\":3,\"meta_default_data\":1,\"last_modify\":null,\"work_no\":\"12345\",\"mobile_no\":\"1234\",\"status\":3,\"operator\":\"liaohj\",\"password\":\"5a8a37dc04a30cfba9f1f4c981b63158\",\"nick_name\":\"大队测试02\",\"user_name\":\"ceshi02\",\"user_id\":0,\"admin\":1}', '2015-09-15 11:27:17', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('160', 'traffic', 'liaohj', '廖红俊', '3', '{\"username\":\"ceshi02\",\"old_pwd\":null,\"new_pwd\":\"9799adf3ee7b6b6c63d6a80e3bb33247\",\"new_pwd1\":null}', '2015-09-15 11:27:35', '操作结果:true', '1');
INSERT INTO `sys_log` VALUES ('161', 'traffic', 'ceshi02', '大队测试02', '3', '{\"email\":null,\"yy_no\":null,\"department\":0,\"meta_default_data\":0,\"last_modify\":null,\"work_no\":null,\"mobile_no\":null,\"status\":0,\"operator\":null,\"password\":null,\"nick_name\":null,\"user_name\":\"ceshi02\",\"user_id\":0,\"admin\":2}', '2015-09-15 11:38:25', '操作结果:true', '1');

-- ----------------------------
-- Table structure for tp_car_num_title
-- ----------------------------
DROP TABLE IF EXISTS `tp_car_num_title`;
CREATE TABLE `tp_car_num_title` (
  `crt_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长id',
  `crt_num_title` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '汽车车牌号前缀',
  `crt_num_id` int(11) DEFAULT NULL COMMENT '汽车车牌前缀编码',
  PRIMARY KEY (`crt_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='汽车车牌前缀';

-- ----------------------------
-- Records of tp_car_num_title
-- ----------------------------
INSERT INTO `tp_car_num_title` VALUES ('12', '湘M', '1');
INSERT INTO `tp_car_num_title` VALUES ('14', '粤A', '2');
INSERT INTO `tp_car_num_title` VALUES ('15', '粤B', '3');
INSERT INTO `tp_car_num_title` VALUES ('16', '粤C', '4');

-- ----------------------------
-- Table structure for tp_car_type
-- ----------------------------
DROP TABLE IF EXISTS `tp_car_type`;
CREATE TABLE `tp_car_type` (
  `ct_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `ct_type_name` varchar(500) DEFAULT NULL COMMENT '车辆类型名称',
  `ct_type_id` varchar(5) DEFAULT NULL COMMENT '汽车类型编码',
  PRIMARY KEY (`ct_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='车辆类型';

-- ----------------------------
-- Records of tp_car_type
-- ----------------------------
INSERT INTO `tp_car_type` VALUES ('1', '大型汽车', 'dxqc');
INSERT INTO `tp_car_type` VALUES ('2', '小型汽车', 'xxqc');
INSERT INTO `tp_car_type` VALUES ('5', '卡丁车', 'kdc');
INSERT INTO `tp_car_type` VALUES ('6', '摩托车', 'mtc');
INSERT INTO `tp_car_type` VALUES ('7', '跑跑卡丁车', 'ppkdc');

-- ----------------------------
-- Table structure for tp_deal_logs
-- ----------------------------
DROP TABLE IF EXISTS `tp_deal_logs`;
CREATE TABLE `tp_deal_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_id` varchar(100) DEFAULT NULL COMMENT '图片存储id，以逗号隔开',
  `user_name` varchar(100) DEFAULT NULL COMMENT '上传用户名称',
  `user_id` int(11) DEFAULT NULL COMMENT '上传用户ID',
  `certificates_type` tinyint(4) DEFAULT NULL COMMENT '证件类型',
  `car_type_id` int(11) DEFAULT NULL COMMENT '汽车类型',
  `car_num` varchar(128) DEFAULT NULL COMMENT '车牌号码',
  `road_id` int(11) DEFAULT NULL COMMENT '路口',
  `violation_action_id` tinyint(4) DEFAULT NULL COMMENT '违反行为',
  `file_status` tinyint(4) DEFAULT NULL COMMENT '状态  0确认匹配 1确认不匹配 2无效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `deal_user_name` varchar(100) DEFAULT NULL COMMENT '处理人',
  `deal_time` datetime DEFAULT NULL COMMENT '处理时间',
  `sp_standard` varchar(25) NOT NULL COMMENT '超速-标准值',
  `sp_measured` varchar(25) DEFAULT NULL COMMENT '超速-实测值',
  `sp_kilometers` varchar(25) NOT NULL COMMENT '实测-公里数',
  `sp_place_metre` varchar(25) DEFAULT NULL COMMENT '超速-地点米数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COMMENT='处理文件记录表';

-- ----------------------------
-- Records of tp_deal_logs
-- ----------------------------
INSERT INTO `tp_deal_logs` VALUES ('1', '29,28,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('2', '27,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('3', '27,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('4', '27,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('5', '27,26,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('6', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('7', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('8', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('9', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('10', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('11', '22,21,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('12', '29,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('13', '25,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('14', '24,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('15', '23,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('16', '30,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-07-14 08:31:00', 'liaohj', '2015-07-14 08:31:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('17', '35,42,43,33,41,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('18', '35,42,43,33,41,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('19', '34,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('20', '34,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('21', '40,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('22', '40,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('23', '40,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('24', '31,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('25', '31,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('26', '32,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('27', '32,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('28', '32,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('29', '32,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('30', '39,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('31', '38,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('32', '44,', 'liaohj', '2', '1', '2', '湘L', '3', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('33', '44,', 'liaohj', '2', '1', '2', '湘L', '3', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('34', '37,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('35', '36,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-17 09:35:00', 'liaohj', '2015-07-17 09:35:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('36', '45,', 'liaohj', '2', '1', '2', '湘L45166', '2', '1', '1', '2015-07-17 10:24:00', 'liaohj', '2015-07-08 12:09:28', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('37', '67,47,74,65,50,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-20 10:37:00', 'liaohj', '2015-07-20 10:37:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('38', '66,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-20 11:00:00', 'liaohj', '2015-07-20 11:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('39', '46,', 'liaohj', '2', '1', '2', '湘L4F128', '2', '1', '1', '2015-07-20 11:00:00', 'liaohj', '2015-07-08 12:48:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('40', '56,', 'liaohj', '2', '1', '2', '湘L12345', '2', '1', '0', '2015-07-20 16:10:00', 'liaohj', '2015-07-19 16:10:46', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('41', '73,64,58,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-07-20 16:17:00', 'liaohj', '2015-07-20 16:17:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('42', '79,88,89,90,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-14 11:13:00', 'liaohj', '2015-08-14 11:13:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('43', '80,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-14 11:14:00', 'liaohj', '2015-08-14 11:14:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('44', '83,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-14 17:06:00', 'liaohj', '2015-08-14 17:06:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('45', '81,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-14 17:06:00', 'liaohj', '2015-08-14 17:06:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('46', '82,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-14 17:06:00', 'liaohj', '2015-08-14 17:06:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('47', '85,112,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-14 17:06:00', 'liaohj', '2015-08-14 17:06:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('48', '113,114,', 'liaohj', '2', '1', '2', '测试1', '1', '1', '1', '2015-08-14 17:38:00', 'liaohj', '2015-08-14 17:38:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('52', '129,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 12:15:00', 'liaohj', '2015-08-15 12:15:13', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('53', '132,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-15 13:53:00', 'liaohj', '2015-08-15 13:53:36', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('54', '130,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 13:53:00', 'liaohj', '2015-08-15 13:53:36', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('55', '133,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 14:25:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('56', '131,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 14:25:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('57', '128,', 'liaohj', '2', '1', '2', '湘L', '1', '2', '1', '2015-08-15 14:25:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('58', '127,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 14:25:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('59', '137,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 14:25:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('60', '84,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('61', '78,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('62', '76,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('63', '75,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('64', '77,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('65', '87,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('66', '135,86,134,', 'liaohj', '2', '1', '2', '湘L', '2', '1', '1', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('67', '136,', 'liaohj', '2', '1', '2', '湘L', '2', '1', '1', '2015-08-15 14:26:00', 'liaohj', '2015-08-15 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('68', '143,', 'liaohj', '2', '1', '1', '湘L111', '1', '1', '1', '2015-08-15 15:29:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('69', '146,', 'liaohj', '2', '1', '1', '湘L4324324', '1', '2', '1', '2015-08-15 15:29:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('70', '144,', 'liaohj', '2', '1', '2', '湘L2131312', '2', '1', '1', '2015-08-15 15:29:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('71', '147,', 'liaohj', '2', '1', '2', '湘L12313123', '1', '1', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('72', '145,', 'liaohj', '2', '1', '2', '湘L123123123', '1', '2', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('73', '142,', 'liaohj', '2', '1', '2', '湘L213123123', '1', '2', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('74', '141,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('75', '140,', 'liaohj', '2', '1', '2', '湘L', '1', '2', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('76', '139,', 'liaohj', '2', '1', '2', '湘L', '1', '2', '1', '2015-08-15 15:30:00', 'liaohj', '2015-08-15 15:29:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('77', '55,138,', 'liaohj', '2', '1', '0', '湘L', '0', '0', '2', '2015-08-15 15:57:00', 'liaohj', '2015-08-15 15:57:05', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('78', '55,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-15 15:58:00', 'liaohj', '2015-08-15 15:57:34', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('79', '180,', 'liaohj', '2', '1', '2', '粤123123123123', '1', '1', '1', '2015-08-15 16:01:00', 'liaohj', '2015-08-15 16:01:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('80', '179,', 'liaohj', '2', '1', '2', '湘L1231312313', '1', '2', '1', '2015-08-15 16:02:00', 'liaohj', '2015-08-15 16:01:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('81', '178,177,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 16:25:00', 'liaohj', '2015-08-04 16:25:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('82', '176,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:26:00', 'liaohj', '2015-08-04 16:25:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('83', '175,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:26:00', 'liaohj', '2015-08-04 16:25:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('84', '174,', 'liaohj', '2', '1', '2', '湘Lweqweqweqeqw', '1', '1', '1', '2015-08-15 16:26:00', 'liaohj', '2015-08-04 21:22:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('85', '173,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:27:00', 'liaohj', '2015-08-04 21:22:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('86', '171,', 'liaohj', '2', '1', '2', '湘L123123123123', '1', '2', '1', '2015-08-15 16:27:00', 'liaohj', '2015-08-04 21:22:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('87', '172,', 'liaohj', '2', '1', '2', '湘L', '1', '1', '1', '2015-08-15 16:27:00', 'liaohj', '2015-08-04 21:22:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('88', '154,153,167,185,186,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('89', '162,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('90', '161,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('91', '152,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('92', '151,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('93', '170,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:46:00', 'liaohj', '2015-08-15 16:45:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('94', '154,160,150,159,149,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:47:00', 'liaohj', '2015-08-15 16:47:10', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('95', '183,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('96', '166,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('97', '158,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('98', '182,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('99', '165,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('100', '169,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('101', '164,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('102', '148,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('103', '157,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('104', '163,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-08-15 16:49:00', 'liaohj', '2015-08-15 16:49:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('105', '193,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-08-15 17:35:00', 'liaohj', '2015-08-15 17:35:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('106', '192,194,', 'liaohj', '2', '1', '2', '湘L13123', '1', '1', '1', '2015-08-15 17:36:00', 'liaohj', '2015-08-15 17:35:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('107', '191,195,', 'liaohj', '2', '1', '2', '湘L312312', '2', '1', '1', '2015-08-16 13:32:00', 'liaohj', '2015-08-16 13:32:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('108', '190,', 'liaohj', '2', '1', '3', '湘L2323', '2', '1', '1', '2015-08-17 10:04:00', 'liaohj', '2015-08-17 09:41:05', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('109', '190,', 'liaohj', '2', '1', '3', '湘L2323', '2', '1', '1', '2015-08-17 10:04:00', 'liaohj', '2015-08-17 09:41:05', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('110', '188,', 'liaohj', '2', '1', '3', '湘L', '2', '2', '1', '2015-08-17 10:05:00', 'liaohj', '2015-08-17 09:41:05', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('111', '189,187,', 'liaohj', '2', '1', '1003', '湘L', '2', '2', '2', '2015-08-17 10:23:00', 'liaohj', '2015-08-17 10:23:48', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('112', '59,', 'liaohj', '2', '1', '1003', '湘L', '2', '1', '1', '2015-08-17 10:24:00', 'liaohj', '2015-08-17 10:23:48', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('113', '72,196,', 'liaohj', '2', '1', '1001', '湘L其味无穷恶趣味', '3', '1', '1', '2015-08-17 10:25:00', 'liaohj', '2015-08-17 10:24:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('114', '197,', 'zd_test', '7', '1', '1001', '湘L1231', '1', '1', '1', '2015-08-17 10:36:00', 'zd_test', '2015-08-11 11:35:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('115', '197,', 'zd_test', '7', '1', '1002', '湘L', '1', '1', '1', '2015-08-17 10:52:00', 'zd_test', '2015-08-17 10:51:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('116', '49,70,', 'liaohj', '2', '1', '1002', '湘L11122', '2', '1', '1', '2015-08-17 11:19:00', 'liaohj', '2015-08-17 11:11:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('117', '54,52,', 'liaohj', '2', '1', '1002', '湘L33311', '2', '1', '1', '2015-08-17 11:21:00', 'liaohj', '2015-08-17 11:21:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('118', '63,', 'liaohj', '2', '1', '1002', '湘L44433', '2', '1', '1', '2015-08-17 11:21:00', 'liaohj', '2015-08-17 11:21:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('119', '71,48,', 'liaohj', '2', '1', '1002', '湘L44433', '2', '1', '1', '2015-08-17 11:22:00', 'liaohj', '2015-08-17 11:21:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('120', '53,', 'liaohj', '2', '1', '1002', '湘L55555', '2', '1', '1', '2015-08-17 11:22:00', 'liaohj', '2015-08-17 11:21:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('121', '57,198,', 'liaohj', '2', '1', '1002', '湘L123', '2', '2', '1', '2015-08-17 11:56:00', 'liaohj', '2015-08-17 11:56:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('122', '53,199,', 'liaohj', '2', '1', '1002', '湘L1231231', '3', '2', '1', '2015-08-17 12:05:00', 'liaohj', '2015-08-17 12:04:42', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('123', '57,200,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 12:44:00', 'liaohj', '2015-08-17 12:43:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('124', '62,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 12:46:00', 'liaohj', '2015-08-17 12:46:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('125', '61,201,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 12:54:00', 'liaohj', '2015-08-17 12:54:20', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('126', '69,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 14:25:00', 'liaohj', '2015-08-17 14:25:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('127', '51,', 'liaohj', '2', '1', '1002', '湘L', '2', '0', '2', '2015-08-17 14:25:00', 'liaohj', '2015-08-17 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('128', '60,', 'liaohj', '2', '1', '1002', '湘L', '2', '0', '2', '2015-08-17 14:25:00', 'liaohj', '2015-08-17 14:25:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('129', '203,', 'dd_test', '6', '1', '1002', '湘L13', '2', '1', '1', '2015-08-17 14:27:00', 'dd_test', '2015-08-17 14:27:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('130', '203,', 'dd_test', '6', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 14:27:00', 'dd_test', '2015-08-17 14:27:50', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('131', '205,', 'dd_test', '6', '1', '1002', '湘L', '1', '1', '1', '2015-08-17 14:37:00', 'dd_test', '2015-08-17 14:36:57', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('132', '68,206,', 'liaohj', '2', '1', '1003', '湘L', '2', '1', '1', '2015-08-17 15:04:00', 'liaohj', '2015-08-17 15:03:54', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('133', '202,', 'liaohj', '2', '1', '1001', '湘L', '1', '1', '1', '2015-08-17 15:04:00', 'liaohj', '2015-08-17 15:04:42', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('134', '156,', 'liaohj', '2', '1', '1002', '湘L', '1', '2', '1', '2015-08-17 15:06:00', 'liaohj', '2015-08-17 15:06:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('135', '208,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 15:42:00', 'liaohj', '2015-08-17 15:42:30', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('136', '155,', 'liaohj', '2', '1', '1002', '湘L', '1', '0', '2', '2015-08-17 16:32:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('137', '207,', 'liaohj', '2', '1', '1002', '湘L', '1', '0', '2', '2015-08-17 16:32:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('138', '209,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 16:32:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('139', '211,', 'liaohj', '2', '1', '1002', '湘L', '2', '2', '1', '2015-08-17 16:32:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('140', '210,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 16:33:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('141', '204,', 'liaohj', '2', '1', '1002', '湘L', '1', '0', '2', '2015-08-17 16:33:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('142', '181,', 'liaohj', '2', '1', '1002', '湘L', '2', '0', '2', '2015-08-17 16:33:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('143', '184,', 'liaohj', '2', '1', '1002', '湘L', '2', '0', '2', '2015-08-17 16:33:00', 'liaohj', '2015-08-17 16:32:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('144', '60,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 17:59:00', 'liaohj', '2015-08-17 17:58:46', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('145', '210,', 'liaohj', '2', '1', '1002', '湘L', '1', '2', '1', '2015-08-17 18:00:00', 'liaohj', '2015-08-17 18:00:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('146', '60,', 'liaohj', '2', '1', '1002', '湘L', '2', '2', '1', '2015-08-17 18:01:00', 'liaohj', '2015-08-17 18:00:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('147', '168,', 'liaohj', '2', '1', '1002', '湘L', '1', '0', '2', '2015-08-17 18:17:00', 'liaohj', '2015-08-17 18:17:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('148', '60,', 'liaohj', '2', '1', '1002', '湘L', '2', '1', '1', '2015-08-17 18:17:00', 'liaohj', '2015-08-17 18:17:28', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('149', '168,', 'liaohj', '2', '1', '1002', '湘L', '1', '1', '1', '2015-08-17 18:23:00', 'liaohj', '2015-08-17 18:23:07', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('150', '212,', 'liaohj', '2', '1', '1002', '湘L', '2', '0', '2', '2015-08-17 18:36:00', 'liaohj', '2015-08-17 18:35:38', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('151', '213,', 'liaohj', '2', '1', '1002', '湘L', '2', '2', '1', '2015-08-17 18:36:00', 'liaohj', '2015-08-17 18:36:40', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('152', '168,', 'liaohj', '2', '1', '1003', '湘L', '3', '2', '1', '2015-08-18 09:34:00', 'liaohj', '2015-08-18 09:34:29', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('153', '168,', 'liaohj', '2', '1', '1002', '湘L1234', '2', '2', '1', '2015-08-18 10:20:00', 'liaohj', '2015-08-18 10:20:32', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('154', '168,', 'liaohj', '2', '1', '1002', '湘L12345', '1', '1', '0', '2015-08-18 10:34:00', 'liaohj', '2015-08-18 10:33:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('155', '214,', 'liaohj', '2', '1', '1002', '湘L2345', '2', '1', '1', '2015-08-18 10:36:00', 'liaohj', '2015-08-18 10:36:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('156', '168,', 'liaohj', '2', '1', '1002', '湘L3333', '3', '2', '1', '2015-08-18 10:36:00', 'liaohj', '2015-08-18 10:36:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('157', '215,', 'liaohj', '2', '1', '1002', '湘L1234', '1', '1', '1', '2015-08-18 10:59:00', 'liaohj', '2015-08-18 10:59:23', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('158', '216,', 'liaohj', '2', '1', '1002', '湘A1234', '2', '1', '0', '2015-08-18 11:42:00', 'liaohj', '2015-08-18 11:42:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('159', '214,168,', 'liaohj', '2', '1', '1002', '湘L13334', '1', '1', '1', '2015-08-18 14:11:00', 'liaohj', '2015-08-18 14:10:54', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('160', '214,', 'liaohj', '2', '1', '1002', '湘L13231', '1', '2', '1', '2015-08-18 15:09:00', 'liaohj', '2015-08-18 15:09:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('161', '214,', 'liaohj', '2', '1', '1003', '湘L55555', '3', '2', '1', '2015-08-18 15:19:00', 'liaohj', '2015-08-18 15:19:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('162', '214,', 'liaohj', '2', '1', '1003', '湘L44444', '3', '2', '1', '2015-08-18 15:38:00', 'liaohj', '2015-08-18 15:38:34', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('163', '216,', 'liaohj', '2', '1', '1003', '湘L55555', '3', '2', '1', '2015-08-18 15:41:00', 'liaohj', '2015-08-18 15:41:08', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('164', '217,', 'liaohj', '2', '1', '1003', '湘L5555', '3', '2', '1', '2015-08-18 15:42:00', 'liaohj', '2015-08-18 15:41:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('165', '217,', 'liaohj', '2', '1', '1002', '湘L2222', '1', '1', '1', '2015-08-18 15:51:00', 'liaohj', '2015-08-18 15:51:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('166', '218,', 'liaohj', '2', '1', '1003', '湘L2222', '3', '2', '1', '2015-08-18 17:07:00', 'liaohj', '2015-08-18 17:07:36', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('167', '214,', 'liaohj', '2', '1', '1003', '湘L3333', '3', '2', '1', '2015-08-18 17:19:00', 'liaohj', '2015-08-18 17:19:26', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('168', '214,', 'liaohj', '2', '1', '1001', '湘L7777', '2', '2', '1', '2015-08-18 17:20:00', 'liaohj', '2015-08-18 17:19:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('169', '60,', 'liaohj', '2', '1', '1003', '湘L22222', '3', '2', '1', '2015-08-19 14:06:00', 'liaohj', '2015-08-19 14:05:40', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('170', '217,', 'liaohj', '2', '1', '1003', '湘L7777', '3', '2', '1', '2015-08-19 14:25:00', 'liaohj', '2015-08-19 14:25:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('171', '217,', 'liaohj', '2', '1', '1003', '湘L00000', '1', '1', '1', '2015-08-19 14:28:00', 'liaohj', '2015-08-19 14:27:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('172', '60,', 'liaohj', '2', '1', '1001', '湘L5656', '1', '2', '1', '2015-08-19 14:36:00', 'liaohj', '2015-08-10 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('173', '60,', 'liaohj', '2', '1', '1001', '湘L44444', '2', '1', '1', '2015-08-19 14:42:00', 'liaohj', '2015-08-19 14:42:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('174', '60,', 'liaohj', '2', '1', '1002', '湘L99999', '2', '1', '1', '2015-08-19 14:45:00', 'liaohj', '2015-08-19 14:45:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('175', '219,', 'liaohj', '2', '1', '2222', '湘L2424', '2', '1', '2', '2015-08-20 09:57:00', 'liaohj', '2015-08-20 09:57:34', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('176', '219,', 'liaohj', '2', '1', '1111', '湘L3333', '1', '2', '1', '2015-08-20 09:59:00', 'liaohj', '2015-08-20 09:57:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('177', '60,', 'liaohj', '2', '1', '1111', '湘L22222', '1', '1', '1', '2015-08-20 10:09:00', 'liaohj', '2015-08-20 10:08:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('178', '231,', 'liaohj', '2', '1', '2222', '湘L33333', '2', '1', '1', '2015-08-28 11:56:00', 'liaohj', '2015-08-28 11:56:26', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('179', '230,', 'liaohj', '2', '1', '2222', '湘L2222', '3', '2', '1', '2015-08-28 11:56:00', 'liaohj', '2015-08-28 11:56:26', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('180', '232,', 'liaohj', '2', '1', '2222', '湘L4444', '2', '2', '1', '2015-08-28 12:41:00', 'liaohj', '2015-04-03 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('181', '230,', 'liaohj', '2', '1', '2222', '湘L1111', '2', '1', '1', '2015-08-28 13:57:00', 'liaohj', '2013-02-03 02:39:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('182', '230,', 'liaohj', '2', '1', '1111', '湘L77777', '2', '2', '1', '2015-08-28 14:10:00', 'liaohj', '2012-02-05 11:02:33', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('183', '230,', 'liaohj', '2', '1', '2222', '湘L3333', '1', '1', '1', '2015-08-28 14:17:00', 'liaohj', '2011-02-03 22:23:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('184', '230,', 'liaohj', '2', '1', '2222', '湘L2222', '1', '3', '1', '2015-08-28 14:50:00', 'liaohj', '2011-03-22 02:02:23', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('185', '230,', 'liaohj', '2', '1', '2222', '湘Lffff', '2', '3', '1', '2015-08-28 14:57:00', 'liaohj', '2015-08-28 14:56:50', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('186', '230,', 'liaohj', '2', '1', '2222', '湘L2222', '1', '3', '1', '2015-08-28 17:18:00', 'liaohj', '2015-08-28 17:18:06', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('187', '230,', 'liaohj', '2', '1', '2222', '湘L222', '0', '0', '2', '2015-08-28 17:23:00', 'liaohj', '2015-08-28 17:23:10', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('188', '233,', 'liaohj', '2', '1', '2222', '湘L2222', '3', '2', '1', '2015-08-28 17:23:00', 'liaohj', '2015-08-28 17:23:10', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('189', '233,', 'liaohj', '2', '1', '2222', '湘L4442', '3', '2', '1', '2015-08-28 18:00:00', 'liaohj', '2015-08-28 18:00:11', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('190', '220,233,', 'liaohj', '2', '1', '2222', '湘L22222', '3', '1', '1', '2015-08-28 18:01:00', 'liaohj', '2015-08-28 18:00:11', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('191', '220,', 'liaohj', '2', '1', '2222', '湘L22223', '2', '1', '1', '2015-08-28 18:12:00', 'liaohj', '2015-08-28 18:12:48', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('192', '232,', 'liaohj', '2', '1', '2222', '湘L0000', '2', '1', '1', '2015-08-28 18:16:00', 'liaohj', '2015-08-28 18:16:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('193', '231,', 'liaohj', '2', '1', '2222', '湘L', '3', '0', '2', '2015-08-28 18:17:00', 'liaohj', '2015-08-28 18:16:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('194', '230,', 'liaohj', '2', '1', '2222', '湘L23232', '1', '3', '1', '2015-08-28 18:17:00', 'liaohj', '2015-08-28 18:16:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('195', '230,', 'liaohj', '2', '1', '2222', '湘L1232', '2', '2', '1', '2015-08-28 18:18:00', 'liaohj', '2015-08-28 18:18:17', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('196', '233,', 'liaohj', '2', '1', '2222', '湘L3333', '3', '2', '1', '2015-08-28 18:18:00', 'liaohj', '2015-08-28 18:18:17', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('197', '233,', 'liaohj', '2', '1', '2222', '湘L2222', '1', '1', '1', '2015-08-29 09:00:00', 'liaohj', '2011-02-03 09:00:13', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('198', '233,', 'liaohj', '2', '1', '2222', '湘L2222', '1', '1', '1', '2015-08-29 09:01:00', 'liaohj', '2015-08-29 09:00:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('199', '218,', 'liaohj', '2', '1', '2222', '湘L4444', '2', '1', '1', '2015-08-29 09:18:00', 'liaohj', '2015-08-29 09:00:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('200', '218,', 'liaohj', '2', '1', '2222', '湘L8888', '3', '2', '1', '2015-08-29 09:18:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('201', '218,', 'liaohj', '2', '1', '2222', '湘L4444', '2', '1', '1', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:00:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('202', '228,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('203', '227,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('204', '226,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('205', '225,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('206', '224,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('207', '223,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('208', '222,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('209', '221,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('210', '229,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('211', '60,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('212', '233,', 'liaohj', '2', '1', '2222', '湘L', '3', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('213', '233,', 'liaohj', '2', '1', '2222', '湘L', '3', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('214', '233,', 'liaohj', '2', '1', '2222', '湘L', '3', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('215', '233,', 'liaohj', '2', '1', '2222', '湘L', '3', '0', '2', '2015-08-29 09:19:00', 'liaohj', '2015-08-29 09:18:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('216', '235,', 'liaohj', '2', '1', '2222', '湘A5543', '1', '4', '1', '2015-08-29 09:38:00', 'liaohj', '2015-08-03 23:02:33', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('217', '240,', 'liaohj', '2', '1', '2222', '湘L44423', '2', '1', '1', '2015-08-29 09:39:00', 'liaohj', '2015-05-03 22:23:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('218', '240,', 'liaohj', '2', '1', '2222', '湘L44222', '1', '4', '1', '2015-08-29 09:40:00', 'liaohj', '2015-08-29 09:40:20', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('219', '234,', 'liaohj', '2', '1', '2222', '湘l32323', '2', '1', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:40:20', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('220', '240,', 'liaohj', '2', '1', '2222', '湘L3332', '2', '2', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:18', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('221', '240,', 'liaohj', '2', '1', '2222', '湘L32323', '1', '2', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('222', '239,', 'liaohj', '2', '1', '2222', '湘L2223', '2', '2', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('223', '238,', 'liaohj', '2', '1', '2222', '湘L3332', '2', '2', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('224', '237,', 'liaohj', '2', '1', '2222', '湘L2223', '2', '3', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('225', '236,', 'liaohj', '2', '1', '2222', '湘L2231', '2', '3', '1', '2015-08-29 09:42:00', 'liaohj', '2015-08-29 09:42:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('226', '240,', 'liaohj', '2', '1', '2222', '湘L33321', '2', '2', '1', '2015-08-29 09:49:00', 'liaohj', '2015-08-29 09:49:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('227', '235,', 'liaohj', '2', '1', '2222', '湘L3231', '2', '2', '1', '2015-08-29 09:56:00', 'liaohj', '2015-08-01 09:56:30', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('228', '240,', 'liaohj', '2', '1', '2222', '湘L32231', '2', '2', '1', '2015-08-29 09:56:00', 'liaohj', '2015-08-01 09:56:30', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('229', '234,', 'liaohj', '2', '1', '2222', '湘L32113', '2', '2', '1', '2015-08-29 09:56:00', 'liaohj', '2015-08-01 09:56:30', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('230', '239,', 'liaohj', '2', '1', '2222', '湘L2222', '2', '2', '1', '2015-08-29 10:16:00', 'liaohj', '2015-08-29 10:15:10', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('231', '238,', 'liaohj', '2', '1', '2222', '湘L2231', '0', '0', '2', '2015-08-29 10:30:00', 'liaohj', '2015-08-29 10:29:57', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('232', '237,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 10:30:00', 'liaohj', '2015-08-29 10:29:57', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('233', '236,', 'liaohj', '2', '1', '2222', '湘L', '2', '0', '2', '2015-08-29 10:30:00', 'liaohj', '2015-08-29 10:29:57', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('234', '35,', 'liaohj', '2', '1', '2222', '湘L2323', '2', '2', '1', '2015-08-29 10:32:00', 'liaohj', '2015-07-08 22:04:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('235', '73,', 'liaohj', '2', '1', '2222', '湘L6jx99', '2', '1', '1', '2015-08-29 10:34:00', 'liaohj', '2015-07-08 12:48:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('236', '242,', 'liaohj', '2', '1', '2222', '湘L4f444', '2', '2', '1', '2015-08-29 10:41:00', 'liaohj', '2015-07-08 22:04:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('237', '242,', 'liaohj', '2', '1', '3333', '湘L4f44', '1', '1', '1', '2015-08-29 10:42:00', 'liaohj', '2015-07-08 22:04:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('238', '241,', 'liaohj', '2', '1', '2222', '湘Ll6jx9', '2', '3', '1', '2015-08-29 10:43:00', 'liaohj', '2015-07-08 12:48:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('239', '242,', 'liaohj', '2', '1', '2222', '湘L3324', '2', '1', '1', '2015-08-31 15:45:00', 'liaohj', '2015-03-02 02:32:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('240', '242,', 'liaohj', '2', '1', '2222', '湘L3324', '2', '1', '1', '2015-08-31 15:45:00', 'liaohj', '2015-03-02 02:32:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('241', '242,', 'liaohj', '2', '1', '2222', '湘L3324', '2', '1', '1', '2015-08-31 15:45:00', 'liaohj', '2015-03-02 02:32:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('242', '241,', 'liaohj', '2', '1', '2222', '湘L6666', '2', '3', '1', '2015-08-31 15:45:00', 'liaohj', '2015-03-02 02:32:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('243', '244,', 'liaohj', '2', '1', '2222', '湘L2332', '1', '2', '1', '2015-08-31 17:01:00', 'liaohj', '2015-08-31 17:00:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('244', '244,', 'liaohj', '2', '1', '2222', '湘L2332', '1', '2', '1', '2015-08-31 17:01:00', 'liaohj', '2015-08-31 17:00:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('245', '243,', 'liaohj', '2', '1', '2222', '湘L2321', '3', '2', '1', '2015-08-31 17:01:00', 'liaohj', '2015-08-31 17:00:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('246', '244,', 'liaohj', '2', '1', '2222', '湘L231', '0', '0', '2', '2015-08-31 18:14:00', 'liaohj', '2015-08-31 18:08:18', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('247', '243,', 'liaohj', '2', '1', '2222', '湘L2222', '3', '3', '1', '2015-08-31 18:19:00', 'liaohj', '2015-08-31 18:18:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('248', '244,', 'liaohj', '2', '1', '2222', '湘L3333', '0', '3', '1', '2015-08-31 18:31:00', 'liaohj', '2015-08-31 18:30:40', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('249', '244,', 'liaohj', '2', '1', '2222', '湘L4F81', '0', '2', '1', '2015-09-01 09:49:00', 'liaohj', '2015-09-01 09:48:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('250', '243,', 'liaohj', '2', '1', '2222', '湘L6JX99', '3', '2', '1', '2015-09-01 09:49:00', 'liaohj', '2015-09-01 09:48:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('251', '231,', 'liaohj', '2', '1', '2222', '湘L2222', '0', '1', '1', '2015-09-01 09:50:00', 'liaohj', '2015-09-01 09:50:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('252', '240,', 'liaohj', '2', '1', '2222', '湘L2222', '0', '1', '1', '2015-09-01 10:38:00', 'liaohj', '2015-09-01 10:38:09', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('253', '239,', 'liaohj', '2', '1', '2222', '湘L3333', '3', '1', '1', '2015-09-01 10:42:00', 'liaohj', '2015-09-01 10:42:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('254', '236,', 'liaohj', '2', '1', '2222', '湘L3333', '1', '2', '1', '2015-09-01 10:44:00', 'liaohj', '2015-09-01 10:44:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('255', '240,239,244,242,243,241,', 'liaohj', '2', '1', '2222', '湘L3333', '0', '2', '1', '2015-09-01 10:51:00', 'liaohj', '2015-09-01 10:47:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('256', '244,', 'liaohj', '2', '1', '2222', '湘L2222', '2', '2', '1', '2015-09-01 10:59:00', 'liaohj', '2015-09-01 10:59:25', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('257', '242,', 'liaohj', '2', '1', '2222', '湘Mdfsf', '1', '1', '1', '2015-09-01 18:27:00', 'liaohj', '2015-09-01 18:27:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('258', '243,', 'liaohj', '2', '1', '2222', '湘L33we', '3', '2', '1', '2015-09-01 18:28:00', 'liaohj', '2015-09-01 18:27:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('259', '241,', 'liaohj', '2', '1', '2222', '湘M2323', '1', '2', '1', '2015-09-01 18:35:00', 'liaohj', '2015-09-01 18:34:51', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('260', '244,', 'liaohj', '2', '1', '2222', '湘M23131', '3', '2', '1', '2015-09-01 18:35:00', 'liaohj', '2015-09-01 18:35:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('261', '244,', 'liaohj', '2', '1', '2222', '湘M23131', '3', '2', '2', '2015-09-01 18:35:00', 'liaohj', '2015-09-01 18:35:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('262', '244,', 'liaohj', '2', '1', '2222', '湘L1322', '1', '2', '1', '2015-09-01 18:35:00', 'liaohj', '2015-09-01 18:35:43', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('263', '243,', 'liaohj', '2', '1', '2222', '湘L2323', '3', '1', '1', '2015-09-01 18:36:00', 'liaohj', '2015-09-01 18:35:43', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('264', '242,', 'liaohj', '2', '1', '2222', '湘L3244', '2', '2', '1', '2015-09-01 18:36:00', 'liaohj', '2015-09-01 18:36:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('265', '241,', 'liaohj', '2', '1', '2222', '湘M2323', '2', '1', '1', '2015-09-01 18:36:00', 'liaohj', '2015-09-01 18:36:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('266', '241,', 'liaohj', '2', '1', '2222', '湘M2323', '2', '1', '1', '2015-09-01 18:36:00', 'liaohj', '2015-09-01 18:36:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('267', '246,', 'liaohj', '2', '1', '3333', '粤Bl4f81', '1', '2', '1', '2015-09-02 09:24:00', 'liaohj', '2015-03-03 09:23:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('268', '245,', 'liaohj', '2', '1', '2222', '湘L6JX99', '1', '1', '1', '2015-09-02 09:24:00', 'liaohj', '2015-03-03 09:23:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('269', '248,', 'liaohj', '2', '1', '3333', '湘L3232', '2', '3', '1', '2015-09-02 09:26:00', 'liaohj', '2015-09-02 09:26:06', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('270', '248,', 'liaohj', '2', '1', '3333', '粤B2231', '3', '2', '1', '2015-09-02 09:26:00', 'liaohj', '2015-09-02 09:26:23', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('271', '247,', 'liaohj', '2', '1', '2222', '粤C2323', '3', '2', '1', '2015-09-02 09:26:00', 'liaohj', '2015-09-02 09:26:23', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('272', '233,', 'liaohj', '2', '1', '4', '湘L', '3', '0', '2', '2015-09-10 12:02:00', 'liaohj', '2015-09-10 12:02:32', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('273', '246,', 'liaohj', '2', '1', '4', '湘L', '1', '0', '2', '2015-09-10 12:02:00', 'liaohj', '2015-09-10 12:02:32', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('274', '249,', 'liaohj', '2', '1', '4', '湘L6jx99', '2', '2', '1', '2015-09-10 12:03:00', 'liaohj', '2015-02-23 12:48:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('275', '249,', 'liaohj', '2', '1', '4', '湘L6jx99', '2', '2', '1', '2015-09-10 12:03:00', 'liaohj', '2015-02-23 12:48:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('276', '250,', 'liaohj', '2', '1', '1', '湘L2323', '1', '3', '1', '2015-09-10 14:13:00', 'liaohj', '2015-09-10 14:13:17', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('277', '248,', 'liaohj', '2', '1', '1', '湘L', '2', '0', '2', '2015-09-10 14:13:00', 'liaohj', '2015-09-10 14:13:17', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('278', '250,', 'liaohj', '2', '1', '6', '湘L2333', '3', '1', '1', '2015-09-10 14:44:00', 'liaohj', '2015-09-10 14:43:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('279', '249,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-09-10 14:54:00', 'liaohj', '2015-09-10 14:54:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('280', '254,', 'liaohj', '2', '1', '1', '湘L2231', '3', '2', '1', '2015-09-10 14:56:00', 'liaohj', '2013-02-21 14:54:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('281', '251,', 'liaohj', '2', '1', '2', '湘L3232', '3', '1', '1', '2015-09-10 14:56:00', 'liaohj', '2012-02-03 14:54:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('282', '253,', 'liaohj', '2', '1', '5', '湘L2323', '3', '1', '1', '2015-09-10 14:56:00', 'liaohj', '2012-02-23 14:54:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('283', '252,', 'liaohj', '2', '1', '6', '湘L2313', '3', '3', '1', '2015-09-10 14:57:00', 'liaohj', '2012-02-22 14:54:01', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('284', '261,', 'liaohj', '2', '1', '2', '湘LFFFF', '1', '1', '1', '2015-09-10 16:15:00', 'liaohj', '2015-09-10 16:15:34', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('285', '260,', 'liaohj', '2', '1', '2', '湘LEEEE', '1', '1', '1', '2015-09-10 16:16:00', 'liaohj', '2015-09-10 16:15:34', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('286', '262,', 'liaohj', '2', '1', '2', '湘L2322', '3', '2', '1', '2015-09-10 17:03:00', 'liaohj', '2015-09-10 17:03:26', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('287', '259,', 'liaohj', '2', '1', '2', '湘L32123', '1', '1', '1', '2015-09-10 17:07:00', 'liaohj', '2015-09-10 17:07:28', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('288', '259,', 'liaohj', '2', '1', '2', '湘L32123', '1', '1', '1', '2015-09-10 17:07:00', 'liaohj', '2015-09-10 17:07:28', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('289', '257,', 'liaohj', '2', '1', '2', '湘L2323', '1', '1', '1', '2015-09-10 17:08:00', 'liaohj', '2015-09-10 23:23:32', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('290', '257,', 'liaohj', '2', '1', '2', '湘L2323', '1', '1', '1', '2015-09-10 17:08:00', 'liaohj', '2015-09-10 23:23:32', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('291', '261,', 'liaohj', '2', '1', '2', '湘L2323', '1', '1', '1', '2015-09-10 17:35:00', 'liaohj', '2015-09-10 17:16:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('292', '260,', 'liaohj', '2', '1', '5', '湘L3232', '1', '2', '1', '2015-09-10 17:36:00', 'liaohj', '2015-09-10 12:03:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('293', '259,267,', 'liaohj', '2', '1', '6', '湘L3232', '1', '1', '1', '2015-09-10 18:04:00', 'liaohj', '2015-09-10 18:03:11', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('294', '258,', 'liaohj', '2', '1', '6', '湘L3322', '1', '3', '1', '2015-09-10 18:04:00', 'liaohj', '2015-09-10 23:33:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('295', '258,', 'liaohj', '2', '1', '6', '湘L3322', '1', '3', '1', '2015-09-10 18:04:00', 'liaohj', '2015-09-10 23:33:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('296', '256,', 'liaohj', '2', '1', '6', '湘L3233', '1', '3', '1', '2015-09-10 18:04:00', 'liaohj', '2015-09-10 23:03:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('297', '257,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-10 18:07:00', 'liaohj', '2015-09-10 18:07:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('298', '263,', 'liaohj', '2', '1', '2', '湘L3231', '2', '1', '1', '2015-09-10 18:08:00', 'liaohj', '2015-09-10 21:23:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('299', '266,', 'liaohj', '2', '1', '2', '湘L3231', '1', '3', '1', '2015-09-10 18:08:00', 'liaohj', '2015-09-10 02:02:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('300', '265,249,', 'liaohj', '2', '1', '2', '湘L', '2', '0', '2', '2015-09-14 09:02:00', 'liaohj', '2015-09-14 09:02:50', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('301', '263,255,', 'liaohj', '2', '1', '2', '湘L12234', '1', '1', '1', '2015-09-14 09:03:00', 'liaohj', '2015-09-14 09:03:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('302', '263,255,', 'liaohj', '2', '1', '2', '湘L12234', '1', '1', '1', '2015-09-14 09:03:00', 'liaohj', '2015-09-14 09:03:14', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('303', '271,', 'liaohj', '2', '1', '2', '湘L3232', '2', '2', '1', '2015-09-14 10:34:00', 'liaohj', '2015-09-14 10:34:25', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('304', '271,', 'liaohj', '2', '1', '2', '湘L2131', '2', '3', '1', '2015-09-14 10:35:00', 'liaohj', '2015-09-14 10:35:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('305', '270,', 'liaohj', '2', '1', '2', '粤A44444', '2', '2', '1', '2015-09-14 10:37:00', 'liaohj', '2015-09-14 10:37:25', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('306', '269,', 'liaohj', '2', '1', '2', '粤B23134', '2', '1', '0', '2015-09-14 10:45:00', 'liaohj', '2015-09-14 10:42:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('307', '272,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-14 10:52:00', 'liaohj', '2015-09-14 10:53:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('308', '273,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-14 11:12:00', 'liaohj', '2015-09-14 11:13:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('309', '274,', 'liaohj', '2', '1', '6', '粤B2322', '4', '5', '1', '2015-09-14 11:15:00', 'liaohj', '2015-09-14 11:15:31', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('310', '273,', 'liaohj', '2', '1', '2', '湘L', '4', '0', '2', '2015-09-14 11:17:00', 'liaohj', '2015-09-14 11:18:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('311', '273,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-14 11:18:00', 'liaohj', '2015-09-14 11:18:56', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('312', '257,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-14 14:09:00', 'liaohj', '2015-09-14 14:09:48', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('313', '275,', 'smh', '9', '1', '5', '湘L12345', '3', '2', '0', '2015-09-14 14:21:00', 'smh', '2015-09-14 16:21:22', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('314', '275,', 'smh', '9', '1', '5', '湘L45678', '4', '3', '1', '2015-09-14 14:45:00', 'smh', '2015-09-14 14:46:23', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('315', '275,', 'smh', '9', '1', '2', '湘L', '0', '0', '2', '2015-09-14 14:47:00', 'smh', '2015-09-14 14:48:08', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('316', '275,', 'smh', '9', '1', '2', '湘L12323', '2', '2', '1', '2015-09-14 14:50:00', 'smh', '2015-09-14 14:51:11', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('317', '277,', 'ssssuu', '11', '1', '2', '湘L23344', '3', '2', '1', '2015-09-14 15:27:00', 'ssssuu', '2015-09-14 15:28:46', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('318', '278,', 'smh02', '10', '1', '2', '湘L12345', '4', '4', '0', '2015-09-14 15:49:00', 'smh02', '2015-09-14 15:51:42', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('319', '268,256,', 'liaohj', '2', '1', '2', '粤Bffer', '1', '4', '1', '2015-09-14 16:11:00', 'liaohj', '2015-09-14 16:09:44', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('320', '268,256,', 'liaohj', '2', '1', '2', '粤Bffer', '1', '4', '2', '2015-09-14 16:11:00', 'liaohj', '2015-09-14 16:09:44', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('321', '279,', 'smh02', '10', '1', '7', '粤C12345', '2', '1', '1', '2015-09-14 16:18:00', 'smh02', '2015-09-14 16:16:43', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('322', '278,280,', 'smh02', '10', '1', '5', '湘L6788', '2', '1', '1', '2015-09-14 16:21:00', 'smh02', '2015-09-14 16:21:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('323', '278,280,', 'smh02', '10', '1', '5', '湘L6788', '2', '1', '1', '2015-09-14 16:21:00', 'smh02', '2015-09-14 16:21:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('324', '278,280,', 'smh02', '10', '1', '5', '湘L6788', '2', '1', '1', '2015-09-14 16:21:00', 'smh02', '2015-09-14 16:21:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('325', '278,280,', 'smh02', '10', '1', '5', '湘L6788', '2', '1', '1', '2015-09-14 16:21:00', 'smh02', '2015-09-14 16:21:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('326', '278,280,', 'smh02', '10', '1', '5', '湘L6788', '2', '1', '1', '2015-09-14 16:21:00', 'smh02', '2015-09-14 16:21:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('327', '285,282,279,281,284,286,283,', 'smh02', '10', '1', '5', '湘L23412', '2', '1', '1', '2015-09-14 16:43:00', 'smh02', '2015-09-14 16:43:52', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('328', '278,283,286,', 'smh02', '10', '1', '2', '湘L', '2', '0', '2', '2015-09-14 16:44:00', 'smh02', '2015-09-14 16:45:55', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('329', '285,279,280,284,281,282,', 'smh02', '10', '1', '2', '湘L', '2', '0', '2', '2015-09-14 16:46:00', 'smh02', '2015-09-14 16:46:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('330', '287,', 'smh02', '10', '1', '6', '粤B6768', '1', '1', '1', '2015-09-14 16:49:00', 'smh02', '2015-09-14 16:49:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('331', '289,', 'smh', '9', '1', '5', '粤C12345', '4', '2', '1', '2015-09-14 17:07:00', 'smh', '2015-09-14 17:08:07', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('332', '276,', 'smh', '9', '1', '5', '粤C45689', '1', '3', '1', '2015-09-14 17:10:00', 'smh', '2015-09-14 17:11:04', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('333', '290,', 'smh', '9', '1', '6', '粤C12309', '1', '1', '1', '2015-09-14 17:20:00', 'smh', '2015-09-14 17:13:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('334', '288,', 'smh02', '10', '1', '5', '湘L12345', '1', '1', '0', '2015-09-14 17:22:00', 'smh02', '2015-09-14 17:23:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('341', '292,', 'ceshi', '12', '1', '1', '湘M99999', '3', '3', '1', '2015-09-14 17:51:00', 'ceshi', '2015-09-14 17:52:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('343', '263,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-14 18:32:00', 'liaohj', '2015-09-14 18:32:06', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('344', '295,', 'liaohj', '2', '1', '7', '粤B23134', '3', '3', '0', '2015-09-14 18:33:00', 'liaohj', '2015-09-14 18:32:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('345', '294,', 'liaohj', '2', '1', '7', '粤B12345', '2', '3', '2', '2015-09-15 09:48:00', 'liaohj', '2015-09-15 09:47:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('346', '295,', 'liaohj', '2', '1', '7', '粤B1234', '1', '1', '1', '2015-09-15 09:48:00', 'liaohj', '2015-09-15 09:48:15', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('347', '265,', 'liaohj', '2', '1', '7', '粤B12345', '1', '2', '0', '2015-09-15 10:26:00', 'liaohj', '2015-09-15 10:25:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('348', '264,', 'liaohj', '2', '1', '6', '粤B12345', '2', '1', '0', '2015-09-15 10:27:00', 'liaohj', '2015-09-15 10:26:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('349', '264,', 'liaohj', '2', '1', '6', '粤B12345', '2', '1', '0', '2015-09-15 10:27:00', 'liaohj', '2015-09-15 10:26:58', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('350', '299,', 'liaohj', '2', '1', '2', '湘L3232', '1', '1', '1', '2015-09-15 10:44:00', 'liaohj', '2015-09-15 10:44:19', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('351', '298,', 'liaohj', '2', '1', '2', '湘L3213', '1', '1', '1', '2015-09-15 10:44:00', 'liaohj', '2015-09-15 10:44:43', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('352', '298,', 'liaohj', '2', '1', '2', '湘L3213', '1', '1', '1', '2015-09-15 10:44:00', 'liaohj', '2015-09-15 10:44:43', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('353', '297,', 'liaohj', '2', '1', '2', '湘L3332', '2', '3', '1', '2015-09-15 10:59:00', 'liaohj', '2011-09-15 10:56:12', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('354', '296,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-15 11:48:00', 'liaohj', '2015-09-15 11:47:39', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('355', '299,', 'liaohj', '2', '1', '2', '湘L32131', '1', '3', '1', '2015-09-15 11:48:00', 'liaohj', '2015-09-13 02:03:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('356', '299,', 'liaohj', '2', '1', '7', '粤B12345', '1', '2', '0', '2015-09-15 13:52:00', 'liaohj', '2015-09-10 13:41:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('357', '298,', 'liaohj', '2', '1', '7', '粤B12345', '2', '1', '1', '2015-09-15 13:54:00', 'liaohj', '2015-09-10 13:47:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('358', '300,', 'smh', '9', '1', '7', '粤B12345', '2', '1', '1', '2015-09-15 14:01:00', 'smh', '2015-09-15 14:01:54', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('359', '300,', 'smh', '9', '1', '7', '粤B12345', '2', '1', '1', '2015-09-15 14:01:00', 'smh', '2015-09-15 14:01:54', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('360', '301,', 'smh02', '10', '1', '7', '粤B12345', '2', '1', '0', '2015-09-15 14:25:00', 'smh02', '2015-09-15 14:25:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('361', '302,', 'smh02', '10', '1', '6', '粤C45321', '2', '1', '1', '2015-09-15 14:32:00', 'smh02', '2015-09-15 14:32:44', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('362', '302,', 'smh02', '10', '1', '7', '粤B12345', '2', '1', '0', '2015-09-15 14:33:00', 'smh02', '2015-09-15 14:33:42', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('363', '303,', 'smh02', '10', '1', '7', '粤B12345', '1', '2', '0', '2015-09-15 14:40:00', 'smh02', '2015-09-15 14:41:18', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('364', '304,', 'smh', '9', '1', '5', '粤C00000', '3', '1', '1', '2015-09-15 14:58:00', 'smh', '2015-09-15 14:59:36', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('365', '305,', 'ceshi', '12', '1', '7', '粤B12340', '3', '3', '1', '2015-09-15 16:57:00', 'ceshi', '2015-09-15 16:58:15', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('366', '306,', 'smh02', '10', '1', '2', '湘L1234', '1', '1', '1', '2015-09-16 09:35:00', 'smh02', '2015-10-09 11:55:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('367', '306,', 'smh02', '10', '1', '5', '粤C8778', '1', '2', '1', '2015-09-16 09:40:00', 'smh02', '2015-09-16 09:41:42', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('368', '268,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-16 12:05:00', 'liaohj', '2015-09-16 11:47:18', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('369', '274,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-16 12:05:00', 'liaohj', '2015-09-16 12:05:21', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('370', '308,307,', 'smh', '9', '1', '5', '粤C6767', '2', '1', '1', '2015-09-16 15:46:00', 'smh', '2015-09-16 15:47:35', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('371', '273,', 'liaohj', '2', '1', '2', '湘L42331', '1', '3', '1', '2015-09-16 16:35:00', 'liaohj', '2015-09-16 16:35:27', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('372', '262,', 'liaohj', '2', '1', '2', '湘L', '3', '0', '2', '2015-09-16 17:16:00', 'liaohj', '2015-09-16 17:16:24', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('373', '312,311,309,', 'liaohj', '2', '1', '2', '湘L4231', '1', '2', '1', '2015-09-16 17:17:00', 'liaohj', '2015-09-16 02:03:03', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('374', '321,320,322,319,318,', 'liaohj', '2', '1', '2', '湘L3123', '3', '2', '1', '2015-09-16 17:44:00', 'liaohj', '2015-09-16 17:44:04', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('375', '314,', 'liaohj', '2', '1', '2', '湘L', '0', '0', '2', '2015-09-17 09:00:00', 'liaohj', '2015-09-17 09:00:11', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('376', '297,', 'liaohj', '2', '1', '2', '湘L', '4', '0', '2', '2015-09-17 09:00:00', 'liaohj', '2015-09-17 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('377', '296,', 'liaohj', '2', '1', '2', '湘L', '4', '0', '2', '2015-09-17 09:00:00', 'liaohj', '2015-09-17 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('378', '265,', 'liaohj', '2', '1', '2', '湘L', '1', '0', '2', '2015-09-17 09:00:00', 'liaohj', '2015-09-17 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('379', '327,326,325,324,323,', 'liaohj', '2', '1', '2', '湘L3242', '3', '2', '1', '2015-09-17 09:00:00', 'liaohj', '2015-09-17 21:02:02', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('380', '330,329,328,', 'smh02', '10', '1', '5', '粤C1234', '4', '1', '1', '2015-09-17 09:01:00', 'smh02', '2015-09-18 10:02:41', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('381', '310,', 'liaohj', '2', '1', '2', '粤A3142', '1', '1', '1', '2015-09-17 09:37:00', 'liaohj', '2015-09-17 09:37:38', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('382', '316,', 'liaohj', '2', '1', '2', '粤B', '4', '0', '2', '2015-09-17 09:37:00', 'liaohj', '2015-09-17 00:00:00', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('383', '332,331,', 'smh', '9', '1', '5', '粤C5666', '1', '2', '1', '2015-09-17 10:10:00', 'smh', '2015-09-17 10:10:53', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('384', '333,335,337,336,334,', 'smh', '9', '1', '7', '粤B12345', '2', '2', '0', '2015-09-17 10:18:00', 'smh', '2015-09-17 10:17:47', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('385', '338,339,340,', 'smh', '9', '1', '2', '湘L1231', '3', '1', '1', '2015-09-17 10:23:00', 'smh', '2015-09-17 10:23:45', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('386', '342,341,344,343,', 'smh', '9', '1', '2', '湘L1111', '1', '1', '1', '2015-09-17 10:32:00', 'smh', '2015-09-17 10:32:18', '', null, '', null);
INSERT INTO `tp_deal_logs` VALUES ('396', '55,', 'liaohj', '2', '1', '2', '湘L33444', '6', '5', '1', '2017-11-23 18:11:42', 'liaohj', '2017-11-23 18:01:39', '20', '50', '50', '50');
INSERT INTO `tp_deal_logs` VALUES ('397', '326,327,', 'liaohj', '2', '1', '2', '湘L', '3', '0', '2', '2017-11-23 18:12:13', 'liaohj', '2017-11-23 00:00:00', '20', '50', '50', '50');
INSERT INTO `tp_deal_logs` VALUES ('398', '246,', 'liaohj', '2', '1', '1', '湘L64564', '6', '2', '1', '2017-11-23 18:12:49', 'liaohj', '2017-11-23 03:02:01', '20', '50', '50', '50');
INSERT INTO `tp_deal_logs` VALUES ('400', '345,', 'liaohj', '2', '1', '1', '粤A11111', '6', '2', '1', '2017-11-23 18:14:20', 'liaohj', '2017-11-23 18:13:21', '345', '345', '345', '345');

-- ----------------------------
-- Table structure for tp_download_statistics
-- ----------------------------
DROP TABLE IF EXISTS `tp_download_statistics`;
CREATE TABLE `tp_download_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `download_num` int(11) DEFAULT NULL COMMENT '下载数',
  `date` date DEFAULT NULL COMMENT '时间',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人ID',
  `user_name` varchar(128) DEFAULT NULL COMMENT '操作人name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='下载审核统计表';

-- ----------------------------
-- Records of tp_download_statistics
-- ----------------------------
INSERT INTO `tp_download_statistics` VALUES ('1', '2', '2015-07-20', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('2', '2', '2015-08-14', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('3', '82', '2015-08-15', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('4', '1', '2015-08-16', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('5', '64', '2015-08-17', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('6', '5', '2015-08-17', '6', 'dd_test');
INSERT INTO `tp_download_statistics` VALUES ('7', '20', '2015-08-18', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('8', '6', '2015-08-19', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('9', '2', '2015-08-20', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('10', '7', '2015-08-28', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('11', '17', '2015-08-29', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('12', '3', '2015-09-02', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('13', '11', '2015-09-10', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('14', '13', '2015-09-11', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('15', '4', '2015-09-14', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('16', '11', '2015-09-14', '11', 'ssssuu');
INSERT INTO `tp_download_statistics` VALUES ('17', '1', '2015-09-15', '11', 'ssssuu');
INSERT INTO `tp_download_statistics` VALUES ('18', '1', '2015-09-15', '13', 'ceshi02');
INSERT INTO `tp_download_statistics` VALUES ('19', '57', '2015-09-16', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('20', '2', '2015-09-16', '11', 'ssssuu');
INSERT INTO `tp_download_statistics` VALUES ('21', '44', '2015-09-17', '2', 'liaohj');
INSERT INTO `tp_download_statistics` VALUES ('22', '28', '2015-09-17', '11', 'ssssuu');
INSERT INTO `tp_download_statistics` VALUES ('23', '10', '2015-09-17', '6', 'dd_test');
INSERT INTO `tp_download_statistics` VALUES ('24', '1', '2017-11-23', '2', 'liaohj');

-- ----------------------------
-- Table structure for tp_equal_log
-- ----------------------------
DROP TABLE IF EXISTS `tp_equal_log`;
CREATE TABLE `tp_equal_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `vp_id` int(11) DEFAULT NULL COMMENT '重要人物ID',
  `user_name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `car_no` varchar(100) DEFAULT NULL COMMENT '车牌号',
  `create_time` datetime DEFAULT NULL COMMENT '时间',
  `equal_type` tinyint(4) DEFAULT NULL COMMENT '方式',
  `road_id` int(11) DEFAULT NULL COMMENT '路口',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='匹配记录表';

-- ----------------------------
-- Records of tp_equal_log
-- ----------------------------
INSERT INTO `tp_equal_log` VALUES ('1', '1', '11111', '湘L12345', '2015-07-20 16:10:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('2', '1', '11111', '湘L12345', '2015-08-18 10:34:00', '1', '1');
INSERT INTO `tp_equal_log` VALUES ('3', '2', 'chen', '湘A1234', '2015-08-18 11:42:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('4', '4', 'test2', '粤B23134', '2015-09-14 10:45:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('7', '1', '11111', '湘L12345', '2015-09-14 17:22:00', '1', '1');
INSERT INTO `tp_equal_log` VALUES ('10', '3', 'test1', '粤B12345', '2015-09-15 10:27:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('11', '3', 'test1', '粤B12345', '2015-09-15 10:27:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('12', '4', 'test2', '粤B12345', '2015-09-15 13:52:00', '2', '1');
INSERT INTO `tp_equal_log` VALUES ('13', '4', 'test2', '粤B12345', '2015-09-15 14:25:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('14', '4', 'test2', '粤B12345', '2015-09-15 14:33:00', '1', '2');
INSERT INTO `tp_equal_log` VALUES ('15', '4', 'test2', '粤B12345', '2015-09-15 14:40:00', '2', '1');
INSERT INTO `tp_equal_log` VALUES ('16', '4', 'test2', '粤B12345', '2015-09-17 10:18:00', '2', '2');

-- ----------------------------
-- Table structure for tp_filter_file
-- ----------------------------
DROP TABLE IF EXISTS `tp_filter_file`;
CREATE TABLE `tp_filter_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `file_id` int(11) DEFAULT NULL COMMENT '文件id',
  `file_down_status` tinyint(4) DEFAULT NULL COMMENT '图片下载状态 0 未下载 1 已下载',
  `creatime` datetime DEFAULT NULL COMMENT '创建时间',
  `road_id` int(11) DEFAULT NULL COMMENT '路口Id',
  `car_num` varchar(128) DEFAULT NULL COMMENT '车牌号',
  `violation_action_id` tinyint(4) DEFAULT NULL COMMENT '违规行为编码',
  `car_type_id` varchar(5) DEFAULT NULL COMMENT '汽车类型编码',
  `user_id` int(11) DEFAULT NULL COMMENT '上传用户id',
  `sp_standard` varchar(25) DEFAULT NULL COMMENT '超速-标准值',
  `sp_measured` varchar(25) DEFAULT NULL COMMENT '超速-实测值',
  `sp_kilometers` varchar(25) DEFAULT NULL COMMENT '超速-公里数',
  `sp_place_metre` varchar(25) DEFAULT NULL COMMENT '超速-地点米数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=utf8 COMMENT='过滤文件表';

-- ----------------------------
-- Records of tp_filter_file
-- ----------------------------
INSERT INTO `tp_filter_file` VALUES ('1', '45', '1', '2015-07-17 10:24:00', '2', '湘L6JX99', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('2', '46', '1', '2015-07-20 11:00:00', '2', '湘L', '0', '4', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('3', '113', '1', '2015-08-14 17:38:00', '1', '测试1', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('4', '114', '1', '2015-08-14 17:38:00', '1', '测试1', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('7', '111', '1', '2015-08-15 10:54:00', '1', null, null, null, null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('11', '124', '1', '2015-08-15 11:24:00', '1', null, null, null, null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('12', '129', '1', '2015-08-15 12:15:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('13', '133', '1', '2015-08-15 14:25:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('14', '131', '1', '2015-08-15 14:25:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('15', '128', '1', '2015-08-15 14:25:00', '1', '湘L', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('16', '137', '1', '2015-08-15 14:25:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('17', '135', '1', '2015-08-15 14:26:00', '2', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('18', '86', '1', '2015-08-15 14:26:00', '2', '湘L', '0', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('19', '134', '1', '2015-08-15 14:26:00', '2', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('20', '136', '1', '2015-08-15 14:26:00', '2', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('21', '143', '1', '2015-08-15 15:29:00', '1', '湘L111', '1', '1', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('22', '146', '1', '2015-08-15 15:29:00', '1', '湘L4324324', '2', '1', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('23', '144', '1', '2015-08-15 15:29:00', '2', '湘L2131312', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('24', '147', '1', '2015-08-15 15:30:00', '1', '湘L12313123', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('25', '145', '1', '2015-08-15 15:30:00', '1', '湘L123123123', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('26', '142', '1', '2015-08-15 15:30:00', '1', '湘L213123123', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('27', '141', '1', '2015-08-15 15:30:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('28', '140', '1', '2015-08-15 15:30:00', '1', '湘L', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('29', '139', '1', '2015-08-15 15:30:00', '1', '湘L', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('30', '180', '1', '2015-08-15 16:01:00', '1', '粤123123123123', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('31', '179', '1', '2015-08-15 16:02:00', '1', '湘L1231312313', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('32', '178', '1', '2015-08-15 16:25:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('33', '177', '1', '2015-08-15 16:25:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('34', '174', '1', '2015-08-15 16:26:00', '1', '湘Lweqweqweqeqw', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('35', '171', '1', '2015-08-15 16:27:00', '1', '湘L123123123123', '2', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('36', '172', '1', '2015-08-15 16:27:00', '1', '湘L', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('37', '192', '1', '2015-08-15 17:36:00', '1', '湘L13123', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('38', '194', '1', '2015-08-15 17:36:00', '1', '湘L13123', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('39', '191', '1', '2015-08-16 13:32:00', '2', '湘L312312', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('40', '195', '1', '2015-08-16 13:32:00', '2', '湘L312312', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('41', '190', '1', '2015-08-17 10:04:00', '2', '湘L2323', '1', '3', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('43', '188', '1', '2015-08-17 10:05:00', '2', '湘L', '2', '3', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('44', '59', '1', '2015-08-17 10:24:00', '2', '湘L', '1', '1003', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('45', '72', '1', '2015-08-17 10:25:00', '3', '湘L其味无穷恶趣味', '1', '1001', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('46', '196', '1', '2015-08-17 10:25:00', '3', '湘L其味无穷恶趣味', '1', '1001', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('48', '197', '1', '2015-08-17 10:52:00', '1', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('49', '49', '1', '2015-08-17 11:19:00', '2', '湘L', '0', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('50', '70', '1', '2015-08-17 11:19:00', '2', '湘L11122', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('51', '54', '1', '2015-08-17 11:21:00', '2', '湘L2231', '2', '1', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('52', '52', '1', '2015-08-17 11:21:00', '2', '湘L2313', '3', '6', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('53', '63', '1', '2015-08-17 11:21:00', '2', '湘L44433', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('54', '71', '1', '2015-08-17 11:22:00', '2', '湘L44433', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('55', '48', '1', '2015-08-17 11:22:00', '2', '湘L', '0', '1', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('58', '198', '1', '2015-08-17 11:56:00', '2', '湘L123', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('59', '53', '1', '2015-08-17 12:05:00', '3', '湘L2323', '1', '5', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('60', '199', '1', '2015-08-17 12:05:00', '3', '湘L1231231', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('61', '57', '1', '2015-08-17 12:44:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('62', '200', '1', '2015-08-17 12:44:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('63', '62', '1', '2015-08-17 12:46:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('64', '61', '1', '2015-08-17 12:54:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('65', '201', '1', '2015-08-17 12:54:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('69', '69', '1', '2015-08-17 14:25:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('71', '203', '1', '2015-08-17 14:27:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('72', '205', '1', '2015-08-17 14:37:00', '1', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('73', '68', '1', '2015-08-17 15:04:00', '2', '湘L13334', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('74', '206', '1', '2015-08-17 15:04:00', '2', '湘L', '1', '1003', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('75', '202', '1', '2015-08-17 15:04:00', '1', '湘L', '1', '1001', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('76', '156', '1', '2015-08-17 15:06:00', '1', '湘L', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('77', '208', '1', '2015-08-17 15:42:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('79', '209', '1', '2015-08-17 16:32:00', '2', '湘L', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('80', '211', '1', '2015-08-17 16:32:00', '2', '湘L', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('83', '210', '1', '2015-08-17 18:00:00', '1', '湘L', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('87', '213', '0', '2015-08-17 18:36:00', '2', '湘L', '2', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('92', '215', '0', '2015-08-18 10:59:00', '1', '湘L1234', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('94', '168', '1', '2015-08-18 14:11:00', '1', '湘L13334', '1', '1002', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('98', '216', '1', '2015-08-18 15:41:00', '3', '湘L55555', '2', '1003', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('101', '214', '1', '2015-08-18 17:20:00', '2', '湘L7777', '2', '1001', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('104', '217', '1', '2015-08-19 14:28:00', '1', '湘L00000', '1', '1003', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('108', '219', '1', '2015-08-20 09:59:00', '1', '湘L3333', '2', '1111', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('123', '220', '0', '2015-08-28 18:12:00', '2', '湘L22223', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('124', '232', '1', '2015-08-28 18:16:00', '2', '湘L0000', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('126', '230', '1', '2015-08-28 18:18:00', '2', '湘L1232', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('130', '218', '1', '2015-08-29 09:18:00', '2', '湘L4444', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('144', '235', '1', '2015-08-29 09:56:00', '2', '湘L3231', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('146', '234', '1', '2015-08-29 09:56:00', '2', '湘L32113', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('148', '35', '1', '2015-08-29 10:32:00', '2', '湘L2323', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('149', '73', '1', '2015-08-29 10:34:00', '2', '湘L6jx99', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('164', '231', '0', '2015-09-01 09:50:00', '0', '湘L2222', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('167', '236', '0', '2015-09-01 10:44:00', '1', '湘L3333', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('168', '240', '0', '2015-09-01 10:51:00', '0', '湘L3333', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('169', '239', '0', '2015-09-01 10:51:00', '0', '湘L3333', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('171', '242', '0', '2015-09-01 10:51:00', '0', '湘L3244', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('175', '242', '0', '2015-09-01 18:27:00', '1', '湘L3244', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('180', '243', '1', '2015-09-01 18:36:00', '3', '湘L2323', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('181', '242', '0', '2015-09-01 18:36:00', '2', '湘L3244', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('182', '241', '1', '2015-09-01 18:36:00', '2', '湘M2323', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('183', '241', '0', '2015-09-01 18:36:00', '2', '湘M2323', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('185', '245', '1', '2015-09-02 09:24:00', '1', '湘L6JX99', '1', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('188', '247', '0', '2015-09-02 09:26:00', '3', '粤C2323', '2', '2222', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('192', '250', '1', '2015-09-10 14:44:00', '3', '湘L2333', '1', '6', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('195', '254', '1', '2015-09-10 14:56:00', '3', '湘L2231', '2', '1', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('196', '251', '1', '2015-09-10 14:56:00', '3', '湘L3232', '1', '2', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('197', '253', '1', '2015-09-10 14:56:00', '3', '湘L2323', '1', '5', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('198', '252', '1', '2015-09-10 14:57:00', '3', '湘L2313', '3', '6', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('203', '259', '0', '2015-09-10 17:07:00', '1', '湘L32123', '1', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('206', '261', '0', '2015-09-10 17:35:00', '1', '湘L2323', '1', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('209', '260', '0', '2015-09-10 17:36:00', '1', '湘L3232', '2', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('210', '259', '0', '2015-09-10 18:04:00', '1', '湘L3232', '1', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('211', '267', '0', '2015-09-10 18:04:00', '1', '湘L3232', '1', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('212', '258', '0', '2015-09-10 18:04:00', '1', '湘L3322', '3', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('213', '258', '0', '2015-09-10 18:04:00', '1', '湘L3322', '3', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('217', '266', '1', '2015-09-10 18:08:00', '1', '湘L3231', '3', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('219', '255', '1', '2015-09-14 09:03:00', '1', '湘L12234', '1', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('220', '263', '0', '2015-09-14 09:03:00', '1', '湘L12234', '1', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('221', '255', '0', '2015-09-14 09:03:00', '1', '湘L12234', '1', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('223', '271', '0', '2015-09-14 10:35:00', '2', '湘L2131', '3', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('224', '270', '1', '2015-09-14 10:37:00', '2', '粤A44444', '2', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('227', '275', '1', '2015-09-14 14:50:00', '2', '湘L12323', '2', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('228', '277', '0', '2015-09-14 15:27:00', '3', '湘L23344', '2', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('230', '256', '0', '2015-09-14 16:11:00', '1', '粤Bffer', '4', '03', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('234', '278', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('235', '280', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('236', '278', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('237', '280', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('238', '278', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('239', '280', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('240', '278', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('241', '280', '0', '2015-09-14 16:21:00', '2', '湘L6788', '1', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('249', '287', '1', '2015-09-14 16:49:00', '1', '粤B6768', '1', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('250', '289', '1', '2015-09-14 17:07:00', '4', '粤C12345', '2', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('251', '276', '1', '2015-09-14 17:10:00', '1', '粤C45689', '3', '02', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('252', '290', '1', '2015-09-14 17:20:00', '1', '粤C12309', '1', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('256', '291', '1', '2015-09-14 17:38:00', '3', '粤A34567', '1', '01', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('257', '291', '0', '2015-09-14 17:38:00', '4', '湘M9087', '1', '11122', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('259', '292', '1', '2015-09-14 17:51:00', '3', '湘M99999', '3', '04', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('264', '298', '1', '2015-09-15 10:44:00', '1', '湘L3213', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('267', '298', '0', '2015-09-15 13:54:00', '2', '粤B12345', '1', 'ppkdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('268', '300', '1', '2015-09-15 14:01:00', '2', '粤B12345', '1', 'ppkdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('269', '300', '0', '2015-09-15 14:01:00', '2', '粤B12345', '1', 'ppkdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('271', '304', '1', '2015-09-15 14:58:00', '3', '粤C00000', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('272', '305', '1', '2015-09-15 16:57:00', '3', '粤B12340', '3', 'ppkdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('274', '306', '1', '2015-09-16 09:40:00', '1', '粤C8778', '2', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('275', '308', '1', '2015-09-16 15:46:00', '2', '粤C6767', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('276', '307', '1', '2015-09-16 15:46:00', '2', '粤C6767', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('277', '273', '0', '2015-09-16 16:35:00', '1', '湘L42331', '3', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('278', '312', '0', '2015-09-16 17:17:00', '1', '湘L4231', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('279', '311', '0', '2015-09-16 17:17:00', '1', '湘L4231', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('280', '309', '1', '2015-09-16 17:17:00', '1', '湘L4231', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('281', '321', '1', '2015-09-16 17:44:00', '3', '湘L3123', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('282', '320', '1', '2015-09-16 17:44:00', '3', '湘L3123', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('283', '322', '1', '2015-09-16 17:44:00', '3', '湘L3123', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('284', '319', '1', '2015-09-16 17:44:00', '3', '湘L3123', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('285', '318', '1', '2015-09-16 17:44:00', '3', '湘L3123', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('288', '325', '0', '2015-09-17 09:00:00', '3', '湘L3242', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('289', '324', '0', '2015-09-17 09:00:00', '3', '湘L3242', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('290', '323', '1', '2015-09-17 09:00:00', '3', '湘L3242', '2', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('291', '330', '0', '2015-09-17 09:01:00', '4', '粤C1234', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('292', '329', '0', '2015-09-17 09:01:00', '4', '粤C1234', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('293', '328', '0', '2015-09-17 09:01:00', '4', '粤C1234', '1', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('294', '310', '0', '2015-09-17 09:37:00', '1', '粤A3142', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('295', '332', '1', '2015-09-17 10:10:00', '1', '粤C5666', '2', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('296', '331', '1', '2015-09-17 10:10:00', '1', '粤C5666', '2', 'kdc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('297', '338', '1', '2015-09-17 10:23:00', '3', '湘L1231', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('298', '339', '1', '2015-09-17 10:23:00', '3', '湘L1231', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('299', '340', '1', '2015-09-17 10:23:00', '3', '湘L1231', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('300', '342', '1', '2015-09-17 10:32:00', '1', '湘L1111', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('301', '341', '1', '2015-09-17 10:32:00', '1', '湘L1111', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('302', '344', '1', '2015-09-17 10:32:00', '1', '湘L1111', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('303', '343', '1', '2015-09-17 10:32:00', '1', '湘L1111', '1', 'xxqc', null, null, null, null, null);
INSERT INTO `tp_filter_file` VALUES ('313', '55', '0', '2017-11-23 18:11:42', '6', '湘L33444', '5', 'xxqc', '2', '20', '50', '50', '50');
INSERT INTO `tp_filter_file` VALUES ('314', '246', '0', '2017-11-23 18:12:49', '6', '湘L64564', '2', 'dxqc', '2', '20', '50', '50', '50');
INSERT INTO `tp_filter_file` VALUES ('316', '345', '1', '2017-11-23 18:14:20', '6', '粤A11111', '2', 'dxqc', '2', '345', '345', '345', '345');

-- ----------------------------
-- Table structure for tp_road
-- ----------------------------
DROP TABLE IF EXISTS `tp_road`;
CREATE TABLE `tp_road` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `road_name` varchar(500) DEFAULT NULL COMMENT '路口名称',
  `road_code` varchar(128) DEFAULT NULL COMMENT '路口代码',
  `road_speed` tinyint(4) NOT NULL DEFAULT '1' COMMENT '超速标识，1为路口违法标识，2为超速违法标识',
  PRIMARY KEY (`cr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='路口管理';

-- ----------------------------
-- Records of tp_road
-- ----------------------------
INSERT INTO `tp_road` VALUES ('1', '天桥十字路口', '111122222', '1');
INSERT INTO `tp_road` VALUES ('2', '四完小', '33333333', '1');
INSERT INTO `tp_road` VALUES ('3', '工业园', '555', '1');
INSERT INTO `tp_road` VALUES ('4', '员村', '1190', '1');
INSERT INTO `tp_road` VALUES ('5', '科韵路路口', '002', '1');
INSERT INTO `tp_road` VALUES ('6', '中环西路', '0022', '2');

-- ----------------------------
-- Table structure for tp_statistics
-- ----------------------------
DROP TABLE IF EXISTS `tp_statistics`;
CREATE TABLE `tp_statistics` (
  `cr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `up_num` int(11) DEFAULT NULL COMMENT '每日上传数',
  `checked` int(11) DEFAULT NULL COMMENT '已核对',
  `invalid` int(11) DEFAULT NULL COMMENT '无效',
  `date` date DEFAULT NULL COMMENT '时间',
  `user_id` int(11) DEFAULT NULL COMMENT '操作人ID',
  `user_name` varchar(128) DEFAULT NULL COMMENT '操作人name',
  PRIMARY KEY (`cr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='审核统计表';

-- ----------------------------
-- Records of tp_statistics
-- ----------------------------
INSERT INTO `tp_statistics` VALUES ('1', '8', '0', '0', '2015-07-13', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('2', '15', '0', '24', '2015-07-14', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('3', '1', '0', '0', '2015-07-15', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('4', '3', '1', '27', '2015-07-17', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('5', '27', '2', '9', '2015-07-20', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('6', '5', '0', '0', '2015-08-06', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('7', '8', '0', '0', '2015-08-07', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('8', '27', '2', '10', '2015-08-14', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('9', '80', '30', '41', '2015-08-15', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('10', '1', '2', '0', '2015-08-16', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('11', '15', '38', '11', '2015-08-17', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('12', '1', '2', '0', '2015-08-17', '7', 'zd_test');
INSERT INTO `tp_statistics` VALUES ('13', '2', '3', '0', '2015-08-17', '6', 'dd_test');
INSERT INTO `tp_statistics` VALUES ('14', '5', '18', '0', '2015-08-18', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('15', '0', '6', '0', '2015-08-19', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('16', '1', '2', '1', '2015-08-20', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('17', '10', '0', '0', '2015-08-24', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('18', '4', '18', '2', '2015-08-28', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('19', '9', '25', '17', '2015-08-29', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('20', '2', '9', '1', '2015-08-31', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('21', '0', '22', '1', '2015-09-01', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('22', '4', '5', '0', '2015-09-02', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('23', '19', '24', '5', '2015-09-10', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('24', '9', '12', '10', '2015-09-14', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('25', '4', '6', '1', '2015-09-14', '9', 'smh');
INSERT INTO `tp_statistics` VALUES ('26', '2', '2', '0', '2015-09-14', '11', 'ssssuu');
INSERT INTO `tp_statistics` VALUES ('27', '11', '21', '9', '2015-09-14', '10', 'smh02');
INSERT INTO `tp_statistics` VALUES ('28', '2', '7', '0', '2015-09-14', '12', 'ceshi');
INSERT INTO `tp_statistics` VALUES ('33', '4', '11', '2', '2015-09-15', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('34', '2', '3', '0', '2015-09-15', '9', 'smh');
INSERT INTO `tp_statistics` VALUES ('35', '3', '4', '0', '2015-09-15', '10', 'smh02');
INSERT INTO `tp_statistics` VALUES ('36', '1', '1', '0', '2015-09-15', '12', 'ceshi');
INSERT INTO `tp_statistics` VALUES ('37', '1', '2', '0', '2015-09-16', '10', 'smh02');
INSERT INTO `tp_statistics` VALUES ('38', '14', '9', '3', '2015-09-16', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('39', '2', '2', '0', '2015-09-16', '9', 'smh');
INSERT INTO `tp_statistics` VALUES ('40', '5', '6', '5', '2015-09-17', '2', 'liaohj');
INSERT INTO `tp_statistics` VALUES ('41', '3', '3', '0', '2015-09-17', '10', 'smh02');
INSERT INTO `tp_statistics` VALUES ('42', '14', '14', '0', '2015-09-17', '9', 'smh');
INSERT INTO `tp_statistics` VALUES ('60', '1', '3', '2', '2017-11-23', '2', 'liaohj');

-- ----------------------------
-- Table structure for tp_upload_temp
-- ----------------------------
DROP TABLE IF EXISTS `tp_upload_temp`;
CREATE TABLE `tp_upload_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '所属用户名称',
  `user_id` int(11) DEFAULT NULL COMMENT '所属用户ID',
  `road_id` int(11) DEFAULT NULL COMMENT '路口Id',
  `file_name` varchar(100) DEFAULT NULL COMMENT '文件名',
  `file_addr` varchar(200) DEFAULT NULL COMMENT '图片存储地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `file_status` tinyint(4) DEFAULT NULL COMMENT '图片状态 0未处理 1已处理',
  `deal_time` datetime DEFAULT NULL COMMENT '处理时间',
  `check_road_id` int(32) DEFAULT NULL COMMENT '所属路口name',
  `file_index` int(11) DEFAULT NULL COMMENT '检索file_index',
  `car_num` varchar(50) DEFAULT NULL COMMENT '车牌号',
  `car_type_name` varchar(50) DEFAULT NULL COMMENT '汽车类型',
  `illegal_time` datetime DEFAULT NULL COMMENT '违法时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8 COMMENT='文件上传临时表';

-- ----------------------------
-- Records of tp_upload_temp
-- ----------------------------
INSERT INTO `tp_upload_temp` VALUES ('21', 'liaohj', '2', '0', 'Chrysanthemum.jpg', '/udata/2015/07/13/4eba3e0d-2445-4010-80cf-6de7f7a410a5.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('22', 'liaohj', '2', '0', 'Desert.jpg', '/udata/2015/07/13/29a8d25a-069a-4c5e-b33b-fe4bff21c5c9.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('23', 'liaohj', '2', '0', 'Hydrangeas.jpg', '/udata/2015/07/13/4d4c48a0-57a2-432a-98f1-ca4b6c2b60a7.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('24', 'liaohj', '2', '0', 'Jellyfish.jpg', '/udata/2015/07/13/d68d4396-fb92-4dee-b3b8-8d8d072d1b20.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('25', 'liaohj', '2', '0', 'Koala.jpg', '/udata/2015/07/13/d37b851e-8913-4dfb-9d2c-275bf4c267bc.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('26', 'liaohj', '2', '0', 'Lighthouse.jpg', '/udata/2015/07/13/fba60da1-3443-4237-b852-28beb28f4dab.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('27', 'liaohj', '2', '0', 'Penguins.jpg', '/udata/2015/07/13/f5160d65-d21e-4ded-a598-f98d715fd0fb.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('28', 'liaohj', '2', '0', 'Tulips.jpg', '/udata/2015/07/13/5c9e073d-bea5-468e-ab26-40f426ec3350.jpg', '2015-07-13 09:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('29', 'liaohj', '2', '2', '_2015070__808160__2170_11.jpg', '/udata/2015/07/14/387c3178-e6c8-4a64-9053-baf7a5ad2644.jpg', '2015-07-14 08:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('30', 'liaohj', '2', '0', '20150708__122050__411_7.jpg', '/udata/2015/07/14/e96f0e89-5036-4ffa-9d44-155bac7072f0.jpg', '2015-07-14 08:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('31', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/14/97e2e16c-f365-4685-a708-1bb7af5fc15f.jpg', '2015-07-14 08:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('32', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/14/8078cf5f-57f5-4556-a351-5d4e981d0548.jpg', '2015-07-14 08:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('33', 'liaohj', '2', '0', '20150708__171600__201_3.jpg', '/udata/2015/07/14/94648180-5009-4e03-982f-01bdee7dd585.jpg', '2015-07-14 08:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('34', 'liaohj', '2', '2', '_2015070__820212__4021_2.jpg', '/udata/2015/07/14/90cd07cc-27de-4b8b-8851-1cf8f6fecefb.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('35', 'liaohj', '2', '2', '_2015070__822204__5100_1.jpg', '/udata/2015/07/14/17fec8eb-209a-4d6d-95a7-8dd632de2bfa.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('36', 'liaohj', '2', '2', '20150708__072949__460_12.jpg', '/udata/2015/07/14/43cf661d-dcf9-49a8-b062-e1b60591d45e.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('37', 'liaohj', '2', '2', '20150708__091739__830_10.jpg', '/udata/2015/07/14/49e687ed-bce1-466f-89ca-8f963d0a6007.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('38', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/14/0fe45d2c-3143-4071-a081-35d481e35d75.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('39', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/14/35fe2256-16ed-464f-977c-af709c52b48e.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('40', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/14/053d69c4-6ca8-4f3f-a86a-7926fe6cf59a.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('41', 'liaohj', '2', '2', '20150708__124803__780_5.jpg', '/udata/2015/07/14/f87edb1f-e9a3-47ea-9610-37cd47ebd521.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('42', 'liaohj', '2', '2', '20150708__171447__620_4.jpg', '/udata/2015/07/14/8720dabd-9e25-4777-b688-bb5b1320ec2b.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('43', 'liaohj', '2', '2', '20150708__171600__201_3.jpg', '/udata/2015/07/14/487426b1-9264-4ab4-b532-9e6b4aff9f06.jpg', '2015-07-14 08:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('44', 'liaohj', '2', '3', '20150708__115549__701_9.jpg', '/udata/2015/07/15/7ee682fa-cb88-452b-8b7d-ddb80d533226.jpg', '2015-07-15 11:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('45', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/17/e324687f-d478-4097-a7f8-443f7289167f.jpg', '2015-07-17 09:35:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('46', 'liaohj', '2', '2', '20150708__171447__620_4.jpg', '/udata/2015/07/17/96292b05-fb0f-4197-bc07-2552b6aeae72.jpg', '2015-07-17 10:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('47', 'liaohj', '2', '2', '20150708__171600__201_3.jpg', '/udata/2015/07/17/c7f7f2dc-edd9-4aaa-bc44-a2dbfd8134c5.jpg', '2015-07-17 10:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('48', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/20/0ef3f45a-9160-4fb6-a4d9-116edc3e4655.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('49', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/20/f5bc7288-5394-4058-89cf-d4b2e5ae7814.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('50', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/20/346a529e-526b-4379-a2d7-6d7ac3a08f88.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('51', 'liaohj', '2', '2', '20150708__072949__460_12.jpg', '/udata/2015/07/20/e9ca5690-c625-4616-a965-ca29efde81bd.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('52', 'liaohj', '2', '2', '20150708__091739__830_10.jpg', '/udata/2015/07/20/68190359-95e7-4712-a2d1-a966a21f9631.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('53', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/20/cb416c15-5db6-4a7e-95f7-565a28a882df.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('54', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/20/a29d713f-c8dd-4fed-bad6-8c733ac4a6a2.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('55', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/20/609f49ad-ce5b-4b3a-a0ea-6bd69b9a615f.jpg', '2015-07-20 10:30:00', '1', '2017-11-23 18:11:42', '6', '396', '湘L33444', '小型汽车', '2017-11-23 18:01:39');
INSERT INTO `tp_upload_temp` VALUES ('56', 'liaohj', '2', '2', '20150708__124803__780_5.jpg', '/udata/2015/07/20/4d0b628a-dc85-4b87-8e56-841a94e2ce8b.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('57', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/20/14ed4892-de61-4a59-a372-9909f003bf75.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('58', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/20/9f8e4cce-bdce-4789-9481-ad8fecea11f2.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('59', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/20/3835b02b-35b9-47a4-b898-fcfd0430630a.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('60', 'liaohj', '2', '2', '20150708__072949__460_12.jpg', '/udata/2015/07/20/10b3b49b-f5be-49ed-8e3d-437840bccc4c.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('61', 'liaohj', '2', '2', '20150708__091739__830_10.jpg', '/udata/2015/07/20/fededa04-6bf1-4659-84af-4308874d19e9.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('62', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/20/594662cd-bae6-4171-be74-a5c51151dd6b.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('63', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/20/4247ed9d-4929-4e95-aad6-a84dfdb447b5.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('64', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/20/88f4e618-af59-449a-b1ae-55e216af3424.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('65', 'liaohj', '2', '2', '20150708__124803__780_5.jpg', '/udata/2015/07/20/5d5a6b73-6537-4dc2-a4e1-a4bc721e59c6.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('66', 'liaohj', '2', '2', '_2015070__820212__4021_2.jpg', '/udata/2015/07/20/aba8d66c-a797-49ac-854a-9c8cfe96642a.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('67', 'liaohj', '2', '2', '_2015070__822204__5100_1.jpg', '/udata/2015/07/20/7c17f795-bd16-494d-97ef-602cfe0b6e47.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('68', 'liaohj', '2', '2', '20150708__072949__460_12.jpg', '/udata/2015/07/20/fa846062-e5e7-4180-aaa8-2890a6dd3a4a.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('69', 'liaohj', '2', '2', '20150708__091739__830_10.jpg', '/udata/2015/07/20/c53e587a-fde9-41e1-9d34-a2c77640d92d.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('70', 'liaohj', '2', '2', '20150708__115549__701_9.jpg', '/udata/2015/07/20/12c626e5-2b0d-4eb8-9e0a-5ad2b601d8c0.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('71', 'liaohj', '2', '2', '20150708__120928__890_8.jpg', '/udata/2015/07/20/05ebea06-7b35-43ed-8b97-0f41fd5ffc87.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('72', 'liaohj', '2', '2', '20150708__122050__411_7.jpg', '/udata/2015/07/20/38f89fbe-eb2a-41b0-80c3-cfb1f7f449cf.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('73', 'liaohj', '2', '2', '20150708__124803__780_5.jpg', '/udata/2015/07/20/b82a30a4-49cf-4427-ac83-891e343f7ed7.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('74', 'liaohj', '2', '2', '20150708__171447__620_4.jpg', '/udata/2015/07/20/0eaaa870-8ebd-420b-9787-f016c3c7d6ad.jpg', '2015-07-20 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('75', 'liaohj', '2', '2', 'QQ截图20150626165917.png', '/udata/2015/08/06/ec1d5316-1ab0-4bee-899f-c2b54a19c54c.png', '2015-08-06 14:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('76', 'liaohj', '2', '2', 'QQ截图20150803110557.png', '/udata/2015/08/06/f9056230-4f26-40a7-9d62-f46c0d5d8983.png', '2015-08-06 14:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('77', 'liaohj', '2', '2', 'QQ图片20150704161613.png', '/udata/2015/08/06/6476819f-8169-4d4d-8ae6-cc96ef1d0bf9.png', '2015-08-06 14:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('78', 'liaohj', '2', '2', 'svn.txt', '/udata/2015/08/06/5ab697e5-7358-459d-81c6-3f29fbcf4d2f.txt', '2015-08-06 14:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('79', 'liaohj', '2', '2', '班级.png', '/udata/2015/08/06/0abca1c1-d427-4ec5-ba0c-2c9aa0dab2dc.png', '2015-08-06 14:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('80', 'liaohj', '2', '0', '查询.txt', '/udata/2015/08/07/d664987f-7668-4d91-af51-68cd22b02e38.txt', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('81', 'liaohj', '2', '0', '公司信息.txt', '/udata/2015/08/07/dc88d60d-3d52-497d-bf03-a6c4663356d4.txt', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('82', 'liaohj', '2', '0', '例子.html', '/udata/2015/08/07/ce98e75b-9480-45e3-b5f8-f400bc54276c.html', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('83', 'liaohj', '2', '0', '妙味课堂--联动下拉菜单.html', '/udata/2015/08/07/9c6033ce-439a-4dfc-9515-6df1782bc324.html', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('84', 'liaohj', '2', '0', 'test.html', '/udata/2015/08/07/68574d67-b416-46e4-a5cc-24330ed6fd32.html', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('85', 'liaohj', '2', '0', 'view-source_suc.bd.haochibang.cn_admin_menu_resource.jspx.html', '/udata/2015/08/07/49a12462-a126-4698-a08e-36c87cb8dd19.html', '2015-08-07 10:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('86', 'liaohj', '2', '0', '123.txt', '/udata/2015/08/07/d8d44bdf-71e0-486c-bf06-bbe353e914fa.txt', '2015-08-07 16:28:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('87', 'liaohj', '2', '0', 'la.html', '/udata/2015/08/07/26e7b3be-503d-4c9f-ae77-8de84d0c8c3f.html', '2015-08-07 16:28:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('137', 'liaohj', '2', '1', 'test_file-one.jpg', '/udata/2015/08/15/a20dd26e-15d7-42a0-9e18-0c84f49f164e.jpg', '2015-08-15 14:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('138', 'liaohj', '2', '1', '0fd764cdedf1dfc196a658c65f6655f1.jpg', '/udata/2015/08/15/92a36600-8a9f-4699-b45b-07b58f2abcbc.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('139', 'liaohj', '2', '1', '4K.jpg', '/udata/2015/08/15/e9fabbc4-62d2-4d33-9802-439c8abf83c0.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('140', 'liaohj', '2', '1', 'c51a64406b5c7d4bff5f7b72372a6f96.jpg', '/udata/2015/08/15/7770d221-de76-48d3-9d9d-45bbbf2d4b6a.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('141', 'liaohj', '2', '1', 'test_file-three.jpg', '/udata/2015/08/15/f3ca2211-76dc-422e-bffe-82443d47df2f.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('142', 'liaohj', '2', '1', 'test_file-two.jpg', '/udata/2015/08/15/310c16fc-1ff8-48b9-a388-48185e102b3e.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('143', 'liaohj', '2', '1', '车牌.jpg', '/udata/2015/08/15/6e7b28a6-336c-4d81-8afa-5587c58b000c.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('144', 'liaohj', '2', '1', '烤鱼.jpg', '/udata/2015/08/15/bc68a830-7d15-4075-9240-53880c7d4e03.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('145', 'liaohj', '2', '1', '周记大排档.jpg', '/udata/2015/08/15/12b9f324-54ae-4d9a-902e-2fd90824ec80.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('146', 'liaohj', '2', '1', '珠江啤酒.jpg', '/udata/2015/08/15/46f276bc-593d-40b1-ab9b-d2f02044844a.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('147', 'liaohj', '2', '1', '抓拍2.jpg', '/udata/2015/08/15/5937b7e9-d0e7-47c7-ab7d-ec3402d20ad3.jpg', '2015-08-15 15:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('148', 'liaohj', '2', '1', '2ca3e523-dd69-4fee-a4aa-bb319896293e.jpg', '/udata/2015/08/15/b06bdc87-cc9e-4796-9f94-bc9e55c66060.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('149', 'liaohj', '2', '1', '4dabe275-0aa7-4344-8ca1-971de1890e38.jpg', '/udata/2015/08/15/7ec8e157-93a9-4677-b1bb-4956d76bd980.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('150', 'liaohj', '2', '1', '4dbb54e2-960b-4377-97c3-15b777bd791a.jpg', '/udata/2015/08/15/c545602f-83c7-41b8-88b5-d6c8952ad0cf.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('151', 'liaohj', '2', '1', '6e7b28a6-336c-4d81-8afa-5587c58b000c.jpg', '/udata/2015/08/15/52c66a32-5560-4c22-944d-dd0756a70f31.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('152', 'liaohj', '2', '1', '6ecfdb03-ed17-4ae8-bbb2-5f59efddef32.jpg', '/udata/2015/08/15/7ddefaa3-c346-4aee-ab64-16f09fa828c5.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('153', 'liaohj', '2', '1', '9d3fc845-4459-4191-8804-9ca6b5013294.jpg', '/udata/2015/08/15/e2a93c1b-5241-4357-9a37-164ff36968f2.jpg', '2015-08-15 16:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('154', 'liaohj', '2', '1', '9e96830b-2a99-43d4-acca-8c9db914e585.jpg', '/udata/2015/08/15/0a316acd-34c5-44b1-84b7-67412f2bc2f8.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('155', 'liaohj', '2', '1', '12b9f324-54ae-4d9a-902e-2fd90824ec80.jpg', '/udata/2015/08/15/d725e970-b474-4762-b3df-868ca4a19480.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('156', 'liaohj', '2', '1', '12f94d5a-413e-420c-84be-c65cd8eaa64a.jpg', '/udata/2015/08/15/65e8eae8-f98e-46a8-88b7-7c3ecaa4e900.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('157', 'liaohj', '2', '1', '25c1be97-de82-468c-b4fc-9c2629a887aa.jpg', '/udata/2015/08/15/c0c9b995-f07f-46d9-ac00-18c7800e1d3f.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('158', 'liaohj', '2', '1', '46c90574-120d-4122-970f-faf23dcd1b80.jpg', '/udata/2015/08/15/26de854d-087b-46b3-9b88-d2ded132ae41.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('159', 'liaohj', '2', '1', '46f276bc-593d-40b1-ab9b-d2f02044844a.jpg', '/udata/2015/08/15/49c2782b-4fbb-4822-9573-4cac3b85b1af.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('160', 'liaohj', '2', '1', '60b435af-2c43-4973-b02c-4144b61a733f.jpg', '/udata/2015/08/15/f2d9a7f7-d961-4a87-b0b2-e4b52cc0e59a.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('161', 'liaohj', '2', '1', '74f8b0f3-a0b0-409e-9e64-416a8fdff85a.jpg', '/udata/2015/08/15/06f65264-4da1-4371-872c-414302c35b5d.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('162', 'liaohj', '2', '1', '92a36600-8a9f-4699-b45b-07b58f2abcbc.jpg', '/udata/2015/08/15/ad6f1993-86bc-48e8-8abd-a66cff15bcc3.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('163', 'liaohj', '2', '1', '247f9264-931b-4faf-bcc0-be30a4c57073.jpg', '/udata/2015/08/15/78743d4f-4de6-4c7a-84ce-25c827708b67.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('164', 'liaohj', '2', '1', '310c16fc-1ff8-48b9-a388-48185e102b3e.jpg', '/udata/2015/08/15/12649b8d-3e0d-4fb7-bfbc-1e6f860e69b3.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('165', 'liaohj', '2', '1', '376f270f-94ec-4e4f-9fd3-1b349ee886bb.jpg', '/udata/2015/08/15/77049123-c454-4975-bf2d-c14f96149e09.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('166', 'liaohj', '2', '1', '5937b7e9-d0e7-47c7-ab7d-ec3402d20ad3.jpg', '/udata/2015/08/15/7b3d9eb2-bd11-4163-bd18-782e5dcba874.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('167', 'liaohj', '2', '1', '7770d221-de76-48d3-9d9d-45bbbf2d4b6a.jpg', '/udata/2015/08/15/af78255a-6a85-4a25-8fdf-6c85e5151244.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('168', 'liaohj', '2', '1', '031684ce-a291-4d4b-8e28-b98517ca9b52.jpg', '/udata/2015/08/15/094c1e88-7fc8-48af-81f5-c63c07741178.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('169', 'liaohj', '2', '1', '33637be1-bdf5-44b0-a276-ed96a1c7add3.jpg', '/udata/2015/08/15/bb30dcdc-53e3-4990-b934-80f7a1250a4a.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('170', 'liaohj', '2', '1', '66736a79-d5f5-4946-893c-fa83dee0fb84.jpg', '/udata/2015/08/15/d58104c4-b1a2-4902-be6e-85368dfeabe3.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('171', 'liaohj', '2', '1', 'a5c22f31-fe8e-4046-9695-ef23ee64f524.jpg', '/udata/2015/08/15/5ee3e4bd-3a93-46e8-84ca-bd2d5c97e5f8.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('172', 'liaohj', '2', '1', 'a20dd26e-15d7-42a0-9e18-0c84f49f164e.jpg', '/udata/2015/08/15/3f56afe3-8294-421e-b7a5-20c76580edea.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('173', 'liaohj', '2', '1', 'bc68a830-7d15-4075-9240-53880c7d4e03.jpg', '/udata/2015/08/15/0055367f-2645-4f86-8ec4-6f43da7d1486.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('174', 'liaohj', '2', '1', 'c5a7bbc7-a586-4ec6-8fe4-8f55cb83d313.jpg', '/udata/2015/08/15/187e22e5-fe2e-4dca-a41a-05308916ef67.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('175', 'liaohj', '2', '1', 'cae16020-a50b-4682-9d0f-81418f913b2a.jpg', '/udata/2015/08/15/906ee7ef-f7fa-45df-8fd6-32fb3960d574.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('176', 'liaohj', '2', '1', 'cfd7388e-966c-4ac2-bd31-38ad9abae815.jpg', '/udata/2015/08/15/d8fdfdc6-f053-4366-b6a8-173cbf2f02f4.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('177', 'liaohj', '2', '1', 'd14db053-48f6-46b7-84b8-553198a51df4.jpg', '/udata/2015/08/15/43ac5303-086e-4f63-91d6-81acfa41242f.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('178', 'liaohj', '2', '1', 'dcb24bc1-0e58-4918-9648-e8a3abd19efb.jpg', '/udata/2015/08/15/48ce53ba-668d-479b-92a2-d54219c039c9.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('179', 'liaohj', '2', '1', 'e9fabbc4-62d2-4d33-9802-439c8abf83c0.jpg', '/udata/2015/08/15/e65df7bb-0ff1-429a-8c21-55691288ff98.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('180', 'liaohj', '2', '1', 'f3ca2211-76dc-422e-bffe-82443d47df2f.jpg', '/udata/2015/08/15/f5616c63-b190-43fd-a6c2-e0bc548ea246.jpg', '2015-08-15 16:01:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('181', 'liaohj', '2', '2', '0a316acd-34c5-44b1-84b7-67412f2bc2f8.jpg', '/udata/2015/08/15/a6ab649b-25d8-4f42-ba4a-a4659044ffcb.jpg', '2015-08-15 16:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('182', 'liaohj', '2', '2', '3f56afe3-8294-421e-b7a5-20c76580edea.jpg', '/udata/2015/08/15/34db819b-85f8-484c-a6db-32d1130d36f7.jpg', '2015-08-15 16:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('183', 'liaohj', '2', '2', '5ee3e4bd-3a93-46e8-84ca-bd2d5c97e5f8.jpg', '/udata/2015/08/15/fc7dbbe9-ac4f-4700-ab20-fb2b4a506d0e.jpg', '2015-08-15 16:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('184', 'liaohj', '2', '2', '06f65264-4da1-4371-872c-414302c35b5d.jpg', '/udata/2015/08/15/f7970fbb-d4dd-4525-804b-5923ee844e29.jpg', '2015-08-15 16:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('185', 'liaohj', '2', '1', '1.jpg', '/udata/2015/08/15/7e63742a-712b-4b9c-9321-f945fd5b178c.jpg', '2015-08-15 16:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('186', 'liaohj', '2', '1', '2.jpg', '/udata/2015/08/15/5a7c0aa6-f845-44ac-8e15-98b53c91b222.jpg', '2015-08-15 16:45:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('187', 'liaohj', '2', '2', '3.jpg', '/udata/2015/08/15/94f1d3fc-e3ea-4844-8219-a3c863517b1e.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('188', 'liaohj', '2', '2', '4.jpg', '/udata/2015/08/15/c0a4dce5-4d52-471f-988c-97034382ad52.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('189', 'liaohj', '2', '2', '5.jpg', '/udata/2015/08/15/3dbcb4d8-eb83-464b-ab49-71873eff993b.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('190', 'liaohj', '2', '2', '6.jpg', '/udata/2015/08/15/6317e718-fdac-4379-9939-5fd6d1fc033c.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('191', 'liaohj', '2', '2', '7.jpg', '/udata/2015/08/15/98d4a35a-60c7-44c0-a86d-497a369e8723.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('192', 'liaohj', '2', '2', '8.jpg', '/udata/2015/08/15/c24d3518-09e6-4d07-9f4f-7e0ef90d8c37.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('193', 'liaohj', '2', '2', '9.jpg', '/udata/2015/08/15/0dc2c163-2df1-48f3-b418-20a609b05e9e.jpg', '2015-08-15 16:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('194', 'liaohj', '2', '1', '10.jpg', '/udata/2015/08/15/5d697c4d-91a8-478e-b817-e580e141602d.jpg', '2015-08-15 17:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('195', 'liaohj', '2', '2', '298b668d5f4b575170007c77abf53caf.jpg', '/udata/2015/08/16/6eac1212-2d05-4499-86c2-4fb3e70d1318.jpg', '2015-08-16 13:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('196', 'liaohj', '2', '3', '11.jpg', '/udata/2015/08/17/fa0a3f40-6ccb-4a39-8a9b-a13336851f64.jpg', '2015-08-17 10:24:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('197', 'zd_test', '7', '1', '12.jpg', '/udata/2015/08/17/2e5e9610-19bd-4869-bbf0-a7afdb6be794.jpg', '2015-08-17 10:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('198', 'liaohj', '2', '2', '13.jpg', '/udata/2015/08/17/aeb983af-b58c-460b-bb79-588f219e4358.jpg', '2015-08-17 11:55:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('199', 'liaohj', '2', '1', '14.jpg', '/udata/2015/08/17/b849a470-180b-4488-b4f1-6216f259cc71.jpg', '2015-08-17 12:04:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('200', 'liaohj', '2', '2', '15.jpg', '/udata/2015/08/17/a026f32c-21bf-4116-b4d0-a48cce62041a.jpg', '2015-08-17 12:43:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('201', 'liaohj', '2', '2', '17.jpg', '/udata/2015/08/17/65929851-5dc1-42aa-bdff-14e1a0ef50f3.jpg', '2015-08-17 12:54:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('202', 'liaohj', '2', '1', '18.jpg', '/udata/2015/08/17/704f2ba7-2af4-474d-8c42-e3ffc46f39e3.jpg', '2015-08-17 14:20:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('203', 'dd_test', '6', '1', '19.jpg', '/udata/2015/08/17/92c5d6a0-d4f1-4ff7-96b1-40fe5a30d02e.jpg', '2015-08-17 14:27:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('204', 'liaohj', '2', '1', '1111111.jpg', '/udata/2015/08/17/f1eab4c5-c8a0-410f-95e4-03fa25f2d55f.jpg', '2015-08-17 14:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('205', 'dd_test', '6', '1', '122.jpg', '/udata/2015/08/17/0e0ca50f-69b6-4527-a0c4-3d70c5ab7e94.jpg', '2015-08-17 14:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('206', 'liaohj', '2', '1', '123.jpg', '/udata/2015/08/17/35e92bd8-4da3-4288-a14e-d4c61f0de33a.jpg', '2015-08-17 15:03:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('207', 'liaohj', '2', '1', '124.jpg', '/udata/2015/08/17/43ddcce7-129f-4bf1-9eab-0a8c9f9885a0.jpg', '2015-08-17 15:06:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('208', 'liaohj', '2', '1', '131.jpg', '/udata/2015/08/17/55d004a4-e0d5-401f-bfba-b6b05686c9a6.jpg', '2015-08-17 15:42:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('209', 'liaohj', '2', '2', '1234.jpg', '/udata/2015/08/17/b2d1f3aa-25cb-4ce8-b757-bc07dea687f1.jpg', '2015-08-17 16:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('210', 'liaohj', '2', '2', '123123 (2).jpg', '/udata/2015/08/17/c05f21ef-4e34-4886-8312-fc03649379b7.jpg', '2015-08-17 16:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('211', 'liaohj', '2', '2', '123123.jpg', '/udata/2015/08/17/ebf0b0cc-e2eb-419e-9c53-65fbd4c7ea97.jpg', '2015-08-17 16:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('212', 'liaohj', '2', '2', 'e854aa24319bd0590e0e16b69688c8d0.jpg', '/udata/2015/08/17/fa02d34b-8d23-4a9a-b760-26781b40284d.jpg', '2015-08-17 18:35:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('213', 'liaohj', '2', '1', '1f980d540fb556d23d64a81fc7230ddc.jpg', '/udata/2015/08/17/27e69b87-00d4-4be3-a7d5-beb5e65e0ca8.jpg', '2015-08-17 18:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('214', 'liaohj', '2', '1', '1234 (2).jpg', '/udata/2015/08/18/770c39e8-0f24-422e-bd77-732e2465a49a.jpg', '2015-08-18 10:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('215', 'liaohj', '2', '1', '1314.jpg', '/udata/2015/08/18/5cff1782-6a0f-43c4-a285-a1c97356e79e.jpg', '2015-08-18 10:59:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('216', 'liaohj', '2', '2', '12344.jpg', '/udata/2015/08/18/9125bcf1-e3d1-4260-8e68-7ca5065e5940.jpg', '2015-08-18 11:29:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('217', 'liaohj', '2', '3', '123123 (3).jpg', '/udata/2015/08/18/9d85ead2-6274-4ebf-8cff-3b72cc4ed2e9.jpg', '2015-08-18 15:41:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('218', 'liaohj', '2', '2', '当时发生地方.jpg', '/udata/2015/08/18/c64cedb8-de0e-4129-a58b-24745165f411.jpg', '2015-08-18 17:07:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('219', 'liaohj', '2', '2', 'ddd.jpg', '/udata/2015/08/20/d9150256-7e6b-4fd4-bd10-c3dd31dd3c49.jpg', '2015-08-20 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('220', 'liaohj', '2', '2', 'ex_child_pic01.png', '/udata/2015/08/24/5662f2fa-1550-4b12-b30b-b096b2fc1eb8.png', '2015-08-24 09:11:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('221', 'liaohj', '2', '2', 'check_photo_list_photo2.png', '/udata/2015/08/24/650ad5ee-5189-4542-9766-84f267e23ae2.png', '2015-08-24 09:11:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('222', 'liaohj', '2', '2', 'check_photo_list_photo3.png', '/udata/2015/08/24/73c139f2-7c8f-4d62-b508-03d17612517d.png', '2015-08-24 09:11:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('223', 'liaohj', '2', '2', 'check_photo_list_photo4.png', '/udata/2015/08/24/8503fb62-b585-4d28-9616-90b33ee7cdd9.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('224', 'liaohj', '2', '2', 'child_paint_pic01.png', '/udata/2015/08/24/08667683-471c-4591-9e73-23b9158f05d8.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('225', 'liaohj', '2', '2', 'child_paint_pic02.png', '/udata/2015/08/24/60a1c16b-cc99-4a45-8b58-d9ee1030be95.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('226', 'liaohj', '2', '2', 'child_paint_pic03.png', '/udata/2015/08/24/6db6cb72-1fa6-4874-9237-4abdf28e3b2c.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('227', 'liaohj', '2', '2', 'child_paint_pic04.png', '/udata/2015/08/24/17ac1def-db7b-4d87-bfd2-3aabb1ff3e68.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('228', 'liaohj', '2', '2', 'class_img.png', '/udata/2015/08/24/6dc8be61-d7c1-4d72-a0f6-8f9d12d42a8a.png', '2015-08-24 09:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('229', 'liaohj', '2', '2', '3CEA7FE0-09A4-4D8D-A54D-AD1CC64D3A20.MOV', '/udata/2015/08/24/7457374f-445c-4632-90d0-fb1770fce918.MOV', '2015-08-24 09:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('230', 'liaohj', '2', '1', '粤A111111_2013020392558471_177.jpg', '/udata/2015/08/28/e2908d64-d3ec-41b5-a74b-cacb52f11ba5.jpg', '2015-08-28 10:41:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('231', 'liaohj', '2', '3', '粤B12312-2015-09-10 111111-闯红灯.jpg', '/udata/2015/08/28/2bc9c36a-c125-4a63-8b61-139d3b019d71.jpg', '2015-08-28 11:08:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('232', 'liaohj', '2', '2', '粤c23232-2015-09-10 111111-闯红灯.jpg', '/udata/2015/08/28/379e3c1f-4582-4a79-afbd-1cbba63030f6.jpg', '2015-08-28 12:06:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('233', 'liaohj', '2', '3', '测试列表.jpg', '/udata/2015/08/28/32d79a3f-e18d-4ecf-ad93-b14d7f0a7e04.jpg', '2015-08-28 17:23:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('234', 'liaohj', '2', '2', '粤A32S2-20150803-223104-2222.jpg', '/udata/2015/08/29/075dee11-6334-4862-9b3a-ae4bbfb7ea03.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('235', 'liaohj', '2', '2', '粤A554-20150803-230203-222.jpg', '/udata/2015/08/29/ba23320a-ce87-47a1-af10-61970daa7568.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('236', 'liaohj', '2', '2', '粤A1234-20150803-223104-2222.jpg', '/udata/2015/08/29/58a073f6-5872-44a6-9480-0fbde9f074fa.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('237', 'liaohj', '2', '2', '粤A1445-20150902-223104-2222.jpg', '/udata/2015/08/29/31b6c5fe-1805-48fc-a3b8-55b119e8d045.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('238', 'liaohj', '2', '2', '粤A2231-20150802-223321-2222.jpg', '/udata/2015/08/29/9d83fcb6-997a-45f7-87ac-a45626d83047.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('239', 'liaohj', '2', '2', '粤A3221-201500872-223104-2222.jpg', '/udata/2015/08/29/b5c0396f-aad9-432b-bc86-1d8aa4b009e1.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('240', 'liaohj', '2', '2', '粤A4442-20150503-2232331-2222.jpg', '/udata/2015/08/29/0edb90a2-bbfb-42c9-8334-468f285a782a.jpg', '2015-08-29 09:36:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('241', 'liaohj', '2', '2', '2015-07-08 12-48-03.0-1-湘L6jx99-16250-2222.jpg', '/udata/2015/08/29/d36424e5-5fa7-4ed9-a3ea-287eea87d3d5.jpg', '2015-08-29 10:39:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('242', 'liaohj', '2', '2', '2015-07-08 22-04-51.0-2-湘L2323-12080-2222.jpg', '/udata/2015/08/29/c97721c2-b520-4ff6-92ea-bae2e46c734e.jpg', '2015-08-29 10:39:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('243', 'liaohj', '2', '3', '2015-07-08 12-48-03.0-1-湘L6jx99-16250-23.jpg', '/udata/2015/08/31/3e07988d-ac6b-4f27-9dc0-d9b5bd50f4fa.jpg', '2015-08-31 16:24:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('244', 'liaohj', '2', '1', '2015-07-08 22-04-51.0-2-湘L2323-12080-2233.jpg', '/udata/2015/08/31/25f6ee29-b487-4197-88e0-a6eeaa719714.jpg', '2015-08-31 17:00:00', '0', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('245', 'liaohj', '2', '1', '2015-4-5.jpg', '/udata/2015/09/02/4447df34-6b60-4bf8-b2fd-0500cc4aa655.jpg', '2015-09-02 09:23:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('246', 'liaohj', '2', '1', '2015-4-6.jpg', '/udata/2015/09/02/4dfe781d-5306-4921-a561-e5f5e29ec9bd.jpg', '2015-09-02 09:23:00', '1', '2017-11-23 18:12:49', '6', '398', '湘L64564', '大型汽车', '2017-11-23 03:02:01');
INSERT INTO `tp_upload_temp` VALUES ('247', 'liaohj', '2', '3', '2015-2-2.jpg', '/udata/2015/09/02/38c3e1fe-b2c3-4e61-b64d-1ce2a1a4b333.jpg', '2015-09-02 09:25:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('248', 'liaohj', '2', '2', '2015-2-3.jpg', '/udata/2015/09/02/da4690f1-a10b-45ec-b04d-094b26e83cdb.jpg', '2015-09-02 09:26:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('249', 'liaohj', '2', '2', '2015-2-23.jpg', '/udata/2015/09/10/13bb2605-7898-45fe-aa0a-1d19af91f010.jpg', '2015-09-10 12:02:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('250', 'liaohj', '2', '3', '2015-2-33.jpg', '/udata/2015/09/10/73f9206f-b65f-43ad-911d-ea1e470d956a.jpg', '2015-09-10 13:44:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('251', 'liaohj', '2', '3', '2012-2-3.jpg', '/udata/2015/09/10/e1d63575-6b02-4bc5-a568-9a46d267e62d.jpg', '2015-09-10 14:53:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('252', 'liaohj', '2', '3', '2012-2-22.jpg', '/udata/2015/09/10/6b7a0bff-a8b6-41ac-b5ac-b0e5738c52bb.jpg', '2015-09-10 14:53:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('253', 'liaohj', '2', '3', '2012-2-23.jpg', '/udata/2015/09/10/a1740560-4c8d-4af5-be16-1a3c13de71fa.jpg', '2015-09-10 14:53:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('254', 'liaohj', '2', '3', '2012-2-33.jpg', '/udata/2015/09/10/fc9d42ac-edf0-4356-a625-aa2645ba4c46.jpg', '2015-09-10 14:53:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('255', 'liaohj', '2', '1', '2012-3-1.jpg', '/udata/2015/09/10/d29adfb9-97bc-44a6-a036-a1405d1a4284.jpg', '2015-09-10 15:47:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('256', 'liaohj', '2', '1', 'aaaa.jpg', '/udata/2015/09/10/eb02ec39-f9c3-4bc9-8454-a9f869d3acb3.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('257', 'liaohj', '2', '1', 'bbbb.jpg', '/udata/2015/09/10/63670eea-4a18-4f38-86f8-224f88964863.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('258', 'liaohj', '2', '1', 'cccc.jpg', '/udata/2015/09/10/b2c83b5a-50cb-45b6-84b3-9c2be73c417a.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('259', 'liaohj', '2', '1', 'dddd.jpg', '/udata/2015/09/10/41a6050a-1370-473d-90b9-08978cacdd89.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('260', 'liaohj', '2', '1', 'eeee.jpg', '/udata/2015/09/10/43917576-5f72-4086-a2b9-320dd76a59fd.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('261', 'liaohj', '2', '1', 'ffff.jpg', '/udata/2015/09/10/3c45cd20-e565-43af-bd5d-9ee5e0538cf5.jpg', '2015-09-10 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('262', 'liaohj', '2', '3', 'qwe.jpg', '/udata/2015/09/10/dd0e508b-0c2f-4aa0-950f-468cf95aa633.jpg', '2015-09-10 16:41:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('263', 'liaohj', '2', '2', '66666.jpg', '/udata/2015/09/10/a86f58b5-fb11-46b4-8d04-77c8a4265a9b.jpg', '2015-09-10 17:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('264', 'liaohj', '2', '1', '283889.jpg', '/udata/2015/09/10/676e2e90-8a60-48e9-9592-5dd3d4ad5079.jpg', '2015-09-10 18:03:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('265', 'liaohj', '2', '1', '286997.jpg', '/udata/2015/09/10/0cc50497-5aab-4cc4-9b54-484f9c8edd02.jpg', '2015-09-10 18:03:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('266', 'liaohj', '2', '1', '286998.jpg', '/udata/2015/09/10/a916d02c-0821-476c-a82a-1ad855b50ec9.jpg', '2015-09-10 18:03:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('267', 'liaohj', '2', '1', '286999.jpg', '/udata/2015/09/10/13a71f7f-1d71-4e26-a958-6415c1e06f13.jpg', '2015-09-10 18:03:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('268', 'liaohj', '2', '2', 'Artistic_Planets_349854.jpg', '/udata/2015/09/14/f2d04dc3-607a-4f3f-9219-d2bc159c0ffd.jpg', '2015-09-14 10:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('269', 'liaohj', '2', '2', 'Artistic_Space_320283.jpg', '/udata/2015/09/14/87d6e49b-3a7b-4762-8217-732aeffa3327.jpg', '2015-09-14 10:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('270', 'liaohj', '2', '2', 'Photography_Manipulation_300001.jpg', '/udata/2015/09/14/eb23667d-4d07-48b6-922a-b7237fd51faf.jpg', '2015-09-14 10:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('271', 'liaohj', '2', '2', 'Sci Fi_adventure_300668.jpg', '/udata/2015/09/14/ebd31891-af0f-428a-9371-8d4cb702771a.jpg', '2015-09-14 10:34:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('272', 'liaohj', '2', '3', 'u=8509094,1408974657&fm=21&gp=0.jpg', '/udata/2015/09/14/f8cc83e5-339b-4193-a61b-ca0456a9912c.jpg', '2015-09-14 10:50:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('273', 'liaohj', '2', '4', 'u=1403710907,125103609&fm=21&gp=0.jpg', '/udata/2015/09/14/24a97762-1a51-4ada-beb8-609ef906148e.jpg', '2015-09-14 10:53:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('274', 'liaohj', '2', '4', 'u=650813247,1580370176&fm=21&gp=0.jpg', '/udata/2015/09/14/25869b3c-b6e9-4e66-846c-f8ba1eee0294.jpg', '2015-09-14 11:12:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('275', 'smh', '9', '4', 'u=1958343483,3377252357&fm=21&gp=0.jpg', '/udata/2015/09/14/03bcd8df-76fe-4ba2-8167-69d2e7169a65.jpg', '2015-09-14 14:20:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('276', 'smh', '9', '1', 'u=1842375882,1975961249&fm=21&gp=0.jpg', '/udata/2015/09/14/a5152fda-cee7-465c-8c74-1d61f7993419.jpg', '2015-09-14 14:28:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('277', 'ssssuu', '11', '3', 'u=2118884290,1319089944&fm=21&gp=0.jpg', '/udata/2015/09/14/51c2e352-12de-40a8-b35e-d644c5879b62.jpg', '2015-09-14 15:27:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('278', 'smh02', '10', '3', 'u=3054344368,1070904328&fm=21&gp=0.jpg', '/udata/2015/09/14/c5f371c0-ec40-49b1-921e-cc200726045c.jpg', '2015-09-14 15:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('279', 'smh02', '10', '1', 'u=2667517873,2184786706&fm=58.jpg', '/udata/2015/09/14/335ac538-3d78-40fe-925d-e951bd9a8382.jpg', '2015-09-14 16:14:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('280', 'smh02', '10', '2', '3_100310151458_1.jpg', '/udata/2015/09/14/b064b30a-1dfb-4848-a42c-b8db2cb660be.jpg', '2015-09-14 16:15:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('281', 'smh02', '10', '2', '6-140613121412429.jpg', '/udata/2015/09/14/1db11d41-3a20-4f4b-81fa-8cc81b076f9d.jpg', '2015-09-14 16:24:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('282', 'smh02', '10', '2', '7e140a83c0d94fb30f65fd029aecdf56.jpg', '/udata/2015/09/14/18940b8f-83c1-41a7-a63b-10ecfc222a15.jpg', '2015-09-14 16:24:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('283', 'smh02', '10', '2', '0606_0604153310.jpg', '/udata/2015/09/14/44b37f08-829f-47e0-8984-55da9fcea82b.jpg', '2015-09-14 16:35:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('284', 'smh02', '10', '2', '562433_140703282311_2.jpg', '/udata/2015/09/14/c46c7383-e561-42b8-a9ad-f341d6eb1c7f.jpg', '2015-09-14 16:37:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('285', 'smh02', '10', '2', 'u=282919268,2834032647&fm=21&gp=0.jpg', '/udata/2015/09/14/8a1c5ef9-eed3-4d9f-ad6f-2019aed3cc4d.jpg', '2015-09-14 16:38:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('286', 'smh02', '10', '2', '37d8125885e69f75-32da289ac2251c44-2cbd6c5456e6e6072ea155f71860cbb1.jpg', '/udata/2015/09/14/a9b3c27c-08eb-464d-b6d0-6f1b05fddd3b.jpg', '2015-09-14 16:39:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('287', 'smh02', '10', '2', 'u=706300896,629155272&fm=21&gp=0.jpg', '/udata/2015/09/14/c0b1377f-6151-4187-ab36-09d7c8b86b2e.jpg', '2015-09-14 16:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('288', 'smh02', '10', '4', 'ac75323d6b6de243-805161b6557a786a-0f54d7712b008d1335f4823c25ec66d3_i.jpg', '/udata/2015/09/14/05a48d8c-72c3-4609-8f49-70144f8660a8.jpg', '2015-09-14 16:48:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('289', 'smh', '9', '2', 'u=864963389,3566579229&fm=21&gp=0.jpg', '/udata/2015/09/14/6d0b5103-f5dc-460d-a9b9-b2ae8e862685.jpg', '2015-09-14 17:06:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('290', 'smh', '9', '1', 'u=4198376809,3929035520&fm=21&gp=0.jpg', '/udata/2015/09/14/ed5f6361-1a51-41d6-a3b7-264588926027.jpg', '2015-09-14 17:11:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('294', 'liaohj', '2', '4', '291474.jpg', '/udata/2015/09/14/7640a0a6-00c5-4080-85a2-a8d5e767de26.jpg', '2015-09-14 18:32:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('295', 'liaohj', '2', '4', 'Abstract_Sci Fi_275030.jpg', '/udata/2015/09/14/6d57e969-c929-4518-bdb9-50e822706f81.jpg', '2015-09-14 18:32:00', '0', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('296', 'liaohj', '2', '4', '287017.jpg', '/udata/2015/09/15/1c64f79c-72fa-4823-b5b1-9219dd75559b.jpg', '2015-09-15 10:44:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('297', 'liaohj', '2', '4', '287018.jpg', '/udata/2015/09/15/d043aa58-d2d2-47eb-a3e6-b26cdcb1e512.jpg', '2015-09-15 10:44:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('298', 'liaohj', '2', '4', '287021.jpg', '/udata/2015/09/15/d34e167e-5f9b-413c-a014-dc0d6605a2ff.jpg', '2015-09-15 10:44:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('299', 'liaohj', '2', '4', '287044.jpg', '/udata/2015/09/15/78422b4d-55c7-4c06-920b-369a0e6a4c87.jpg', '2015-09-15 10:44:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('300', 'smh', '9', '2', 'cefc1e178a82b901c4918650768da9773912ef91.jpg', '/udata/2015/09/15/fcebb41f-d592-4050-8edf-49b42f424e87.jpg', '2015-09-15 14:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('301', 'smh02', '10', '2', 'u=1345787590,537918010&fm=21&gp=0.jpg', '/udata/2015/09/15/48f7b1fb-61bf-4d86-b9a3-266cc1b171ac.jpg', '2015-09-15 14:24:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('302', 'smh02', '10', '3', 'u=585146582,1059985279&fm=21&gp=0.jpg', '/udata/2015/09/15/3850af2a-0450-4a7b-824d-5c2e4afd1a6d.jpg', '2015-09-15 14:31:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('303', 'smh02', '10', '3', 'u=991804804,537202575&fm=21&gp=0.jpg', '/udata/2015/09/15/c8f3eec1-c41e-4f31-a0fd-a65a82b7e099.jpg', '2015-09-15 14:39:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('304', 'smh', '9', '3', 'u=1264703665,3784865623&fm=21&gp=0.jpg', '/udata/2015/09/15/ff3d780d-3f1b-47ad-b412-315df4bbd20d.jpg', '2015-09-15 14:58:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('305', 'ceshi', '12', '3', 'u=566391941,1015372400&fm=96&s=7D9C679E54436153C883CC6E0300F07B.jpg', '/udata/2015/09/15/f1e0fbbe-d89f-4c1a-a6df-e8a235b6952e.jpg', '2015-09-15 16:51:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('306', 'smh02', '10', '3', 'u=4225249901,58953268&fm=21&gp=0.jpg', '/udata/2015/09/16/750d13b9-39f2-49b2-a77b-381acbcd8088.jpg', '2015-09-16 09:33:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('307', 'smh', '9', '2', 'u=1519095430,2307521081&fm=116&gp=0.jpg', '/udata/2015/09/16/2c91ad91-bb8f-4802-90db-a117463352ba.jpg', '2015-09-16 15:46:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('308', 'smh', '9', '2', 'u=2162766932,244861494&fm=116&gp=0.jpg', '/udata/2015/09/16/9ec4d6dc-8315-461a-b1ff-e0b162a91a5a.jpg', '2015-09-16 15:46:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('309', 'liaohj', '2', '1', '32134.jpg', '/udata/2015/09/16/6a0e2844-c354-4805-9723-99d30bf16c02.jpg', '2015-09-16 16:35:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('310', 'liaohj', '2', '4', '2313.jpg', '/udata/2015/09/16/ce952b87-42f5-43a6-be67-2f052847cd16.jpg', '2015-09-16 17:15:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('311', 'liaohj', '2', '4', '3324.jpg', '/udata/2015/09/16/44aa7fe3-523f-4f1d-b78c-9630016064a9.jpg', '2015-09-16 17:15:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('312', 'liaohj', '2', '4', '4341.jpg', '/udata/2015/09/16/9cc17666-f70f-4e9b-9d8b-724766e503f6.jpg', '2015-09-16 17:15:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('313', 'liaohj', '2', '4', '23124.jpg', '/udata/2015/09/16/3d99b80e-ae14-47bd-a852-4af31d1fc743.jpg', '2015-09-16 17:15:00', '0', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('314', 'liaohj', '2', '4', '3211124.jpg', '/udata/2015/09/16/8a05cf4c-f84e-4e61-81de-31ade1de4fc6.jpg', '2015-09-16 17:40:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('315', 'liaohj', '2', '4', '21412424.jpg', '/udata/2015/09/16/69168d9c-03bf-40bd-9e2d-94dd3625e48c.jpg', '2015-09-16 17:40:00', '0', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('316', 'liaohj', '2', '4', '231241241.jpg', '/udata/2015/09/16/bc58bce9-d1fa-47c2-af14-ad993d8dac5a.jpg', '2015-09-16 17:40:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('317', 'liaohj', '2', '4', '231241241 (2).jpg', '/udata/2015/09/16/847ce43c-fd97-42cf-8eab-d915ed4ce9af.jpg', '2015-09-16 17:40:00', '0', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('318', 'liaohj', '2', '3', '43534244.jpg', '/udata/2015/09/16/b170446f-b12a-45f6-bc92-c70290995ad0.jpg', '2015-09-16 17:42:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('319', 'liaohj', '2', '1', 'djfdslf.jpg', '/udata/2015/09/16/86dc5a63-0139-4a88-a69e-94a7119cea7c.jpg', '2015-09-16 17:43:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('320', 'liaohj', '2', '1', 'fklsdjfdsljf.jpg', '/udata/2015/09/16/409a9965-d025-466f-95c2-14b0ebfea439.jpg', '2015-09-16 17:43:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('321', 'liaohj', '2', '1', 'slfjdslfj.jpg', '/udata/2015/09/16/338f8004-2bbf-4e30-b6b4-141954a23d60.jpg', '2015-09-16 17:43:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('322', 'liaohj', '2', '1', 'sdlfj.jpg', '/udata/2015/09/16/d040b1d1-71d4-4d54-9d9d-2e2667cdc955.jpg', '2015-09-16 17:43:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('323', 'liaohj', '2', '3', '1280x720.jpg', '/udata/2015/09/17/bbd88744-1db2-4cfa-8e2e-ed0b00175f04.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('324', 'liaohj', '2', '3', '1440x900.jpg', '/udata/2015/09/17/b6d283a3-f4b6-40d0-a98b-1476428dcbcd.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('325', 'liaohj', '2', '3', '1600x900.jpg', '/udata/2015/09/17/b96603fb-f19b-43ff-9ab7-2dac3da7ed99.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('326', 'liaohj', '2', '3', '1920x1080.jpg', '/udata/2015/09/17/2dd38950-acdb-4b96-9ec3-48f1b1eb7964.jpg', '2015-09-17 09:00:00', '2', '2017-11-23 18:12:13', '3', '397', '湘L', '小型汽车', '2017-11-23 00:00:00');
INSERT INTO `tp_upload_temp` VALUES ('327', 'liaohj', '2', '3', '2560x1440.jpg', '/udata/2015/09/17/06f2ea9a-ee16-4c91-a41d-9c4b02bfe3a6.jpg', '2015-09-17 09:00:00', '2', '2017-11-23 18:12:13', '3', '397', '湘L', '小型汽车', '2017-11-23 00:00:00');
INSERT INTO `tp_upload_temp` VALUES ('328', 'smh02', '10', '4', 'u=2651666712,3423349209&fm=116&gp=0.jpg', '/udata/2015/09/17/34b7c238-eb3d-4a23-9dde-a93f1fa58dca.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('329', 'smh02', '10', '4', 'u=2796135251,3567181510&fm=116&gp=0.jpg', '/udata/2015/09/17/5818896d-918e-4a06-8fdc-56d7a18a2e99.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('330', 'smh02', '10', '4', 'u=3371032114,892333757&fm=116&gp=0.jpg', '/udata/2015/09/17/69689262-17b4-4bdb-8766-7d87891eea84.jpg', '2015-09-17 09:00:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('331', 'smh', '9', '1', 'u=3503591489,2046578318&fm=21&gp=0.jpg', '/udata/2015/09/17/0aaa844e-eaf4-41f9-8b0c-c4b73cc7bcde.jpg', '2015-09-17 10:09:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('332', 'smh', '9', '1', 'u=4076989799,2826785422&fm=21&gp=0.jpg', '/udata/2015/09/17/39471998-9700-4b56-80dd-0cb67700d24c.jpg', '2015-09-17 10:09:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('333', 'smh', '9', '2', 'u=3801519706,405978603&fm=21&gp=0.jpg', '/udata/2015/09/17/560e0689-9629-41df-8b01-1fb6d1703b33.jpg', '2015-09-17 10:16:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('334', 'smh', '9', '2', 'u=1332321919,2132707668&fm=21&gp=0.jpg', '/udata/2015/09/17/c0aa87c3-5abc-490a-bbb2-d6bb62749735.jpg', '2015-09-17 10:16:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('335', 'smh', '9', '2', 'u=377943345,2552709390&fm=21&gp=0.jpg', '/udata/2015/09/17/b80be0ff-0f96-4af0-88b4-6e9fec779d17.jpg', '2015-09-17 10:16:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('336', 'smh', '9', '2', 'u=3330737067,2498478851&fm=21&gp=0.jpg', '/udata/2015/09/17/52dee34c-8b8e-44eb-957f-fea35353135d.jpg', '2015-09-17 10:16:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('337', 'smh', '9', '2', 'u=3551485824,1194929858&fm=21&gp=0.jpg', '/udata/2015/09/17/a0d3f010-8ac6-4563-bfd7-59432d3e6c8b.jpg', '2015-09-17 10:16:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('338', 'smh', '9', '3', 'u=680948941,1178031701&fm=21&gp=0.jpg', '/udata/2015/09/17/47fde9b5-82b5-4765-ae0c-fa5107ef8fcc.jpg', '2015-09-17 10:22:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('339', 'smh', '9', '3', 'u=4177476423,117576673&fm=21&gp=0.jpg', '/udata/2015/09/17/b6e79137-6544-4415-a0d3-05b33f0dea4a.jpg', '2015-09-17 10:22:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('340', 'smh', '9', '3', 'u=3245116602,3691897954&fm=21&gp=0.jpg', '/udata/2015/09/17/944877c2-6709-45e2-81be-472c915ef5a6.jpg', '2015-09-17 10:22:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('341', 'smh', '9', '1', 'u=2825004365,1525084527&fm=116&gp=0.jpg', '/udata/2015/09/17/5316a6df-b0b6-4de0-9b0a-2745464c9a30.jpg', '2015-09-17 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('342', 'smh', '9', '1', 'u=3841157212,2135341815&fm=116&gp=0.jpg', '/udata/2015/09/17/a49fee26-3128-4dbf-a385-e21a92724866.jpg', '2015-09-17 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('343', 'smh', '9', '1', 'u=1070902365,2619384777&fm=116&gp=0.jpg', '/udata/2015/09/17/6f5b7627-1f37-4b7a-8d8f-bb5a418abd22.jpg', '2015-09-17 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('344', 'smh', '9', '1', 'u=2783552916,508796275&fm=116&gp=0.jpg', '/udata/2015/09/17/97cbab4d-a8ac-44b7-95ab-3aa7748ac0f4.jpg', '2015-09-17 10:30:00', '1', null, null, null, null, null, null);
INSERT INTO `tp_upload_temp` VALUES ('345', 'liaohj', '2', '6', '330817-14030621503595.jpg', '/udata/2017/11/23/7dd957a9-968f-40a8-8e14-d17466123e00.jpg', '2017-11-23 18:13:17', '1', '2017-11-23 18:14:20', '6', '400', '粤A11111', '大型汽车', '2017-11-23 18:13:21');

-- ----------------------------
-- Table structure for tp_violation_action
-- ----------------------------
DROP TABLE IF EXISTS `tp_violation_action`;
CREATE TABLE `tp_violation_action` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `action_name` varchar(500) DEFAULT NULL COMMENT '行为名称',
  `action_id` int(11) DEFAULT NULL COMMENT '违规行为编码',
  PRIMARY KEY (`v_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='违反交通规则行为表';

-- ----------------------------
-- Records of tp_violation_action
-- ----------------------------
INSERT INTO `tp_violation_action` VALUES ('1', '闯红灯  ', '16250');
INSERT INTO `tp_violation_action` VALUES ('2', '不按规定车道行驶  ', '12080');
INSERT INTO `tp_violation_action` VALUES ('3', '阻碍交通', '23314');
INSERT INTO `tp_violation_action` VALUES ('4', '测试违法行为名称', '1313');
INSERT INTO `tp_violation_action` VALUES ('5', '公交站停车', '112200');

-- ----------------------------
-- Table structure for tp_vip_user
-- ----------------------------
DROP TABLE IF EXISTS `tp_vip_user`;
CREATE TABLE `tp_vip_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(4) DEFAULT NULL COMMENT '性别',
  `position` varchar(100) DEFAULT NULL COMMENT '职务',
  `mobile` varchar(100) DEFAULT NULL COMMENT '联系方式',
  `car_no` varchar(100) DEFAULT NULL COMMENT '车牌号',
  `create_user` varchar(100) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_user` varchar(100) DEFAULT NULL COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `car_type` int(11) DEFAULT NULL COMMENT '车辆类型',
  `expired_time` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='重要人物表';

-- ----------------------------
-- Records of tp_vip_user
-- ----------------------------
INSERT INTO `tp_vip_user` VALUES ('1', '11111', '0', null, null, '湘L12345', 'liaohj', '2015-07-20 11:16:00', 'liaohj', '2015-07-20 11:16:00', '2', '2017-07-05 11:16:00');
INSERT INTO `tp_vip_user` VALUES ('2', 'chen', '1', null, null, '湘A1234', 'liaohj', '2015-08-14 17:43:00', 'liaohj', '2015-08-18 11:42:00', '2', '2015-08-27 17:43:00');
INSERT INTO `tp_vip_user` VALUES ('3', 'test1', '1', null, null, '粤B12345', null, null, 'dd_test', '2015-09-15 09:32:00', '6', '2015-09-30 09:32:00');
INSERT INTO `tp_vip_user` VALUES ('4', 'test2', '1', null, null, '粤B12345', null, null, 'ssssuu', '2015-09-15 14:10:00', '7', '2015-09-25 14:11:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `user_name` varchar(20) NOT NULL COMMENT '管理员登录名，多玩通行证',
  `nick_name` varchar(20) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `password` varchar(40) DEFAULT NULL COMMENT '密码',
  `operator` varchar(20) NOT NULL DEFAULT '' COMMENT '操作员ID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '管理员状态，1-正常,2-冻结',
  `mobile_no` varchar(15) DEFAULT NULL COMMENT '移动电话',
  `work_no` varchar(15) DEFAULT NULL COMMENT '工作号',
  `department` int(11) DEFAULT NULL COMMENT '部门',
  `yy_no` varchar(20) DEFAULT NULL COMMENT 'yy号',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱地址',
  `admin` tinyint(1) DEFAULT NULL COMMENT '是否管理员',
  `meta_default_data` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否是基本用户，0-不是，1-是,不可以删除',
  `last_modify` datetime NOT NULL COMMENT '修改时间',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '删除标志 0未删除 1已删除',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `AK_Key_2` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='管理员名单';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'xxx', 'e10adc3949ba59abbe56e057f20f883e', 'install', '1', null, null, null, null, null, '1', '1', '2015-04-30 11:39:56', '0');
INSERT INTO `user` VALUES ('2', 'liaohj', '廖红俊', 'e10adc3949ba59abbe56e057f20f883e', 'liaohj', '1', '13682243708', 'G1022', '2', null, '465087012@qq.com', '1', '1', '2015-08-17 10:32:12', '0');
INSERT INTO `user` VALUES ('3', 'limh', 'limh', 'e10adc3949ba59abbe56e057f20f883e', 'liminghai', '3', '123', '123', '2', null, '903308590@qq.com', '2', '1', '2015-06-01 15:12:29', '0');
INSERT INTO `user` VALUES ('4', 'liminghai', 'liminghai', 'e10adc3949ba59abbe56e057f20f883e', 'liminghai', '3', '123', '123', '2', null, '903308590@qq.com', '2', '1', '2015-06-01 15:12:35', '0');
INSERT INTO `user` VALUES ('5', '一中队', '一中队', 'a1890afa5d28d6deac2b861cc2342ed5', 'liaohj', '1', '11234567890', '111111', '2', null, '111', '2', '1', '2015-06-03 17:16:57', '0');
INSERT INTO `user` VALUES ('6', 'dd_test', '大队测试', 'e10adc3949ba59abbe56e057f20f883e', 'liaohj', '1', '13600000000', '111', '2', null, '123@qq.com', '2', '1', '2015-09-15 09:30:51', '0');
INSERT INTO `user` VALUES ('7', 'zd_test', '中队测试', 'e10adc3949ba59abbe56e057f20f883e', 'liaohj', '1', '13500000000', '222', '3', null, '132@qq.com', '2', '1', '2015-08-17 10:38:34', '0');
INSERT INTO `user` VALUES ('8', 'sumh', 'sumh', 'a90560c1752ddc8b585bfae56ba501cc', 'liaohj', '1', '15289063451', '110120', '2', null, '1522802691@qq.com', '1', '1', '2015-09-14 11:37:43', '1');
INSERT INTO `user` VALUES ('9', 'smh', '一中队测试01', 'e10adc3949ba59abbe56e057f20f883e', 'smh', '1', '15236457541', '11022', '2', null, '1522802598@qq.com', '2', '1', '2015-09-14 13:48:03', '0');
INSERT INTO `user` VALUES ('10', 'smh02', '一中队测试02', 'e10adc3949ba59abbe56e057f20f883e', 'smh02', '1', '15826457541', '1200', '2', null, '1014543114@qq.com', '2', '1', '2015-09-14 13:46:33', '0');
INSERT INTO `user` VALUES ('11', 'ssssuu', '大队测试03', 'e10adc3949ba59abbe56e057f20f883e', 'ssssuu', '3', '1234', '1234', '2', null, '1234@qq.com', '2', '1', '2015-09-14 13:55:49', '0');
INSERT INTO `user` VALUES ('12', 'ceshi', '二中队测试01', 'e10adc3949ba59abbe56e057f20f883e', 'ceshi', '1', '18209784562', '1234', '3', null, '123@qq.com', '2', '1', '2015-09-14 17:29:46', '0');
INSERT INTO `user` VALUES ('13', 'ceshi02', '大队测试02', 'e10adc3949ba59abbe56e057f20f883e', 'ceshi02', '1', '1234', '12345', '3', null, '12345@qq.com', '2', '1', '2015-09-15 11:38:25', '0');

-- ----------------------------
-- Table structure for user_group_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_group_relation`;
CREATE TABLE `user_group_relation` (
  `user_id` int(11) NOT NULL COMMENT ' 管理员id',
  `group_id` varchar(32) NOT NULL COMMENT '业务组id',
  `charge_admin` tinyint(4) DEFAULT '0' COMMENT '是否是管理员1，是，0不是',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与组对应关系';

-- ----------------------------
-- Records of user_group_relation
-- ----------------------------
INSERT INTO `user_group_relation` VALUES ('2', '0001', '1');

-- ----------------------------
-- Table structure for user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_role_relation`;
CREATE TABLE `user_role_relation` (
  `user_id` int(11) NOT NULL COMMENT ' 管理员id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of user_role_relation
-- ----------------------------
INSERT INTO `user_role_relation` VALUES ('1', '1');
INSERT INTO `user_role_relation` VALUES ('2', '2');
INSERT INTO `user_role_relation` VALUES ('2', '3');
INSERT INTO `user_role_relation` VALUES ('3', '4');
INSERT INTO `user_role_relation` VALUES ('4', '4');
INSERT INTO `user_role_relation` VALUES ('5', '4');
INSERT INTO `user_role_relation` VALUES ('6', '3');
INSERT INTO `user_role_relation` VALUES ('7', '4');
INSERT INTO `user_role_relation` VALUES ('8', '4');
INSERT INTO `user_role_relation` VALUES ('9', '4');
INSERT INTO `user_role_relation` VALUES ('10', '4');
INSERT INTO `user_role_relation` VALUES ('11', '3');
INSERT INTO `user_role_relation` VALUES ('12', '4');
INSERT INTO `user_role_relation` VALUES ('13', '3');
