SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounting_entry
-- ----------------------------
DROP TABLE IF EXISTS `accounting_entry`;
CREATE TABLE `accounting_entry`
(
  `ACCOUNTING_ENTRY_ID` bigint(20) NOT NULL COMMENT '会计分录ID',
  `MERCHANT_ID`         bigint(20)     DEFAULT NULL COMMENT '商户ID',
  `USER_ID`             bigint(20)     DEFAULT NULL COMMENT '子商户ID',
  `SUBJECT`             varchar(10)    DEFAULT NULL COMMENT '科目（1:其他货币资金、2:应收账款）',
  `SUBJECT_TYPE`        varchar(10)    DEFAULT NULL COMMENT '类别（1:借、2:贷）',
  `AMOUNT`              decimal(20, 0) DEFAULT NULL COMMENT '操作金额',
  `AMOUNT_BEGIN`        decimal(20, 0) DEFAULT NULL COMMENT '期初金额',
  `AMOUNT_END`          decimal(20, 0) DEFAULT NULL COMMENT '期末金额',
  `ORDER_NO`            varchar(64)    DEFAULT NULL COMMENT '单号（业务平台请求订单号）',
  `REMARKS`             varchar(256)   DEFAULT NULL COMMENT '备注',
  `CREATE_DATE`         datetime       DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ACCOUNTING_ENTRY_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='会计分录信息X';

-- ----------------------------
-- Table structure for am_merchant
-- ----------------------------
DROP TABLE IF EXISTS `am_merchant`;
CREATE TABLE `am_merchant`
(
  `MERCHANT_ID`            bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商户ID',
  `MERCHANT_NAME`          varchar(150)   DEFAULT NULL COMMENT '商户名称',
  `COMPANY_LOCATION`       varchar(150)   DEFAULT NULL COMMENT '公司所在地(详细地址)x',
  `MERCHANT_NO`            varchar(32)    DEFAULT NULL COMMENT '入网商户号(自动生成)x',
  `LEGAL_PERSON`           varchar(30)    DEFAULT NULL COMMENT '法人姓名x',
  `LEGAL_PERSON_IDCARD_NO` varchar(30)    DEFAULT NULL COMMENT '法人身份证号x',
  `STATUS`                 varchar(30)    DEFAULT NULL COMMENT '待审核(TO_BE_AUDIT)、审核失败(AUDIT_FAIL)、审核成功(AUDIT_SUCCESS)、审核中(AUDITING)x',
  `DOMAIN_NAME`            varchar(150)   DEFAULT NULL COMMENT '域名x',
  `IP_ADDR`                varchar(15)    DEFAULT NULL COMMENT 'IP地址x',
  `RECORD_NO`              varchar(100)   DEFAULT NULL COMMENT '备案号x',
  `REGISTERED_CAPITAL`     decimal(20, 2) DEFAULT NULL COMMENT '注册资本x',
  `REGISTER_DATE`          datetime       DEFAULT NULL COMMENT '注册日期x',
  `SERVICE_TEL`            varchar(30)    DEFAULT NULL COMMENT '客服电话x',
  `SERVICE_EMAIL`          varchar(100)   DEFAULT NULL COMMENT '客服邮箱x',
  `MANAGED_ACCOUNT`        varchar(50)    DEFAULT NULL COMMENT '托管账号',
  `DELETE_FLAG`            char(1)        DEFAULT NULL COMMENT '删除标记 是:Y   否: N',
  `PLATFORM_PASSWORD`      varchar(100)   DEFAULT NULL COMMENT '平台密码',
  `PAYMENT_PASSWORD`       varchar(100)   DEFAULT NULL COMMENT '交易密码',
  `PROVINCE`               varchar(100)   DEFAULT NULL COMMENT '省',
  `CITY`                   varchar(100)   DEFAULT NULL COMMENT '市',
  `AREA`                   varchar(100)   DEFAULT NULL COMMENT '区',
  `MER_ID`                 varchar(64)    DEFAULT NULL COMMENT '商户号，（针对渠道,实名认证使用）',
  `PUBLIC_KEY`             varchar(64)    DEFAULT NULL COMMENT '公钥',
  `PRIVATE_KEY`            varchar(64)    DEFAULT NULL COMMENT '私钥',
  `business_man_id`        varchar(32)    DEFAULT NULL COMMENT '业务员ID',
  `business_man_name`      varchar(32)    DEFAULT NULL COMMENT '业务员姓名',
  `audit_status`           varchar(30)    DEFAULT NULL COMMENT '再审核状态：待审核(TO_BE_AUDIT)、审核失败(AUDIT_FAIL)、审核成功(AUDIT_SUCCESS)、审核中(AUDITING)',
  `RECEIVE_URL`            varchar(400)   DEFAULT NULL COMMENT '接收地址',
  PRIMARY KEY (`MERCHANT_ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 33
  DEFAULT CHARSET = utf8 COMMENT ='商户信息';

-- ----------------------------
-- Table structure for am_user
-- ----------------------------
DROP TABLE IF EXISTS `am_user`;
CREATE TABLE `am_user`
(
  `USER_ID`     bigint(20) NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `USER_PHONE`  varchar(11)  DEFAULT NULL COMMENT '手机(会员在平台的登陆账号）',
  `CARD_NO`     varchar(20)  DEFAULT NULL COMMENT '会员身份证',
  `USER_NAME`   varchar(80)  DEFAULT NULL COMMENT '会员名称',
  `EMAIL`       varchar(50)  DEFAULT NULL COMMENT '邮箱',
  `USER_TYPE`   varchar(1)   DEFAULT '0' COMMENT '用户类型;0：个人用户\n            1：企业用户',
  `LOGIN_PWD`   varchar(32)  DEFAULT NULL COMMENT '登陆密码:会员ID+输入密码\n            32位MD5大写加密',
  `TRADE_PWD`   varchar(32)  DEFAULT NULL COMMENT '交易密码:会员ID+输入密码\n            32位MD5大写加密',
  `CREATE_DATE` datetime     DEFAULT NULL COMMENT '创建时间',
  `VERIFIED`    varchar(100) DEFAULT '0' COMMENT '是否已实名认证；0：未认证；1：已认证',
  `SEX`         varchar(100) DEFAULT NULL COMMENT '性别；1男；2女',
  `USER_NO`     varchar(64)  DEFAULT NULL COMMENT '二级商户号',
  PRIMARY KEY (`USER_ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 86
  DEFAULT CHARSET = utf8 COMMENT ='会员信息';

-- ----------------------------
-- Table structure for check_bill
-- ----------------------------
DROP TABLE IF EXISTS `check_bill`;
CREATE TABLE `check_bill`
(
  `CHECK_BILL_ID`     bigint(20) NOT NULL COMMENT '对账单接口ID',
  `MERCHANT_NO`       varchar(32)   DEFAULT NULL COMMENT '商户号',
  `MER_ORDER_NO`      varchar(32)   DEFAULT NULL COMMENT '业务订单号',
  `PLATFORM_ORDER_ID` varchar(32)   DEFAULT NULL COMMENT '响应订单号',
  `BILL_TYPE`         varchar(10)   DEFAULT NULL COMMENT '对账单类型（01：全渠道）',
  `BILL_DATE`         varchar(20)   DEFAULT NULL COMMENT '对账单日期（格式：yyyyMMdd）',
  `DATA_PACKET`       varchar(1000) DEFAULT NULL COMMENT '对账单数据包',
  `RESP_DATA_PACKET`  varchar(2000) DEFAULT NULL COMMENT '对账单响应数据包',
  PRIMARY KEY (`CHECK_BILL_ID`),
  UNIQUE KEY `AK_Key_2` (`MERCHANT_NO`, `MER_ORDER_NO`),
  UNIQUE KEY `AK_Key_3` (`MERCHANT_NO`, `PLATFORM_ORDER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='对账单接口信息';

-- ----------------------------
-- Table structure for check_files
-- ----------------------------
DROP TABLE IF EXISTS `check_files`;
CREATE TABLE `check_files`
(
  `ID`            bigint(20) NOT NULL,
  `MERCHANT_NO`   varchar(32)   DEFAULT NULL,
  `TXN_DATE`      varchar(32)   DEFAULT NULL,
  `DOWN_FLAG`     char(1)       DEFAULT NULL,
  `ANALYSIS_FLAG` char(1)       DEFAULT NULL,
  `CHECK_FLAG`    char(1)       DEFAULT NULL,
  `ADJUST_FLAG`   char(1)       DEFAULT NULL,
  `MESSAGE`       varchar(2000) DEFAULT NULL,
  `RECHARGE_TYPE` varchar(10)   DEFAULT NULL,
  `MER_ID`        varchar(32)   DEFAULT NULL,
  `CHANNEL_TYPE`  varchar(10)   DEFAULT NULL,
  `CREATE_DATE`   datetime      DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='对账文件下载列表';

-- ----------------------------
-- Table structure for merchant_user
-- ----------------------------
DROP TABLE IF EXISTS `merchant_user`;
CREATE TABLE `merchant_user`
(
  `MU_ID`            bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商户会员ID',
  `USER_ID`          bigint(20)   DEFAULT NULL COMMENT '会员在分账平台的ID',
  `MERCHANT_NO`      varchar(32)  DEFAULT NULL COMMENT '商户在分账平台的编码',
  `USER_PHONE`       varchar(11)  DEFAULT NULL COMMENT '手机',
  `GRANTED`          varchar(100) DEFAULT '0' COMMENT '是否已授权；0：未授权；1：已授权',
  `CREATE_DATE`      datetime     DEFAULT NULL COMMENT '创建时间',
  `MERCHANT_USER_ID` varchar(50)  DEFAULT NULL COMMENT '会员在商户平台的ID',
  `STATUS`           varchar(100) DEFAULT NULL COMMENT '状态：0正常，1停用',
  PRIMARY KEY (`MU_ID`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 70
  DEFAULT CHARSET = utf8 COMMENT ='商户会员信息';

-- ----------------------------
-- Table structure for order_payment_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_payment_detail`;
CREATE TABLE `order_payment_detail`
(
  `ORDER_PAYMENT_DETAIL_ID` bigint(20) NOT NULL COMMENT '订单支付明细ID',
  `ORDER_PAYMENT_ID`        bigint(20) DEFAULT NULL COMMENT '支付订单ID',
  `PAYEE_USER_LIST`         text COMMENT '收款人信息列表',
  `PAY_DATA_PACKET`         text COMMENT '支付数据包',
  PRIMARY KEY (`ORDER_PAYMENT_DETAIL_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='订单支付明细';

-- ----------------------------
-- Table structure for order_transfer_account_receive
-- ----------------------------
DROP TABLE IF EXISTS `order_transfer_account_receive`;
CREATE TABLE `order_transfer_account_receive`
(
  `PAYEE_DETAIL_ID`               bigint(20) NOT NULL AUTO_INCREMENT COMMENT '转账明细ID',
  `TRANS_ID`                      bigint(20)     DEFAULT NULL COMMENT '转账ID',
  `PLATFORM_ORDER_ID`             varchar(32)    DEFAULT NULL COMMENT '响应订单号',
  `ORDER_ID`                      varchar(32)    DEFAULT NULL COMMENT '业务平台交易订单号',
  `PAYEE_USER_NO`                 varchar(64)    DEFAULT NULL COMMENT '收款方账号ID',
  `PAYEE_AMOUNT`                  decimal(20, 0) DEFAULT NULL COMMENT '收款金额',
  `FEE_TO_MERCHANT`               decimal(20, 0) DEFAULT NULL COMMENT '佣金(商户平台向会员收取的手续费)',
  `TRANSFER_TYPE`                 varchar(10)    DEFAULT NULL COMMENT '转账方式(0：托管转账，需要商户管理员审核通过后，资金才会划转到对方账户；1：直接转账，转账成功后，资金直接划转到对方账户中。)',
  `FEE_TYPE`                      varchar(10)    DEFAULT NULL COMMENT '佣金收取方式(0：立即收取；1：交易结束时收取。如果商户有收取交易手续费，且转账方式为“托管转账”时有效)',
  `AUTO_PAYDAY`                   varchar(10)    DEFAULT NULL COMMENT '自动支付时间：天(当transferType为“0：托管转账”时有效,当传入为空时系统不会自动转账确认)',
  `AUDIT_TYPE`                    varchar(10)    DEFAULT NULL COMMENT '审核类型(0:未审核,1:部分审核,2:全部审核)',
  `ITEM_LIST`                     text COMMENT '商品列表json格式',
  `CREATE_DATE`                   datetime       DEFAULT NULL COMMENT '创建时间',
  `AUTO_AUDIT_DATE`               datetime       DEFAULT NULL COMMENT '自动确认时间',
  `PASS_AMOUNT`                   decimal(20, 0) DEFAULT NULL COMMENT '审核通过金额(与回退金额总和为：收费金额)',
  `FALLBACK_AMOUNT`               decimal(20, 0) DEFAULT NULL COMMENT '审核回退金额(与通过金额总和为：收费金额)',
  `PASS_FEE_AMOUNT`               decimal(20, 0) DEFAULT NULL COMMENT '审核通过佣金(与回退佣金总和为：佣金)',
  `FALLBACK_FEE_AMOUNT`           decimal(20, 0) DEFAULT NULL COMMENT '审核回退佣金(与通过佣金总和为：佣金)',
  `REFUND_AMOUNT`                 decimal(20, 0) DEFAULT NULL COMMENT '已退款金额',
  `FEE_TO_MERCHANT_REFUND_AMOUNT` decimal(20, 0) DEFAULT NULL COMMENT '商户平台立即收取佣金退款金额',
  `CHECK_CODE`                    varchar(64)    DEFAULT NULL COMMENT 'MD5校验码',
  `PAYEE_USER_NAME`               varchar(100)   DEFAULT NULL COMMENT '收款方二级商户名称',
  PRIMARY KEY (`PAYEE_DETAIL_ID`),
  UNIQUE KEY `AK_Key_2` (`TRANS_ID`, `ORDER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='转账明细';

-- ----------------------------
-- Table structure for order_transfer_order
-- ----------------------------
DROP TABLE IF EXISTS `order_transfer_order`;
CREATE TABLE `order_transfer_order`
(
  `TRANSFER_ORDER_ID`   bigint(20) NOT NULL AUTO_INCREMENT COMMENT '转账ID',
  `MER_ORDER_ID`        bigint(20)     DEFAULT NULL COMMENT '请求订单号',
  `PLATFORM_ORDER_ID`   varchar(32)    DEFAULT NULL COMMENT '响应订单号',
  `MERCHANT_NO`         varchar(32)    DEFAULT NULL COMMENT '商户编号',
  `AMOUNT`              decimal(20, 0) DEFAULT NULL COMMENT '交易金额',
  `PAYER_USER_NO`       varchar(64)    DEFAULT NULL COMMENT '付款方二级商户号',
  `PAYER_USER_NAME`     varchar(150)   DEFAULT NULL COMMENT '付款人姓名',
  `PAYER_USER_PHONE`    varchar(20)    DEFAULT NULL COMMENT '付款人手机号',
  `ACTION_TYPE`         varchar(10)    DEFAULT NULL COMMENT '业务类型(1：消费转账)X',
  `PAY_TYPE`            varchar(10)    DEFAULT NULL COMMENT '转账支付方式(0:余额转账，1:充值转账)X',
  `TOPUP_MER_ORDER_ID`  varchar(64)    DEFAULT NULL COMMENT '充值订单号',
  `TOPUP_STATUS`        varchar(10)    DEFAULT NULL COMMENT '充值状态(0：充值成功；1：充值失败；2：待处理)',
  `STATUS`              varchar(10)    DEFAULT NULL COMMENT '单据状态(1:转账待处理;2:转账失败;3:转账成功)',
  `FRONT_URL`           varchar(500)   DEFAULT NULL COMMENT '前台回调地址',
  `NOTIFY_URL`          varchar(500)   DEFAULT NULL COMMENT '后台回调地址',
  `PARAMETER1`          varchar(100)   DEFAULT NULL COMMENT '自定义参数1',
  `PARAMETER2`          varchar(100)   DEFAULT NULL COMMENT '自定义参数2',
  `CREATE_DATE`         datetime       DEFAULT NULL COMMENT '创建时间',
  `ACCREDIT_VERSION_NO` decimal(8, 0)  DEFAULT NULL COMMENT '授权版本号',
  `TOPUP_FEE_PAYER`     varchar(10)    DEFAULT '0' COMMENT '充值手续费承担方：0：商户平台；1：会员(收款方)。默认为商户平台X',
  `TOPUP_FEE`           decimal(8, 0)  DEFAULT NULL COMMENT '充值手续费',
  `REFUND_TOPUP_FEE`    decimal(20, 0) DEFAULT NULL COMMENT '已退充值手续费',
  `TOPUP_TYPE`          varchar(10)    DEFAULT NULL COMMENT '支付类型（1：个人网关 2：企业网银 3：快捷支付）',
  `PAYMENT_ORDER_ID`    bigint(20)     DEFAULT NULL COMMENT '支付订单ID',
  `CHANNEL_TYPE`        varchar(10)    DEFAULT NULL COMMENT '渠道类型（01：全渠道）',
  PRIMARY KEY (`TRANSFER_ORDER_ID`),
  UNIQUE KEY `AK_Key_2` (`MER_ORDER_ID`, `MERCHANT_NO`),
  UNIQUE KEY `AK_Key_3` (`PLATFORM_ORDER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='转账信息';

-- ----------------------------
-- Table structure for payment_order
-- ----------------------------
DROP TABLE IF EXISTS `payment_order`;
CREATE TABLE `payment_order`
(
  `PAYMENT_ORDER_ID`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '支付订单ID',
  `MERCHANT_NO`       varchar(32)    DEFAULT NULL COMMENT '商户号',
  `MER_ORDER_NO`      varchar(32)    DEFAULT NULL COMMENT '业务订单号',
  `PLATFORM_ORDER_ID` varchar(32)    DEFAULT NULL COMMENT '响应订单号',
  `AMOUNT`            decimal(20, 0) DEFAULT NULL COMMENT '交易金额（单位：分）',
  `PAYER_USER_NO`     varchar(64)    DEFAULT NULL COMMENT '付款方平台账号',
  `PAYER_USER_NAME`   varchar(150)   DEFAULT NULL COMMENT '付款方名称',
  `PAYER_USER_PHONE`  varchar(20)    DEFAULT NULL COMMENT '付款方手机号',
  `TOPUP_TYPE`        varchar(10)    DEFAULT NULL COMMENT '支付类型（0000：余额转账 0101：个人网关 0201：企业网银 0301：快捷支付）\r\n            前两位为支付类型，后两位为渠道',
  `FRONT_URL`         varchar(500)   DEFAULT NULL COMMENT '前台回调地址',
  `NOTIFY_URL`        varchar(500)   DEFAULT NULL COMMENT '后台回调地址',
  `PARAMETER1`        varchar(100)   DEFAULT NULL COMMENT '自定义参数1',
  `PARAMETER2`        varchar(100)   DEFAULT NULL COMMENT '自定义参数2',
  `STATUS`            varchar(10)    DEFAULT NULL COMMENT '单据状态(1:转账待处理;2:转账失败;3:转账成功)',
  `REMARKS`           varchar(512)   DEFAULT NULL COMMENT '摘要',
  `CREATE_DATE`       datetime       DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE`       datetime       DEFAULT NULL COMMENT '更新时间',
  `TOPUP_FEE`         decimal(20, 0) DEFAULT NULL COMMENT '充值手续费',
  PRIMARY KEY (`PAYMENT_ORDER_ID`),
  UNIQUE KEY `AK_Key_2` (`MER_ORDER_NO`, `MERCHANT_NO`),
  UNIQUE KEY `AK_Key_3` (`PLATFORM_ORDER_ID`, `MERCHANT_NO`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='支付订单信息';

-- ----------------------------
-- Table structure for refunds
-- ----------------------------
DROP TABLE IF EXISTS `refunds`;
CREATE TABLE `refunds`
(
  `REFUNDS_ID`         bigint(20) NOT NULL AUTO_INCREMENT COMMENT '退款ID',
  `MERCHANT_NO`        varchar(32)    DEFAULT NULL COMMENT '商户号',
  `MER_ORDER_NO`       varchar(32)    DEFAULT NULL COMMENT '请求订单号',
  `PLATFORM_ORDER_ID`  varchar(32)    DEFAULT NULL COMMENT '响应订单号',
  `USER_NO`            varchar(64)    DEFAULT NULL COMMENT '付款人业务编号',
  `AMOUNT`             decimal(20, 0) DEFAULT NULL COMMENT '退款金额',
  `ORIG_MER_ORDER_NO`  varchar(32)    DEFAULT NULL COMMENT '原支付请求订单号',
  `REFUND_NO`          varchar(64)    DEFAULT NULL COMMENT '退款订单号(请求渠道订单号)',
  `REFUNDS_LIST`       varchar(1000)  DEFAULT NULL COMMENT '退款列表',
  `NOTIFY_URL`         varchar(500)   DEFAULT NULL COMMENT '后台回调地址',
  `PARAMETER1`         varchar(100)   DEFAULT NULL COMMENT '自定义参数1',
  `STATUS`             varchar(10)    DEFAULT NULL COMMENT '退款状态（0：成功 1：失败 2：待处理）',
  `TOPUP_TYPE`         varchar(10)    DEFAULT NULL COMMENT '支付类型',
  `PAYMENT_ORDER_ID`   bigint(20)     DEFAULT NULL COMMENT '支付订单ID',
  `CREATE_DATE`        datetime       DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE`        datetime       DEFAULT NULL COMMENT '更新时间',
  `REFUND_DATA_PACKET` varchar(2000)  DEFAULT NULL COMMENT '退款数据包',
  `REFUNDS_FEE`        decimal(20, 0) DEFAULT NULL COMMENT '退款手续费',
  PRIMARY KEY (`REFUNDS_ID`),
  UNIQUE KEY `AK_Key_2` (`MER_ORDER_NO`, `MERCHANT_NO`),
  UNIQUE KEY `AK_Key_3` (`PLATFORM_ORDER_ID`, `MERCHANT_NO`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='退款信息';

-- ----------------------------
-- Table structure for refunds_detail
-- ----------------------------
DROP TABLE IF EXISTS `refunds_detail`;
CREATE TABLE `refunds_detail`
(
  `REFUNDS_DETAIL_ID` bigint(20) NOT NULL COMMENT '退款明细ID',
  `REFUNDS_ID`        bigint(20)     DEFAULT NULL COMMENT '退款ID',
  `ORDER_ID`          varchar(32)    DEFAULT NULL COMMENT '业务平台交易订单号',
  `AMOUNT`            decimal(20, 0) DEFAULT NULL COMMENT '退款金额',
  PRIMARY KEY (`REFUNDS_DETAIL_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='退款明细';

-- ----------------------------
-- Table structure for union_pay_checkitem
-- ----------------------------
DROP TABLE IF EXISTS `union_pay_checkitem`;
CREATE TABLE `union_pay_checkitem`
(
  `UNION_PAY_CHECKITEM_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '全渠道对账信息ID',
  `PAYMENT_ORDER_ID`       bigint(20)     DEFAULT NULL COMMENT '对账单接口ID',
  `MERCHANT_NO`            varchar(32)    DEFAULT NULL COMMENT '商户号',
  `SETTLE_DATE`            varchar(10)    DEFAULT NULL COMMENT '清算日期(格式:MMDD)',
  `FILE_NAME`              varchar(256)   DEFAULT NULL COMMENT '对账文件名',
  `TRACE_NO`               varchar(10)    DEFAULT NULL COMMENT '系统跟踪号',
  `TXN_TIME`               varchar(20)    DEFAULT NULL COMMENT '交易传输时间',
  `PAY_CARD_NO`            varchar(32)    DEFAULT NULL COMMENT '支付账号',
  `TXN_AMT`                decimal(20, 0) DEFAULT NULL COMMENT '交易金额',
  `QUERY_ID`               varchar(32)    DEFAULT NULL COMMENT '查询流水号',
  `OLD_PAY_TYPE`           varchar(10)    DEFAULT NULL COMMENT '支付方式（旧）',
  `ORDER_ID`               varchar(64)    DEFAULT NULL COMMENT '商户订单号',
  `PAY_CARD_TYPE`          varchar(16)    DEFAULT NULL COMMENT '支付卡类型',
  `ORIG_TXN_DATE`          varchar(32)    DEFAULT NULL COMMENT '原始交易日期时间',
  `FEE`                    decimal(20, 0) DEFAULT NULL COMMENT '商户手续费',
  `SETTLE_AMT`             decimal(20, 0) DEFAULT NULL COMMENT '结算金额',
  `PAY_TYPE`               varchar(16)    DEFAULT NULL COMMENT '支付方式',
  `TXN_TYPE`               varchar(60)    DEFAULT NULL COMMENT '交易类型',
  `BIZ_TYPE`               varchar(20)    DEFAULT NULL COMMENT '业务类型',
  `ACC_TYPE`               varchar(10)    DEFAULT NULL COMMENT '账号类型',
  `BILL_TYPE`              varchar(10)    DEFAULT NULL COMMENT '账单类型',
  `BILL_NO`                varchar(64)    DEFAULT NULL COMMENT '账单号码',
  `TXN_DATE`               varchar(32)    DEFAULT NULL COMMENT '交易日期',
  `MER_ID`                 varchar(32)    DEFAULT NULL COMMENT '渠道商户代码',
  `SPLIT_TYPE`             varchar(10)    DEFAULT NULL COMMENT '分账入账方式',
  `SUB_MER_ID`             varchar(32)    DEFAULT NULL COMMENT '二级商户代码',
  `SUB_MER_ABBR`           varchar(64)    DEFAULT NULL COMMENT '二级商户简称',
  `CHECK_FLAG`             char(1)        DEFAULT NULL COMMENT '是否已对账（0：否 1：是）',
  `UPLOAD_FLAG`            char(1)        DEFAULT NULL COMMENT '是否上传清算平台（0：否 1：是）',
  `REMARKS`                varchar(200)   DEFAULT NULL COMMENT '备注',
  `CREATE_DATE`            datetime       DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE`            datetime       DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`UNION_PAY_CHECKITEM_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='全渠道对账信息';

-- ----------------------------
-- Table structure for union_pay_info
-- ----------------------------
DROP TABLE IF EXISTS `union_pay_info`;
CREATE TABLE `union_pay_info`
(
  `UNION_PAY_INFO_ID`    bigint(20) NOT NULL AUTO_INCREMENT COMMENT '全渠道支付信息ID',
  `TXN_TYPE`             varchar(2)     DEFAULT NULL COMMENT '交易类型（01：消费 ）',
  `TXN_SUB_TYPE`         varchar(2)     DEFAULT NULL COMMENT '交易子类（01：消费）',
  `BIZ_TYPE`             varchar(6)     DEFAULT NULL COMMENT '产品类型（000201：个人网银 000202：企业网银）',
  `CHANNEL_TYPE`         varchar(20)    DEFAULT NULL COMMENT '渠道类型（05：语音 07：互联网 08：移动）',
  `FRONT_URL`            varchar(256)   DEFAULT NULL COMMENT '前台通知地址',
  `BACK_URL`             varchar(256)   DEFAULT NULL COMMENT '后台通知地址',
  `ACCESS_TYPE`          varchar(1)     DEFAULT NULL COMMENT '接入类型（0：商户直连接入 1：收单机构接入 2：平台商户接入）',
  `MER_ID`               varchar(32)    DEFAULT NULL COMMENT '商户代码',
  `ORDER_ID`             varchar(40)    DEFAULT NULL COMMENT '商户订单号',
  `TXN_TIME`             varchar(20)    DEFAULT NULL COMMENT '订单发送时间（YYYYMMDDhhmmss）',
  `TXN_AMT`              varchar(20)    DEFAULT NULL COMMENT '交易金额（单位：分）',
  `CURRENCY_CODE`        varchar(10)    DEFAULT NULL COMMENT '交易币种（156：人民币）',
  `QUERY_ID`             varchar(30)    DEFAULT NULL COMMENT '交易查询流水号',
  `RESP_CODE`            varchar(10)    DEFAULT NULL COMMENT '应答码',
  `RESP_MSG`             varchar(500)   DEFAULT NULL COMMENT '应答信息',
  `SETTLE_AMT`           varchar(20)    DEFAULT NULL COMMENT '清算金额',
  `SETTLE_CURRENCY_CODE` varchar(10)    DEFAULT NULL COMMENT '清算币种',
  `SETTLE_DATE`          varchar(10)    DEFAULT NULL COMMENT '清算日期（MMDD）',
  `TRACE_NO`             varchar(40)    DEFAULT NULL COMMENT '系统跟踪号',
  `TRACE_TIME`           varchar(20)    DEFAULT NULL COMMENT '交易传输时间（MMDDhhmmss）',
  `STATUS`               varchar(10)    DEFAULT NULL COMMENT '状态（0：成功 1：失败 2：待处理）',
  `PAY_TIMEOUT`          varchar(20)    DEFAULT NULL COMMENT '支付超时时间（YYYYMMDDhhmmss）订单支付超时时间，超过此时间用户支付成功的交易，不通知商户，系统自动退款，大约5个工作日金额返还到用户账户',
  `UPDATE_TYPE`          varchar(10)    DEFAULT NULL COMMENT '更新类型（1：支付回调更新、2：查询更新 3：对账更新）',
  `CREATE_DATE`          datetime       DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE`          datetime       DEFAULT NULL COMMENT '更新时间',
  `PAYMENT_ORDER_ID`     bigint(20)     DEFAULT NULL COMMENT '支付订单ID',
  `TOPUP_FEE`            decimal(20, 0) DEFAULT NULL COMMENT '充值手续费',
  PRIMARY KEY (`UNION_PAY_INFO_ID`),
  UNIQUE KEY `AK_Key_2` (`ORDER_ID`, `MER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='全渠道支付信息';

-- ----------------------------
-- Table structure for union_pay_refund
-- ----------------------------
DROP TABLE IF EXISTS `union_pay_refund`;
CREATE TABLE `union_pay_refund`
(
  `UNION_PAY_REFUND_ID`  bigint(20) NOT NULL AUTO_INCREMENT COMMENT '全渠道支付退款ID',
  `TXN_TYPE`             varchar(2)     DEFAULT NULL COMMENT '交易类型（01：消费 ）',
  `TXN_SUB_TYPE`         varchar(2)     DEFAULT NULL COMMENT '交易子类（01：消费）',
  `BIZ_TYPE`             varchar(6)     DEFAULT NULL COMMENT '产品类型（000201：个人网银 000202：企业网银）',
  `CHANNEL_TYPE`         varchar(20)    DEFAULT NULL COMMENT '渠道类型（05：语音 07：互联网 08：移动）',
  `BACK_URL`             varchar(256)   DEFAULT NULL COMMENT '后台通知地址',
  `ACCESS_TYPE`          varchar(1)     DEFAULT NULL COMMENT '接入类型（0：商户直连接入 1：收单机构接入 2：平台商户接入）',
  `MER_ID`               varchar(32)    DEFAULT NULL COMMENT '商户代码',
  `ORDER_ID`             varchar(40)    DEFAULT NULL COMMENT '商户订单号',
  `ORIG_QRY_ID`          varchar(30)    DEFAULT NULL COMMENT '原始交易流水号（原始消费交易的queryId）',
  `TXN_TIME`             varchar(20)    DEFAULT NULL COMMENT '订单发送时间（YYYYMMDDhhmmss）',
  `TXN_AMT`              varchar(20)    DEFAULT NULL COMMENT '交易金额（单位：分）',
  `CURRENCY_CODE`        varchar(10)    DEFAULT NULL COMMENT '交易币种（156：人民币）',
  `QUERY_ID`             varchar(30)    DEFAULT NULL COMMENT '交易查询流水号（退货交易的交易流水号供查询用）',
  `RESP_CODE`            varchar(10)    DEFAULT NULL COMMENT '应答码',
  `RESP_MSG`             varchar(500)   DEFAULT NULL COMMENT '应答信息',
  `SETTLE_AMT`           varchar(20)    DEFAULT NULL COMMENT '清算金额',
  `SETTLE_CURRENCY_CODE` varchar(10)    DEFAULT NULL COMMENT '清算币种',
  `SETTLE_DATE`          varchar(10)    DEFAULT NULL COMMENT '清算日期（MMDD）',
  `TRACE_NO`             varchar(40)    DEFAULT NULL COMMENT '系统跟踪号',
  `TRACE_TIME`           varchar(20)    DEFAULT NULL COMMENT '交易传输时间（MMDDhhmmss）',
  `STATUS`               varchar(10)    DEFAULT NULL COMMENT '退款状态（0：成功 1：失败 2：待处理）',
  `CREATE_DATE`          datetime       DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE`          datetime       DEFAULT NULL COMMENT '更新时间',
  `REFUNDS_ID`           bigint(20)     DEFAULT NULL COMMENT '退款ID',
  `REFUNDS_FEE`          decimal(20, 0) DEFAULT NULL COMMENT '退款手续费',
  PRIMARY KEY (`UNION_PAY_REFUND_ID`),
  UNIQUE KEY `AK_Key_2` (`ORDER_ID`, `MER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='全渠道退款信息';

-- ----------------------------
-- Table structure for upms_log
-- ----------------------------
DROP TABLE IF EXISTS `upms_log`;
CREATE TABLE `upms_log`
(
  `log_id`      bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `description` varchar(100)  DEFAULT NULL COMMENT '操作描述',
  `username`    varchar(20)   DEFAULT NULL COMMENT '操作用户',
  `start_time`  bigint(20)    DEFAULT NULL COMMENT '操作时间',
  `spend_time`  int(11)       DEFAULT NULL COMMENT '消耗时间',
  `base_path`   varchar(500)  DEFAULT NULL COMMENT '根路径',
  `uri`         varchar(500)  DEFAULT NULL COMMENT 'URI',
  `url`         varchar(500)  DEFAULT NULL COMMENT 'URL',
  `method`      varchar(10)   DEFAULT NULL COMMENT '请求类型',
  `parameter`   varchar(2000) DEFAULT NULL,
  `user_agent`  varchar(500)  DEFAULT NULL COMMENT '用户标识',
  `ip`          varchar(30)   DEFAULT NULL COMMENT 'IP地址',
  `result`      mediumtext,
  `permissions` varchar(100)  DEFAULT NULL COMMENT '权限值',
  PRIMARY KEY (`log_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='操作日志';

-- ----------------------------
-- Table structure for upms_organization
-- ----------------------------
DROP TABLE IF EXISTS `upms_organization`;
CREATE TABLE `upms_organization`
(
  `organization_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `pid`             bigint(20)    DEFAULT NULL COMMENT '所属上级',
  `name`            varchar(20)   DEFAULT NULL COMMENT '组织名称',
  `description`     varchar(1000) DEFAULT NULL COMMENT '组织描述',
  `ctime`           bigint(20)    DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`organization_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8 COMMENT ='组织';

-- ----------------------------
-- Table structure for upms_permission
-- ----------------------------
DROP TABLE IF EXISTS `upms_permission`;
CREATE TABLE `upms_permission`
(
  `permission_id`    bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `system_id`        bigint(20) NOT NULL COMMENT '所属系统',
  `pid`              bigint(20)   DEFAULT NULL COMMENT '所属上级',
  `name`             varchar(20)  DEFAULT NULL COMMENT '名称',
  `type`             tinyint(4)   DEFAULT NULL COMMENT '类型(1:目录,2:菜单,3:按钮)',
  `permission_value` varchar(50)  DEFAULT NULL COMMENT '权限值',
  `uri`              varchar(100) DEFAULT NULL COMMENT '路径',
  `icon`             varchar(50)  DEFAULT NULL COMMENT '图标',
  `status`           tinyint(4)   DEFAULT NULL COMMENT '状态(0:禁止,1:正常)',
  `create_time`      datetime     DEFAULT NULL COMMENT '创建时间',
  `orders`           bigint(20)   DEFAULT NULL COMMENT '排序',
  `modify_time`      datetime     DEFAULT NULL,
  `creater`          varchar(40)  DEFAULT NULL,
  `modifier`         varchar(40)  DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 176
  DEFAULT CHARSET = utf8 COMMENT ='权限';

-- ----------------------------
-- Table structure for upms_role
-- ----------------------------
DROP TABLE IF EXISTS `upms_role`;
CREATE TABLE `upms_role`
(
  `role_id`     bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name`        varchar(20)   DEFAULT NULL COMMENT '角色名称',
  `title`       varchar(20)   DEFAULT NULL COMMENT '角色标题',
  `description` varchar(1000) DEFAULT NULL COMMENT '角色描述',
  `create_time` datetime      DEFAULT NULL COMMENT '创建时间',
  `orders`      bigint(20) NOT NULL COMMENT '排序',
  `locked`      tinyint(4)    DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8 COMMENT ='角色';

-- ----------------------------
-- Table structure for upms_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `upms_role_permission`;
CREATE TABLE `upms_role_permission`
(
  `role_permission_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role_id`            bigint(20) NOT NULL COMMENT '角色编号',
  `permission_id`      bigint(20) NOT NULL COMMENT '权限编号',
  PRIMARY KEY (`role_permission_id`),
  KEY `FK_Reference_23` (`role_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 5147
  DEFAULT CHARSET = utf8 COMMENT ='角色权限关联表';

-- ----------------------------
-- Table structure for upms_system
-- ----------------------------
DROP TABLE IF EXISTS `upms_system`;
CREATE TABLE `upms_system`
(
  `system_id`   bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `icon`        varchar(50)  DEFAULT NULL COMMENT '图标',
  `banner`      varchar(150) DEFAULT NULL COMMENT '背景',
  `theme`       varchar(50)  DEFAULT NULL COMMENT '主题',
  `basepath`    varchar(100) DEFAULT NULL COMMENT '根目录',
  `status`      tinyint(4)   DEFAULT NULL COMMENT '状态(-1:黑名单,1:正常)',
  `name`        varchar(20)  DEFAULT NULL COMMENT '系统名称',
  `title`       varchar(20)  DEFAULT NULL COMMENT '系统标题',
  `description` varchar(300) DEFAULT NULL COMMENT '系统描述',
  `ctime`       bigint(20)   DEFAULT NULL COMMENT '创建时间',
  `orders`      bigint(20)   DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`system_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8 COMMENT ='系统';

-- ----------------------------
-- Table structure for upms_user
-- ----------------------------
DROP TABLE IF EXISTS `upms_user`;
CREATE TABLE `upms_user`
(
  `user_id`         bigint(20)  NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_name`       varchar(20) NOT NULL COMMENT '帐号',
  `password`        varchar(32)   DEFAULT NULL COMMENT '密码MD5(密码+盐)',
  `salt`            varchar(32)   DEFAULT NULL COMMENT '盐',
  `real_name`       varchar(20)   DEFAULT NULL COMMENT '姓名',
  `avatar`          varchar(150)  DEFAULT NULL COMMENT '头像',
  `phone`           varchar(20)   DEFAULT NULL COMMENT '电话',
  `email`           varchar(50)   DEFAULT NULL COMMENT '邮箱',
  `sex`             tinyint(4)    DEFAULT '1' COMMENT '性别',
  `locked`          tinyint(4)    DEFAULT '0' COMMENT '状态(0:正常,1:锁定)',
  `create_time`     datetime      DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creater`         varchar(40)   DEFAULT NULL,
  `modify_time`     datetime      DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `modifier`        varchar(40)   DEFAULT NULL,
  `role_ids`        varchar(1000) DEFAULT NULL,
  `role_name`       varchar(1000) DEFAULT NULL,
  `verify_password` char(1)       DEFAULT '0' COMMENT '是否修改过密码0未修改1已修改',
  `account_type`    char(1)       DEFAULT NULL COMMENT '账户类型0平台账户1代理商账号2商户账户',
  PRIMARY KEY (`user_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 940066629088182273
  DEFAULT CHARSET = utf8 COMMENT ='用户';

-- ----------------------------
-- Table structure for upms_user_organization
-- ----------------------------
DROP TABLE IF EXISTS `upms_user_organization`;
CREATE TABLE `upms_user_organization`
(
  `user_organization_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id`              bigint(20) NOT NULL COMMENT '用户编号',
  `organization_id`      bigint(20) NOT NULL COMMENT '组织编号',
  PRIMARY KEY (`user_organization_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 24
  DEFAULT CHARSET = utf8 COMMENT ='用户组织关联表';

-- ----------------------------
-- Table structure for upms_user_permission
-- ----------------------------
DROP TABLE IF EXISTS `upms_user_permission`;
CREATE TABLE `upms_user_permission`
(
  `user_permission_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id`            bigint(20) NOT NULL COMMENT '用户编号',
  `permission_id`      bigint(20) NOT NULL COMMENT '权限编号',
  `type`               tinyint(4) NOT NULL COMMENT '权限类型(-1:减权限,1:增权限)',
  PRIMARY KEY (`user_permission_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 25
  DEFAULT CHARSET = utf8 COMMENT ='用户权限关联表';

-- ----------------------------
-- Table structure for upms_user_role
-- ----------------------------
DROP TABLE IF EXISTS `upms_user_role`;
CREATE TABLE `upms_user_role`
(
  `user_role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id`      bigint(20) NOT NULL COMMENT '用户编号',
  `role_id`      bigint(20) DEFAULT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_role_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 936481206726295554
  DEFAULT CHARSET = utf8 COMMENT ='用户角色关联表';

-- 2018/1/24 yaojc
alter table am_merchant
  add column phone VARCHAR(11) COMMENT '手机号';
alter table am_merchant
  add column contact_name VARCHAR(30) COMMENT '联系人';
alter table am_merchant
  add column remark VARCHAR(200) COMMENT '备注';

alter table am_user
  add column CONTACT_MAN varchar(80) comment '联系人';
alter table am_user
  add column AUDIT_STATUS varchar(10) comment '审核状态(0：待审核 1：已审核)';
alter table am_user
  add column REMARKS varchar(200) comment '备注';

-- add by sflin 2018/01/25
drop table if exists order_payment_detail;
drop table if exists PAYMENT_ORDER_DETAIL;
create table PAYMENT_ORDER_DETAIL
(
  PAYMENT_ORDER_DETAIL_ID bigint(20) not null comment '订单支付明细ID',
  PAYMENT_ORDER_ID        bigint(20) comment '支付订单ID',
  PAYEE_USER_LIST         TEXT comment '收款人信息列表',
  PAY_DATA_PACKET         TEXT comment '支付数据包',
  primary key (PAYMENT_ORDER_DETAIL_ID)
);

alter table PAYMENT_ORDER_DETAIL
  comment '订单支付明细';

ALTER TABLE `union_pay_info`
  ADD COLUMN `PAY_CARD_TYPE` varchar(10) NULL COMMENT '支付卡类型（00：未知 01：借记账户 02：贷记账户 03：准贷记账户 04：借贷合一账户 05：预付费账户 06：半开放预付费账户）' AFTER `TOPUP_FEE`,
  ADD COLUMN `REQ_RESERVED` varchar(1024) NULL COMMENT '请求方保留域' AFTER `PAY_CARD_TYPE`;

ALTER TABLE `union_pay_refund`
  ADD COLUMN `REQ_RESERVED` varchar(1024) NULL COMMENT '请求方保留域' AFTER `REFUNDS_FEE`;

CREATE TABLE `interface_log`
(
  `LOG_ID`      bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `ORDER_ID`    varchar(32)    DEFAULT NULL COMMENT '请求/响应订单号',
  `LOG_TYPE`    varchar(100)   DEFAULT NULL COMMENT '日志类型（注册、授权、充值、提现、转账、审核）',
  `OPT_TYPE`    varchar(100)   DEFAULT NULL COMMENT '操作方式（收到/发出）',
  `IP_ADDR`     varchar(100)   DEFAULT NULL COMMENT 'IP地址',
  `MERCHANT_NO` varchar(32)    DEFAULT NULL COMMENT '商户号',
  `SIGN`        varchar(400)   DEFAULT NULL COMMENT '签名',
  `SERVER_CODE` varchar(100)   DEFAULT NULL COMMENT '业务类型编号',
  `VERSION`     varchar(10)    DEFAULT NULL COMMENT '接口版本号',
  `PARAMS`      text COMMENT '业务参数',
  `DATETIME`    decimal(30, 0) DEFAULT NULL COMMENT '时间戳',
  `CREATE_TIME` datetime       DEFAULT NULL COMMENT '接收时间/发送时间',
  `CODE`        varchar(10)    DEFAULT NULL COMMENT '结果代码',
  `MSG`         varchar(255)   DEFAULT NULL COMMENT '结果信息',
  PRIMARY KEY (`LOG_ID`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 956105462879621121
  DEFAULT CHARSET = utf8
  ROW_FORMAT = DYNAMIC COMMENT ='接口日志表';

-- add by yaojc 2018/1/26
alter table payment_order
  modify COLUMN TOPUP_TYPE varchar(10) COMMENT "支付类型（0000：余额转账 0101：个人网关 0201：企业网银 0301：快捷支付 0401:手机wap）
            前两位为支付类型，后两位为渠道";
alter table `am_merchant`
  modify COLUMN audit_status varchar(30) COMMENT '再审核状态(0:待提交，1:审核失败,2:审核成功,3:审核中)';
alter table `am_merchant`
  modify COLUMN status varchar(30) COMMENT '状态(0:待提交，1:审核失败,2:审核成功,3:审核中)';
alter table `am_merchant`
  modify COLUMN merchant_id varchar(20) COMMENT '商户ID';

-- ADD BY SFLIN 2018/01/29

ALTER TABLE `payment_order`
  CHANGE COLUMN `MER_ORDER_NO` `MER_ORDER_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务订单号' AFTER `MERCHANT_NO`;

ALTER TABLE `refunds`
  CHANGE COLUMN `MER_ORDER_NO` `MER_ORDER_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求订单号' AFTER `MERCHANT_NO`;



drop table if exists order_transfer_order;
drop table if exists ORDER_TRANSFER_ACCOUNT;

/*==============================================================*/
/* Table: ORDER_TRANSFER_ACCOUNT                                */
/*==============================================================*/
create table ORDER_TRANSFER_ACCOUNT
(
  TRANS_ID            BIGINT(20) not null auto_increment comment '转账ID',
  MER_ORDER_ID        VARCHAR(32) comment '请求订单号',
  PLATFORM_ORDER_ID   varchar(32) comment '响应订单号',
  MERCHANT_NO         varchar(32) comment '商户编号',
  AMOUNT              decimal(20, 0) comment '交易金额',
  PAYER_USER_NO       varchar(64) comment '付款方二级商户号',
  PAYER_USER_NAME     varchar(150) comment '付款人姓名',
  PAYER_USER_PHONE    varchar(20) comment '付款人手机号',
  ACTION_TYPE         varchar(10) comment '业务类型(1：消费转账)X',
  PAY_TYPE            varchar(10) comment '转账支付方式(0:余额转账，1:充值转账)X',
  TOPUP_MER_ORDER_ID  varchar(64) comment '充值订单号',
  TOPUP_STATUS        varchar(10) comment '充值状态(0：充值成功；1：充值失败；2：待处理)',
  STATUS              varchar(10) comment '单据状态(1:转账待处理;2:转账失败;3:转账成功)',
  FRONT_URL           varchar(500) comment '前台回调地址',
  NOTIFY_URL          varchar(500) comment '后台回调地址',
  PARAMETER1          varchar(100) comment '自定义参数1',
  PARAMETER2          varchar(100) comment '自定义参数2',
  CREATE_DATE         datetime comment '创建时间',
  ACCREDIT_VERSION_NO decimal(8, 0) comment '授权版本号',
  TOPUP_FEE_PAYER     varchar(10) default '0' comment '充值手续费承担方：0：商户平台；1：会员(收款方)。默认为商户平台X',
  TOPUP_FEE           decimal(8, 0) comment '充值手续费',
  REFUND_TOPUP_FEE    decimal(20, 0) comment '已退充值手续费',
  TOPUP_TYPE          varchar(10) comment '支付类型（1：个人网关 2：企业网银 3：快捷支付）',
  PAYMENT_ORDER_ID    BIGINT(20) comment '支付订单ID',
  CHANNEL_TYPE        varchar(10) comment '渠道类型（01：全渠道）',
  primary key (TRANS_ID),
  unique key AK_Key_2 (MER_ORDER_ID, MERCHANT_NO),
  unique key AK_Key_3 (PLATFORM_ORDER_ID)
);

alter table ORDER_TRANSFER_ACCOUNT
  comment '转账信息';


ALTER TABLE `refunds`
  CHANGE COLUMN `ORIG_MER_ORDER_NO` `ORIG_MER_ORDER_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原支付请求订单号' AFTER `AMOUNT`;

-- add by sflin 2018/01/30
DROP VIEW IF EXISTS sum_refund_amt_group_by_order_id_view;
CREATE VIEW sum_refund_amt_group_by_order_id_view AS
select r.MERCHANT_NO, r.MER_ORDER_ID, rd.ORDER_ID, SUM(rd.AMOUNT) as alreadyRefundAmt, r.ORIG_MER_ORDER_ID
from refunds r,
     refunds_detail rd
where r.REFUNDS_ID = rd.REFUNDS_ID
  and r.`STATUS` in ('0', '2')
GROUP BY r.MERCHANT_NO, r.MER_ORDER_ID, rd.ORDER_ID;

DROP VIEW IF EXISTS order_transfer_account_receive_view;
CREATE VIEW order_transfer_account_receive_view AS
select r.PAYEE_DETAIL_ID,
       r.TRANS_ID,
       r.PLATFORM_ORDER_ID,
       r.ORDER_ID,
       r.PAYEE_USER_NO,
       r.PAYEE_AMOUNT,
       r.FEE_TO_MERCHANT,
       r.TRANSFER_TYPE,
       r.FEE_TYPE,
       r.AUTO_PAYDAY,
       r.AUDIT_TYPE,
       r.CREATE_DATE,
       r.AUTO_AUDIT_DATE,
       r.PASS_AMOUNT,
       r.FALLBACK_AMOUNT,
       r.PASS_FEE_AMOUNT,
       r.FALLBACK_FEE_AMOUNT,
       r.REFUND_AMOUNT,
       r.FEE_TO_MERCHANT_REFUND_AMOUNT,
       r.CHECK_CODE,
       r.PAYEE_USER_NAME,
       r.ITEM_LIST,
       a.MER_ORDER_ID,
       a.MERCHANT_NO
from order_transfer_account_receive r,
     order_transfer_account a
where r.TRANS_ID = a.TRANS_ID;

-- add by yaojc 2018/01/30
alter table am_user
  add column is_disable varchar(10) comment '是否禁用(0:否 1:是)';
alter table am_merchant
  add column is_disable varchar(10) comment '是否禁用(0:否 1:是)';
alter table am_merchant
  alter column is_disable set default '0';
alter table am_user
  alter column is_disable set default '0';

-- add by sflin 2018/01/30
ALTER TABLE `union_pay_checkitem`
  CHANGE COLUMN `PAYMENT_ORDER_ID` `CHECK_BILL_ID` bigint(20) NULL DEFAULT NULL COMMENT '对账单接口ID' AFTER `UNION_PAY_CHECKITEM_ID`;



-- add by sflin 2018/02/01

/*==============================================================*/
/* Table: BILL_DIFF_RECORD                                      */
/*==============================================================*/
create table BILL_DIFF_RECORD
(
  RECORD_ID         bigint(20) not null comment '主键',
  PAYMENT_ORDER_ID  bigint(20) comment '支付订单ID',
  MER_ORDER_ID      VARCHAR(32) comment '业务订单号',
  TRADING_TIME      datetime comment '交易时间',
  MERCHANT_NO       VARCHAR(32) comment '商户号',
  MERCHANT_NAME     varchar(150) default NULL comment '商户名称',
  TOPUP_TYPE        varchar(10) comment '支付类型（1：个人网关 2：企业网银 3：快捷支付）',
  CHANNEL_AMOUNT    decimal(20, 0) comment '渠道金额',
  PLATFORM_AMOUNT   decimal(20, 0) comment '平台金额',
  DIFF_AMOUNT       decimal(20, 0) comment '差额',
  ADJUSTMENT_STATUS varchar(10) comment '调账状态( 1 ：已处理；2 ： 未处理 )',
  REMARK            varchar(512) comment '备注',
  CREATE_DATE       datetime comment '创建时间',
  UPDATE_DATE       datetime comment '更新时间',
  primary key (RECORD_ID)
);

alter table BILL_DIFF_RECORD
  comment '对账差错列表';


/*==============================================================*/
/* Table: DAILY_BILL                                            */
/*==============================================================*/
create table DAILY_BILL
(
  DAILY_BILL_ID bigint(20) not null comment '主键',
  TRADING_DATE  datetime comment '交易日期',
  MERCHANT_NO   VARCHAR(32) comment '商户号',
  MERCHANT_NAME varchar(150) default NULL comment '商户名称',
  TOTAL_IN      decimal(20, 0) comment '入金总额',
  TOTAL_REFUND  decimal(20, 0) comment '退款总额',
  CREATE_DATE   datetime comment '创建时间',
  UPDATE_DATE   datetime comment '更新时间',
  primary key (DAILY_BILL_ID)
);

alter table DAILY_BILL
  comment '日账单表';


/*==============================================================*/
/* Table: DAILY_BILL_DETAIL                                     */
/*==============================================================*/
create table DAILY_BILL_DETAIL
(
  DAILY_BILL_DETAIL_ID bigint(20) not null comment '主键',
  DAILY_BILL_ID        bigint(20) comment '日账单表主键',
  TOPUP_TYPE           varchar(10) comment '支付类型（1：个人网关 2：企业网银 3：快捷支付）',
  IN_COUNT             bigint(20) comment '入金笔数',
  IN_TOTAL_AMOUNT      decimal(20, 0) comment '入金总额',
  REFUND_COUNT         bigint(20) comment '退款笔数',
  REFUND_TOTAL_AMOUNT  decimal(20, 0) comment '退款总额',
  primary key (DAILY_BILL_DETAIL_ID)
);

alter table DAILY_BILL_DETAIL
  comment '日账单明细表';

-- add by wusf  日志表添加创建时间
alter table upms_log
  add column create_date TIMESTAMP comment '创建时间';

-- add by huangts
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE sys_dict
(
  ID          VARCHAR(64)                               NULL comment 'ID',
  VALUE       VARCHAR(100)                              NULL comment '值',
  LABEL       VARCHAR(100)                              NULL comment '标签',
  TYPE        VARCHAR(100)                              NULL comment '类型',
  DESCRIPTION VARCHAR(100)                              NULL comment '描述',
  SORT        DECIMAL                                   NULL,
  PARENT_ID   VARCHAR(64) DEFAULT '0'                   NULL,
  CREATE_BY   VARCHAR(64)                               NULL comment '创建者',
  CREATE_DATE TIMESTAMP   DEFAULT CURRENT_TIMESTAMP     NOT NULL ON UPDATE CURRENT_TIMESTAMP comment '创建日期',
  UPDATE_BY   VARCHAR(64)                               NULL comment '修改人',
  UPDATE_DATE TIMESTAMP   DEFAULT '0000-00-00 00:00:00' NOT NULL comment '修改日期',
  REMARKS     VARCHAR(255)                              NULL comment '备注',
  DEL_FLAG    CHAR        DEFAULT '0'                   NULL comment '标志'
) COMMENT ='字典表';

ALTER TABLE upms_role
  ADD is_delete TINYINT null COMMENT '是否已删除（1-是，2-否）';

ALTER TABLE upms_user_role
  ADD locked TINYINT(4) COMMENT '角色是否禁止（1-禁止，0-启用）';

-- 2018/02/06 add by sflin
ALTER TABLE `bill_diff_record`
  CHANGE COLUMN `PAYMENT_ORDER_ID` `PLATFORM_ORDER_ID` bigint(20) NULL DEFAULT NULL COMMENT '支付订单ID' AFTER `RECORD_ID`;

-- 2018/02/07 add by yaojc
drop table if exists REFUNDS_DETAIL;

/*==============================================================*/
/* Table: REFUNDS_DETAIL                                        */
/*==============================================================*/
create table REFUNDS_DETAIL
(
  REFUNDS_DETAIL_ID bigint(20) not null comment '退款明细ID',
  REFUNDS_ID        bigint(20) comment '退款ID',
  ORDER_ID          varchar(32) comment '业务子订单号',
  AMOUNT            decimal(20, 0) comment '退款金额',
  PAYEE_AMOUNT      decimal(20, 0) comment '子订单交易金额',
  PAYEE_USER_NO     varchar(64) comment '子商户编号',
  REFUNDS_FEE       decimal(20, 0) comment '退款手续费',
  primary key (REFUNDS_DETAIL_ID)
);

alter table REFUNDS_DETAIL
  comment '退款明细';

-- 2018/02/08 add by sflin
ALTER TABLE `union_pay_info`
  ADD COLUMN `ACQ_INS_CODE` varchar(20) NULL COMMENT '收单机构代码，目前固定为48022900' AFTER `REQ_RESERVED`;

ALTER TABLE `union_pay_refund`
  ADD COLUMN `ACQ_INS_CODE` varchar(20) NULL COMMENT '收单机构代码，目前固定为48022900' AFTER `REQ_RESERVED`;

drop table if exists UNION_PAY_INFO_DETAIL;
create table UNION_PAY_INFO_DETAIL
(
  UNION_PAY_INFO_DETAIL_ID bigint(20) not null comment '全渠道支付明细ID',
  UNION_PAY_INFO_ID        bigint(20) comment '全渠道支付ID',
  SEQ_NO                   varchar(40) comment '批次号',
  ORDER_ID                 varchar(32) comment '子订单号',
  AMOUNT                   decimal(20, 0) comment '子订单金额',
  FEE                      decimal(20, 0) comment '子订单手续费',
  REMARKS                  varchar(256) comment '子订单备注',
  STATUS                   varchar(10) comment '清分勾兑标志（1：失败 2：成功）',
  CREATE_DATE              datetime comment '创建时间',
  UPDATE_DATE              datetime comment '更新时间',
  primary key (UNION_PAY_INFO_DETAIL_ID)
);

alter table UNION_PAY_INFO_DETAIL
  comment '全渠道支付明细';

drop table if exists UNION_PAY_REFUND_DETAIL;
create table UNION_PAY_REFUND_DETAIL
(
  UNION_PAY_REFUND_DETAIL_ID bigint(20) not null comment '全渠道支付明细ID',
  UNION_PAY_REFUND_ID        bigint(20) comment '全渠道支付ID',
  SEQ_NO                     varchar(40) comment '批次号',
  ORDER_ID                   varchar(32) comment '子订单号',
  AMOUNT                     decimal(20, 0) comment '子订单金额',
  FEE                        decimal(20, 0) comment '子订单手续费',
  REMARKS                    varchar(256) comment '子订单备注',
  STATUS                     varchar(10) comment '清分勾兑标志（1：失败 2：成功）',
  CREATE_DATE                datetime comment '创建时间',
  UPDATE_DATE                datetime comment '更新时间',
  primary key (UNION_PAY_REFUND_DETAIL_ID)
);

alter table UNION_PAY_REFUND_DETAIL
  comment '全渠道退款明细';

-- 2018/02/09 add by yaojc
alter table order_transfer_account_receive
  add column fee DECIMAL(20, 0) COMMENT '子订单手续费';

-- add by huangts
INSERT INTO upms_permission (permission_id, system_id, pid, name, type, permission_value, uri, icon, status,
                             create_time, orders, modify_time, creater, modifier)
VALUES (7, 0, 0, '个人中心', 1, 'info_manager', '', '', 0, '2018-02-09 14:40:59', 1518158459381, null, null, null);

-- 2018/02/11 add by yaojc
alter table am_merchant
  add column create_date datetime COMMENT '创建时间';
alter table am_merchant
  add column update_date datetime COMMENT '更新时间';
alter table am_merchant
  add column update_by varchar(64) COMMENT '更新人';
alter table am_merchant
  add column create_by varchar(64) COMMENT '创建人';
alter table am_user
  add column update_date datetime COMMENT '更新时间';
alter table am_user
  add column update_by varchar(64) COMMENT '更新人';
alter table am_user
  add column create_by varchar(64) COMMENT '创建人';

-- 2018-02-11 add by huangts
alter table upms_role
  add column role_no VARCHAR(64) NOT NULL COMMENT '角色编号';
UPDATE upms_role
set role_no = role_id
where 1 = 1;
alter table upms_role
  add unique (role_no);

-- 2018-02-22 add by huangts
DELETE
from upms_permission
where permission_id = '7';
UPDATE upms_permission
set permission_value='dict_manager'
where name like '字典管理';
alter table upms_user
  add column remarks VARCHAR(500) NULL COMMENT '备注';

ALTER TABLE upms_role
  DROP INDEX upms_role_role_no_uindex;

-- 2018/02/13 ADD BY LINSF

ALTER TABLE `interface_log`
  ADD COLUMN `DATA_PACKET` varchar(2000) NULL COMMENT '数据包' AFTER `MSG`;

-- 2018/02/23 add by yaojc
alter table refunds
  add column remarks varchar(200) COMMENT '备注';

-- 2018/02/24 add by yaojc
ALTER TABLE am_user
  ADD merchant_no VARCHAR(500) NULL COMMENT '关联商户号';
ALTER TABLE am_user
  ADD merchant_name VARCHAR(500) NULL COMMENT '关联商户名称';

-- 2018/02/26 add by maozw
alter table union_pay_info_detail
  add column USER_NO varchar(64) comment '子商户号' after ORDER_ID;
alter table union_pay_refund_detail
  add column USER_NO varchar(64) comment '子商户号' after ORDER_ID;
alter table union_pay_info
  add column SETTLE_DATE_FULL varchar(64) comment '完整清算日期（YYYYMMDD）';
alter table union_pay_refund
  add column SETTLE_DATE_FULL varchar(64) comment '完整清算日期（YYYYMMDD）';
create table SETTLE_FILE_LOG
(
  SETTLE_FILE_LOG_ID bigint(20) NOT NULL AUTO_INCREMENT comment '清算文件日志',
  SETTLE_DATE        varchar(8) comment '清算日期(格式：yyyyMMdd)',
  HAS_UPLOAD         varchar(1) comment '是否上传',
  HAS_DOWNLOAD       varchar(1) comment '是否下载',
  UPLOAD_FILENAME    varchar(200) comment '上传文件名',
  DOWNLOAD_FILENAME  varchar(200) comment '下载文件名',
  CREATE_DATE        datetime comment '创建时间',
  UPDATE_DATE        datetime comment '更新时间',
  PRIMARY KEY (`SETTLE_FILE_LOG_ID`)
);
alter table SETTLE_FILE_LOG
  comment '清算文件日志';

-- 2018/02/28 add by yaojc
CREATE TABLE dm_merchant
(
  id                VARCHAR(40)  NOT NULL
    COMMENT '编号'
    PRIMARY KEY,
  merchant_no       VARCHAR(40)  NULL
    COMMENT '商户编号',
  merchant_id       VARCHAR(40)  NULL
    COMMENT '商户id',
  merchant_name     VARCHAR(150) NULL
    COMMENT '商户名称',
  dm_remarks        VARCHAR(500) NULL
    COMMENT '备注信息',
  customer_resource VARCHAR(30)  NULL
    COMMENT '客户来源(0:银商,1:投融汇,2：渠道01,3:渠道02)',
  dm_merchant_no    VARCHAR(40)  NULL
    COMMENT 'dm系统商户号'
)
  COMMENT 'dm系统商户号表'
  ENGINE = InnoDB;

alter table am_user
  change merchant_no merchant_no VARCHAR(1000) COMMENT "关联商户号";
alter table am_user
  change merchant_name merchant_name VARCHAR(1000) COMMENT "关联商户名称";
alter table am_merchant
  change merchant_id merchant_id BIGINT(20) COMMENT "商户ID";
alter table dm_merchant
  change merchant_id merchant_id BIGINT(20) COMMENT "商户ID";
alter table dm_merchant
  drop column customer_resource;
alter table dm_merchant
  change merchant_no merchant_no VARCHAR(32) COMMENT "商户编号";
alter table am_merchant
  add column customer_resource VARCHAR(30) COMMENT '客户来源(0:银商,1:投融汇,2：渠道01,3:渠道02)';

-- 2018/03/01 add by yaojc
alter table settle_file_log
  change HAS_UPLOAD HAS_UPLOAD VARCHAR(1) COMMENT "0:否，1:是";
alter table settle_file_log
  change HAS_DOWNLOAD HAS_DOWNLOAD VARCHAR(1) COMMENT "0:否，1:是";

ALTER TABLE union_pay_info
  add COLUMN merchant_no varchar(32) COMMENT '商户号';
ALTER TABLE union_pay_info
  add COLUMN merchant_name varchar(150) COMMENT '商户名称';
ALTER TABLE union_pay_refund
  add COLUMN merchant_no varchar(32) COMMENT '商户号';
ALTER TABLE union_pay_refund
  add COLUMN merchant_name varchar(150) COMMENT '商户名称';
ALTER TABLE union_pay_info_detail
  add COLUMN old_seq_no varchar(40) COMMENT '旧批次号';
ALTER TABLE union_pay_info_detail
  add COLUMN user_name varchar(80) COMMENT '子商户名称';
ALTER TABLE union_pay_info_detail
  add COLUMN user_phone varchar(11) COMMENT '子商户手机号';
ALTER TABLE union_pay_refund_detail
  add COLUMN old_seq_no varchar(40) COMMENT '旧批次号';
ALTER TABLE union_pay_refund_detail
  add COLUMN user_name varchar(80) COMMENT '子商户名称';
ALTER TABLE union_pay_refund_detail
  add COLUMN user_phone varchar(11) COMMENT '子商户手机号';


-- 2018/03/02 add by linsf
drop view if EXISTS sum_refund_amt_group_by_order_id_view;
create view sum_refund_amt_group_by_order_id_view as
SELECT `r`.`MERCHANT_NO`       AS `MERCHANT_NO`,
       `r`.`MER_ORDER_ID`      AS `MER_ORDER_ID`,
       `r`.`ORIG_MER_ORDER_ID` AS `ORIG_MER_ORDER_ID`,
       `rd`.`ORDER_ID`         AS `ORDER_ID`,
       sum(`rd`.`AMOUNT`)      AS `alreadyRefundAmt`
FROM (
      `refunds` `r`
       JOIN `refunds_detail` `rd`
  )
WHERE (
          (
            `r`.`REFUNDS_ID` = `rd`.`REFUNDS_ID`
            )
          AND (`r`.`STATUS` IN ('0', '2'))
        )
GROUP BY `r`.`MERCHANT_NO`,
         `r`.`ORIG_MER_ORDER_ID`, `rd`.`ORDER_ID`;

--	2018/03/07 add by yaojc
ALTER TABLE withdraw
  ADD COLUMN rcv_acct_Name varchar(100) COMMENT '账户名';