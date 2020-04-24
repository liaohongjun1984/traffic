/*
Navicat MySQL Data Transfer

Source Server         : mycon
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : traf

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-11-24 10:12:15
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
-- Table structure for menu_resources_relation
-- ----------------------------
DROP TABLE IF EXISTS `menu_resources_relation`;
CREATE TABLE `menu_resources_relation` (
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  `resources_id` int(11) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`menu_id`,`resources_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单与资源对应表';

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
-- Table structure for road_action_relation
-- ----------------------------
DROP TABLE IF EXISTS `road_action_relation`;
CREATE TABLE `road_action_relation` (
  `action_id` int(11) NOT NULL COMMENT '违法行为id',
  `road_id` int(11) NOT NULL COMMENT '路口id',
  PRIMARY KEY (`action_id`,`road_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='路口与违法行为的对应关系';

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
-- Table structure for role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `role_menu_relation`;
CREATE TABLE `role_menu_relation` (
  `menu_id` int(11) NOT NULL COMMENT '角色id',
  `role_id` int(11) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`menu_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

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
-- Table structure for user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_role_relation`;
CREATE TABLE `user_role_relation` (
  `user_id` int(11) NOT NULL COMMENT ' 管理员id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';
