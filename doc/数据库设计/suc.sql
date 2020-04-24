/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2014/7/22 22:03:04                           */
/*==============================================================*/


drop table if exists app;

drop table if exists app_group;

drop table if exists bus_group;

drop table if exists domain_weights;

drop table if exists info_flow;

drop table if exists key_value_setting;

drop table if exists menu;

drop table if exists menu_resources_relation;

drop table if exists queue1;

drop table if exists queue2;

drop table if exists queue3;

drop table if exists queue4;

drop table if exists queue5;

drop table if exists queue6;

drop table if exists queue_config;

drop table if exists role;

drop table if exists role_menu_relation;

drop table if exists security_resources;

drop table if exists send_log;

drop table if exists sys_log;

drop table if exists user;

drop table if exists user_group_relation;

drop table if exists user_role_relation;

/*==============================================================*/
/* Table: app                                                   */
/*==============================================================*/
create table app
(
   app_id               int not null auto_increment comment '流水号',
   name                 varchar(30) not null comment '名称',
   cn_name              varchar(30) comment '中文名称,显示名称',
   app_key              varchar(50) comment '系统连接上来密码',
   descript             text comment '系统描述',
   status               tinyint default 1 comment '是否可用,1可用，2不可用',
   app_group_id         int comment '应用分类,1运维系统，2 运维内部系统',
   url                  varchar(500) comment '访问url',
   sequence             double comment '排序',
   operator             varchar(20) not null comment '操作者',
   last_modify          datetime comment '更新时间',
   bug_url              varchar(500) comment '报bug url',
   demand_url           varchar(500) comment '提需求url',
   primary key (app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table app comment '应用系统信息';

/*==============================================================*/
/* Table: app_group                                             */
/*==============================================================*/
create table app_group
(
   app_group_id         int not null auto_increment comment '流水号',
   name                 varchar(30) not null comment '名称',
   last_modify          datetime comment '更新时间',
   primary key (app_group_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table app_group comment '应用系统信息';

/*==============================================================*/
/* Table: bus_group                                             */
/*==============================================================*/
create table bus_group
(
   id                   int not null auto_increment comment '自增长id,主要是为生成group_id使用',
   group_id             varchar(32) not null comment '业务组id',
   parent_id            varchar(32) not null default '00' comment '父权限,00表示顶层',
   name                 varchar(100) not null comment '名称',
   notes                text comment '备注',
   status               tinyint default 0 comment '状态0正常，1无效',
   last_modify          datetime comment '更新时间',
   operator             varchar(20) not null comment '操作者',
   primary key (id),
   key AK_Key_business_id (group_id),
   key AK_Key_parent_id (parent_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table bus_group comment '业务组织结构';

/*==============================================================*/
/* Table: domain_weights                                        */
/*==============================================================*/
create table domain_weights
(
   id                   int not null auto_increment,
   host                 varchar(32) not null comment '设置域名',
   weight               int not null default 0 comment '权重',
   app_id               int not null comment '应用系统ID',
   notes                text comment '备注',
   last_modify          datetime comment '修改时间',
   operator             varchar(20) not null comment '操作人',
   primary key (id)
);

alter table domain_weights comment '系统哉名权重信息';

/*==============================================================*/
/* Table: info_flow                                             */
/*==============================================================*/
create table info_flow
(
   id                   int not null auto_increment comment '流水号',
   user_name            varchar(20) comment '用户名称',
   value                text comment '信息流，文本',
   app_id               int comment '应用id',
   create_time          datetime,
   primary key (id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table info_flow comment '各个系统推送信息流，主要用在首页显示';

/*==============================================================*/
/* Table: key_value_setting                                     */
/*==============================================================*/
create table key_value_setting
(
   id                   int not null auto_increment comment '流水号',
   dic_key              varchar(50) comment '字典名称',
   value                text comment '值',
   name                 varchar(100) comment '显示名称',
   primary key (id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table key_value_setting comment '字典通用表';

/*==============================================================*/
/* Table: menu                                                  */
/*==============================================================*/
create table menu
(
   menu_id              int not null auto_increment comment '流水号',
   parent_id            int comment '父菜单id',
   app_id               int comment '应用系统id',
   name                 varchar(30) not null comment '名称',
   url                  varchar(250) not null comment '资源',
   sequence             double not null default 0 comment '排序id号',
   operator             varchar(20) not null comment '操作者',
   last_modify          datetime comment '更新时间',
   hide                 boolean default 0 comment '菜单是否隐藏，true隐藏,false不隐藏',
   primary key (menu_id),
   key AK_Key_2 (app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table menu comment '菜单';

/*==============================================================*/
/* Table: menu_resources_relation                               */
/*==============================================================*/
create table menu_resources_relation
(
   menu_id              int not null comment '菜单id',
   resources_id         int not null comment '资源id',
   primary key (menu_id, resources_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table menu_resources_relation comment '菜单与资源对应表';

/*==============================================================*/
/* Table: queue1                                                */
/*==============================================================*/
create table queue1
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue1 comment '信息队列1';

/*==============================================================*/
/* Table: queue2                                                */
/*==============================================================*/
create table queue2
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue2 comment '信息队列1';

/*==============================================================*/
/* Table: queue3                                                */
/*==============================================================*/
create table queue3
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue3 comment '信息队列1';

/*==============================================================*/
/* Table: queue4                                                */
/*==============================================================*/
create table queue4
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue4 comment '信息队列1';

/*==============================================================*/
/* Table: queue5                                                */
/*==============================================================*/
create table queue5
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue5 comment '信息队列1';

/*==============================================================*/
/* Table: queue6                                                */
/*==============================================================*/
create table queue6
(
   queue_id             bigint not null auto_increment comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '发送类型，1-mail,2-手机,3-yy信息，4-yy群信息',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   data                 text comment '用户自定义数据，可存在json数据等',
   create_admin         varchar(20) comment '创建者',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue6 comment '信息队列1';

/*==============================================================*/
/* Table: queue_config                                          */
/*==============================================================*/
create table queue_config
(
   server_id            int not null auto_increment comment '流水号',
   queue_index          varchar(20) comment '队列索引，多个用","分开',
   create_time          datetime comment '创建时间',
   create_admin         varchar(20) comment '创建管理员',
   primary key (server_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue_config comment '队列配置信息';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id              int not null auto_increment comment '角色id',
   role_name            varchar(30) not null comment '角色名称',
   app_id               int comment '应用id',
   notes                varchar(200) comment '备注',
   operator             varchar(20) default '' comment '操作者',
   last_modify          datetime not null comment '操作时间',
   primary key (role_id),
   unique key AK_Key_2 (role_name, app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table role comment '角色';

/*==============================================================*/
/* Table: role_menu_relation                                    */
/*==============================================================*/
create table role_menu_relation
(
   menu_id              int not null comment '角色id',
   role_id              int not null comment '权限id',
   primary key (menu_id, role_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table role_menu_relation comment '角色与菜单对应关系';

/*==============================================================*/
/* Table: security_resources                                    */
/*==============================================================*/
create table security_resources
(
   resources_id         int not null auto_increment comment '流水号',
   parent_id            int not null default 0 comment '父权限',
   name                 varchar(30) not null comment '名称',
   uri                  varchar(250) not null comment '资源',
   operator             varchar(20) not null comment '操作者',
   last_modify          datetime comment '更新时间',
   sequence             double not null default 0 comment '排序id号',
   app_id               int comment '应用系统id',
   type                 int default 1 comment '资源类型，如1 url,2 button 等',
   primary key (resources_id),
   key AK_Key_4 (parent_id),
   unique key AK_Key_5 (uri, app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table security_resources comment '权限资源';

/*==============================================================*/
/* Table: send_log                                              */
/*==============================================================*/
create table send_log
(
   id                   bigint not null auto_increment,
   queue_id             bigint not null comment '流水号',
   recipient            text comment '收件人，多个用","分开',
   cc                   text comment '抄送，多个用","分开',
   subject              varchar(300) comment '标题',
   message              longtext comment '信息',
   execute_time         datetime comment '执行时间',
   queue_type           int default 1 comment '队列类型',
   create_time          datetime comment '创建时间',
   last_modify          datetime comment '最后修改时间',
   queue_index          int comment '队列索引',
   data                 text comment '用户自定义数据，可存在json数据等',
   result               text comment '通道发送结果',
   create_admin         varchar(20) comment '创建人',
   primary key (id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table send_log comment '发送日志';

/*==============================================================*/
/* Table: sys_log                                               */
/*==============================================================*/
create table sys_log
(
   log_id               int not null auto_increment comment '日志id',
   app_name             varchar(30) comment '应用名称',
   user_name            varchar(30) default '' comment '用户名',
   nick_name            varchar(20) comment '用户名字',
   type                 int not null comment '操作类型',
   content              text not null comment '操作内容',
   create_time          datetime comment '时间',
   result               varchar(25) comment '操作结果',
   app_id               int comment '应该系统id',
   primary key (log_id),
   key AK_Key_user_name (user_name, create_time),
   key AK_Key_type (type),
   key AK_Key_nick_name (nick_name)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table sys_log comment '后台操作记录';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null auto_increment comment '流水号',
   user_name            varchar(20) not null comment '管理员登录名，多玩通行证',
   nick_name            varchar(20) not null default '' comment '真实姓名',
   password             varchar(40) comment '密码',
   operator             varchar(20) not null default '' comment '操作员ID',
   status               tinyint not null default 1 comment '管理员状态，1-正常,2-冻结',
   mobile_no            varchar(15) default NULL comment '移动电话',
   work_no              varchar(15) comment '工作号',
   department           int comment '部门',
   yy_no                varchar(20) comment 'yy号',
   email                varchar(30) comment '邮箱地址',
   admin                boolean comment '是否管理员',
   meta_default_data    tinyint not null default 0 comment '是否是基本用户，0-不是，1-是,不可以删除',
   last_modify          datetime not null comment '修改时间',
   del_flag             tinyint default 0 comment '删除标志 0未删除 1已删除',
   primary key (user_id),
   unique key AK_Key_2 (user_name)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user comment '管理员名单';

/*==============================================================*/
/* Table: user_group_relation                                   */
/*==============================================================*/
create table user_group_relation
(
   user_id              int not null comment ' 管理员id',
   group_id             varchar(32) not null comment '业务组id',
   charge_admin         tinyint default 0 comment '是否是管理员1，是，0不是',
   primary key (user_id, group_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user_group_relation comment '用户与组对应关系';

/*==============================================================*/
/* Table: user_role_relation                                    */
/*==============================================================*/
create table user_role_relation
(
   user_id              int not null comment ' 管理员id',
   role_id              int not null comment '角色id',
   primary key (user_id, role_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user_role_relation comment '用户与角色对应关系';

