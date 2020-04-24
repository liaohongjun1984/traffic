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
   app_id               int not null auto_increment comment '��ˮ��',
   name                 varchar(30) not null comment '����',
   cn_name              varchar(30) comment '��������,��ʾ����',
   app_key              varchar(50) comment 'ϵͳ������������',
   descript             text comment 'ϵͳ����',
   status               tinyint default 1 comment '�Ƿ����,1���ã�2������',
   app_group_id         int comment 'Ӧ�÷���,1��άϵͳ��2 ��ά�ڲ�ϵͳ',
   url                  varchar(500) comment '����url',
   sequence             double comment '����',
   operator             varchar(20) not null comment '������',
   last_modify          datetime comment '����ʱ��',
   bug_url              varchar(500) comment '��bug url',
   demand_url           varchar(500) comment '������url',
   primary key (app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table app comment 'Ӧ��ϵͳ��Ϣ';

/*==============================================================*/
/* Table: app_group                                             */
/*==============================================================*/
create table app_group
(
   app_group_id         int not null auto_increment comment '��ˮ��',
   name                 varchar(30) not null comment '����',
   last_modify          datetime comment '����ʱ��',
   primary key (app_group_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table app_group comment 'Ӧ��ϵͳ��Ϣ';

/*==============================================================*/
/* Table: bus_group                                             */
/*==============================================================*/
create table bus_group
(
   id                   int not null auto_increment comment '������id,��Ҫ��Ϊ����group_idʹ��',
   group_id             varchar(32) not null comment 'ҵ����id',
   parent_id            varchar(32) not null default '00' comment '��Ȩ��,00��ʾ����',
   name                 varchar(100) not null comment '����',
   notes                text comment '��ע',
   status               tinyint default 0 comment '״̬0������1��Ч',
   last_modify          datetime comment '����ʱ��',
   operator             varchar(20) not null comment '������',
   primary key (id),
   key AK_Key_business_id (group_id),
   key AK_Key_parent_id (parent_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table bus_group comment 'ҵ����֯�ṹ';

/*==============================================================*/
/* Table: domain_weights                                        */
/*==============================================================*/
create table domain_weights
(
   id                   int not null auto_increment,
   host                 varchar(32) not null comment '��������',
   weight               int not null default 0 comment 'Ȩ��',
   app_id               int not null comment 'Ӧ��ϵͳID',
   notes                text comment '��ע',
   last_modify          datetime comment '�޸�ʱ��',
   operator             varchar(20) not null comment '������',
   primary key (id)
);

alter table domain_weights comment 'ϵͳ����Ȩ����Ϣ';

/*==============================================================*/
/* Table: info_flow                                             */
/*==============================================================*/
create table info_flow
(
   id                   int not null auto_increment comment '��ˮ��',
   user_name            varchar(20) comment '�û�����',
   value                text comment '��Ϣ�����ı�',
   app_id               int comment 'Ӧ��id',
   create_time          datetime,
   primary key (id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table info_flow comment '����ϵͳ������Ϣ������Ҫ������ҳ��ʾ';

/*==============================================================*/
/* Table: key_value_setting                                     */
/*==============================================================*/
create table key_value_setting
(
   id                   int not null auto_increment comment '��ˮ��',
   dic_key              varchar(50) comment '�ֵ�����',
   value                text comment 'ֵ',
   name                 varchar(100) comment '��ʾ����',
   primary key (id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table key_value_setting comment '�ֵ�ͨ�ñ�';

/*==============================================================*/
/* Table: menu                                                  */
/*==============================================================*/
create table menu
(
   menu_id              int not null auto_increment comment '��ˮ��',
   parent_id            int comment '���˵�id',
   app_id               int comment 'Ӧ��ϵͳid',
   name                 varchar(30) not null comment '����',
   url                  varchar(250) not null comment '��Դ',
   sequence             double not null default 0 comment '����id��',
   operator             varchar(20) not null comment '������',
   last_modify          datetime comment '����ʱ��',
   hide                 boolean default 0 comment '�˵��Ƿ����أ�true����,false������',
   primary key (menu_id),
   key AK_Key_2 (app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table menu comment '�˵�';

/*==============================================================*/
/* Table: menu_resources_relation                               */
/*==============================================================*/
create table menu_resources_relation
(
   menu_id              int not null comment '�˵�id',
   resources_id         int not null comment '��Դid',
   primary key (menu_id, resources_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table menu_resources_relation comment '�˵�����Դ��Ӧ��';

/*==============================================================*/
/* Table: queue1                                                */
/*==============================================================*/
create table queue1
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue1 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue2                                                */
/*==============================================================*/
create table queue2
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue2 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue3                                                */
/*==============================================================*/
create table queue3
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue3 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue4                                                */
/*==============================================================*/
create table queue4
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue4 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue5                                                */
/*==============================================================*/
create table queue5
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue5 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue6                                                */
/*==============================================================*/
create table queue6
(
   queue_id             bigint not null auto_increment comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '�������ͣ�1-mail,2-�ֻ�,3-yy��Ϣ��4-yyȺ��Ϣ',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   create_admin         varchar(20) comment '������',
   primary key (queue_id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue6 comment '��Ϣ����1';

/*==============================================================*/
/* Table: queue_config                                          */
/*==============================================================*/
create table queue_config
(
   server_id            int not null auto_increment comment '��ˮ��',
   queue_index          varchar(20) comment '���������������","�ֿ�',
   create_time          datetime comment '����ʱ��',
   create_admin         varchar(20) comment '��������Ա',
   primary key (server_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table queue_config comment '����������Ϣ';

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id              int not null auto_increment comment '��ɫid',
   role_name            varchar(30) not null comment '��ɫ����',
   app_id               int comment 'Ӧ��id',
   notes                varchar(200) comment '��ע',
   operator             varchar(20) default '' comment '������',
   last_modify          datetime not null comment '����ʱ��',
   primary key (role_id),
   unique key AK_Key_2 (role_name, app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table role comment '��ɫ';

/*==============================================================*/
/* Table: role_menu_relation                                    */
/*==============================================================*/
create table role_menu_relation
(
   menu_id              int not null comment '��ɫid',
   role_id              int not null comment 'Ȩ��id',
   primary key (menu_id, role_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table role_menu_relation comment '��ɫ��˵���Ӧ��ϵ';

/*==============================================================*/
/* Table: security_resources                                    */
/*==============================================================*/
create table security_resources
(
   resources_id         int not null auto_increment comment '��ˮ��',
   parent_id            int not null default 0 comment '��Ȩ��',
   name                 varchar(30) not null comment '����',
   uri                  varchar(250) not null comment '��Դ',
   operator             varchar(20) not null comment '������',
   last_modify          datetime comment '����ʱ��',
   sequence             double not null default 0 comment '����id��',
   app_id               int comment 'Ӧ��ϵͳid',
   type                 int default 1 comment '��Դ���ͣ���1 url,2 button ��',
   primary key (resources_id),
   key AK_Key_4 (parent_id),
   unique key AK_Key_5 (uri, app_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table security_resources comment 'Ȩ����Դ';

/*==============================================================*/
/* Table: send_log                                              */
/*==============================================================*/
create table send_log
(
   id                   bigint not null auto_increment,
   queue_id             bigint not null comment '��ˮ��',
   recipient            text comment '�ռ��ˣ������","�ֿ�',
   cc                   text comment '���ͣ������","�ֿ�',
   subject              varchar(300) comment '����',
   message              longtext comment '��Ϣ',
   execute_time         datetime comment 'ִ��ʱ��',
   queue_type           int default 1 comment '��������',
   create_time          datetime comment '����ʱ��',
   last_modify          datetime comment '����޸�ʱ��',
   queue_index          int comment '��������',
   data                 text comment '�û��Զ������ݣ��ɴ���json���ݵ�',
   result               text comment 'ͨ�����ͽ��',
   create_admin         varchar(20) comment '������',
   primary key (id),
   key AK_Key_2 (execute_time)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table send_log comment '������־';

/*==============================================================*/
/* Table: sys_log                                               */
/*==============================================================*/
create table sys_log
(
   log_id               int not null auto_increment comment '��־id',
   app_name             varchar(30) comment 'Ӧ������',
   user_name            varchar(30) default '' comment '�û���',
   nick_name            varchar(20) comment '�û�����',
   type                 int not null comment '��������',
   content              text not null comment '��������',
   create_time          datetime comment 'ʱ��',
   result               varchar(25) comment '�������',
   app_id               int comment 'Ӧ��ϵͳid',
   primary key (log_id),
   key AK_Key_user_name (user_name, create_time),
   key AK_Key_type (type),
   key AK_Key_nick_name (nick_name)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table sys_log comment '��̨������¼';

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null auto_increment comment '��ˮ��',
   user_name            varchar(20) not null comment '����Ա��¼��������ͨ��֤',
   nick_name            varchar(20) not null default '' comment '��ʵ����',
   password             varchar(40) comment '����',
   operator             varchar(20) not null default '' comment '����ԱID',
   status               tinyint not null default 1 comment '����Ա״̬��1-����,2-����',
   mobile_no            varchar(15) default NULL comment '�ƶ��绰',
   work_no              varchar(15) comment '������',
   department           int comment '����',
   yy_no                varchar(20) comment 'yy��',
   email                varchar(30) comment '�����ַ',
   admin                boolean comment '�Ƿ����Ա',
   meta_default_data    tinyint not null default 0 comment '�Ƿ��ǻ����û���0-���ǣ�1-��,������ɾ��',
   last_modify          datetime not null comment '�޸�ʱ��',
   del_flag             tinyint default 0 comment 'ɾ����־ 0δɾ�� 1��ɾ��',
   primary key (user_id),
   unique key AK_Key_2 (user_name)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user comment '����Ա����';

/*==============================================================*/
/* Table: user_group_relation                                   */
/*==============================================================*/
create table user_group_relation
(
   user_id              int not null comment ' ����Աid',
   group_id             varchar(32) not null comment 'ҵ����id',
   charge_admin         tinyint default 0 comment '�Ƿ��ǹ���Ա1���ǣ�0����',
   primary key (user_id, group_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user_group_relation comment '�û������Ӧ��ϵ';

/*==============================================================*/
/* Table: user_role_relation                                    */
/*==============================================================*/
create table user_role_relation
(
   user_id              int not null comment ' ����Աid',
   role_id              int not null comment '��ɫid',
   primary key (user_id, role_id)
)
ENGINE= InnoDB DEFAULT CHARSET=utf8;

alter table user_role_relation comment '�û����ɫ��Ӧ��ϵ';

