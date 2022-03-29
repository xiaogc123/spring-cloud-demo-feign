create database `pay_db` default character set utf8 collate utf8_general_ci;
use pay_db;
create table `user`
(
  `id`          bigint(20) not null comment 'id',
  `user_phone`  varchar(11) default null comment '手机',
  `user_name`   varchar(80) default null comment '名称',
  `email`       varchar(50) default null comment '邮箱',
  `login_pwd`   varchar(32) default null comment '密码',
  `create_time` datetime    default null comment '创建时间',
  `update_time` datetime    default null comment '更新时间',
  primary key (`id`)
) engine = innodb
  default charset = utf8 comment ='会员信息';

create table `order`
(
  `id`            bigint(20) not null comment '订单id',
  `order_no`      varchar(32)    default null comment '业务订单号',
  `amount`        decimal(20, 0) default null comment '交易金额（单位：分）',
  `payer_user_id` varchar(64)    default null comment '付款方编号',
  `payee_user_id` varchar(64)    default null comment '收款方编号',
  `topup_type`    varchar(10)    default null comment '支付类型（alipay：支付宝 wechat：微信 ）',
  `status`        varchar(10)    default null comment '状态(0:待处理;1:失败;2:成功)',
  `create_time`   datetime       default null comment '创建时间',
  `update_time`   datetime       default null comment '更新时间',
  primary key (`id`),
  unique key `ak_key_order_no` (`order_no`)
) engine = innodb
  default charset = utf8 comment ='订单信息';


create table user_account
(
  id          bigint           not null  comment '资金表id',
  user_id     bigint           null comment '用户ID',
  amount      bigint default 0 null comment '金额',
  check_code  varchar(64)      null comment '金额校验码',
  version     int              null comment '版本号',
  create_time datetime         null,
  update_time datetime         null,
  constraint user_account_pk
    primary key (id)
)
  comment '用户资金表';


