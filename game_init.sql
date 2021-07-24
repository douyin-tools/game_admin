/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:8001
 Source Schema         : game_init

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 17/07/2021 23:36:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for caipiao_admingroup
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_admingroup`;
CREATE TABLE `caipiao_admingroup` (
  `groupid` smallint(6) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(30) NOT NULL,
  `level` smallint(6) NOT NULL,
  PRIMARY KEY (`groupid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_admingroup
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_admingroup` VALUES (1, '超级管理员', 1);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_adminlog
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_adminlog`;
CREATE TABLE `caipiao_adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `type` char(20) NOT NULL COMMENT 'login 登入，logout 登出，act 操作',
  `info` varchar(60) NOT NULL,
  `ip` char(20) NOT NULL,
  `iparea` varchar(60) NOT NULL COMMENT 'ip地区',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_adminloginerror
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_adminloginerror`;
CREATE TABLE `caipiao_adminloginerror` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(30) NOT NULL,
  `ip` char(20) NOT NULL,
  `time` int(11) NOT NULL,
  `errornum` smallint(6) NOT NULL,
  `locktime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_adminmember
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_adminmember`;
CREATE TABLE `caipiao_adminmember` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` smallint(6) NOT NULL,
  `username` char(60) NOT NULL,
  `email` char(60) NOT NULL,
  `password` char(64) NOT NULL,
  `safecode` mediumint(9) NOT NULL DEFAULT '1234',
  `loginip` char(20) NOT NULL,
  `iparea` char(20) NOT NULL,
  `logintime` int(11) NOT NULL,
  `islock` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groupid` (`groupid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of caipiao_adminmember
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_adminmember` VALUES (1, 1, 'admin', '', 'MDAwMDAwMDAwML2Idt2F3bVqhs1tbQ', 123456, '172.17.0.1', '局域网', 1626435112, 0);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_adminsession
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_adminsession`;
CREATE TABLE `caipiao_adminsession` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `sessionid` char(32) NOT NULL,
  `ip` char(20) NOT NULL COMMENT '登录ip',
  `time` int(11) NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`sid`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_agbetrecord
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_agbetrecord`;
CREATE TABLE `caipiao_agbetrecord` (
  `AgID` int(11) NOT NULL AUTO_INCREMENT,
  `DataType` varchar(25) DEFAULT NULL,
  `BillNo` varchar(45) DEFAULT NULL,
  `PlayerName` varchar(45) DEFAULT NULL,
  `AgentCode` varchar(25) DEFAULT NULL,
  `GameCode` varchar(35) DEFAULT NULL,
  `NetAmount` decimal(10,0) DEFAULT NULL,
  `BetTime` datetime DEFAULT NULL,
  `GameType` varchar(15) DEFAULT NULL,
  `BetAmount` decimal(10,0) DEFAULT NULL,
  `ValidBetAmount` decimal(10,0) DEFAULT NULL,
  `Flag` int(4) DEFAULT NULL,
  `TableCode` varchar(15) DEFAULT NULL,
  `LoginIP` varchar(255) DEFAULT NULL,
  `RecalcuTime` datetime DEFAULT NULL,
  `PlatformType` varchar(15) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `Round` varchar(15) DEFAULT NULL,
  `BeforeCredit` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`AgID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_agentlink
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_agentlink`;
CREATE TABLE `caipiao_agentlink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `proxy` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1代理 0玩家',
  `tpltype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '模版类型 0默认',
  `usenum` int(11) NOT NULL COMMENT '使用次数',
  `okusenum` int(11) NOT NULL COMMENT '已经使用的次数',
  `fandian` decimal(6,1) NOT NULL,
  `oddtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_banklist
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_banklist`;
CREATE TABLE `caipiao_banklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `username` char(30) NOT NULL COMMENT '会员昵称',
  `bankaddress` varchar(80) NOT NULL COMMENT '开户行地址',
  `bankname` varchar(60) NOT NULL COMMENT '开户银行',
  `bankcode` char(20) NOT NULL,
  `bankbranch` varchar(80) NOT NULL COMMENT '开户网点',
  `accountname` varchar(30) NOT NULL COMMENT '开户姓名',
  `banknumber` varchar(22) NOT NULL COMMENT '银行卡号',
  `isdefault` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1默认',
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0审核中 1默认 2驳回',
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会员银行绑定表';

-- ----------------------------
-- Table structure for caipiao_bbbetrecord
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_bbbetrecord`;
CREATE TABLE `caipiao_bbbetrecord` (
  `bbId` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(25) DEFAULT NULL,
  `WagersID` varchar(35) DEFAULT NULL,
  `WagersDate` datetime DEFAULT NULL,
  `SerialID` varchar(35) DEFAULT NULL,
  `RoundNo` varchar(25) DEFAULT NULL,
  `GameType` varchar(25) DEFAULT NULL,
  `WagerDetail` varchar(45) DEFAULT NULL,
  `GameCode` varchar(25) DEFAULT NULL,
  `Result` varchar(25) DEFAULT NULL,
  `Card` varchar(25) DEFAULT NULL,
  `BetAmount` decimal(10,0) DEFAULT NULL,
  `Origin` varchar(15) DEFAULT NULL,
  `Commissionable` decimal(10,0) DEFAULT NULL,
  `Payoff` decimal(10,0) DEFAULT NULL,
  `ExchangeRate` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`bbId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_caipiao
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_caipiao`;
CREATE TABLE `caipiao_caipiao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeid` char(20) NOT NULL COMMENT '彩票分类（ssc、k3）',
  `title` varchar(80) NOT NULL COMMENT '彩种名称',
  `ftitle` varchar(180) NOT NULL COMMENT '彩种简介',
  `firsttime` char(8) DEFAULT NULL,
  `endtime` char(8) DEFAULT NULL,
  `qishu` smallint(3) NOT NULL,
  `name` char(30) NOT NULL COMMENT '彩种标示（唯一）',
  `ftime` smallint(6) NOT NULL DEFAULT '120' COMMENT '停止投注间隔',
  `isopen` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启',
  `issys` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0第三方彩票 1系统彩票',
  `closetime1` time NOT NULL DEFAULT '00:00:00',
  `closetime2` time NOT NULL DEFAULT '00:00:00',
  `expecttime` smallint(6) NOT NULL DEFAULT '1' COMMENT '多久1期 最少1分钟',
  `iswh` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1维护',
  `allsort` smallint(6) NOT NULL,
  `listorder` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `typeid` (`typeid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_caipiao
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_caipiao` VALUES (16, 'k3', '北京快3', '全天44期', '09:22:45', '23:42:45', 44, 'bjk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 2, 3);
INSERT INTO `caipiao_caipiao` VALUES (17, 'k3', '江苏快3', '全天41期', '08:50:30', '22:10:30', 41, 'jsk3', 5, 0, 0, '00:00:00', '00:00:00', 5, 0, 21, 2);
INSERT INTO `caipiao_caipiao` VALUES (18, 'k3', '湖北快3', '全天39期', '09:20:30', '22:00:30', 39, 'hubk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 50, 4);
INSERT INTO `caipiao_caipiao` VALUES (19, 'k3', '广西快3', '全天40期', '09:30:45', '22:30:45', 40, 'gxk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 100, 9);
INSERT INTO `caipiao_caipiao` VALUES (20, 'k3', '安徽快3', '全天40期', '08:50:50', '21:55:50', 40, 'ahk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 3, 11);
INSERT INTO `caipiao_caipiao` VALUES (21, 'k3', '上海快3', '全天41期', '08:58:00', '22:18:00', 41, 'shk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 102, 6);
INSERT INTO `caipiao_caipiao` VALUES (53, 'k3', '河北快3', '全天41期', '08:50:00', '22:10:00', 41, 'hebk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 40, 5);
INSERT INTO `caipiao_caipiao` VALUES (84, 'k3', '江西快3', '全天84期', '09:04:00', '22:54:00', 144, 'jxk3', 60, 0, 1, '00:00:00', '00:50:00', 10, 0, 100, 8);
INSERT INTO `caipiao_caipiao` VALUES (91, 'k3', '无敌快3', '1分钟1期', '00:00:00', '23:55:00', 717, 'f1k3', 20, 1, 1, '00:00:00', '23:50:00', 1, 0, 1, 1);
INSERT INTO `caipiao_caipiao` VALUES (92, 'k3', '幸运快3', '1分钟1期', '00:00:00', '23:30:00', 1439, 'f5k3', 10, 1, 1, '00:00:00', '23:59:00', 1, 0, 100, 10);
INSERT INTO `caipiao_caipiao` VALUES (93, 'k3', '吉林快3', '全天41期', '09:30:40', '23:50:40', 41, 'jlk3', 120, 1, 0, '00:00:00', '00:00:00', 0, 0, 20, 7);
INSERT INTO `caipiao_caipiao` VALUES (98, 'ssc', '天津时时彩', '全天42期', '09:20:30', '23:00:30', 42, 'tjssc', 120, 1, 0, '00:00:00', '00:00:00', 1, 0, 100, 3);
INSERT INTO `caipiao_caipiao` VALUES (99, 'ssc', '新疆时时彩', '全天48期', '10:20:30', '23:40:30', 48, 'xjssc', 120, 1, 0, '00:00:00', '00:00:00', 20, 0, 100, 2);
INSERT INTO `caipiao_caipiao` VALUES (100, 'ssc', '重庆时时彩', '全天59期', '07:30:45', '23:50:45', 59, 'cqssc', 180, 1, 0, '00:00:00', '00:00:00', 20, 0, 0, 1);
INSERT INTO `caipiao_caipiao` VALUES (102, 'pk10', '北京赛车', '全天44期', '09:30:40', '23:50:40', 44, 'bjpk10', 60, 1, 0, '00:00:00', '00:00:00', 20, 0, 5, 1);
INSERT INTO `caipiao_caipiao` VALUES (103, 'keno', '北京快乐8', '全天179期', '09:05:00', '23:55:00', 179, 'bjkeno', 60, 1, 0, '00:00:00', '00:00:00', 1, 0, 102, 1);
INSERT INTO `caipiao_caipiao` VALUES (104, 'x5', '广东11选5', '全天42期', '09:30:30', '23:10:30', 42, 'gd11x5', 120, 1, 0, '00:00:00', '00:00:00', 20, 0, 100, 1);
INSERT INTO `caipiao_caipiao` VALUES (105, 'x5', '上海11选5', '全天45期', '09:20:50', '23:40:50', 45, 'sh11x5', 120, 1, 0, '00:00:00', '00:00:00', 20, 0, 16, 2);
INSERT INTO `caipiao_caipiao` VALUES (107, 'x5', '江西11选5', '全天42期', '09:30:30', '23:10:30', 42, 'jx11x5', 120, 1, 0, '00:00:00', '00:00:00', 20, 0, 11, 4);
INSERT INTO `caipiao_caipiao` VALUES (108, 'dpc', '福彩3D', '全天一期', '21:15:00', '21:15:00', 1, 'fc3d', 600, 1, 0, '00:00:00', '00:00:00', 1, 0, 19, 1);
INSERT INTO `caipiao_caipiao` VALUES (109, 'dpc', '排列三', '全天一期', '20:30:00', '20:30:00', 1, 'pl3', 600, 1, 0, '00:00:00', '00:00:00', 1, 0, 17, 2);
INSERT INTO `caipiao_caipiao` VALUES (111, 'dpc', '极速3D', '5分钟1期', '', '', 180, 'df3d', 60, 1, 1, '08:30:00', '23:30:00', 5, 0, 18, 110);
INSERT INTO `caipiao_caipiao` VALUES (112, 'x5', '五分11选5', '5分钟1期', '', '', 180, 'df11x5', 30, 1, 1, '08:30:00', '23:30:00', 5, 0, 100, 112);
INSERT INTO `caipiao_caipiao` VALUES (113, 'keno', '二分快乐8', '2分钟1期', '', '', 420, 'dfkeno', 10, 1, 1, '08:30:00', '22:30:00', 2, 0, 15, 113);
INSERT INTO `caipiao_caipiao` VALUES (114, 'pk10', '幸运飞艇', '全天180期', '13:09:35', '23:59:35', 180, 'dfpk10', 10, 1, 1, '13:10:00', '04:00:00', 5, 0, 6, 114);
INSERT INTO `caipiao_caipiao` VALUES (116, 'lhc', '香港六合彩', '每周三期', '', '', 0, 'lhc', 300, 0, 0, '00:00:00', '00:00:00', 1, 1, 12, 115);
INSERT INTO `caipiao_caipiao` VALUES (117, 'lhc', '幸运六合彩', '2分钟1期', '', '', 420, 'dflhc', 10, 1, 1, '00:01:00', '23:58:00', 2, 0, 13, 117);
INSERT INTO `caipiao_caipiao` VALUES (121, 'ssc', '大富分分彩', '1分钟1期', '', '', 1350, 'yfssc', 10, 1, 1, '01:00:00', '23:30:00', 1, 0, 22, 121);
INSERT INTO `caipiao_caipiao` VALUES (122, 'ssc', '幸运二分彩', '2分钟一期', '', '', 675, 'efssc', 20, 1, 1, '01:00:00', '23:30:00', 2, 0, 10, 1);
INSERT INTO `caipiao_caipiao` VALUES (123, 'ssc', '幸运五分彩', '5分钟一期', '', '', 288, 'wfssc', 30, 1, 1, '00:00:00', '23:55:00', 5, 0, 9, 1);
INSERT INTO `caipiao_caipiao` VALUES (125, 'ssc', '腾讯分分彩', '1分钟1期', '00:00:00', '23:59:00', 1440, 'xtxssc', 10, 1, 0, '00:00:00', '23:59:00', 1, 0, 11, 1);
INSERT INTO `caipiao_caipiao` VALUES (130, 'pk10', '极速赛车', '5分钟1期', '00:00:00', '23:30:00', 288, 'xypk10', 10, 1, 1, '00:00:00', '23:55:00', 5, 0, 4, 1);
INSERT INTO `caipiao_caipiao` VALUES (131, 'ssc', '澳洲时时彩', '5分钟1期', '09:00:00', '23:58:00', 288, 'oldssc', 20, 1, 1, '00:00:00', '23:55:00', 5, 0, 8, 131);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_caipiaotimes
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_caipiaotimes`;
CREATE TABLE `caipiao_caipiaotimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `expect` int(11) NOT NULL,
  `starttime` time NOT NULL,
  `stoptime` time NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `expect` (`expect`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_category
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_category`;
CREATE TABLE `caipiao_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` int(11) NOT NULL,
  `catname` varchar(120) NOT NULL COMMENT '栏目名称',
  `listorder` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='栏目管理';

-- ----------------------------
-- Records of caipiao_category
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_category` VALUES (29, 0, '帮助中心', 1);
INSERT INTO `caipiao_category` VALUES (30, 0, '网站介绍', 100);
INSERT INTO `caipiao_category` VALUES (33, 29, '帮助指南', 1);
INSERT INTO `caipiao_category` VALUES (34, 29, '安全问题', 2);
INSERT INTO `caipiao_category` VALUES (35, 29, '充值问题', 3);
INSERT INTO `caipiao_category` VALUES (36, 29, '购彩问题', 4);
INSERT INTO `caipiao_category` VALUES (37, 29, '提现问题', 5);
INSERT INTO `caipiao_category` VALUES (38, 29, '账户安全', 6);
INSERT INTO `caipiao_category` VALUES (39, 29, '玩法限制', 7);
INSERT INTO `caipiao_category` VALUES (40, 29, '快三技巧攻略', 8);
INSERT INTO `caipiao_category` VALUES (41, 0, '优惠活动', 200);
INSERT INTO `caipiao_category` VALUES (46, 29, '代理合作', 42);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_chat_list
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_chat_list`;
CREATE TABLE `caipiao_chat_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `uid` int(11) NOT NULL,
  `create_at` int(11) NOT NULL,
  `type` smallint(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level` int(2) NOT NULL,
  `head` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_commission
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_commission`;
CREATE TABLE `caipiao_commission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '代理人ID',
  `username` varchar(255) NOT NULL,
  `share_rate` int(5) NOT NULL COMMENT '合营比例',
  `yesterday_balance` decimal(14,2) NOT NULL COMMENT '前一天所有下级会员的余额',
  `balance` decimal(14,2) NOT NULL COMMENT '当前所有会员的余额',
  `recharge` decimal(14,2) NOT NULL COMMENT '充值',
  `withdraw` decimal(14,2) NOT NULL COMMENT '提现',
  `commission` decimal(14,2) NOT NULL COMMENT '佣金',
  `status` tinyint(1) NOT NULL COMMENT '0 冻结中；1已发放到余额',
  `remarks` text COMMENT '备注',
  `date` char(11) DEFAULT NULL COMMENT '结算日期',
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理佣金结算';

-- ----------------------------
-- Table structure for caipiao_cp_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_cp_game_order`;
CREATE TABLE `caipiao_cp_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(10) DEFAULT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `ticket_plan_no` varchar(32) DEFAULT NULL COMMENT '奖期号',
  `bet_count` bigint(20) DEFAULT NULL COMMENT '注数',
  `bet_multiple` bigint(20) DEFAULT NULL COMMENT '倍数',
  `bet_model` decimal(20,4) DEFAULT NULL COMMENT '投注模式：1, 0.1, 0.01, 0.001, 2, 0.2, 0.02,  0.002',
  `bet_rebate` decimal(20,4) DEFAULT NULL COMMENT '投注返点',
  `bet_prize` varchar(500) DEFAULT NULL COMMENT '奖金：多奖级逗号隔开',
  `risk_status` int(11) DEFAULT NULL COMMENT '状态1待风控,2风控通过,3风控锁定,4风控解锁.',
  `risk_unlock_by` varchar(50) DEFAULT NULL COMMENT '风控解锁人',
  `single_game` int(11) DEFAULT NULL COMMENT '是否单式玩法：false：否',
  `base_rate` varchar(500) DEFAULT NULL COMMENT '基准返奖率',
  `bonus_reduce_rate` varchar(500) DEFAULT NULL COMMENT '返奖率下调幅度',
  `directly_mode` int(11) DEFAULT NULL COMMENT '结算模式，false.代理，true.直客',
  `member_rebate` decimal(20,4) DEFAULT NULL COMMENT '用户返点值',
  `judge_result_cn` varchar(100) DEFAULT NULL COMMENT '开奖结果',
  `win_count` bigint(20) DEFAULT NULL COMMENT '中奖注数',
  `solo` int(11) DEFAULT NULL COMMENT '是否单挑 false: 否, true: 是',
  `chase_id` varchar(50) DEFAULT NULL COMMENT '追号单id',
  `chase_plan_id` varchar(50) DEFAULT NULL COMMENT '追号排期表ID',
  `group_mode` int(11) DEFAULT NULL COMMENT '盘面1:标准盘,2:双面盘 3:特色.',
  `series_type` int(11) DEFAULT NULL COMMENT '系列类型: false传统 true特色',
  `cancel_by` varchar(100) DEFAULT NULL COMMENT '注单撤销人account',
  `cancel_desc` varchar(200) DEFAULT NULL COMMENT '注单撤销说明',
  `bet_num` text COMMENT '投注号码',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  `details` text COMMENT '注单详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_czddh
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_czddh`;
CREATE TABLE `caipiao_czddh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paytype` char(20) NOT NULL COMMENT '支付宝 alipay QQ钱包 tenpay 微信：weixin',
  `uid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `trano` char(60) NOT NULL,
  `threetrano` char(255) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `oddtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE,
  KEY `threetrano` (`threetrano`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='平台充值订单与第三方订单关系表';

-- ----------------------------
-- Table structure for caipiao_dailifandian
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_dailifandian`;
CREATE TABLE `caipiao_dailifandian` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `trano` char(20) DEFAULT NULL,
  `amount` decimal(10,3) DEFAULT NULL,
  `touzhujine` decimal(10,3) DEFAULT NULL,
  `fandian` decimal(6,1) DEFAULT NULL,
  `xiajiid` mediumint(8) DEFAULT NULL,
  `xiajiuser` char(20) DEFAULT NULL COMMENT '//涓嬬骇',
  `xiajifandian` decimal(6,1) DEFAULT NULL,
  `shenhe` tinyint(2) DEFAULT '0' COMMENT '//1閫氳繃,0,绛夊緟,-1澶辫触',
  `oddtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_dailifenhong
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_dailifenhong`;
CREATE TABLE `caipiao_dailifenhong` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trano` char(60) NOT NULL,
  `uid` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `tzsumamount` decimal(14,4) NOT NULL,
  `fjsumamount` decimal(14,4) NOT NULL,
  `yingkui` decimal(14,4) NOT NULL,
  `fanwei` char(60) NOT NULL,
  `bili` char(10) NOT NULL,
  `amount` decimal(14,4) NOT NULL,
  `oddtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_dailiyongjin
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_dailiyongjin`;
CREATE TABLE `caipiao_dailiyongjin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listorder` smallint(6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `addtime` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `username` char(30) NOT NULL COMMENT '会员昵称',
  `touzhuedu` decimal(10,2) NOT NULL COMMENT '下线流水',
  `yongjinfw` char(30) NOT NULL COMMENT '佣金范围',
  `amount` decimal(10,2) NOT NULL COMMENT '佣金金额',
  `yjtype` char(10) NOT NULL COMMENT '佣金类型',
  `oddtime` int(11) NOT NULL COMMENT '领取时间',
  `shenhe` tinyint(4) NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_dj_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_dj_game_order`;
CREATE TABLE `caipiao_dj_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(50) DEFAULT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `series_type` int(11) DEFAULT NULL COMMENT '"串关类型 1 普通注单 2:2 串 1\r\n3:3 串 1…"',
  `round_id_dj` varchar(100) DEFAULT NULL COMMENT '游戏ID',
  `tournament_id` varchar(100) DEFAULT NULL COMMENT '联赛ID',
  `match_id` varchar(100) DEFAULT NULL COMMENT '比赛ID',
  `match_type` int(11) DEFAULT NULL COMMENT '比赛类型',
  `market_id` varchar(100) DEFAULT NULL COMMENT '盘口ID',
  `market_cn_name` varchar(500) DEFAULT NULL COMMENT '盘口简称',
  `team_name` varchar(200) DEFAULT NULL COMMENT '战队名称',
  `round` int(11) DEFAULT NULL COMMENT '局数',
  `is_live` int(11) DEFAULT NULL COMMENT '赛事阶段 1-初盘 2-滚盘',
  `confirm_type` int(11) DEFAULT NULL COMMENT '"确认方式 1-自动确认 2-手动待\r\n确认 3-手动确认 4-手动拒绝"',
  `settle_count` varchar(200) DEFAULT NULL COMMENT '结算统计',
  `team_id` varchar(100) DEFAULT NULL COMMENT '战队ID',
  `details` text,
  `match_info` varchar(255) DEFAULT NULL COMMENT '赛事简称 map 结构.key 值为 联赛ID  tournamentId',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_dy_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_dy_game_order`;
CREATE TABLE `caipiao_dy_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(10) DEFAULT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `room_type` bigint(20) DEFAULT NULL COMMENT '房间类型',
  `game_room` varchar(100) DEFAULT NULL COMMENT '游戏房间',
  `game_flag` int(11) DEFAULT NULL COMMENT '游戏分类标识（0捕鱼类，1电子类）',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  `details` text COMMENT '注单详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_fanshui
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_fanshui`;
CREATE TABLE `caipiao_fanshui` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trano` char(60) NOT NULL,
  `listorder` smallint(6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `addtime` int(11) NOT NULL,
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `username` char(30) NOT NULL COMMENT '会员昵称',
  `groupname` char(30) NOT NULL COMMENT '领取反水时会员等级',
  `bili` char(10) NOT NULL COMMENT '反水比例',
  `touzhuedu` decimal(20,2) NOT NULL COMMENT '流水额度',
  `amount` decimal(20,2) NOT NULL COMMENT '反水金额',
  `oddtime` int(11) NOT NULL COMMENT '领取时间',
  `shenhe` tinyint(4) NOT NULL COMMENT '审核状态',
  `yongjinfw` char(80) NOT NULL COMMENT '反水范围',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_fields
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_fields`;
CREATE TABLE `caipiao_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `tbname` char(30) NOT NULL,
  `name` char(30) NOT NULL,
  `fieldtype` char(20) NOT NULL COMMENT '字段类型',
  `length` smallint(6) NOT NULL COMMENT '字段长度',
  `istitle` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否标题字段',
  `islist` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否列表显示',
  `remark` varchar(60) NOT NULL COMMENT '备注',
  `setting` text NOT NULL,
  `listorder` smallint(6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_fuddetail
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_fuddetail`;
CREATE TABLE `caipiao_fuddetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trano` char(20) NOT NULL DEFAULT '' COMMENT '单号',
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `username` char(30) NOT NULL COMMENT '会员昵称',
  `type` char(30) NOT NULL COMMENT 'order代购 cancel撤单 reward返奖 commission返点 activity活动 transferPlatform平台转帐 backwater百家乐返水 backpoint百家乐返点 rollback后台撤单 editcommission修正手续费 editrecharge修正充值 editwithdraw修正提款 editactivity修正活动 downrecharge下级充值 upwithdraw上级提款 withdrawFailure提款失败',
  `typename` varchar(60) NOT NULL COMMENT '类型名称',
  `amount` decimal(14,2) NOT NULL COMMENT '金额',
  `amountbefor` decimal(14,2) NOT NULL COMMENT '账变前金额',
  `amountafter` decimal(14,2) NOT NULL COMMENT '账变后金额',
  `oddtime` int(11) NOT NULL COMMENT '时间',
  `remark` varchar(180) NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='账户明细';

-- ----------------------------
-- Table structure for caipiao_gonggao
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_gonggao`;
CREATE TABLE `caipiao_gonggao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `oddtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_gonggao
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_gonggao` VALUES (1, '欢迎来到钻石娱乐！', '\n欢迎来到钻石娱乐，钻石娱乐进行颠覆性技术升级，行业内视讯直播最低延迟，100%图像识别率，视频同步开牌等系列大幅度提升用户体验的技术革新。钻石娱乐，与您共度美好时光！', 1596252711);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_jinjijiangli
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_jinjijiangli`;
CREATE TABLE `caipiao_jinjijiangli` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trano` char(60) NOT NULL COMMENT '//流水号',
  `listorder` smallint(6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `addtime` int(11) NOT NULL,
  `uid` mediumtext NOT NULL COMMENT '会员ID',
  `username` char(20) NOT NULL COMMENT '会员名称',
  `groupid` mediumtext NOT NULL COMMENT '会员组ID',
  `beforegroupname` varchar(20) DEFAULT NULL COMMENT '//晋级前等级',
  `groupname` varchar(20) NOT NULL COMMENT '会员组名称',
  `jlje` decimal(10,0) NOT NULL COMMENT '晋级奖励金额',
  `point` float NOT NULL COMMENT '积晋级时积分',
  `oddtime` int(11) NOT NULL COMMENT '奖励时间',
  `shenhe` tinyint(4) NOT NULL COMMENT '审核',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_kaijiang
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_kaijiang`;
CREATE TABLE `caipiao_kaijiang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addtime` int(11) NOT NULL,
  `name` char(30) NOT NULL COMMENT '彩票标识',
  `title` varchar(30) NOT NULL COMMENT '彩票名称',
  `opencode` char(59) NOT NULL COMMENT '开奖号码',
  `sourcecode` char(255) NOT NULL,
  `remarks` char(255) NOT NULL COMMENT '第三方快乐彩结果',
  `expect` char(40) NOT NULL COMMENT '期号',
  `opentime` int(11) NOT NULL COMMENT '开奖时间',
  `isdraw` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未开奖 1开奖',
  `source` varchar(30) NOT NULL COMMENT '来源',
  `drawtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `isdraw` (`isdraw`) USING BTREE,
  KEY `expect` (`expect`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='开奖管理';

-- ----------------------------
-- Table structure for caipiao_kenolimitred
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_kenolimitred`;
CREATE TABLE `caipiao_kenolimitred` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `mixmoney` int(11) NOT NULL,
  `maxmoney` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_linebanklist
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_linebanklist`;
CREATE TABLE `caipiao_linebanklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bankname` varchar(60) NOT NULL COMMENT '银行名称',
  `accountname` varchar(30) NOT NULL COMMENT '开户姓名',
  `banknumber` char(22) NOT NULL COMMENT '开户卡号',
  `banklogo` char(120) NOT NULL COMMENT '银行logo',
  `listorder` smallint(6) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1开启 0关闭',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_member
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_member`;
CREATE TABLE `caipiao_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` int(11) NOT NULL DEFAULT '0' COMMENT '上线会员ID',
  `groupid` smallint(6) NOT NULL DEFAULT '1',
  `jinjijilu` tinyint(2) DEFAULT '1' COMMENT '//晋级记录',
  `username` char(60) NOT NULL DEFAULT '',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `proxy` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1代理 0普通',
  `isnb` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1内部会员 0正常',
  `email` char(60) NOT NULL DEFAULT '',
  `phone` char(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `userbankname` varchar(30) NOT NULL DEFAULT '' COMMENT '银行真实姓名',
  `password` char(32) NOT NULL DEFAULT '',
  `tradepassword` char(32) NOT NULL DEFAULT '' COMMENT '资金密码',
  `sex` tinyint(3) DEFAULT '1' COMMENT '//性别',
  `balance` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `yesterday_balance` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '昨天的结算金额',
  `point` int(14) NOT NULL DEFAULT '0' COMMENT '积分',
  `xima` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '洗码余额 0可提现',
  `fandian` decimal(6,1) NOT NULL DEFAULT '0.0' COMMENT '会员通用返点',
  `tel` char(20) NOT NULL DEFAULT '',
  `face` varchar(255) DEFAULT NULL,
  `qq` char(20) NOT NULL DEFAULT '',
  `loginip` char(20) NOT NULL DEFAULT '',
  `iparea` char(11) NOT NULL DEFAULT '',
  `regtime` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `regip` char(20) NOT NULL DEFAULT '' COMMENT '注册IP',
  `source` varchar(30) NOT NULL DEFAULT '' COMMENT '注册来源',
  `logintime` int(11) NOT NULL DEFAULT '0',
  `loginsource` char(20) NOT NULL DEFAULT '' COMMENT 'pc,mobile',
  `onlinetime` int(11) NOT NULL DEFAULT '0' COMMENT '最后在线时间',
  `islock` tinyint(1) NOT NULL DEFAULT '0',
  `birthday` date DEFAULT NULL,
  `zijin_num` varchar(2) NOT NULL DEFAULT '0',
  `mlogin_num` varchar(2) NOT NULL DEFAULT '0',
  `mzijin_num` varchar(2) NOT NULL DEFAULT '0',
  `xiaoxi` int(10) NOT NULL DEFAULT '0' COMMENT '未读消息数',
  `beizhu` varchar(800) NOT NULL DEFAULT '',
  `agent_code` char(10) NOT NULL DEFAULT '' COMMENT '推广码',
  `share_rate` int(10) NOT NULL DEFAULT '0' COMMENT '合营比例',
  `return_water_date` char(10) NOT NULL DEFAULT '' COMMENT '返水日期',
  `last_login_game` varchar(10) DEFAULT '',
  `ob_balance` decimal(14,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `groupid` (`groupid`) USING BTREE,
  KEY `onlinetime` (`onlinetime`) USING BTREE,
  KEY `isnb` (`isnb`) USING BTREE,
  KEY `proxy` (`proxy`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_member_third_game
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_member_third_game`;
CREATE TABLE `caipiao_member_third_game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `game_code` varchar(6) NOT NULL,
  `game_type` varchar(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of caipiao_member_third_game
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_member_third_game` VALUES (1, 1, 'ob', 'fish');
INSERT INTO `caipiao_member_third_game` VALUES (2, 3, 'ob', 'qp');
INSERT INTO `caipiao_member_third_game` VALUES (3, 3, 'ob', 'fish');
INSERT INTO `caipiao_member_third_game` VALUES (4, 3, 'ob', 'zr');
INSERT INTO `caipiao_member_third_game` VALUES (5, 3, 'ob', 'cp');
INSERT INTO `caipiao_member_third_game` VALUES (6, 4, 'ob', 'zr');
INSERT INTO `caipiao_member_third_game` VALUES (7, 3, 'ob', 'ty');
INSERT INTO `caipiao_member_third_game` VALUES (8, 3, 'ob', 'dj');
INSERT INTO `caipiao_member_third_game` VALUES (9, 1, 'ob', 'ty');
INSERT INTO `caipiao_member_third_game` VALUES (10, 1, 'ob', 'qp');
INSERT INTO `caipiao_member_third_game` VALUES (11, 2, 'ob', 'qp');
INSERT INTO `caipiao_member_third_game` VALUES (12, 2, 'ob', 'ty');
INSERT INTO `caipiao_member_third_game` VALUES (13, 2, 'ob', 'fish');
INSERT INTO `caipiao_member_third_game` VALUES (14, 5, 'ob', 'qp');
COMMIT;

-- ----------------------------
-- Table structure for caipiao_membergroup
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_membergroup`;
CREATE TABLE `caipiao_membergroup` (
  `groupid` int(11) NOT NULL AUTO_INCREMENT,
  `listorder` smallint(6) NOT NULL,
  `groupstatus` tinyint(4) NOT NULL DEFAULT '1',
  `addtime` int(11) NOT NULL,
  `groupname` char(80) NOT NULL,
  `isagent` tinyint(4) NOT NULL COMMENT '是否代理',
  `isdefautreg` tinyint(4) NOT NULL COMMENT '注册默认',
  `lowest` smallint(6) NOT NULL DEFAULT '2' COMMENT '最低投注',
  `highest` int(11) NOT NULL COMMENT '最高投注',
  `fanshui` char(255) NOT NULL COMMENT '0.1 ==返水0.1%',
  `touhan` char(20) NOT NULL COMMENT '头衔',
  `shengjiedu` char(30) NOT NULL COMMENT '输额度 | 隔开',
  `rifanyonglv` char(255) NOT NULL COMMENT '日返佣：今天领昨天的；下线会员打码总额：10000-100000|1%； 多个记录使用 "#" 隔开',
  `yuefanyonglv` char(255) NOT NULL COMMENT '月返佣：当月领上月的；下线会员打码总额：10000-100000|1%； 多个记录使用 "#" 隔开',
  `jjje` float NOT NULL COMMENT '晋级金额',
  `tiaoji` float NOT NULL COMMENT '跳级奖励',
  `configs` longtext NOT NULL,
  `level` smallint(6) NOT NULL,
  PRIMARY KEY (`groupid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of caipiao_membergroup
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_membergroup` VALUES (1, 0, 1, 1456912144, 'VIP1', 0, 1, 2, 10000, '100-2000|0.1;2000-10000|0.2;10000-200000|0.3', '农民', '0', '0', '', 0, 0, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (2, 1, 1, 1492393617, 'VIP2', 0, 0, 2, 0, '100-2000|0.2;2000-10000|0.3;10000-200000|0.4', '地主', '10', '0', '', 1, 1, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (3, 2, 1, 1492393701, 'VIP3', 0, 0, 2, 0, '100-2000|0.3;2000-10000|0.4;10000-200000|0.5', '知县', '200', '0', '', 5, 6, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (4, 3, 1, 1456974912, 'VIP4', 0, 0, 2, 0, '100-2000|0.4;2000-10000|0.5;10000-200000|0.6', '通判', '1000', '0', '', 10, 16, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (5, 4, 1, 1492395106, 'VIP5', 0, 0, 2, 0, '100-2000|0.5;2000-10000|0.5;10000-200000|0.5', '知府', '10000', '0', '', 58, 74, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (6, 5, 1, 1492395119, 'VIP6', 0, 0, 2, 0, '100-2000|0.6;2000-10000|0.7;10000-200000|0.8', '总督', '50000', '0', '', 318, 392, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (7, 6, 1, 1469113035, 'VIP7', 0, 0, 2, 0, '100-2000|0.6;2000-10000|0.7;10000-200000|0.8', '巡抚', '250000', '0', '', 1688, 2080, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (8, 7, 1, 1492394070, 'VIP8', 0, 0, 2, 0, '100-2000|0.7;2000-10000|0.8;10000-200000|0.9', '丞相', '1000000', '0', '', 6888, 8968, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (9, 8, 1, 1469113237, 'VIP9', 0, 0, 2, 0, '100-2000|1;2000-10000|1.1;10000-200000|1.2', '帝王', '5000000', '0', '', 38888, 47856, '', 0);
INSERT INTO `caipiao_membergroup` VALUES (10, 9, 1, 1469113531, '代理', 1, 1, 2, 0, '100-2000|0.1;2000-10000|0.5;10000-200000|1;200000-1000000|1.5', '阎罗王', '申请', '100-2000|0.8;2000-10000|1.2;10000-100000|1.5', '100-2000|0.8;2000-10000|1.2;100-100000|1.5', 0, 0, 'a:56:{s:11:\"min_k3ethfx\";i:0;s:11:\"max_k3ethfx\";i:0;s:11:\"min_k3ethdx\";i:0;s:11:\"max_k3ethdx\";i:0;s:12:\"min_k3ebthbz\";i:0;s:12:\"max_k3ebthbz\";i:0;s:11:\"min_k3sthdx\";i:0;s:11:\"max_k3sthdx\";i:0;s:11:\"min_k3sthtx\";i:0;s:11:\"max_k3sthtx\";i:0;s:12:\"min_k3sbthbz\";i:0;s:12:\"max_k3sbthbz\";i:0;s:11:\"min_k3slhtx\";i:0;s:11:\"max_k3slhtx\";i:0;s:11:\"min_k3slhdx\";i:0;s:11:\"max_k3slhdx\";i:0;s:9:\"min_k3hz3\";i:0;s:9:\"max_k3hz3\";i:0;s:9:\"min_k3hz4\";i:0;s:9:\"max_k3hz4\";i:0;s:9:\"min_k3hz5\";i:0;s:9:\"max_k3hz5\";i:0;s:9:\"min_k3hz6\";i:0;s:9:\"max_k3hz6\";i:0;s:9:\"min_k3hz7\";i:0;s:9:\"max_k3hz7\";i:0;s:9:\"min_k3hz8\";i:0;s:9:\"max_k3hz8\";i:0;s:9:\"min_k3hz9\";i:0;s:9:\"max_k3hz9\";i:0;s:10:\"min_k3hz10\";i:0;s:10:\"max_k3hz10\";i:0;s:10:\"min_k3hz11\";i:0;s:10:\"max_k3hz11\";i:0;s:10:\"min_k3hz12\";i:0;s:10:\"max_k3hz12\";i:0;s:10:\"min_k3hz13\";i:0;s:10:\"max_k3hz13\";i:0;s:10:\"min_k3hz14\";i:0;s:10:\"max_k3hz14\";i:0;s:10:\"min_k3hz15\";i:0;s:10:\"max_k3hz15\";i:0;s:10:\"min_k3hz16\";i:0;s:10:\"max_k3hz16\";i:0;s:10:\"min_k3hz17\";i:0;s:10:\"max_k3hz17\";i:0;s:10:\"min_k3hz18\";i:0;s:10:\"max_k3hz18\";i:0;s:11:\"min_k3hzbig\";i:0;s:11:\"max_k3hzbig\";i:0;s:13:\"min_k3hzsmall\";i:0;s:13:\"max_k3hzsmall\";i:0;s:11:\"min_k3hzodd\";i:0;s:11:\"max_k3hzodd\";i:0;s:12:\"min_k3hzeven\";i:0;s:12:\"max_k3hzeven\";i:0;}', 0);
INSERT INTO `caipiao_membergroup` VALUES (11, 11, 1, 0, '总代', 0, 0, 2, 0, '100-2000|0.2;2000-10000|1.0;10000-200000|1.5;200000-1000000|2.0', '玉帝', '', '', '', 0, 0, '', 0);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_memberlog
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_memberlog`;
CREATE TABLE `caipiao_memberlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `type` char(20) NOT NULL COMMENT 'login 登入，logout 登出，withdraw提款',
  `info` varchar(60) NOT NULL,
  `ip` char(20) NOT NULL,
  `iparea` varchar(60) NOT NULL COMMENT 'ip地区',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_memberloginerror
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_memberloginerror`;
CREATE TABLE `caipiao_memberloginerror` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(30) NOT NULL,
  `ip` char(20) NOT NULL,
  `time` int(11) NOT NULL,
  `errornum` smallint(6) NOT NULL,
  `locktime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_membersession
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_membersession`;
CREATE TABLE `caipiao_membersession` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `username` char(60) NOT NULL,
  `sessionid` char(32) NOT NULL,
  `ip` char(20) NOT NULL COMMENT '登录ip',
  `time` int(11) NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`sid`) USING BTREE,
  KEY `userid` (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_message
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_message`;
CREATE TABLE `caipiao_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sentid` int(11) NOT NULL COMMENT '发送人id 系统：system',
  `sentname` char(20) NOT NULL COMMENT '发送人昵称 系统：system',
  `senttitle` varchar(255) NOT NULL COMMENT '标题',
  `sentcontext` text NOT NULL COMMENT '信件内容',
  `receid` int(11) NOT NULL COMMENT '收件人id 系统：system',
  `recename` char(20) NOT NULL COMMENT '收件人昵称 系统：system',
  `senttime` int(11) NOT NULL COMMENT '发送时间',
  `readtime` int(11) NOT NULL DEFAULT '0' COMMENT '读取时间',
  `is_read` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已读',
  `sentdel` tinyint(4) NOT NULL DEFAULT '0',
  `recdel` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sentid` (`sentid`) USING BTREE,
  KEY `sentname` (`sentname`) USING BTREE,
  KEY `receid` (`receid`) USING BTREE,
  KEY `recename` (`recename`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_module
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_module`;
CREATE TABLE `caipiao_module` (
  `moduleid` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `name` char(60) NOT NULL,
  `remark` varchar(120) NOT NULL,
  `listorder` smallint(6) NOT NULL,
  PRIMARY KEY (`moduleid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_news
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_news`;
CREATE TABLE `caipiao_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catid` smallint(6) NOT NULL,
  `catname` varchar(160) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `oddtime` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `catid` (`catid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_news
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_news` VALUES (3, 30, '网站介绍', '关于我们', '<p>\r\n	“彩票，是指国家为筹集社会公益资金，促进社会公益事业发展而特许发行、依法销售，自然人自愿购买，并按照特定规则获得中奖机会的凭证。”<br />\r\n目前特许发行的彩票有中国福利彩票和中国体育彩票，分别归口民政部和体育总局系统发行销售。<br />\r\n以中国福利彩票的拳头产品彩票为例，彩票销售收入的构成比例为：75%返还奖金，1%销售调节基金，5%发行费用，19%公益金。<br />\r\n其中公益金的用途对于福利彩票而言，主要投入到福利、慈善事业；对于彩票而言，主要投入到群众健身设施、奥运项目等等。<br />\r\n买彩票的目的\r\n</p>\r\n<p>\r\n	买彩票是支持中国公益事业的善举，买一注彩票2元钱不多，但表达的爱心无限。<br />\r\n客户买彩票目的，应该立足于爱心、娱乐、可承受。不应该为了侥幸中得大奖而铤而走险，动用不该动用的资金。<br />\r\n彩票团队\r\n</p>\r\n<p>\r\n	彩票目前拥有员工250余人，是一支充满朝气的年轻团队，正处于快速扩张时期。<br />\r\n我们的管理理念是为大家提供尽量宽松舒适的工作环境，充分尊重每个人的价值。管理虽然仍有不少欠缺，但是我们一直在努力做到阳光、健康、规范。<br />\r\n彩票网敞开人才引进之门，为有志之士提供足够的发展空间、提供优厚的薪酬福利待遇。<br />\r\n遵循共同分享的理念，以建设激情澎湃的共同创业团队为目的，我们准备了数量不菲的红股、期权奖励给所有为公司做出贡献的员工。\r\n</p>', 1480805970);
INSERT INTO `caipiao_news` VALUES (10, 34, '安全问题', '参与游戏是否安全？', '<p>\r\n	<span style=\"font-size:16px;\">快3网承若： </span>\r\n</p>\r\n<p>\r\n	<span style=\"font-size:16px;\">1、快3网采用128位SSL加密技术和严格的安全管理体系，确保客户安全得到最完善的保障。 </span>\r\n</p>\r\n<p>\r\n	<span style=\"font-size:16px;\"> 2、客户的所有投注都是在极其严密的情况下进行，我们绝对不会向任何第三方透露客户资料。 </span>\r\n</p>\r\n<p>\r\n	<span style=\"font-size:16px;\"> 3、我们会对每一项交易均采取严格的保密和防盗防诈措施，保证玩家帐户的真实合法性并同时保证玩家交易和支付的安全性。</span>\r\n</p>\r\n<p>\r\n	<span style=\"font-size:16px;\"> 4、快3网安全性业内第一，还请放心游戏。</span>\r\n</p>', 1480812017);
INSERT INTO `caipiao_news` VALUES (14, 34, '安全问题', '钻石娱乐简介', '钻石娱乐是由中国福彩中心推出的全国唯一的大型垂直类彩票平台，涵盖国内所有的彩票玩法，致力于推动快3游戏在中国的发展。钻石娱乐目前是国内最受欢迎的快开类游戏，已经成功在国内覆盖了13个省份，有近千万彩民参与并购买过快3游戏，成功完成了几百亿的销售额。\r\n<p class=\"p2\">\r\n	钻石娱乐的推出是为了让彩民可以更简单、快捷的获取各个省份彩票的开奖数据，预测分析，提供专业的走势、遗漏数据，让彩民可以玩的更加专业，中得更多奖金。不仅如此，钻石娱乐还联合了几个省份，开通彩票在线投注。这极大的方便了彩民用户，实现可以随时随地的购买快3彩票。同时钻石娱乐还推出手机端，联合微信、支付宝，让彩民享受移动互联网的便利。\r\n</p>\r\n<p class=\"p3\">\r\n	钻石娱乐希望跟随中国福彩事业的发展，坚持以彩民利益为先，坚持提供安全、稳定、可靠的彩票数据，致力打造中国领先的彩票服务平台！\r\n</p>', 1480965304);
INSERT INTO `caipiao_news` VALUES (15, 34, '安全问题', '注册之后信息是否会泄露？', '<strong>在您注册成为我们的会员时，客户可能需要填写一些个人信息，如姓名、地址、电子邮箱、电话号码和银行帐号，以便我们更加及时方便的为您提供全方位的服务，在此我们相向您郑重承诺，我们会对会员的隐私进行保护，本平台在任何情况下都不会泄露客户资料！</strong>', 1480965354);
INSERT INTO `caipiao_news` VALUES (16, 34, '安全问题', '安全中心的设置和介绍', '<p>\r\n	本平台采用独有的手机和邮箱的双重认证体制，塑造全新的验证通道。\r\n</p>\r\n<p>\r\n	使其达到最安全的用户体验。\r\n        建议完备下列安全信息，使您账户的安全级别更高，资金更安全。\r\n</p>\r\n<p>\r\n	问题1、什么是手机和邮箱的实时验证码？\r\n</p>\r\n<p>\r\n	首次登陆要根据引导进行邮箱和手机的绑定操作，绑定后，以后的任何操作都要经过验证码的验证保护。\r\n</p>\r\n<p>\r\n	问题2、什么是安全问题？\r\n</p>\r\n<p>\r\n	安全问题用于找回您的平台账号资料，绑定后可以通过安全问题找回。\r\n</p>\r\n<p>\r\n	问题3、绑定邮箱的作用？\r\n</p>\r\n<p>\r\n	绑定邮箱可增加账号安全级别，也可以确保在邮箱正常的情况下取回实时验证码。\r\n</p>', 1480965410);
INSERT INTO `caipiao_news` VALUES (17, 35, '充值问题', '网银汇款须知', '<ul class=\"ul_help\" id=\"ul_help_s\">\r\n	<li style=\"background-color:#fff;\">\r\n		<div class=\"hc_cont\">\r\n			<strong><span style=\"color:#333333;font-family:\'Microsoft Yahei\', \'Hiragino Sans GB\', \'Helvetica Neue\', Helvetica, tahoma, arial, Verdana, sans-serif, \'WenQuanYi Micro Hei\', 宋体;font-size:14px;line-height:24px;background-color:#FFFFFF;\">由于网银汇款暂时只提供：工商银行和建设银行，没有这两个银行卡的会员，需要使用其他银行进行跨行转账；</span> \r\n			<p style=\"color:#666666;font-family:\'Microsoft Yahei\', \'Hiragino Sans GB\', \'Helvetica Neue\', Helvetica, tahoma, arial, Verdana, sans-serif, \'WenQuanYi Micro Hei\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n				为了您的充值能过及时到账，在使用跨行转账时，请尽量使用<strong>“加急汇款”</strong> \r\n			</p>\r\n			<p style=\"color:#666666;font-family:\'Microsoft Yahei\', \'Hiragino Sans GB\', \'Helvetica Neue\', Helvetica, tahoma, arial, Verdana, sans-serif, \'WenQuanYi Micro Hei\', 宋体;font-size:14px;background-color:#FFFFFF;\">\r\n				使用“加急汇款”功能的时间为周一至周五的09:00～16:30，其余时间和假日没有加急选项功能，建议您于可以在加急的时间段内进行充值，使用加急功能进行充值可以快速到账。\r\n			</p>\r\n</strong>\r\n		</div>\r\n	</li>\r\n</ul>', 1480965470);
INSERT INTO `caipiao_news` VALUES (18, 35, '充值问题', '工行转账充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息，并请务必使用”复制”功能</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：点击“登录网上银行付款”，进入工行银行点击上方菜单栏位的“转账汇款”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang3.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：点击页面左侧的“境内汇款”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang4.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：使用“复制”功能，在网银对应栏内粘贴“收款人姓名、收款账号或者收款E-mail、附言”等必填信息（注：请复制申请充值信息的“附言”，粘贴入网银页面“给收款人附言”一栏)</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang5.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第六步：点击“提交”提示交易成功</strong> \r\n</p>', 1480965488);
INSERT INTO `caipiao_news` VALUES (19, 35, '充值问题', '建行转账充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息</strong> \r\n</p>\r\n<p>\r\n	<strong><img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang2.png\" /></strong> \r\n</p>\r\n<p>\r\n	<strong>第三步：点击“转账汇款”,然后点击“活期转账汇款”,跳转跨行转账页面</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang3.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：使用复制功能，在网银对应栏内粘贴“收款账户名、收款账号、附言”等必填信息。（注：复制正确的附言，张贴到附言一栏）</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang4.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：跳转至确认转账信息页面后并点击“确认”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang5.jpg\" /> \r\n</p>\r\n<p>\r\n	<b>第六步：输入建行“网银盾密码”进行支付</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jianhang6.jpg\" /> \r\n</p>\r\n<p>\r\n	<b>第七步：支付信息确认后,跳转至“转账交易成功”页面 </b> \r\n</p>', 1480965506);
INSERT INTO `caipiao_news` VALUES (20, 35, '充值问题', '农行转工商充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang1.png\" /> \r\n</p>\r\n<p>\r\n	<b>第二步：获取充值信息</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang2.png\" /> \r\n</p>\r\n<p>\r\n	<b>第三步：点击“登录网上银行汇款\'后，点击”单笔转账“</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/nonghang3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：添加”新增收款方“</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/nonghang4.png\" /> \r\n</p>\r\n<p>\r\n	<b>第五步：使用复制功能，在网银对应栏内粘贴“账号、账户名、开户网点”等信息</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/nonghang5.png\" /> \r\n</p>\r\n<p>\r\n	<b>第六步：复制平台“附言”信息，粘贴入“转账用途”</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/nonghang6.png\" /> \r\n</p>\r\n<p>\r\n	<b>第七步：输入\"支付密码“点击“提交” 第八步：支付信息确认后，跳转至“转账交易成功”页面</b> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/nonghang7.png\" /> \r\n</p>\r\n<b>第八步：支付信息确认后，跳转至“转账交易成功”页面</b>', 1480965525);
INSERT INTO `caipiao_news` VALUES (21, 35, '充值问题', '民生转工商充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：登录网银页面，点击“转账汇款”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/minsheng3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：选择“跨行转账”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/minsheng4.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：使用复制功能，在网银对应栏内粘贴“收款账户名称、收款账户、附言”等信息（注：请复制申请充值信息的“附言”，粘贴入网银页面“用途”一栏)</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/minsheng5.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第六步：确认充值信息，点击“提交” </strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/minsheng6.jpg\" /> \r\n</p>\r\n<p>\r\n	<strong>第七步：交易成功页面</strong> \r\n</p>', 1480965545);
INSERT INTO `caipiao_news` VALUES (22, 35, '充值问题', '招商转工商充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：登录招商网银页面，点击“转账汇款”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zhaohang3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步:选择</strong><strong>“跨行转账”，	并使用复制功能，在网银对应栏内粘贴“收款方户名、收款方账号、开户网点”等信息（注：请复制申请充值信息的“附言”，粘贴入网银页面“附言”一栏) </strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zhaohang4.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：确认转账信息</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zhaohang5.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第六步：充值成功信息</strong> \r\n</p>', 1480965569);
INSERT INTO `caipiao_news` VALUES (23, 35, '充值问题', '交通转工商充值流程', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-网银汇款”按钮，选择“工商银行\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/gongshang2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：登录网银，选择\"转账\"项下的\"转其他银行\"，点击\"汇款\"</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jiaotong3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：复制平台申请充值信息，粘贴入网银页面“收款人卡号、收款人户名、收款人开户银行、附言”等信息（注：请复制申请充值信息的“附言”，粘贴入网银页面“汇款附言”一栏)</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jiaotong4.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：核对信息后，输入“转入账户校验码”，点击“确定”，输入“usbkey密码”。</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/jiaotong5.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第六步：转账成功</strong> \r\n</p>', 1480965588);
INSERT INTO `caipiao_news` VALUES (24, 35, '充值问题', '快捷充值', '<ul class=\"ul_help\" id=\"ul_help_s\">\r\n	<li style=\"background-color:#fff;\">\r\n		<div class=\"hc_cont\">\r\n			<ul class=\"ul_help\" id=\"ul_help_s\">\r\n				<li style=\"background-color:#FFFFFF;\">\r\n					<div class=\"hc_cont\">\r\n						<p>\r\n							<strong>为了保障会员的权益，保证资金的安全。</strong> \r\n						</p>\r\n						<p>\r\n							<strong>1，我平台合作的第三方有支付宝，易宝，环迅，微信，全部获得银联会支付牌照。</strong> \r\n						</p>\r\n						<p>\r\n							<strong>2，点击充值，选择快捷支付功能，根据选择填写充值金额。</strong> \r\n						</p>\r\n						<p>\r\n							<strong>3，登陆网银付款。</strong> \r\n						</p>\r\n						<p>\r\n							<strong>4，充值成功。</strong> \r\n						</p>\r\n					</div>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</li>\r\n</ul>', 1480965605);
INSERT INTO `caipiao_news` VALUES (25, 35, '充值问题', '支付宝充值', '<p>\r\n	<strong>第一步：点击首页“会员中心-资金管理-我要充值-快捷支付”按钮，选择“支付宝\"输入金额，点击“下一步”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zfb1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：获取充值信息</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zfb2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：点击“去支付宝充值”登录到支付宝页面</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zfb3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第四步：进入转账付款页面，在“收款人”一行，粘贴从平台复制的“收款支付宝账号”和“校验姓名”，“输入充值金额”（注：请复制申请充值信息的“附言”，粘贴入“付款说明”一栏)</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zfb4.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第五步：点击“付款”后，输入“支付密码”</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/zfb5.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第六步：充值付款成功</strong> \r\n</p>', 1480965624);
INSERT INTO `caipiao_news` VALUES (26, 36, '购彩问题', '购彩流程', '<p>\r\n	<strong>第一步：</strong><strong>登录进入平台，选择您需要投注的彩种(如江苏快3...）</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/goucai1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：进入投注页面，选择自己喜欢的玩法（如 大小、单双），选择号码后输入”金额“</strong> <strong>点击”立即投注“</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/goucai2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：请再次检查是否正确，便可点击【确定】</strong> \r\n</p>\r\n<p>\r\n	<strong><img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/goucai3.png\" /></strong> \r\n</p>\r\n<p>\r\n	<strong>第四步： 投注成功后，点击【投注记录】即可查询投注记录</strong> \r\n</p>', 1480965647);
INSERT INTO `caipiao_news` VALUES (27, 37, '提现问题', '平台提款安全吗？', '<strong>通过提交提款申请确保只能由用户自己提款；通过将用户提交的提款银行卡信息与用户注册时提交的身份认证信息进行核对，确保用户只能提款到本人银行卡，任何人都无法盗取用户的资金，保证提款的绝对安全。</strong>', 1480965672);
INSERT INTO `caipiao_news` VALUES (28, 37, '提现问题', '提现须知', '<ul class=\"ul_help\" id=\"ul_help_s\">\r\n	<li style=\"background-color:#fff;\">\r\n		<div class=\"hc_cont\">\r\n			<ul class=\"ul_help\" id=\"ul_help_s\">\r\n				<li style=\"background-color:#FFFFFF;\">\r\n					<div class=\"hc_cont\">\r\n						<strong>1. 提款前请先绑定\"邮箱\"或\"手机\"，并且绑定好银行卡。&nbsp;</strong> \r\n						<p>\r\n							<strong>2. 提款金额必须在可提现额度范围以内。&nbsp;</strong> \r\n						</p>\r\n						<p>\r\n							<strong>3. 当发起提款申请成功后，提款10分钟内到账，如因网银系统问题或其他不可抗力因素影响，到账时间将会延迟，您有任何关于提款问题也可以咨询在线客服。</strong> \r\n						</p>\r\n					</div>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</li>\r\n</ul>', 1480965692);
INSERT INTO `caipiao_news` VALUES (29, 37, '提现问题', ' 如何提款？', '<p>\r\n	<strong>进入平台首页点击“会员中心--资金管理--我要取款”，选择您需要提款的银行卡后，输入您的\"验证码\"提交即可，首次注册账号的用户请您务必绑定好您的\"邮箱\"和\"或手机\"并且\"绑定银行卡\"。</strong> \r\n</p>\r\n<p>\r\n	<strong><img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/qk1.png\" /></strong> \r\n</p>', 1480965710);
INSERT INTO `caipiao_news` VALUES (30, 38, '账户安全', '如何修改登录密码？', '<ul class=\"ul_help\" id=\"ul_help_s\">\r\n	<li style=\"background-color:#fff;\">\r\n		<div class=\"hc_cont\">\r\n			<ul class=\"ul_help\" id=\"ul_help_s\">\r\n				<li style=\"background-color:#FFFFFF;\">\r\n					<div class=\"hc_cont\">\r\n						<strong>请您进入【平台安全中心--密码管理】，通过输入“旧密码”来修改您的登录密码。</strong> \r\n					</div>\r\n				</li>\r\n			</ul>\r\n		</div>\r\n	</li>\r\n</ul>', 1480965738);
INSERT INTO `caipiao_news` VALUES (31, 38, '账户安全', '忘记账户名怎么办？', '<ul class=\"ul_help\" id=\"ul_help_s\">\n	<li style=\"background-color:#fff;\">\n		<div class=\"hc_cont\">\n			<ul class=\"ul_help\" id=\"ul_help_s\">\n				<li style=\"background-color:#FFFFFF;\">\n					<div class=\"hc_cont\">\n						<p>\n							<strong>忘记平台账户名（用户名</strong><strong>），请您联系平台客服提供相关资料帮助找回。</strong> \n						</p>\n					</div>\n				</li>\n			</ul>\n		</div>\n	</li>\n</ul>', 1480965763);
INSERT INTO `caipiao_news` VALUES (32, 38, '账户安全', '忘记登录密码怎么办？', '<p>\r\n	&nbsp;<strong>第一步：进入平台登录页面，点击登录页面的“忘记密码”</strong> \r\n</p>\r\n<p>\r\n	&nbsp;<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/wjmm1.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第二步：第二步：输入您需要登录密码的账户名和验证码后点击“下一步” </strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/wjmm2.png\" /> \r\n</p>\r\n<p>\r\n	<strong>第三步：选择您需要找回登录密码的方式，共有以下3种方式可以找回。</strong> \r\n</p>\r\n<p>\r\n	<img alt=\"\" src=\"http://www.k399.com/templates/SSC/images/bzzx/wjmm3.png\" /> \r\n</p>\r\n<p>\r\n	<strong>如果</strong><strong>以上方式都不可用？您还可以通过在线客服人工申诉找回登录密码</strong>。\r\n</p>', 1480965940);
INSERT INTO `caipiao_news` VALUES (33, 39, '玩法限制规则', '玩法注数限制及最高奖金设置说明', '<ul class=\"ul_help\" id=\"ul_help_s\">\n	<li style=\"background-color:#fff;\">\n		<div class=\"hc_cont\">\n			<ul class=\"ul_help\" id=\"ul_help_s\">\n				<li style=\"background-color:#FFFFFF;\">\n					<div class=\"hc_cont\">\n						<p>\n							<strong>本平台玩法限制，禁止一切刷佣金行为，对此平台将实时监控。</strong> \n						</p>\n						<p>\n							<strong>玩法限制：5星大于80000注，4星大于8000注，3星大于800注，2星大于80注，定位胆大于8码的一律按作弊处理，严重者给予封号处理。&nbsp;</strong> \n						</p>\n						<p>\n							<strong>每单最高奖金限额200000.00元，超出按200000.00元计算</strong><strong>超出的奖金清0；</strong> \n						</p>\n						<p>\n							<strong>五星直选1024注以内，四星直选81注、三星直选8注，二星直选4注以内，组三2注，组六4注及以下均列为单挑模式，单挑模式每期最高奖金10000.00元，超过将按10000.00元返还，请务必知悉</strong> \n						</p>\n					</div>\n				</li>\n			</ul>\n		</div>\n	</li>\n</ul>', 1480965965);
INSERT INTO `caipiao_news` VALUES (34, 40, '快三技巧攻略', '快3投注技巧与实战攻略分享：出球轨迹追踪法', '新快3 独门秘籍分享 出球轨迹追踪法&nbsp;&nbsp; \n出球轨迹追踪法主要参考“快3原始装球顺序图”，快3中奖号码在装球顺序图中呈纵向、横向、三角形、斜向趣味分布。按该三要素走势，挑出“百位数号码摆\n放”“十位数号码摆放”“个位数号码摆放”中具有明显特征的号码，给予特别关注。<br />\n出球轨迹追踪法”以“球摆放”为立足点进行研究，角度新颖，不同于我们日常所参照的“试机号”与“机球号”等，较精确。球摆放即是指摇奖机中球的摆放位置，没有固定的顺序。<br />\n除“出球轨迹追踪法”外，本报特约彩评师李玉群的另一研究成果即“前三期有无号分布图”，即本期奖号在前三期中含有几个，三期有无号在分布图中呈有规\n律地分布。如果彩民能准确地断定当期号码在前三期会含有几个，那么投注范围将会缩小很多。该分布图被本报采纳后，在彩民中产生了较大反响，新彩民可细心留\n意。', 1480965984);
INSERT INTO `caipiao_news` VALUES (35, 40, '快三技巧攻略', '快3投注技巧推荐：教您从公式中找选号玄机', '在投注站里，有几个彩民扰着自己的头在想投注号码该选哪个，有的抬头看站里的走势图，有的人对着屏幕看开奖号，而这些人都是快3的爱好者，10分钟一期的快3游戏，让他们爱不释手。彩站的战主看到大家对选号头痛的样子，于是凑上前去告诉大家自己知道的一些小技巧。<br />\r\n&nbsp;<br />\r\n“快3”里，如果不分位置，同一个号码连续出现3或4期就是极限了，当某个号码连续出现4期(不分位置)，下期相信没人会再选它了。但是这种杀码的机会又不多，一年也没有几次连续出现4期的时候，于是大家就在寻找这种极限机会。“公式法”就是这样产生的，它一出现就受到了彩民的欢迎与追捧。<br />\r\n&nbsp;<br />\r\n公式一：<br />\r\n&nbsp;<br />\r\n“快3”中的“杀号公式”是这样的：当期开奖号码第3位×2+4，结果除以10取余数，余数即为“下期”很可能出的号码!<br />\r\n&nbsp;<br />\r\n公式二：<br />\r\n&nbsp;<br />\r\n当期开奖号码：第3位×3+3牞结果除以10取余数，余数即为“下期”很可能出的号码!', 1480966010);
INSERT INTO `caipiao_news` VALUES (36, 40, '快三技巧攻略', '快3投注技巧与实战攻略分享：和值投注三原则', '实践出真知，在彩民们运用了大量的方法来投注快3时，最后得出一个结论，运用和数值投注“快3”，是中奖率提高的重要手段之一。为了让中奖率进一步提高，总结出了准确选择排列三和数值的“三原则”：<br />\r\n原则一：相邻和数值是否开出。倘若我们选择13的和数值投注，就要先看一看与13相邻的和数值，即12和14的和数值是否曾开出。如果开出，就可考虑投注。如果12和14的和数值已经开出，下一期说不定就有可能出12和14的中间号，即13的和数值。否则，就应放弃。<br />\r\n原则三：同尾和数值是否开出。倘若我们选择13的和数值投注，就要看一看13的同尾和数值，即3或23的和数值是否开出。如果开出，就可考虑投注。在这 \r\n里，我们可以把已经开出的3或23的和数值视为和数值13的“前奏曲”，下一期，说不定就可能开出和数值13这个“协助曲”。否则，就应放弃。此“三原 \r\n则”，综合运用，才能收到明显效果，切忌不可单打独奏，拆开运用。<br />\r\n原则三：平均间隔期是否达到。以和数值13为例，从“快3”正式单 \r\n独开奖以来，截至到05018期，和数值13共出现过14次，其间隔的期数依次为：8、11、2、13、2、2、17、12、18、3、20、0、26、\r\n 1。间隔的总期数为135期，平均间隔期约为10期。我们在确定运用和数值投注时，就要看一看13的和数值是否已出现10期以上。倘若达到，就可考虑投\r\n 注;倘若没有达到，就应放弃。', 1480966029);
INSERT INTO `caipiao_news` VALUES (37, 40, '快三技巧攻略', '快3技巧攻略详解：心态很重要 切勿忘三心', '快3做为一种快开型彩票，即开即奖的特点让彩民们享受了不少购彩的乐趣，但无论中与不中，购买快3都需要不断调整心态，控制好购买的力度，这样无论结果如何，都是一次成功的购彩经历。那该怎样调整心态呢?小编觉得有“三心”很重要!<br />\r\n“玩”心：平常心对彩票的发行和长期购买应有一种健康心态。能冷静沉着地看待“风采”，情绪保持正常，无大波动。做到以买彩为游戏，不做冒险投赌，以“玩”为主，寻求乐趣，增加生活内容;投注多少量力而行，绝不影响生活。中彩与否在情绪上无大波动，中大奖不大喜，狂喜，防止乐极生悲;频投落空，不悔不怨，当做献“爱心”。<br />\r\n“恒”心：恒心购买彩票，期期紧跟，无特殊原因绝不间断，不学有些彩民兴来即投，失中即停，半途而废;也不因中小奖就加大注数，更不因频频失中便哀声叹气，以至中断买彩。要把买彩票看做锻炼毅力的好机会，持之以恒，细水长流，从长期玩彩中找乐趣，撞财运。<br />\r\n“学”心：选号要有“学”心，要学习别人投注的各种方法和技巧，在钻研过程中享受乐趣，丰富人生内涵，更重要的是总结个人投注的得失，从无规律中找窍门，寻求较好的投注方法。而老年彩民更要\"学\"，通过\"学\"玩彩促进脑细胞的新陈代谢，灵活脑力，达到延年益寿的目的。彩票世界，也是百态人生。', 1480966047);
INSERT INTO `caipiao_news` VALUES (38, 40, '快三技巧攻略', '快3投注技巧：如何玩转三同号 高手为您来支招', '三同号投注包含三同号通选和三同号单选两种玩法。其中三同号通选玩法相对比较简单，只用2元就可全包豹子(111、222、333、444、555、666)进行投注，开奖号码中，只要开出任意豹子即中奖;三同号单选投注，是指从所有相同的三个号码(111、222、333、444、555、666)中任意选择一组号码进行投注，该种玩法相对较难，但是相应的奖金也是比较较高。<br />\r\n下面总结出了高手彩民玩快3常用的几种技巧，希望对大家有所帮助。<br />\r\n一、遗漏追号<br />\r\n一个三同号的遗漏周期相对较大，目前最大遗漏是111组合的1260期，虽然三同号单选奖金较多，但风险大。因此，要根据时机来追三同号。可以根据最近的走势，假如前30期未开出，那么就可以通过56个号码分布图对比一下6个三同号在一个月内开出的次数，去掉最冷的和开的次数最多的，还有开的次数最少的三个三同号，剩下三个三同号做40期追号计划，根据自身条件设计合理的利润，在很多时候会有所收获。<br />\r\n如果你觉得选三同号太难，怕即使开出三同号也未必是你选择的那几个，那么选择追三同号通选就比较保险，只要在你追号的周期内开出，你就可以盈利。当然小编也要提醒大家，在最近连续开出21天三同号的情况下追三同号通选也是存在风险的，因为一个号热久了会有冷的一天。您也可以选择在三同号冷后的第三天开始利用这个方法来设计追三同号单选或者三同号通选，以此来提高命中率。<br />\r\n二、利用和值选号<br />\r\n在快3中，包含三同号组合的和值分别有：3(111)、6(222)、9(333)12(444)、15(555)、18(666)，其中9和12的出现频率较高，而3和18的奖金最高，但开出概率较低。因此，可以重点关注几个高频率的中间和值来进行选号，投注三同号单选。<br />\r\n三、重号热号结合<br />\r\n观察最近10期的开奖号码，可利用热号和重号结合来选号投注三同号单选。从图中可以看出，热号1在连续开出了3期后，第72期便开出了三同号111。<br />\r\n三同号通选的理论遗漏为1/36，在三同号通选的遗漏期数达到理论遗漏的2倍左右，就可以结合近两天三同号的出号情况做一个追号计划。值得注意的是，三同号通选的历史最大遗漏为317期。', 1480966068);
INSERT INTO `caipiao_news` VALUES (43, 33, '帮助指南', '如何注册', '<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\n	<span style=\"font-size:12px;\">点击网站右上角＂用户注册＂按钮，就可以进入用户注册页面；</span>\n</p>\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\n	按照提示，填写注册信息，即可完成<span style=\"font-size:12px;\">注册</span>；\n</p>\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\n	账号为4-15位字符，支持数字和字母，禁止以0开头；\n</p>\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\n	密码为6-16位字符，支持数字、字母、符号；\n</p>\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\n	注册完成后，系统将随机分配一张头像，进入＂我的账户＂＂个人信息＂可以修改头像和设置昵称；\n</p>', 1494640149);
INSERT INTO `caipiao_news` VALUES (44, 33, '帮助指南', '在线客服服务时间', '<span style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\">平台在线客服在上午</span></span><span style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\">08:30-夜间24:00为您提供最优质专业的服务，</span></span><span style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\">其他时间段请您留下您的联系方式，问题，我们会尽快帮您联系处理</span></span><span style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\">。平台的服务宗旨：我专业，您放心，我敬业，您省心。</span></span>', 1494640774);
INSERT INTO `caipiao_news` VALUES (45, 33, '帮助指南', '平台的充值方式有哪些？', '<p style=\"font-family:微软雅黑, &quot;font-size:14px;background-color:#FFFFFF;color:#666666;\">\n	<span style=\"font-family:Tahoma;\">本站暂时提供四种充值方式，即“网银汇款、快捷充值、微信充值和支付宝充值”。</span>\n</p>\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;background-color:#FFFFFF;color:#666666;\">\n	<span style=\"font-family:Tahoma;\">网银汇款：指通过网上银行、银行存款等方式打款到本站提供的银行账户；</span>\n</p>\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;background-color:#FFFFFF;color:#666666;\">\n	<span style=\"font-family:Tahoma;\">快捷充值：指通过第三方进行支付，方便快捷；</span>\n</p>\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;background-color:#FFFFFF;color:#666666;\">\n	<span style=\"font-family:Tahoma;\">支付宝充值：指通过支付宝转账到本站提供的支付宝账户。</span>\n</p>\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;background-color:#FFFFFF;color:#666666;\">\n	<span style=\"font-family:Tahoma;\">微信充值：指通过微信转账到本站提供的微信账户。</span>\n</p>', 1494640796);
INSERT INTO `caipiao_news` VALUES (46, 33, '帮助指南', '如何购彩', '<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:&quot;font-size:12px;\">购彩前需要先进行充值，账户有余额才可以进行购彩投注；</span>\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	充值完成后，可进入＂购彩大厅＂选择您喜欢的彩票进行投注；\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	彩票投注页面，提供了＂玩法说明＂＂走势图＂，可以帮您更快了解＂玩法规则＂和＂开奖走势＂\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	投注完成后，可以进入＂我的账户＂＂投注记录＂，查看您的投注明细，查看是否中奖；\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	投注完成后，需等开奖后，才能查看是否中奖；\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	投注成功后，系统将自动从您的账户余额扣除对应的投注金额，如果中奖，奖金会自动添加到您的账户余额；\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:&quot;font-size:12px;\">可以进入＂我的账户＂＂交易记录＂，查看您的账户交易明细；</span>\r\n</p>', 1494640853);
INSERT INTO `caipiao_news` VALUES (47, 33, '帮助指南', '如何提现', '<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	<span style=\"font-family:\" font-size:12px;\"=\"\">中奖后如何提现？点击网站右上角＂提现＂按钮，就可以进入提现页面；</span> \r\n	</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	选择您绑定的银行卡，填写您要提现的金额，并输入＂安全密码＂；\r\n</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	提现订单提交后，3-5分钟左右即可到账，可登陆银行查看银行账户余额；\r\n	</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	点击＂我的账户＂＂交易记录＂可查看每日的交易明细；\r\n</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	<span style=\"font-family:\" font-size:12px;\"=\"\">提现之前需先设置</span><span style=\"font-family:\" font-size:12px;\"=\"\">＂安全密码</span><span style=\"font-family:\" font-size:12px;\"=\"\">＂和绑定您要用来提现的银行卡；</span> \r\n	</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	提现金额不能大于可提现金额；\r\n</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\">\r\n	为了提供更好的服务体验，降低广大用户提现订单的处理时间，每日最多只允许提现3次，建议用户合理安排每日的提现时间和次数；\r\n	</p>', 1494640874);
INSERT INTO `caipiao_news` VALUES (48, 33, '帮助指南', '手机如何购彩', '<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:&quot;font-size:12px;\">直接在手机浏览器输入网址，即可登录手机版，无需下载；</span>\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	手机版<span style=\"font-family:&quot;font-size:12px;\">随时随地可以进行投注，</span>更加便捷，建议广大用户使用手机版进行投注；\r\n</p>\r\n<p style=\"font-family:&quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	建议使用＂谷歌＂＂苹果＂＂UC＂浏览器，操作体验更佳；\r\n</p>', 1494640891);
INSERT INTO `caipiao_news` VALUES (49, 33, '帮助指南', '账户安全', '<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	为了广大用户的账户安全，网站的＂安全中心＂提供了多项提升账户安全系数的功能；\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	新用户注册完成后，请及时进入＂安全中心＂绑定＂密保手机＂<span style=\"font-size:12px;\">＂</span>密保问题＂＂密保邮箱＂；\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	用户忘记密码时，可通过以上功能，找回密码；\r\n</p>', 1494640907);
INSERT INTO `caipiao_news` VALUES (50, 33, '帮助指南', '网上购彩常见骗术', '<span style=\"font-family:Tahoma;font-size:14px;color:#E53333;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\">骗术一、步步为营 巧立名目，不断要求用户缴费</span></span><span style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\"></span><span style=\"color:#666666;font-family:&quot;background-color:#FFFFFF;\"></span>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">用户注册后要求用户缴纳会员费、资料费、保证金、押金、开通费等多种名目的费用，步步紧逼，将用户带向缴费的无底洞，当用户恍然觉醒，后悔晚矣！</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术二、高额回报 收取号码预测费，不中退款</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">提供号码预测有偿服务，吹嘘高命中率和高回报率，并承诺不中退款甚至给予赔偿，利用用户想中大奖的心理骗取号码预测费，一旦号码预测错误，便溜之大吉。</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术三、收费骗局 收取费用后不提供服务也不退款</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">某些网站收取用户的费用后，不提供事先承诺的服务，当用户要求退款时，也不退款，用户最终是投诉无门，退款无望，最终不了了之。</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术四、故计重施 骗完一批人，改头换面继续行骗</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">某些网站骗了一批用户后，使用新的网站名称、域名以及客服电话，对网站内容稍加改动或干脆不改动继续行骗，使一批批用户不断上当。</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术五、官方旗号 借用彩票中心名义行骗</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">假借福利彩票发行中心或体育彩票管理中心等官方机构的名义，增加网站的公信力，当用户放松警惕后，便要求用户缴纳各种费用。</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术六、无中生有 编造子虚乌有的机构行骗</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\">编造双色球管理局、3D管理局等子虚乌有的机构欺骗用户，使用户误以为网站有官方背景，继而对用户行骗。</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;\"></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\">骗术七、私自主动加你好友%99是骗子</span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-family:Tahoma;font-size:12px;color:#E53333;\"><span style=\"font-weight:bolder;font-family:&quot;\"></span></span>\r\n</p>\r\n<p style=\"font-family:微软雅黑, &quot;font-size:14px;color:#666666;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:&quot;font-size:12px;\"><span style=\"font-family:Tahoma;\">编造各种好处诱惑您上当，大家谨防受骗</span></span>\r\n</p>', 1494640927);
INSERT INTO `caipiao_news` VALUES (51, 33, '帮助指南', '如何绑定银行卡', '<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	<span style=\"font-size:12px;\">进入</span><span style=\"font-size:12px;\">＂我的账户＂</span><span style=\"font-size:12px;\">＂银行卡管理＂可以绑定您要用来提现的银行卡；</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	<span style=\"font-size:12px;\">绑定银行卡前，需先设置安全密码；</span>\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	银行卡最多只允许绑定5张；\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	银行卡绑定支持所有主流银行；\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;background-color:#FFFFFF;font-family:&quot;\">\r\n	为了用户资金安全，已成功提现的银行卡将自动锁定，无法删除和修改；如想弃用银行卡，可联系在线客服禁用该银行卡；\r\n</p>', 1494640956);
INSERT INTO `caipiao_news` VALUES (52, 33, '帮助指南', '平台提款时间段', '<span style=\"color:#666666;font-family:&quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;font-family:&quot;color:#666666;background-color:#FFFFFF;\"><span style=\"font-family:SimSun;font-size:18px;\">提款时间段为每天上午10:00---夜间24:00，其他时间提交统一等上午10点准时出款</span></span></span>', 1494641014);
INSERT INTO `caipiao_news` VALUES (53, 33, '帮助指南', '游戏规则', '<p style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:;\"><span style=\"font-size:14px;color:#000000;\">本平台快3开奖结果是根据江苏快3、广西快3、吉林快3、湖北快3、河北快3、安徽快3开奖为依据的。另外会员可以下注单、双、大、小。详细规则如下：</span></span> \r\n</p>\r\n<p style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;\"><br />\r\n</span>\r\n</p>\r\n<p style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;\">第一条 &nbsp;快3游戏投注是指以三个号码组合为一注进行单式投注，每个投注号码为1-6共六个自然数中的任意一个，一组三个号码的组合称为一注。。购买者可对其选定的投注号码进行多注投注。单注彩票的投注金额最高无上限。</span>\r\n</p>\r\n<h3 style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:;\"> 第二条 &nbsp;购买者在网上投注。投注号码记录为江苏开奖凭证，开奖时将自动结算到帐户。</span>\r\n</h3>\r\n<h3 style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:;\"> 第三条 &nbsp;快3游戏根据号码组合共分为“和值”、“三同号”、“二同号”、“三不同号”、“二不同号”、“三连号通选（即全包）”投注方式，具体规定如下：<br />\r\n（一）、和值投注：是指对三个号码的和值进行投注，包括“和值3”至“和值18”投注。<br />\r\n（二）、三同号投注：是指对三个相同的号码进行投注，具体分为：<br />\r\n1、三同号通选（即全包）：是指对所有相同的三个号码（111、222、…、666）进行投注；<br />\r\n2、三同号单选：是指从所有相同的三个号码（111、222、…、666）中任意选择一组号码进行投注。<br />\r\n（三）二同号投注：是指对两个指定的相同号码进行投注，具体分为：<br />\r\n1、二同号复选：是指对三个号码中两个指定的相同号码和一个任意号码进行投注；<br />\r\n2、二同号单选：是指对三个号码中两个指定的相同号码和一个指定的不同号码进行投注。<br />\r\n（四）三不同号投注：是指对三个各不相同的号码进行投注。<br />\r\n（五）二不同号投注：是指对三个号码中两个指定的不同号码和一个任意号码进行投注。<br />\r\n（六）三连号通选投注（即全包）：是指对所有三个相连的号码（仅限：123、234、345、456）进行投注。</span> \r\n</h3>\r\n<h3 style=\"font-family:微软雅黑;font-size:12px;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:;\"><span style=\"font-size:14px;color:#000000;\"></span></span> \r\n</h3>\r\n<h1 style=\"font-size:12px;font-family:微软雅黑;color:#333333;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-family:;\"><span style=\"font-size:14px;color:#E53333;\">以上如不清楚请您与客服联系！谢谢合作！</span></span> \r\n</h1>\r\n<br />\r\n<p>\r\n	<br />\r\n</p>', 1494641056);
INSERT INTO `caipiao_news` VALUES (54, 33, '帮助指南', '什么是可提现金额', '<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\"> <span style=\"font-size:12px;\">为防止洗黑钱等行为；每一笔充值，至少需要投注充值金额的50%才可以全额提现；</span> \r\n	</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\"><br />\r\n</p>\r\n<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;\"=\"\"><br />\r\n	</p>\r\n	<div>\r\n		<br />\r\n	</div>', 1494641072);
INSERT INTO `caipiao_news` VALUES (55, 33, '帮助指南', '二维码支付管理', '<p style=\"font-family:\" font-size:14px;color:#666666;background-color:#ffffff;text-align:center;\"=\"\"><span><b><span style=\"color:#F46E00;font-family:&quot;background-color:#FFFDEB;\">手机用户充值流程：</span><br />\r\n<span style=\"color:#F46E00;font-family:&quot;background-color:#FFFDEB;\">1：选择输入好自己要充值的金额,输入付款支付宝账号&nbsp;点击下一步</span><br />\r\n<span style=\"color:#F46E00;font-family:&quot;background-color:#FFFDEB;\">2：跳转出二维码，然后长按二维码保存或截屏起来</span><br />\r\n<span style=\"color:#F46E00;font-family:&quot;background-color:#FFFDEB;\">3：进入自己支付宝的扫一扫，右上角点击下相册，选择扫描刚刚保存的二维码</span><br />\r\n<span style=\"color:#F46E00;font-family:&quot;background-color:#FFFDEB;\">4：手机点击下立即支付，支付成功后刷新下网页立即到账哦。</span></b></span> \r\n	</p>', 1494641114);
INSERT INTO `caipiao_news` VALUES (56, 30, '网站介绍', '联系我们', '<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;\"><span style=\"color:#666666;font-family:\" background-color:#ffffff;\"=\"\"><span background-color:#ffffff;\"=\"\" style=\"color: rgb(102, 102, 102); font-family: \" microsoft=\"\" yahei\",=\"\" simsun,=\"\" arial;=\"\" white-space:=\"\" normal;=\"\" background-color:=\"\" rgb(255,=\"\" 255,=\"\" 255);\"=\"\">钻石</span><span style=\"color:#666666;font-family:\" background-color:#ffffff;\"=\"\">娱乐</span></span>暂时仅提供在线咨询服务，点击网站右上角＂在线客服</span><span style=\"font-size:12px;\">＂即可进行在线咨询；</span> \r\n</p>\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<span style=\"font-size:12px;\"><span>我们提供全天候在线咨询服务，全年无休；</span>专业的客服团队，全天候为您解答所有疑问；咨询服务请联系＂在线客服＂</span>\r\n</p>', 1495071988);
INSERT INTO `caipiao_news` VALUES (57, 30, '网站介绍', '商务合作', '<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-size:12px;\"><span style=\"color:#333333;\">内容合作</span></span>\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	如果您拥有精彩或原创的与彩票玩法彩票技巧等相关的内容或其他资源,欢迎您与我们取得联系！\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<span style=\"font-weight:bolder;font-family:\'Microsoft YaHei\';color:#666666;line-height:24px;background-color:#FFFFFF;\"><span style=\"color:#333333;\">广告合作</span></span><br />\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	通过对网站广告位的互换及其他自由组合形式的广告资源置换来扩大宣传、增加多样化服务入口，最终以提升网站用户能获取更多附加价值为目的。如果您有相应的资源，非常欢迎您和我们取得联系。\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<br />\r\n</p>\r\n<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	<span style=\"font-weight:bolder;font-size:12px;\"><span style=\"color:#333333;\">媒体合作</span></span><br />\r\n<span style=\"font-size:12px;\">如果您拥有互联网、微信、微博等各类传统与新媒体的丰富资源欢迎您与我们取得联系,让我们通过双方的友好合作来共同提高彼此的影响力！</span>\r\n</p>', 1495072030);
INSERT INTO `caipiao_news` VALUES (58, 30, '网站介绍', '法律声明', '<span style=\"color:#666666;font-family:\'Microsoft YaHei\';font-size:14px;line-height:24px;background-color:#FFFFFF;\">本网站提供的任何内容（包括但不限于数据、文字、图表、图象、声音或录象等）的版权均属于本网站或相关权利人。未经本网站或相关权利人事先的书面许可，您不得以任何方式擅自复制、再造、传播、出版、转帖、改编或陈列本网站的内容。同时，未经本网站书面许可，对于本网站上的任何内容，任何人不得在非本网站所属的服务器上做镜像。任何未经授权使用本网站的行为都将违反《中华人民共和国著作权法》和其他法律法规以及有关国际公约的规定。</span>', 1495072059);
INSERT INTO `caipiao_news` VALUES (59, 30, '网站介绍', '隐私声明', '<p style=\"font-size:14px;color:#666666;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\">\r\n	在登陆时向我们提供您的个人信息是基于对我们的信任，我们会以专业、谨慎和负责的态度对待您的个人信息。我们认为隐私权是您的重要权利，我们尊重您的隐私权，您提供的信息只能用于帮助我们为您提供更好的服务，因此，我们制定了个人信息保密制度以保护您的个人信息。凡以任何方式登陆本网站或直接、间接使用本网站资料者，视为自愿接受本网站声明的约束。我们的隐私权保护条款如下：\r\n</p>\r\n<span style=\"line-height:24px;color:#333333;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;\">个人信息的收集</span></span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">在您注册、使用本网站服务时，经您的同意，我们收集与个人身份有关的信息。如果您无法提供相应信息，可能会不能使用对应服务。我们也会基于优化用户体验的目的，收集其他有关的信息，以便优化我们的网站服务。</span><br />\r\n<span style=\"font-weight:bolder;font-family:\'Microsoft YaHei\';color:#666666;line-height:24px;background-color:#FFFFFF;\"><span style=\"color:#333333;\">隐私的保护</span></span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">保护用户隐私是本网站的一项基本政策。本网站不会公布或传播您在本网站注册的任何资料，但下列情况除外：</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">1）事先获得用户的明确授权；</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">2）用户对自身信息保密不当原因，导致用户非公开信息泄露；</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">3）由于网络线路、黑客攻击、计算机病毒、政府管制等原因造成的资料泄露、丢失、被盗用或被篡改等；</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">4）根据有关法律法规的要求；&nbsp;</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">5）依据法院或仲裁机构的裁判或裁决，以及其他司法程序的要求；</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">6）按照相关政府主管部门的要求；</span><br />\r\n<span style=\"line-height:24px;color:#333333;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;\">自我更新与信息公开</span></span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">我们鼓励您自我更新和修改个人信息以使其安全和有效。您能在任何时候非常容易地获取并修改您的个人信息，您可以随时自行决定修改、删除您在网站上的相关资料。您是唯一对您的账号和密码信息负有保密责任的人，任何情况下，请小心妥善保管。</span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">无论何时您自愿在公开场合披露个人信息， 此种信息可能被他人收集及使用，因此造成您的个人信息泄露，网站不承担责任。</span><br />\r\n<span style=\"line-height:24px;color:#333333;font-family:\'Microsoft YaHei\' !important;background-color:#FFFFFF;\"><span style=\"font-weight:bolder;\">提示</span></span><br />\r\n<span style=\"font-family:\'Microsoft YaHei\', SimSun, Arial;color:#666666;line-height:24px;background-color:#FFFFFF;\">我们可能会不时修改我们的隐私政策，这些修改会反映在本声明中，我们的任何修改都会将您的权益和满意度置於首位，我们希望您在每次访问我们的网页时都查阅我们的隐私声明，用户继续享用服务，则视为接受服务条款的变动。</span>', 1495072080);
INSERT INTO `caipiao_news` VALUES (60, 46, '代理合作', '代理合作', '<div>\r\n	<span style=\"color:#666666;font-family:\" background-color:#ffffff;\"=\"\"><span background-color:#ffffff;\"=\"\" style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft YaHei&quot;, SimSun, Arial; white-space: normal; background-color: rgb(255, 255, 255);\">众乐</span><span style=\"color:#666666;font-family:&quot;background-color:#FFFFFF;\">彩票</span></span>网拥有多元化的产品，使用最公平、公正、公开的系统，在市场上的众多博彩网站中，我们自豪的提供会员最优惠的回馈，给予合作伙伴最优势的营利回报!&nbsp;无论&nbsp;拥有的是网络资源，或是人脉资源，都欢迎您来加入<span style=\"color:#666666;font-family:\" background-color:#ffffff;\"=\"\"><span background-color:#ffffff;\"=\"\" style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft YaHei&quot;, SimSun, Arial; white-space: normal; background-color: rgb(255, 255, 255);\">众乐</span><span style=\"color:#666666;font-family:&quot;background-color:#FFFFFF;\">彩票</span></span>网合作伙伴的行列，无须负担任何费用，就可以开始无上限的收入。&nbsp;选择<span style=\"color:#666666;font-family:\" background-color:#ffffff;\"=\"\"><span background-color:#ffffff;\"=\"\" style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft YaHei&quot;, SimSun, Arial; white-space: normal; background-color: rgb(255, 255, 255);\">众乐</span><span style=\"color:#666666;font-family:&quot;background-color:#FFFFFF;\">彩票</span></span>网，绝对是您最聪明的选择!<br />\r\n代理条件：<br />\r\na.具有便利的计算机上网设备。<br />\r\nb.有一定的人脉资源、网络资源或自己的广告网站。<br />\r\nc.每期都要有2个实际有效投注的会员以上，如达不到就累积到下期计算佣金。<br />\r\n代理独立平台：<br />\r\n我们为您提供单独的代理后台，您可以在后台不受限制的开出下线，并且实时了解下线会员输赢，存款，取款情况。代理后台有一个您的专属链接，您可以直接将您的专属链接链接在网站、论坛、博客等等可链接的网络页面，也可在群里面发送您的专属链接，只要通过您的专属链接注册的会员都算是您的下线。推广方式简单方便，推广渠道多种多样。<br />\r\n有效会员：<br />\r\n月结区间内进行过最少五次有效下注且投注总额不低于500RMB的会员！如联盟体系当月未达（月最低有效会员）最低门坎5人，则该月无法领取佣金回馈。联盟体系当月营利达到标准，而（月最低有效会员）人数未达相应最低门坎，则该月佣金比例依照﹛月最低有效会员﹜人数所达门坎相应的百分比进行退佣。<br />\r\n代理收入：<br />\r\nA：比如您本月的代理账号内有赢利的情况下，就可拥有以下收入:<br />\r\n1.一个月内公司在您的代理账号内纯赢利达到1000元-50000元，可享受其中15%的佣金。<br />\r\n2.一个月内公司在您的代理账号内纯赢利达到50001元-100000元，可享受其中20%的佣金。<br />\r\n3.一个月内公司在您的代理账号内纯赢利达到100001元-200000元，可享受其中25%的佣金。<br />\r\n4.一个月内公司在您的代理账号内纯赢利达到200001元-500000元，可享受其中30%的佣金。<br />\r\n5.一个月内公司在您的代理账号内纯赢利达到500001元以上，可享受其中35%的佣金。<br />\r\n请注意：<br />\r\n每位加入合营商的客户，如果您在第一个月的有效会员未达到公司要求，但有产生佣金，您的佣金将累计到下个月。<br />\r\n禁止代理商私自开设会员帐号进行非法投注套利。任何使用不诚实方法骗取代理佣金或下线会员与代理商同IP的我们视为代理商自己开设会员游戏，将取消代理资格并永久冻结账户，佣金一律不予发放。同IP出现多个会员的话，将被视为无效会员，不得计算在内。&nbsp; 详细洽谈。<br />\r\n</div>', 1497777712);
INSERT INTO `caipiao_news` VALUES (66, 41, '优惠活动', '充值三连送  彩金送不停', '<p align=\"left\" style=\"text-align:center;text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">新会员首次充值三连送</span> <span style=\"font-family:宋体;\">充多送多</span> <span style=\"font-family:宋体;\">彩金送不停</span></span></b>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">新会员首次充值三连送</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动对象：众乐彩票全体成员</span> &nbsp;</span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动内容：多充多送，彩金送不停</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动时间：</span>2018-11-5<span style=\"font-family:宋体;\">至</span><span style=\"font-family:Calibri;\">2020-11-5</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-align:center;text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">独家品牌</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">诚信铸就</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">信誉第一</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">网投首选</span></span></b>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">活动详情</span></span></b>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">凡是在众乐彩票新注册的会员即可参与存款</span>100<span style=\"font-family:宋体;\">元以上送彩金活动</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">充多送多</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">领取的优惠彩金只需</span><span style=\"font-family:Calibri;\">1</span><span style=\"font-family:宋体;\">倍流水即可提现。</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<table style=\"border:currentColor;width:426.1pt;border-collapse:collapse;\" border=\"1\" cellspacing=\"0\">\r\n		<tbody>\r\n			<tr>\r\n				<td width=\"189\" valign=\"top\" style=\"border:1pt solid windowtext;background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">充值次数</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">赠送金额</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">提款要求</span>\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">首次</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">2%</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\" rowspan=\"3\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:Calibri;font-size:10.5pt;\">&nbsp;</span>\r\n					</p>\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">一倍打码</span>\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">二次</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">3%</span>\r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">三次</span>\r\n					</p>\r\n				</td>\r\n				<td width=\"189\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">5%</span>\r\n					</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"color:#FF0000;font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">例如：张三首次充值</span>100<span style=\"font-family:宋体;\">元，赠送</span><span style=\"font-family:Calibri;\">2</span><span style=\"font-family:宋体;\">元，一倍打码量就是</span></span><span style=\"color:#FF0000;font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">投注累计达到</span></span><span style=\"color:#FF0000;font-family:宋体;font-size:10.5pt;\">102<span style=\"font-family:宋体;\">元即可提款</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">申请方式</span></span></b>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">符合条件的会员请您联系</span>QQ<span style=\"font-family:宋体;\">：</span><span style=\"font-family:Calibri;\">89163677</span><span style=\"font-family:宋体;\">专员进行申请</span></span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<span style=\"font-family:Calibri;font-size:10.5pt;\">&nbsp;</span>\r\n</p>\r\n<p align=\"left\" style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">活动规则</span></span></b>\r\n</p>\r\n<p align=\"left\" style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\">1.<span style=\"font-family:宋体;\">所获得奖金需</span><span style=\"font-family:Calibri;\">1</span><span style=\"font-family:宋体;\">倍打码即可申请提款 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">2.</span><span style=\"font-family:宋体;\">首次充值会员需在</span><span style=\"font-family:Calibri;\">48</span><span style=\"font-family:宋体;\">小时内到优惠活动大厅申请</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">逾期则视为放弃。 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">3.</span><span style=\"font-family:宋体;\">每位会员</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">每一相同</span><span style=\"font-family:Calibri;\">IP</span><span style=\"font-family:宋体;\">、每一电子邮箱、每一电话号码、相同支付方式</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">借记卡</span><span style=\"font-family:Calibri;\">/</span><span style=\"font-family:宋体;\">信用卡</span><span style=\"font-family:Calibri;\">/</span><span style=\"font-family:宋体;\">银行账户</span><span style=\"font-family:Calibri;\">)</span><span style=\"font-family:宋体;\">及共享计算环境</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">例如网吧、其他公用计算机等</span><span style=\"font-family:Calibri;\">)</span><span style=\"font-family:宋体;\">只能享受一次优惠</span><span style=\"font-family:Calibri;\">;</span><span style=\"font-family:宋体;\">若会员有重复申请优惠行为</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">公司保留取消或收回会员优惠彩金的权利 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">4.</span><span style=\"font-family:宋体;\">众乐彩票的所有优惠为玩家而设</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">如发现任何团体或个人</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">以不诚实方式获取红利或造成任何威胁</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">滥用公司优惠等行为公司保留冻结、取消该团体或个人账户结余的权利 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">5.</span><span style=\"font-family:宋体;\">若会员对活动有争议时</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">为确保双方利益</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">杜绝身份盗用行为</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">众乐彩票有权要求会员向我们提供充足有效证件</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">用以确保是否享有该优惠的资质。 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">6.</span><span style=\"font-family:宋体;\">此活动可与其他优惠同时进行享用。 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"font-family:Calibri;\">7.</span><span style=\"font-family:宋体;\">众乐彩票保留对活动最终解释权以及在无通知的情况下修改、终止活动的权利</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">适用于所有优惠。</span></span>\r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<br />\r\n</p>', 1552053402);
INSERT INTO `caipiao_news` VALUES (67, 41, '优惠活动', '下载APP赠送彩金', '<p style=\"text-align:center;text-indent:2em;\" align=\"center\">\r\n	<span style=\"color:#FF0000;font-family:宋体;font-size:16pt;\"><span style=\"font-family:宋体;\">下载手机</span>APP<span style=\"font-family:宋体;\">，赠送</span><span style=\"font-family:Calibri;\">28</span><span style=\"font-family:宋体;\">元彩金，游戏随时随地，一手掌握</span></span> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">下载</span>APP<span style=\"font-family:宋体;\">赠送</span><span style=\"font-family:Calibri;\">28</span><span style=\"font-family:宋体;\">元彩金</span></span> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动对象：众乐彩票全体成员</span></span> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动内容：快捷方便</span></span> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动时间：</span>2018-11-5<span style=\"font-family:宋体;\">至</span><span style=\"font-family:Calibri;\">2020-11-5</span></span> \r\n</p>\r\n<p style=\"text-align:center;text-indent:2em;\" align=\"center\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">独家品牌</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">诚信铸就</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">信誉第一</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">网投首选</span></span></b> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">活动详情</span></span></b> \r\n</p>\r\n<p style=\"text-align:left;text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">下载手机</span>APP<span style=\"font-family:宋体;\">注册众乐彩票会员</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">充值</span><span style=\"font-family:Calibri;\">100</span><span style=\"font-family:宋体;\">元以上即可添加优惠专员微信领取</span><span style=\"font-family:Calibri;\">28</span><span style=\"font-family:宋体;\">元</span><span style=\"font-family:Calibri;\">APP</span><span style=\"font-family:宋体;\">彩金。所获彩金只需一倍流水即可出款。手机</span><span style=\"font-family:Calibri;\">APP</span><span style=\"font-family:宋体;\">在线购彩</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">即方便又快捷</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">让广大彩民享受彩票带来的无限乐趣。</span></span> \r\n</p>\r\n<p style=\"text-align:left;\">\r\n	<span></span>\r\n</p>', 1552053662);
INSERT INTO `caipiao_news` VALUES (68, 41, '优惠活动', '聆听会员的声音 真诚服务会员', '<p align=\"center\" style=\"text-align:center;text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:12pt;font-weight:bold;\"><span style=\"font-family:宋体;\">客户满意度调查</span> <span style=\"font-family:宋体;\">中彩网一贯的宗旨</span> <span style=\"font-family:宋体;\">聆听会员的声音</span> <span style=\"font-family:宋体;\">真诚服务会员</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"> </span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">中彩网彩票宗旨</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动对象：中彩网全体成员</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动内容：聆听会员的声音</span> <span style=\"font-family:宋体;\">真诚服务会员</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">活动时间：</span>2018-11-5<span style=\"font-family:宋体;\">至</span><span style=\"font-family:Calibri;\">2020-11-5</span></span> \r\n</p>\r\n<p align=\"center\" style=\"text-align:center;text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">独家品牌</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">诚信铸就</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">信誉第一</span></span></b><b><span style=\"color:#FF0000;font-family:Wingdings;font-size:18pt;font-weight:bold;\">?</span></b><b><span style=\"color:#FF0000;font-family:宋体;font-size:18pt;font-weight:bold;\"><span style=\"font-family:宋体;\">网投首选</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:10.5pt;font-weight:bold;\"><span style=\"font-family:宋体;\">活动详情</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10pt;\"><span style=\"font-family:宋体;\">用心聆听</span>,<span style=\"font-family:宋体;\">真诚服务”是中彩网彩票一贯的追求。为持续提升服务品质</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">中彩网彩票设立专职部门受理各类投诉与建议、监督客服服务质量</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">实现为客户创造快乐、让客户感受到宾至如归的服务为宗旨投诉</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">如果您在中彩网彩票娱乐期间受到令您不悦的体验。 </span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10pt;\"><span style=\"font-family:宋体;\">例如</span>:<span style=\"font-family:宋体;\">客服回复态度恶劣、没有解決问题核心</span><span style=\"font-family:Calibri;\">;</span><span style=\"font-family:宋体;\">财务部门出入款效率极慢</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">超过</span><span style=\"font-family:Calibri;\">2</span><span style=\"font-family:宋体;\">小时以上未处理</span><span style=\"font-family:Calibri;\">)</span><span style=\"font-family:宋体;\">等现象</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">请及时投诉给我们</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">我们会核实后根据投诉的问题的性质给您派发相应的监督奖</span><span style=\"font-family:Calibri;\">! </span><span style=\"font-family:宋体;\">建议</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">如果您有好的建议和想法</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">具有切实可行的方案</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">可以反馈给我们</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">您的宝贵建议被采纳后</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">我们会根据建议的质量给您派发建议奖。</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10pt;\"> </span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:10.5pt;font-weight:bold;\"><span style=\"font-family:宋体;\">监督奖</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10pt;\"><span style=\"font-family:宋体;\">为让我们的客服人员更好的为您提供服务</span>,<span style=\"font-family:宋体;\">全面提升客服人员的“业务水平”和“服务态度”</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">我们请您帮我们监督我们的客服人员。投诉一经核实</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">我们将按如下方式给您派发监督奖。具体各类奖项如下</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<table style=\"border:currentColor;width:426.1pt;border-collapse:collapse;\" border=\"1\" cellspacing=\"0\">\r\n		<tbody>\r\n			<tr>\r\n				<td width=\"142\" valign=\"top\" style=\"border:1pt solid windowtext;background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">投诉性质</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">恶劣</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">严重</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">一般</span> \r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">监督奖励</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">58<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">38<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"142\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10pt;\">18</span> \r\n					</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">对于不同性质的投诉定义如下</span>:<span style=\"font-family:宋体;\">恶劣</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">沟通过程中存在侮辱性词汇或谩骂、诅咒等内容</span><span style=\"font-family:Calibri;\">)</span><span style=\"font-family:宋体;\">严重</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">对未超出客服职权范围内的业务知识十分不熟练、答非所问、误导客户、主动关闭对话窗口</span><span style=\"font-family:Calibri;\">)</span><span style=\"font-family:宋体;\">、一般</span><span style=\"font-family:Calibri;\">(</span><span style=\"font-family:宋体;\">缺乏热情、在非高峰期或非特殊情況下</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">客服超过</span><span style=\"font-family:Calibri;\">5</span><span style=\"font-family:宋体;\">分钟未做出任何回复</span><span style=\"font-family:Calibri;\">)</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"> </span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"color:#FF0000;font-family:宋体;font-size:10.5pt;font-weight:bold;\"><span style=\"font-family:宋体;\">建议奖</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">我们的一小步</span>,<span style=\"font-family:宋体;\">也许是行业的一大步</span><span style=\"font-family:Calibri;\">!</span><span style=\"font-family:宋体;\">不断创新</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">为喜欢“中彩网彩票</span><span style=\"font-family:Calibri;\">\"</span><span style=\"font-family:宋体;\">的朋友</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">提供一个“有信誉、有实力、有情怀、更便捷的娱乐平台始终是我们使命和核心价值观</span><span style=\"font-family:Calibri;\">!</span><span style=\"font-family:宋体;\">如果您有好的建议和想法</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">我们将按照如下方式派奖</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<table style=\"border:currentColor;width:426.1pt;border-collapse:collapse;\" border=\"1\" cellspacing=\"0\">\r\n		<tbody>\r\n			<tr>\r\n				<td width=\"95\" valign=\"top\" style=\"border:1pt solid windowtext;background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">建议质量</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"96\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">总裁鼓励奖</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"95\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">杰出贡献奖</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"95\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">特别贡献奖</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"92\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">金玉良言奖</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"92\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">奇思妙想奖</span> \r\n					</p>\r\n				</td>\r\n			</tr>\r\n			<tr>\r\n				<td width=\"95\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">建议奖励</span> \r\n					</p>\r\n				</td>\r\n				<td width=\"96\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">188<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"95\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">88<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"95\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">58<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"92\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">38<span>元</span></span> \r\n					</p>\r\n				</td>\r\n				<td width=\"92\" valign=\"top\" style=\"background-color:transparent;\">\r\n					<p align=\"center\" style=\"text-align:center;\">\r\n						<span style=\"font-family:宋体;font-size:10.5pt;\">18<span>元</span></span> \r\n					</p>\r\n				</td>\r\n			</tr>\r\n		</tbody>\r\n	</table>\r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"> </span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">申请方式</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">符合条件的会员请添加中彩网彩票客服经理</span></span><span style=\"font-family:宋体;font-size:10.5pt;\">QQ</span><span style=\"font-family:宋体;font-size:10.5pt;\"><span style=\"font-family:宋体;\">进行投诉与建议</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\"> </span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<b><span style=\"font-family:宋体;font-size:11pt;font-weight:bold;\"><span style=\"font-family:宋体;\">活动规则</span></span></b> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\">1<span style=\"font-family:宋体;\">、注意事项</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">对于伪滥事件、恶意诽谤的会员</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">一律不回复</span><span style=\"font-family:Calibri;\">!</span><span style=\"font-family:宋体;\">情节严重者</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">直接封停账号</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\">2<span style=\"font-family:宋体;\">、投诉方式</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">将客服姓名、发生时间、具体清晰的对话内容截图或拍照提供给客服经理</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\">3<span style=\"font-family:宋体;\">、投诉时间</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">北京时间</span><span style=\"font-family:Calibri;\">10:00~~22:00,</span><span style=\"font-family:宋体;\">请您提前准备好相关证据</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">减少沟通成本</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">加快处理速度。</span><span style=\"font-family:Calibri;\">4</span><span style=\"font-family:宋体;\">、派发奖励</span><span style=\"font-family:Calibri;\">:</span><span style=\"font-family:宋体;\">对于投诉或建议的问题经核实后</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">将按照标准派发相应的监督奖或建议奖。</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<span style=\"font-family:宋体;font-size:10.5pt;\">5<span style=\"font-family:宋体;\">、中彩网彩票保留对活动的最终解释权</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">以及在无通知的情况下修改、终止活动的权利</span><span style=\"font-family:Calibri;\">,</span><span style=\"font-family:宋体;\">适用于所有优惠。</span></span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	<br />\r\n</p>', 1552053715);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_page
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_page`;
CREATE TABLE `caipiao_page` (
  `catid` smallint(6) NOT NULL,
  `title` varchar(180) NOT NULL,
  `content` longtext NOT NULL,
  KEY `catid` (`catid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


-- ----------------------------
-- Table structure for caipiao_payset
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_payset`;
CREATE TABLE `caipiao_payset` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `paytype` char(20) NOT NULL,
  `paytypetitle` varchar(30) NOT NULL,
  `ftitle` varchar(160) NOT NULL COMMENT '副标题',
  `minmoney` decimal(10,2) NOT NULL DEFAULT '50.00',
  `maxmoney` decimal(10,2) NOT NULL DEFAULT '50000.00',
  `remark` text NOT NULL COMMENT '支付说明',
  `configs` text NOT NULL COMMENT '配置',
  `isonline` tinyint(4) NOT NULL DEFAULT '-1' COMMENT '1线上支付 -1线下支付',
  `listorder` smallint(6) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1开启 -1关闭',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_payset
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_payset` VALUES (1, 'alipay', '支付宝充值', '支付宝扫码', 100.00, 100000.00, '<span style=\"color:#F46E00;font-family:\'Microsoft YaHei\', SimSun, Arial;line-height:24px;background-color:#FFFDEB;\"> \r\n<p>\r\n	手机用户充值流程：<br />\r\n1：选择输入好自己要充值的金额，输入转账人姓名，点击”确定“\r\n</p>\r\n<p>\r\n	2：跳转后，点击提交即可！\r\n</p>\r\n<p>\r\n	温馨提示：充值失败，请查看个人账户，点击消息中心，了解详细情况！\r\n</p>\r\n</span><span style=\"color:#F46E00;font-family:\'Microsoft YaHei\', SimSun, Arial;line-height:24px;background-color:#FFFDEB;\"></span>', 'a:3:{s:8:\"bankname\";s:0:\"\";s:8:\"bankcode\";s:0:\"\";s:6:\"ewmurl\";s:79:\"https://www.cnv3.com/template/elecnation_x3t_future/touch/common/images/2wm.png\";}', -1, 2, 1);
INSERT INTO `caipiao_payset` VALUES (6, 'weixin', '微信充值', '微信扫码', 100.00, 5000000.00, '<span style=\"color: rgb(244, 110, 0); font-size: 14px;\" background-color:#fffdeb;\"=\"\">手机用户充值流程：</span><br />\r\n<span style=\"color: rgb(244, 110, 0); font-size: 14px;\" background-color:#fffdeb;\"=\"\">1：选择输入好自己要充值的金额，输入转账人姓名，点击”确定“</span><br />\r\n<p>\r\n	<span style=\"color:#F46E00;font-family:\" background-color:#fffdeb;\"=\"\"><span style=\"font-size:14px;\">2：跳转后，点击提交即可！</span><span style=\"font-size:12px;\"></span></span> \r\n</p>\r\n<p>\r\n	<span style=\"color: rgb(244, 110, 0); font-size: 14px;\" background-color:#fffdeb;\"=\"\">温馨提示：充值失败，请查看个人账户，点击消息中心，了解详细情况！</span> \r\n</p>\r\n<br />\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<br />\r\n</p>', 'a:4:{s:8:\"bankname\";s:0:\"\";s:8:\"bankcode\";s:0:\"\";s:5:\"isewm\";s:2:\"-1\";s:6:\"ewmurl\";s:79:\"https://www.cnv3.com/template/elecnation_x3t_future/touch/common/images/2wm.png\";}', -1, 3, 1);
INSERT INTO `caipiao_payset` VALUES (26, 'linepay', '网上银行', '网上银行', 100.00, 5000000.00, '<p>\r\n	※ 温馨提示：\r\n</p>\r\n<p>\r\n	1、请转账完成后再提交充值订单。\r\n</p>\r\n<p>\r\n	2、请正确填写您的户名和充值金额。\r\n</p>\r\n<p>\r\n	3、转账1笔提交1次，请勿重复提交订单。\r\n</p>\r\n<p>\r\n	4、转帐完成后请保留单据作为核对证明。\r\n</p>', 'a:4:{s:8:\"bankname\";s:15:\"测试账户名\";s:8:\"bankcode\";s:18:\"888888888888888888\";s:5:\"isewm\";s:2:\"-1\";s:6:\"ewmurl\";s:0:\"\";}', -1, 1, 1);
INSERT INTO `caipiao_payset` VALUES (27, 'kfpay', '客服代充', '客服代充', 100.00, 5000000.00, '<span>请在获得充值订单号后联系客服协助充值</span>', 'a:4:{s:8:\"bankname\";s:15:\"测试账户名\";s:8:\"bankcode\";s:18:\"888888888888888888\";s:5:\"isewm\";s:2:\"-1\";s:6:\"ewmurl\";s:0:\"\";} ', -1, 0, 1);
INSERT INTO `caipiao_payset` VALUES (28, 'usdt', 'USDT转账', 'USDT转账', 100.00, 5000000.00, '网络：TRC20', 'a:7:{s:8:\"bankname\";s:0:\"\";s:8:\"bankcode\";s:0:\"\";s:5:\"isewm\";s:2:\"-1\";s:11:\"trc20_adder\";s:32:\"d93a5def7511da3d0f2d171d9c344e91\";s:12:\"trc20_ewmurl\";s:79:\"https://www.cnv3.com/template/elecnation_x3t_future/touch/common/images/2wm.png\";s:11:\"erc20_adder\";s:32:\"c78b6663d47cfbdb4d65ea51c104044e\";s:12:\"erc20_ewmurl\";s:79:\"https://www.cnv3.com/template/elecnation_x3t_future/touch/common/images/2wm.png\";}', -1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_qp_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_qp_game_order`;
CREATE TABLE `caipiao_qp_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(10) DEFAULT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `room_type` bigint(20) DEFAULT NULL COMMENT '房间类型',
  `game_room` varchar(100) DEFAULT NULL COMMENT '游戏房间',
  `game_flag` int(11) DEFAULT NULL COMMENT '游戏分类标识（0捕鱼类，1电子类）',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  `details` text COMMENT '注单详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_question
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_question`;
CREATE TABLE `caipiao_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `questionone` varchar(120) NOT NULL,
  `answerone` varchar(120) NOT NULL,
  `questiontwo` varchar(120) NOT NULL,
  `answertwo` varchar(120) NOT NULL,
  `questionthree` varchar(120) NOT NULL,
  `answerthree` varchar(120) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_question
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_question` VALUES (1, 8002, 'hjjfukfu', '您小学班主任的名字是?', 'fd3d02985ebb2bd8f937924fa431e510', '您中学班主任的名字是?', '65123dd3cbcc71e3f2134aefaa1956b9', '您高中班主任的名字是?', '9a289f5c3953a84d4532ae615f263b16');
INSERT INTO `caipiao_question` VALUES (13, 8020, 'zggcdyz', '您小学班主任的名字是?', '7055eced15538bfb7c07f8a5b28fc5d0', '您母亲的姓名是?', 'dca1117a4a9933499a4a870b4190065a', '您最喜欢的运动是?', 'a36abd601b784b2ece294786ee83e834');
INSERT INTO `caipiao_question` VALUES (14, 8021, 'abc123', '您的出生地是?', '7055eced15538bfb7c07f8a5b28fc5d0', '您中学班主任的名字是?', 'dca1117a4a9933499a4a870b4190065a', '您高中班主任的名字是?', 'a36abd601b784b2ece294786ee83e834');
INSERT INTO `caipiao_question` VALUES (15, 8022, 'abc123t1', '您的出生地是?', '7055eced15538bfb7c07f8a5b28fc5d0', '您高中班主任的名字是?', 'dca1117a4a9933499a4a870b4190065a', '您大学班主任的名字是?', 'a36abd601b784b2ece294786ee83e834');
INSERT INTO `caipiao_question` VALUES (16, 8017, 'y123456', '您的出生地是?', '7055eced15538bfb7c07f8a5b28fc5d0', '您中学班主任的名字是?', '174a9535b7fd93ceecbe1fc0392fa0f2', '您小学班主任的名字是?', '6116afedcb0bc31083935c1c262ff4c9');
INSERT INTO `caipiao_question` VALUES (17, 8073, 'ceshi', '您的出生地是?', '213b0e5bf59a1d51d20e50f15c148036', '您小学班主任的名字是?', '568965e8a32803ca331c8ce3ab645311', '您高中班主任的名字是?', '63652f976d8b6a0c4d6cdac6909ba131');
INSERT INTO `caipiao_question` VALUES (18, 8105, 'ceshi', '您的出生地是?', '7055eced15538bfb7c07f8a5b28fc5d0', '您小学班主任的名字是?', 'dca1117a4a9933499a4a870b4190065a', '您中学班主任的名字是?', 'a36abd601b784b2ece294786ee83e834');
INSERT INTO `caipiao_question` VALUES (19, 615, '2863279622', '您小学班主任的名字是?', 'd350f8aca4086b99b3740acb9fd201ee', '您最喜欢的明星名字是?', 'b997085b7b69b37b52d2154e7a2f7db9', '您配偶的生日是?', '77760db538a0d5d484d09d9e8f1b1161');
INSERT INTO `caipiao_question` VALUES (20, 773, 'plko01523', '您的出生地是?', 'b6d8e27f39707c8de52d98b09b3c4895', '您的小学校名是?', '88fbb3a57829dc4b050679405bd914bf', '您的学号（或工号）是?', '96b73e91bccf2763b9bfab4e11a361b4');
INSERT INTO `caipiao_question` VALUES (21, 809, '吴悠', '您最熟悉的童年好友名字是?', '3ff098194071b332b8431e1743d41e7b', '您配偶的生日是?', 'e76a3d45374a9bb94cc64cdf896e5d9a', '您的出生地是?', '228d2129d30423f4e8ee2e09c0351239');
COMMIT;

-- ----------------------------
-- Table structure for caipiao_recharge
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_recharge`;
CREATE TABLE `caipiao_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0',
  `username` char(30) NOT NULL DEFAULT '',
  `paytype` char(20) NOT NULL DEFAULT '' COMMENT '存款方式标识',
  `paytypetitle` varchar(60) NOT NULL DEFAULT '' COMMENT '存款方式名称',
  `trano` char(60) NOT NULL DEFAULT '' COMMENT '单号',
  `threetrano` char(255) NOT NULL DEFAULT '' COMMENT '第三方订单号',
  `amount` decimal(12,0) NOT NULL DEFAULT '0' COMMENT '金额',
  `fee` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  `actualamount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际金额',
  `actualfee` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际手续费',
  `oldaccountmoney` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '变更前金额',
  `newaccountmoney` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '变更后金额',
  `remark` varchar(155) NOT NULL DEFAULT '' COMMENT '备注',
  `payname` varchar(255) NOT NULL DEFAULT '' COMMENT '支付账号或线下存款银行',
  `fuyanma` int(11) NOT NULL DEFAULT '0' COMMENT '附言码',
  `isauto` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 自动 2手动充',
  `sdtype` tinyint(4) NOT NULL DEFAULT '0' COMMENT '手动充值类型1增加 -1减少',
  `usdt_rate` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT 'USDT汇率',
  `usdt_value` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'USDT支付数额',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未审核 1审核通过 -1取消订单',
  `oddtime` int(11) NOT NULL DEFAULT '0' COMMENT '订单时间',
  `stateadmin` char(30) NOT NULL DEFAULT '' COMMENT '审核管理员',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否满足打码量',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已打码量金额',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `isauto` (`isauto`) USING BTREE,
  KEY `oddtime` (`oddtime`) USING BTREE,
  KEY `paytype` (`paytype`) USING BTREE,
  KEY `sdtype` (`sdtype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_setting
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_setting`;
CREATE TABLE `caipiao_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_setting
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_setting` VALUES (1, 'webtitle', '钻石娱乐');
INSERT INTO `caipiao_setting` VALUES (2, 'keywords', '钻石娱乐');
INSERT INTO `caipiao_setting` VALUES (3, 'description', '祝您游戏愉快');
INSERT INTO `caipiao_setting` VALUES (4, 'iskillorder', '0');
INSERT INTO `caipiao_setting` VALUES (5, 'sysBankMaxNum', '1');
INSERT INTO `caipiao_setting` VALUES (6, 'damaliang', '100');
INSERT INTO `caipiao_setting` VALUES (7, 'tikuanMin', '100');
INSERT INTO `caipiao_setting` VALUES (8, 'tikuanMax', '1000000');
INSERT INTO `caipiao_setting` VALUES (9, 'ritikuanxiane', '10000000');
INSERT INTO `caipiao_setting` VALUES (10, 'tikuanstart', '12:00');
INSERT INTO `caipiao_setting` VALUES (11, 'tikuanend', '23:59');
INSERT INTO `caipiao_setting` VALUES (12, 'tikuannum', '8');
INSERT INTO `caipiao_setting` VALUES (13, 'tikuannumoverbilv', '20');
INSERT INTO `caipiao_setting` VALUES (14, 'tikuannumovermin', '10');
INSERT INTO `caipiao_setting` VALUES (15, 'tikuannumovermax', '5000');
INSERT INTO `caipiao_setting` VALUES (16, 'paiduinum', '10');
INSERT INTO `caipiao_setting` VALUES (17, 'pointchongzhi', '1');
INSERT INTO `caipiao_setting` VALUES (18, 'pointchongzhiadd', '0');
INSERT INTO `caipiao_setting` VALUES (19, 'pointtouzhu', '1');
INSERT INTO `caipiao_setting` VALUES (20, 'pointtouzhuadd', '1');
INSERT INTO `caipiao_setting` VALUES (21, 'pointhuisun', '1');
INSERT INTO `caipiao_setting` VALUES (22, 'pointhuisunadd', '1');
INSERT INTO `caipiao_setting` VALUES (23, 'kefuthree', 'https://wapi.pop800.com/chat/783865');
INSERT INTO `caipiao_setting` VALUES (24, 'bindcardamount', '0');
INSERT INTO `caipiao_setting` VALUES (25, 'newmemberrecharge', '1000');
INSERT INTO `caipiao_setting` VALUES (26, 'newmemberrechargeamount', '0');
INSERT INTO `caipiao_setting` VALUES (27, 'activity_cz0_money', '100~1000');
INSERT INTO `caipiao_setting` VALUES (28, 'activity_cz0_zsmoney', '0');
INSERT INTO `caipiao_setting` VALUES (29, 'activity_cz1_money', '1000~10000');
INSERT INTO `caipiao_setting` VALUES (30, 'activity_cz1_zsmoney', '0');
INSERT INTO `caipiao_setting` VALUES (31, 'activity_cz2_money', '10000~100000');
INSERT INTO `caipiao_setting` VALUES (32, 'activity_cz2_zsmoney', '0');
INSERT INTO `caipiao_setting` VALUES (33, 'riCommissionBase0_0', '200~3000');
INSERT INTO `caipiao_setting` VALUES (34, 'riCommissionBase0_1', '0');
INSERT INTO `caipiao_setting` VALUES (35, 'riCommissionBase0_2', '0');
INSERT INTO `caipiao_setting` VALUES (36, 'riCommissionBase1_0', '3001~10000');
INSERT INTO `caipiao_setting` VALUES (37, 'riCommissionBase1_1', '0');
INSERT INTO `caipiao_setting` VALUES (38, 'riCommissionBase1_2', '0');
INSERT INTO `caipiao_setting` VALUES (39, 'riCommissionBase2_0', '10001~100000');
INSERT INTO `caipiao_setting` VALUES (40, 'riCommissionBase2_1', '0');
INSERT INTO `caipiao_setting` VALUES (41, 'riCommissionBase2_2', '0');
INSERT INTO `caipiao_setting` VALUES (42, 'yueCommissionBase0_0', '1000~10000');
INSERT INTO `caipiao_setting` VALUES (43, 'yueCommissionBase0_1', '0');
INSERT INTO `caipiao_setting` VALUES (44, 'yueCommissionBase0_2', '0');
INSERT INTO `caipiao_setting` VALUES (45, 'yueCommissionBase1_0', '10000~100000');
INSERT INTO `caipiao_setting` VALUES (46, 'yueCommissionBase1_1', '0');
INSERT INTO `caipiao_setting` VALUES (47, 'yueCommissionBase1_2', '0');
INSERT INTO `caipiao_setting` VALUES (48, 'yueCommissionBase2_0', '100000~1000000');
INSERT INTO `caipiao_setting` VALUES (49, 'yueCommissionBase2_1', '0');
INSERT INTO `caipiao_setting` VALUES (50, 'yueCommissionBase2_2', '0');
INSERT INTO `caipiao_setting` VALUES (51, 'riKuisunBase0_0', '1~1000');
INSERT INTO `caipiao_setting` VALUES (52, 'riKuisunBase0_1', '0');
INSERT INTO `caipiao_setting` VALUES (53, 'riKuisunBase0_2', '0');
INSERT INTO `caipiao_setting` VALUES (54, 'riKuisunBase1_0', '3000~10000000');
INSERT INTO `caipiao_setting` VALUES (55, 'riKuisunBase1_1', '0');
INSERT INTO `caipiao_setting` VALUES (56, 'riKuisunBase1_2', '0');
INSERT INTO `caipiao_setting` VALUES (57, 'riKuisunBase2_0', '10000~100000000');
INSERT INTO `caipiao_setting` VALUES (58, 'riKuisunBase2_1', '0');
INSERT INTO `caipiao_setting` VALUES (59, 'riKuisunBase2_2', '0');
INSERT INTO `caipiao_setting` VALUES (60, 'yueKuisunBase0_0', '1000~10000');
INSERT INTO `caipiao_setting` VALUES (61, 'yueKuisunBase0_1', '0');
INSERT INTO `caipiao_setting` VALUES (62, 'yueKuisunBase0_2', '0');
INSERT INTO `caipiao_setting` VALUES (63, 'yueKuisunBase1_0', '10000~100000');
INSERT INTO `caipiao_setting` VALUES (64, 'yueKuisunBase1_1', '0');
INSERT INTO `caipiao_setting` VALUES (65, 'yueKuisunBase1_2', '0');
INSERT INTO `caipiao_setting` VALUES (66, 'yueKuisunBase2_0', '100000~1000000');
INSERT INTO `caipiao_setting` VALUES (67, 'yueKuisunBase2_1', '0');
INSERT INTO `caipiao_setting` VALUES (68, 'yueKuisunBase2_2', '0');
INSERT INTO `caipiao_setting` VALUES (69, 'agentBonusBase0_0', '1000~5000');
INSERT INTO `caipiao_setting` VALUES (70, 'agentBonusBase0_1', '0');
INSERT INTO `caipiao_setting` VALUES (71, 'agentBonusBase1_0', '5000~10000');
INSERT INTO `caipiao_setting` VALUES (72, 'agentBonusBase1_1', '0');
INSERT INTO `caipiao_setting` VALUES (73, 'agentBonusBase2_0', '10000~100000');
INSERT INTO `caipiao_setting` VALUES (74, 'agentBonusBase2_1', '0');
INSERT INTO `caipiao_setting` VALUES (75, 'agentBonusBase3_0', '100000~1000000');
INSERT INTO `caipiao_setting` VALUES (76, 'agentBonusBase3_1', '0');
INSERT INTO `caipiao_setting` VALUES (77, 'loginerrornum', '6');
INSERT INTO `caipiao_setting` VALUES (78, 'loginerrorclosetime', '1');
INSERT INTO `caipiao_setting` VALUES (79, 'islogincode', '0');
INSERT INTO `caipiao_setting` VALUES (80, 'isemailcode', '0');
INSERT INTO `caipiao_setting` VALUES (81, 'adminemailcodetime', '180');
INSERT INTO `caipiao_setting` VALUES (82, 'getemailcode', 'www@cnv3.com');
INSERT INTO `caipiao_setting` VALUES (83, 'loginerrornum_q', '6');
INSERT INTO `caipiao_setting` VALUES (84, 'loginerrorclosetime_q', '24');
INSERT INTO `caipiao_setting` VALUES (85, 'SMTP_HOST', '');
INSERT INTO `caipiao_setting` VALUES (86, 'SMTP_SSL', '0');
INSERT INTO `caipiao_setting` VALUES (87, 'SMTP_PORT', '');
INSERT INTO `caipiao_setting` VALUES (88, 'FROM_EMAIL', '');
INSERT INTO `caipiao_setting` VALUES (89, 'SMTP_USER', 'admin');
INSERT INTO `caipiao_setting` VALUES (90, 'FROM_NAME', '');
INSERT INTO `caipiao_setting` VALUES (91, 'REPLY_EMAIL', '');
INSERT INTO `caipiao_setting` VALUES (92, 'REPLY_NAME', '');
INSERT INTO `caipiao_setting` VALUES (93, 'SMTP_PASS', 'aabbcc');
INSERT INTO `caipiao_setting` VALUES (94, 'dbnizationapiurl', 'http://127.0.0.58/');
INSERT INTO `caipiao_setting` VALUES (95, 'dbnizationips', '');
INSERT INTO `caipiao_setting` VALUES (96, 'caijieapiurl', 'http://127.0.0.6');
INSERT INTO `caipiao_setting` VALUES (97, 'weballowips', '');
INSERT INTO `caipiao_setting` VALUES (98, 'caijiset', 'a:30:{s:5:\"cqssc\";s:1:\"1\";s:5:\"efssc\";s:1:\"1\";s:5:\"wfssc\";s:1:\"1\";s:6:\"xtxssc\";s:1:\"1\";s:5:\"xjssc\";s:1:\"1\";s:5:\"tjssc\";s:1:\"1\";s:5:\"yfssc\";s:1:\"1\";s:6:\"oldssc\";s:1:\"1\";s:4:\"f1k3\";s:1:\"1\";s:4:\"bjk3\";s:1:\"1\";s:5:\"hubk3\";s:1:\"1\";s:5:\"hebk3\";s:1:\"1\";s:4:\"shk3\";s:1:\"1\";s:4:\"jlk3\";s:1:\"1\";s:4:\"gxk3\";s:1:\"1\";s:4:\"f5k3\";s:1:\"1\";s:4:\"ahk3\";s:1:\"1\";s:6:\"gd11x5\";s:1:\"1\";s:6:\"sh11x5\";s:1:\"1\";s:6:\"jx11x5\";s:1:\"1\";s:6:\"df11x5\";s:1:\"1\";s:6:\"bjkeno\";s:1:\"1\";s:6:\"dfkeno\";s:1:\"1\";s:6:\"bjpk10\";s:1:\"1\";s:6:\"xypk10\";s:1:\"1\";s:6:\"dfpk10\";s:1:\"1\";s:4:\"fc3d\";s:1:\"1\";s:3:\"pl3\";s:1:\"1\";s:4:\"df3d\";s:1:\"1\";s:5:\"dflhc\";s:1:\"1\";}');
INSERT INTO `caipiao_setting` VALUES (99, 'ipblackisopen', '0');
INSERT INTO `caipiao_setting` VALUES (100, 'ipblacklist', '127.0.0.1,127.0.0.2');
INSERT INTO `caipiao_setting` VALUES (101, 'ipwhiteisopen', '0');
INSERT INTO `caipiao_setting` VALUES (102, 'ipwhitelist', '');
INSERT INTO `caipiao_setting` VALUES (103, 'jihua_rixiaofei_shi', '2');
INSERT INTO `caipiao_setting` VALUES (104, 'jihua_rixiaofei_fen', '20');
INSERT INTO `caipiao_setting` VALUES (105, 'jihua_rikuisun_shi', '0');
INSERT INTO `caipiao_setting` VALUES (106, 'jihua_rikuisun_fen', '20');
INSERT INTO `caipiao_setting` VALUES (107, 'jihua_yuexiaofei_shi', '0');
INSERT INTO `caipiao_setting` VALUES (108, 'jihua_yuexiaofei_fen', '20');
INSERT INTO `caipiao_setting` VALUES (109, 'jihua_yuekuisun_shi', '0');
INSERT INTO `caipiao_setting` VALUES (110, 'jihua_yuekuisun_fen', '20');
INSERT INTO `caipiao_setting` VALUES (111, 'jihua_dailifandian_shi', '0');
INSERT INTO `caipiao_setting` VALUES (112, 'jihua_dailifandian_fen', '20');
INSERT INTO `caipiao_setting` VALUES (113, 'jihua_kaijiang_days', '60');
INSERT INTO `caipiao_setting` VALUES (114, 'jihua_touzhu_days', '45');
INSERT INTO `caipiao_setting` VALUES (115, 'jihua_fuddetail_days', '45');
INSERT INTO `caipiao_setting` VALUES (116, 'jihua_memlog_days', '7');
INSERT INTO `caipiao_setting` VALUES (117, 'jihua_adminlog_days', '7');
INSERT INTO `caipiao_setting` VALUES (118, 'pointexchangeamount', '1000');
INSERT INTO `caipiao_setting` VALUES (119, 'kefuqq', '88888888');
INSERT INTO `caipiao_setting` VALUES (120, 'newmemberrecharge1', '1~1000');
INSERT INTO `caipiao_setting` VALUES (121, 'newmemberrechargeamount1', '1');
INSERT INTO `caipiao_setting` VALUES (122, 'newmemberrecharge2', '1000~10000');
INSERT INTO `caipiao_setting` VALUES (123, 'newmemberrechargeamount2', '2');
INSERT INTO `caipiao_setting` VALUES (124, 'newmemberrecharge3', '10000~100000');
INSERT INTO `caipiao_setting` VALUES (125, 'newmemberrechargeamount3', '3');
INSERT INTO `caipiao_setting` VALUES (126, 'defaulttjcode', '295');
INSERT INTO `caipiao_setting` VALUES (127, 'newmemberrecharge4', '100000~1000000');
INSERT INTO `caipiao_setting` VALUES (128, 'newmemberrechargeamount4', '4');
INSERT INTO `caipiao_setting` VALUES (129, 'newmemberrecharge5', '1000000~10000000');
INSERT INTO `caipiao_setting` VALUES (130, 'newmemberrechargeamount5', '5');
INSERT INTO `caipiao_setting` VALUES (131, 'activity_cz3_money', '100000~1000000');
INSERT INTO `caipiao_setting` VALUES (132, 'activity_cz3_zsmoney', '0');
INSERT INTO `caipiao_setting` VALUES (133, 'activity_cz4_money', '1000000~10000000');
INSERT INTO `caipiao_setting` VALUES (134, 'activity_cz4_zsmoney', '0');
INSERT INTO `caipiao_setting` VALUES (135, 'czaudioplay', '1');
INSERT INTO `caipiao_setting` VALUES (136, 'czaudioplaytime', '60');
INSERT INTO `caipiao_setting` VALUES (137, 'czaudioqxtime', '300');
INSERT INTO `caipiao_setting` VALUES (138, 'tkaudioplay', '1');
INSERT INTO `caipiao_setting` VALUES (139, 'tkaudioplaytime', '1');
INSERT INTO `caipiao_setting` VALUES (140, 'cardaudioplay', '1');
INSERT INTO `caipiao_setting` VALUES (141, 'cardaudioplaytime', '12');
INSERT INTO `caipiao_setting` VALUES (142, 'riCommissionBase3_0', '');
INSERT INTO `caipiao_setting` VALUES (143, 'riCommissionBase3_1', '0');
INSERT INTO `caipiao_setting` VALUES (144, 'riCommissionBase3_2', '0');
INSERT INTO `caipiao_setting` VALUES (145, 'riCommissionBase4_0', '');
INSERT INTO `caipiao_setting` VALUES (146, 'riCommissionBase4_1', '0');
INSERT INTO `caipiao_setting` VALUES (147, 'riCommissionBase4_2', '0');
INSERT INTO `caipiao_setting` VALUES (148, 'chongzhiMin', '100');
INSERT INTO `caipiao_setting` VALUES (149, 'chongzhiMax', '50000');
INSERT INTO `caipiao_setting` VALUES (150, 'caijiset', 'a:30:{s:5:\"cqssc\";s:1:\"1\";s:5:\"efssc\";s:1:\"1\";s:5:\"wfssc\";s:1:\"1\";s:6:\"xtxssc\";s:1:\"1\";s:5:\"xjssc\";s:1:\"1\";s:5:\"tjssc\";s:1:\"1\";s:5:\"yfssc\";s:1:\"1\";s:6:\"oldssc\";s:1:\"1\";s:4:\"f1k3\";s:1:\"1\";s:4:\"bjk3\";s:1:\"1\";s:5:\"hubk3\";s:1:\"1\";s:5:\"hebk3\";s:1:\"1\";s:4:\"shk3\";s:1:\"1\";s:4:\"jlk3\";s:1:\"1\";s:4:\"gxk3\";s:1:\"1\";s:4:\"f5k3\";s:1:\"1\";s:4:\"ahk3\";s:1:\"1\";s:6:\"gd11x5\";s:1:\"1\";s:6:\"sh11x5\";s:1:\"1\";s:6:\"jx11x5\";s:1:\"1\";s:6:\"df11x5\";s:1:\"1\";s:6:\"bjkeno\";s:1:\"1\";s:6:\"dfkeno\";s:1:\"1\";s:6:\"bjpk10\";s:1:\"1\";s:6:\"xypk10\";s:1:\"1\";s:6:\"dfpk10\";s:1:\"1\";s:4:\"fc3d\";s:1:\"1\";s:3:\"pl3\";s:1:\"1\";s:4:\"df3d\";s:1:\"1\";s:5:\"dflhc\";s:1:\"1\";}');
INSERT INTO `caipiao_setting` VALUES (151, 'fanDianMax', '10');
INSERT INTO `caipiao_setting` VALUES (152, 'fanDianMin', '0');
INSERT INTO `caipiao_setting` VALUES (153, 'jihua_fandian_days', '1');
INSERT INTO `caipiao_setting` VALUES (154, 'jihua_jinjijiangli_days', '1');
INSERT INTO `caipiao_setting` VALUES (155, 'jihua_fanshui_days', '1');
INSERT INTO `caipiao_setting` VALUES (156, 'xtclirun', '0');
INSERT INTO `caipiao_setting` VALUES (157, 'istest', '1');
INSERT INTO `caipiao_setting` VALUES (158, 'is_chat', '0');
INSERT INTO `caipiao_setting` VALUES (159, 'is_video', '0');
INSERT INTO `caipiao_setting` VALUES (160, 'chat_filter', '草你妈,垃圾,黑,杂种,');
INSERT INTO `caipiao_setting` VALUES (161, 'a_app_url', '');
INSERT INTO `caipiao_setting` VALUES (162, 'i_app_url', '');
INSERT INTO `caipiao_setting` VALUES (163, 'web_path', '');
INSERT INTO `caipiao_setting` VALUES (164, 'admin_path', '');
INSERT INTO `caipiao_setting` VALUES (165, 'kj_path', '');
INSERT INTO `caipiao_setting` VALUES (166, 'switch_ng', '0');
INSERT INTO `caipiao_setting` VALUES (167, 'api_account', '');
INSERT INTO `caipiao_setting` VALUES (168, 'sign_key', '');
INSERT INTO `caipiao_setting` VALUES (169, 'webisopen', '0');
INSERT INTO `caipiao_setting` VALUES (170, 'webcloseinfo', '');
INSERT INTO `caipiao_setting` VALUES (171, 'switchbuy', '0');
INSERT INTO `caipiao_setting` VALUES (172, 'switchdlbuy', '0');
INSERT INTO `caipiao_setting` VALUES (173, 'switchzdbuy', '0');
INSERT INTO `caipiao_setting` VALUES (174, 'recharge', '0');
INSERT INTO `caipiao_setting` VALUES (175, 'touzhuMax', '0');
INSERT INTO `caipiao_setting` VALUES (176, 'zhongjiangMax', '0');
INSERT INTO `caipiao_setting` VALUES (177, 'user_water_rate', '0.7');
INSERT INTO `caipiao_setting` VALUES (178, 'cooperation_rate', '50');
INSERT INTO `caipiao_setting` VALUES (179, 'agent_withdraw_days', '15');
COMMIT;

-- ----------------------------
-- Table structure for caipiao_sysbank
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_sysbank`;
CREATE TABLE `caipiao_sysbank` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `bankcode` char(15) NOT NULL COMMENT '银行代码',
  `bankname` varchar(60) NOT NULL COMMENT '银行名称',
  `banklogo` char(120) NOT NULL COMMENT '银行LOGO',
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `listorder` smallint(6) NOT NULL,
  `imgbg` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_sysbank
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_sysbank` VALUES (1, '102', '工商银行', '', 1, 1, NULL);
INSERT INTO `caipiao_sysbank` VALUES (2, '105', '建设银行', '', 1, 2, NULL);
INSERT INTO `caipiao_sysbank` VALUES (3, '103', '农业银行', '', 1, 3, NULL);
INSERT INTO `caipiao_sysbank` VALUES (4, '104', '中国银行', '', 1, 4, NULL);
INSERT INTO `caipiao_sysbank` VALUES (5, '302', '中信银行', '', 1, 5, NULL);
INSERT INTO `caipiao_sysbank` VALUES (6, '303', '光大银行', '', 1, 6, NULL);
INSERT INTO `caipiao_sysbank` VALUES (7, '308', '招商银行', '', 1, 7, NULL);
INSERT INTO `caipiao_sysbank` VALUES (8, '309', '兴业银行', '', 1, 8, NULL);
INSERT INTO `caipiao_sysbank` VALUES (9, '402', '农村信用社', '', 1, 9, NULL);
INSERT INTO `caipiao_sysbank` VALUES (10, '504', '恒生银行', '', 1, 10, NULL);
INSERT INTO `caipiao_sysbank` VALUES (11, '505', '中银香港', '', 1, 11, NULL);
INSERT INTO `caipiao_sysbank` VALUES (12, '531', '花旗银行', '', 1, 12, NULL);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_touzhu
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_touzhu`;
CREATE TABLE `caipiao_touzhu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isdraw` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未开 1中 -1未中 -2撤单',
  `trano` char(60) NOT NULL COMMENT '单号',
  `yjf` char(10) NOT NULL DEFAULT '1' COMMENT '1元 0.1 角 0.01分 0.001厘',
  `typeid` char(20) NOT NULL COMMENT '彩票种类',
  `playid` char(30) NOT NULL COMMENT '玩法标识',
  `playtitle` varchar(60) NOT NULL COMMENT '玩法名称',
  `cptitle` varchar(30) NOT NULL COMMENT '彩票标题',
  `cpname` varchar(60) NOT NULL COMMENT '彩票名称',
  `expect` char(25) NOT NULL COMMENT '期号',
  `uid` int(11) NOT NULL COMMENT '会员ID',
  `username` char(60) NOT NULL COMMENT '会员昵称',
  `itemcount` int(11) NOT NULL COMMENT '投注注数',
  `beishu` smallint(6) NOT NULL DEFAULT '1' COMMENT '倍数',
  `tzcode` longtext NOT NULL COMMENT '投注号码',
  `repoint` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '返点比例',
  `repointamout` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '返点金额',
  `mode` varchar(40) NOT NULL COMMENT '奖金',
  `amount` decimal(20,2) NOT NULL COMMENT '投注金额',
  `amountbefor` decimal(14,2) NOT NULL COMMENT '投注前金额',
  `amountafter` decimal(14,2) NOT NULL COMMENT '投注后金额',
  `okamount` decimal(20,2) NOT NULL COMMENT '可盈金额',
  `okcount` smallint(6) NOT NULL COMMENT '中奖注数',
  `Chase` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1追号 0不是',
  `stopChase` tinyint(4) NOT NULL COMMENT '是否中奖停止追号 1是',
  `oddtime` int(11) NOT NULL COMMENT '投注时间',
  `opencode` char(60) NOT NULL COMMENT '开奖号码',
  `source` char(20) NOT NULL COMMENT 'pc,mobile',
  `is_show` varchar(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE,
  KEY `isdraw` (`isdraw`) USING BTREE,
  KEY `typeid` (`typeid`) USING BTREE,
  KEY `playid` (`playid`) USING BTREE,
  KEY `cpname` (`cpname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='投注管理';

-- ----------------------------
-- Table structure for caipiao_transrecord
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_transrecord`;
CREATE TABLE `caipiao_transrecord` (
  `transID` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `transBillno` varchar(25) DEFAULT NULL COMMENT '交易编号',
  `transType` varchar(10) DEFAULT NULL COMMENT '转让类型',
  `transDes` varchar(25) DEFAULT NULL,
  `tansAmount` decimal(10,0) DEFAULT NULL,
  `state` int(4) DEFAULT NULL COMMENT '状态 1 成功 0失败',
  `transTime` datetime DEFAULT NULL,
  PRIMARY KEY (`transID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for caipiao_ty_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_ty_game_order`;
CREATE TABLE `caipiao_ty_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(10) NOT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `bet_count` int(11) DEFAULT NULL COMMENT '重算标志',
  `bet_result` int(11) DEFAULT NULL COMMENT '局结果',
  `series_type` int(11) DEFAULT NULL COMMENT '靴号',
  `series_value` varchar(100) DEFAULT NULL COMMENT '设备 id ',
  `details` text,
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_wanfa
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_wanfa`;
CREATE TABLE `caipiao_wanfa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) NOT NULL,
  `typeid` char(30) NOT NULL,
  `playid` char(30) NOT NULL,
  `totalzs` int(11) NOT NULL COMMENT '总注数',
  `maxjj` varchar(40) NOT NULL COMMENT '最高奖金',
  `minjj` varchar(40) NOT NULL COMMENT '最低奖金',
  `maxrate` decimal(12,3) NOT NULL COMMENT '//最大赔率',
  `minrate` decimal(12,3) NOT NULL COMMENT '//最小赔率',
  `rate` decimal(12,2) NOT NULL COMMENT '赔率',
  `maxzs` int(6) NOT NULL DEFAULT '0' COMMENT '最高注数',
  `minxf` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '最低消费',
  `maxxf` decimal(10,2) NOT NULL DEFAULT '10000.00' COMMENT '最大投注金额',
  `maxprize` decimal(12,2) NOT NULL,
  `remark` text NOT NULL,
  `isopen` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1开启 0关闭',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `typeid` (`typeid`) USING BTREE,
  KEY `playid` (`playid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=896 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of caipiao_wanfa
-- ----------------------------
BEGIN;
INSERT INTO `caipiao_wanfa` VALUES (1, '五星复式', 'ssc', 'wxzhixfs', 100000, '198000', '180000', 0.000, 0.000, 0.00, 100000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (2, '五星单式', 'ssc', 'wxzhixds', 100000, '198000', '180000', 0.000, 0.000, 0.00, 100000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (3, '组选120', 'ssc', 'wxzxyel', 252, '1649.99', '1500', 0.000, 0.000, 0.00, 252, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (4, '龙虎十个', 'ssc', 'lhsg', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (5, '龙虎百个', 'ssc', 'lhbg', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (6, '龙虎百十', 'ssc', 'lhbs', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (7, '龙虎千个', 'ssc', 'lhqg', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (8, '龙虎千十', 'ssc', 'lhqs', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (9, '龙虎千百', 'ssc', 'lhqb', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (10, '龙虎万个', 'ssc', 'lhwg', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (11, '龙虎万十', 'ssc', 'lhws', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (12, '龙虎万百', 'ssc', 'lhwb', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (13, '龙虎万千', 'ssc', 'lhwq', 3, '2.20', '1.87', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (14, '四季发财', 'ssc', 'qwsjfc', 10, '4283.00', '3913.04', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (15, '三星报喜', 'ssc', 'qwsxbx', 10, '231.00', '210.28', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (16, '好事成双', 'ssc', 'qwhscs', 10, '25.00', '22.09', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (17, '一帆风顺', 'ssc', 'qwyffs', 10, '5.00', '4.39', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (18, '后三和尾', 'ssc', 'hzwshs', 0, '1930.00', '1700.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (19, '中三和尾', 'ssc', 'hzwszs', 0, '1930.00', '1700.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (20, '前三和尾', 'ssc', 'hzwsqs', 0, '1930.00', '1700.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (21, '后三组选和值', 'ssc', 'zuxhzhs', 210, '329.00', '300.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (22, '中三组选和值', 'ssc', 'zuxhzzs', 210, '329.00', '300.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (23, '前三组选和值', 'ssc', 'zuxhzqs', 210, '329.00', '300.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (24, '后二直选和值', 'ssc', 'zhixhzhe', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (25, '前二直选和值', 'ssc', 'zhixhzqe', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (26, '后三直选和值', 'ssc', 'zhixhzhs', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (27, '中三直选和值', 'ssc', 'zhixhzzs', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (28, '前三直选和值', 'ssc', 'zhixhzqs', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (29, '后二大小单双', 'ssc', 'dxdshe', 16, '8.00', '7.20', 0.000, 0.000, 0.00, 16, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (30, '前二大小单双', 'ssc', 'dxdsqe', 16, '8.00', '7.20', 0.000, 0.000, 0.00, 16, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (31, '任二组选', 'ssc', 'rx2zx', 100, '196.00', '170.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (32, '任二单式', 'ssc', 'rx2ds', 100, '0.00', '0.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (33, '任二复式', 'ssc', 'rx2fs', 100, '196.00', '170.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (34, '任三混合', 'ssc', 'rx3zxhh', 100, '196.00', '170.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (35, '任三组六', 'ssc', 'rx3z6', 100, '196.00', '170.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (36, '任三组三', 'ssc', 'rx3z3', 100, '196.00', '170.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (37, '任三单式', 'ssc', 'rx3ds', 170, '196.00', '170.00', 0.000, 0.000, 0.00, 170, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (38, '任三复式', 'ssc', 'rx3fs', 0, '0.00', '0.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (39, '任四单式', 'ssc', 'rx4ds', 0, '0.00', '0.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (40, '任四复式', 'ssc', 'rx4fs', 0, '0.00', '0.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (41, '后二跨度', 'ssc', 'kuaduhe', 100, '156.00', '117.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (42, '前二跨度', 'ssc', 'kuaduqe', 100, '156.00', '117.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (43, '后三跨度', 'ssc', 'kuaduhs', 1000, '1560.00', '1170.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (44, '中三跨度', 'ssc', 'kuaduzs', 1000, '1560.00', '1170.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (45, '前三跨度', 'ssc', 'kuaduqs', 1000, '1560.00', '1170.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (46, '三码计重', 'ssc', 'bdw3mjc', 10, '3.30', '3.30', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (47, '二码计重', 'ssc', 'bdw2mjc', 10, '3.30', '3.30', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (48, '五星三码不定位', 'ssc', 'bdw5x3m', 120, '46.00', '41.37', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (49, '五星二码不定位', 'ssc', 'bdw5x2m', 45, '14.00', '12.26', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (50, '五星一码不定位', 'ssc', 'bdw5x1m', 10, '5.00', '4.39', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (51, '后三不定位', 'ssc', 'bdwhs', 10, '8.00', '6.64', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (52, '中三不定位', 'ssc', 'bdwzs', 10, '8.00', '6.64', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (53, '前三不定位', 'ssc', 'bdwqs', 10, '8.00', '6.64', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (54, '一星复式', 'ssc', 'dweid', 50, '19.8', '19.8', 0.000, 0.000, 0.00, 50, 1.00, 2000000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (55, '后二组选单式', 'ssc', 'exzuxdsh', 45, '99.00', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (56, '后二组选复式', 'ssc', 'exzuxfsh', 45, '99.00', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (57, '前二组选单式', 'ssc', 'exzuxdsq', 45, '99.00', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (58, '前二组选复式', 'ssc', 'exzuxfsq', 45, '99.00', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (59, '后二直选单式', 'ssc', 'exzhixdsh', 100, '198', '180', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (60, '后二直选复式', 'ssc', 'exzhixfsh', 100, '198', '180', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (61, '前二直选单式', 'ssc', 'exzhixdsq', 100, '198', '180', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (62, '前二直选复式', 'ssc', 'exzhixfsq', 100, '198', '180', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 300000.00, 'FSDAFEW FSAF DF DASF', 1);
INSERT INTO `caipiao_wanfa` VALUES (63, '后三混合组选', 'ssc', 'sxhhzxh', 1000, '659.99', '600.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (64, '后三组六胆拖', 'ssc', 'sxzuxzldth', 1000, '1960.00', '1700.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (65, '后三组六', 'ssc', 'sxzuxzlh', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (66, '组三胆拖', 'ssc', 'sxzuxzsdth', 1000, '1960.00', '1700.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (67, '后三组三', 'ssc', 'sxzuxzsh', 90, '659.99', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (68, '后三单式', 'ssc', 'sxzhixdsh', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (69, '后三复式', 'ssc', 'sxzhixfsh', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (70, '中三混合组选', 'ssc', 'sxhhzxz', 120, '659.99', '600', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (71, '组六胆拖', 'ssc', 'sxzuxzldtz', 1000, '1930.00', '1700.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (72, '中三组六', 'ssc', 'sxzuxzlz', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (73, '组三胆拖', 'ssc', 'sxzuxzsdtz', 1000, '1930.00', '1700.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (74, '中三组三', 'ssc', 'sxzuxzsz', 90, '659.99', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (75, '中三单式', 'ssc', 'sxzhixdsz', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (76, '中三复式', 'ssc', 'sxzhixfsz', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (77, '前三混合组选', 'ssc', 'sxhhzxq', 120, '659.99', '600', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (78, '前三组六胆拖', 'ssc', 'sxzuxzldtq', 0, '0.00', '0.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (79, '前三胆拖', 'ssc', 'sxzuxzsdtq', 1000, '190.00', '170.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (80, '前三组六', 'ssc', 'sxzuxzlq', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (81, '前三组三', 'ssc', 'sxzuxzsq', 90, '659.99', '600', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (82, '前三单式', 'ssc', 'sxzhixdsq', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (83, '前三复式', 'ssc', 'sxzhixfsq', 1000, '1980', '1800', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (84, '后四组选4', 'ssc', 'hsizxs', 90, '4950', '4500.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (85, '后四组选6', 'ssc', 'hsizxl', 45, '3299.99', '3000.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (86, '后四组选12', 'ssc', 'hsizxye', 360, '1649.99', '1500.00', 0.000, 0.000, 0.00, 360, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (87, '后四组选24', 'ssc', 'hsizxes', 210, '824.99', '750.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (88, '后四单式', 'ssc', 'sixzhixdsh', 10000, '19800', '18000', 0.000, 0.000, 0.00, 10000, 1.00, 20000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (89, '后四复式', 'ssc', 'sixzhixfsh', 10000, '19800', '18000', 0.000, 0.000, 0.00, 10000, 1.00, 20000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (90, '前四组选4', 'ssc', 'qsizxs', 90, '4800.00', '4625.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (91, '前四组选6', 'ssc', 'qsizxl', 45, '3200.00', '3083.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (92, '前四组选12', 'ssc', 'qsizxye', 360, '1335.00', '1141.00', 0.000, 0.000, 0.00, 360, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (93, '前四组选24', 'ssc', 'qsizxes', 210, '800.00', '770.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (94, '前四单式', 'ssc', 'sixzhixdsq', 10000, '19300.00', '17000.00', 0.000, 0.000, 0.00, 10000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (95, '前四复式', 'ssc', 'sixzhixfsq', 10000, '19200.00', '17000.00', 0.000, 0.000, 0.00, 10000, 1.00, 20000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (96, '组选5', 'ssc', 'wxzxw', 90, '39600', '36000', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (97, '组选10', 'ssc', 'wxzxyl', 90, '19800', '18000', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (98, '组选20', 'ssc', 'wxzxel', 360, '9900', '9000', 0.000, 0.000, 0.00, 360, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (99, '组选30', 'ssc', 'wxzxsl', 360, '6599.99', '6000', 0.000, 0.000, 0.00, 360, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (100, '组选60', 'ssc', 'wxzxls', 840, '3299.99', '3000', 0.000, 0.000, 0.00, 840, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (101, '前三复式', 'ssc', 'x5_3x_q3zxfs', 0, '212.50', '200.80', 0.000, 0.000, 0.00, 111, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (102, '', 'ssc', 'big', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (103, '', 'ssc', 'bigsmahe', 1, '0.00', '0.00', 0.000, 0.000, 4.30, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (104, '', 'ssc', 'sma', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (105, '', 'ssc', 'up', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (106, '', 'ssc', 'mid', 1, '0.00', '0.00', 0.000, 0.000, 4.30, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (107, '', 'ssc', 'tu', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (108, '', 'ssc', 'ji', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (109, '', 'ssc', 'jiouhe', 1, '0.00', '0.00', 0.000, 0.000, 4.30, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (110, '', 'ssc', 'ou', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (111, '', 'ssc', 'sin', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (112, '', 'ssc', 'cou', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (129, '任选一', 'keno', 'bjkl8rx1', 80, '7.88', '7.2', 0.000, 0.000, 0.00, 8, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (130, '任选二', 'keno', 'bjkl8rx2', 28, '32.76', '29.93', 0.000, 0.000, 0.00, 28, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (131, '任选三', 'keno', 'bjkl8rx3', 56, '76.07|7.09', '41.11|6.53', 0.000, 0.000, 0.00, 56, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (132, '任选四', 'keno', 'bjkl8rx4', 70, '214.05|15.16|3.08', '197.28|13.97|2.84', 0.000, 0.000, 0.00, 70, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (133, '任选五', 'keno', 'bjkl8rx5', 56, '1016.76|54.22|7.8', '937.1|49.97|7.2', 0.000, 0.000, 0.00, 56, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (134, '任选六', 'keno', 'bjkl8rx6', 28, '3812.83|158.87|17.23|3.78', '3514.13|146.42|15.88|3.49', 0.000, 0.000, 0.00, 28, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (135, '任选七', 'keno', 'bjkl8rx7', 80, '16112.73|537.42|45.54|7.54|3.24', '14850.44|495.32|41.97|6.94|2.98', 0.000, 0.000, 0.00, 8, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (136, '上下盘', 'keno', 'bjkl8sxp', 3, '9.69|4.94', '8.85|4.51', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (137, '奇偶盘', 'keno', 'bjkl8jop', 3, '9.69|4.94', '8.85|4.51', 0.000, 0.000, 0.00, 3, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (138, '大小单双', 'keno', 'bjkl8dxds', 4, '7.78', '7.68', 0.000, 0.000, 0.00, 4, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (139, '上', 'keno', 'up', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (140, '中', 'keno', 'mid', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (141, '下', 'keno', 'down', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (142, '奇', 'keno', 'ji', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (143, '和', 'keno', 'jiouhe', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (144, '偶', 'keno', 'ou', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (145, '单', 'keno', 'sin', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (146, '双', 'keno', 'cou', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (147, '大单', 'keno', 'bigsin', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (148, '小单', 'keno', 'smasin', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (149, '大双', 'keno', 'bigcou', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (150, '小双', 'keno', 'smacou', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (151, '金', 'keno', 'jin', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (152, '木', 'keno', 'mu', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (153, '水', 'keno', 'shui', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (154, '火', 'keno', 'huo', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (155, '土', 'keno', 'tu', 1, '0.00', '0.00', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (156, '二同号复选', 'k3', 'k3ethfx', 1, '', '', 0.000, 0.000, 12.60, 1, 2.00, 500000.00, 30000.00, '从11-66中任选1个或多个号码，选号与奖号(包含11-66，不限顺序)相同，即为中奖（不含豹子）。赔率12.60倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (157, '二不同号标准', 'k3', 'k3ebthbz', 1, '', '', 0.000, 0.000, 6.30, 1, 2.00, 500000.00, 30000.00, '从1-6中任选2个或多个号码，所选号码与开奖号码任意2个号码相同，即为中奖。赔率6.30倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (158, '二不同号胆拖', 'k3', 'k3ebthdt', 5, '0.00', '0.00', 0.000, 0.000, 6.50, 5, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (159, '三同号单选', 'k3', 'k3sthdx', 1, '', '', 0.000, 0.000, 189.00, 1, 2.00, 500000.00, 30000.00, '对相同的三个号码(111、222、333、444、555、666)中的任意一个或多个进行投注，所选号码开出，即为中奖。赔率189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (160, '三同号通选', 'k3', 'k3sthtx', 1, '', '', 0.000, 0.000, 31.50, 1, 2.00, 500000.00, 30000.00, '对所有相同的三个号码(111、222、333、444、555、666)进行投注，任意号码开出，即为中奖。赔率31.50倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (161, '三不同号标准', 'k3', 'k3sbthbz', 1, '', '', 0.000, 0.000, 31.50, 1, 2.00, 500000.00, 30000.00, '从1-6中任选3个或多个号码,所选号码与开奖号码的3个号码相同,即为中奖。赔率31.50倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (162, '三不同号胆拖', 'k3', 'k3sbthdt', 10, '0.00', '0.00', 0.000, 0.000, 32.50, 10, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (163, '三连号通选', 'k3', 'k3slhtx', 1, '', '', 0.000, 0.000, 7.87, 1, 2.00, 500000.00, 30000.00, '对所有的3个相连号码(123、234、345、456)进行投注，任意号码开出，即为中奖。赔率7.87倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (164, '三连号单选', 'k3', 'k3slhdx', 1, '', '', 0.000, 0.000, 8.00, 1, 2.00, 500000.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (165, '和值3', 'k3', 'k3hz3', 1, '', '', 0.000, 0.000, 189.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (166, '和值4', 'k3', 'k3hz4', 1, '', '', 0.000, 0.000, 63.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (167, '和值5', 'k3', 'k3hz5', 1, '', '', 0.000, 0.000, 31.50, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (168, '和值6', 'k3', 'k3hz6', 1, '', '', 0.000, 0.000, 18.90, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (169, '和值7', 'k3', 'k3hz7', 1, '', '', 0.000, 0.000, 12.60, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (170, '和值8', 'k3', 'k3hz8', 1, '', '', 0.000, 0.000, 9.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (171, '和值9', 'k3', 'k3hz9', 1, '', '', 0.000, 0.000, 7.56, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (172, '和值10', 'k3', 'k3hz10', 1, '', '', 0.000, 0.000, 7.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (173, '和值11', 'k3', 'k3hz11', 1, '', '', 0.000, 0.000, 7.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (174, '和值12', 'k3', 'k3hz12', 1, '', '', 0.000, 0.000, 7.56, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (175, '和值13', 'k3', 'k3hz13', 1, '', '', 0.000, 0.000, 9.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (176, '和值14', 'k3', 'k3hz14', 1, '', '', 0.000, 0.000, 12.60, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (177, '和值15', 'k3', 'k3hz15', 1, '', '', 0.000, 0.000, 18.90, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (178, '和值16', 'k3', 'k3hz16', 1, '', '', 0.000, 0.000, 31.50, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (179, '和值17', 'k3', 'k3hz17', 1, '', '', 0.000, 0.000, 63.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (180, '和值18', 'k3', 'k3hz18', 1, '', '', 0.000, 0.000, 189.00, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (181, '二同号单选', 'k3', 'k3ethdx', 1, '', '', 0.000, 0.000, 63.00, 1, 2.00, 500000.00, 30000.00, '选择1对相同号码和1个不同号码投注，选号与奖号相同，即为中奖。赔率63.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (182, '大小第一名', 'pk10', 'bjpk10dxdy', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (183, '大小第二名', 'pk10', 'bjpk10dxde', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (184, '大小第三名', 'pk10', 'bjpk10dxds', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (185, '单双第一名', 'pk10', 'bjpk10dsdy', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (186, '单双第二名', 'pk10', 'bjpk10dsde', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (187, '单双第三名', 'pk10', 'bjpk10dsds', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (188, '龙虎第一名', 'pk10', 'bjpk10lhdy', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (189, '龙虎第二名', 'pk10', 'bjpk10lhde', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (190, '龙虎第三名', 'pk10', 'bjpk10lhds', 2, '3.92', '3.40', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (191, '定位胆', 'pk10', 'bjpk10dwd', 100, '19.80', '19.80', 0.000, 0.000, 0.00, 100, 1.00, 100000.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (192, '前一复式', 'pk10', 'bjpk10qian1', 100, '20', '18', 0.000, 0.000, 0.00, 100, 1.00, 1000000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (193, '前二复式', 'pk10', 'bjpk10qian2', 90, '178.2', '176.58', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (194, '前二单式', 'pk10', 'bjpk10qian2ds', 90, '178.2', '176.58', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (195, '前三复式', 'pk10', 'bjpk10qian3', 720, '1425.6', '1412.64', 0.000, 0.000, 0.00, 720, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (196, '前三单式', 'pk10', 'bjpk10qian3ds', 720, '1425.6', '1412.64', 0.000, 0.000, 0.00, 720, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (197, '前三直选复式', 'x5', 'x5qsfs', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 20000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (198, '前三直选单式', 'x5', 'x5qsds', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (199, '中三直选复式', 'x5', 'x5zsfs', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (200, '中三直选单式', 'x5', 'x5zsds', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (201, '后三直选复式', 'x5', 'x5hsfs', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (202, '后三直选单式', 'x5', 'x5hsds', 990, '1050.30', '882.00', 0.000, 0.000, 0.00, 990, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (203, '前三组选复式', 'x5', 'x5qszx', 165, '168', '120.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (204, '中三组选复式', 'x5', 'x5zszx', 165, '168', '120.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (205, '后三组选复式', 'x5', 'x5hszx', 165, '168', '120.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (206, '后三组选胆拖', 'x5', 'x5hsdt', 165, '325.04', '297.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (207, '中三组选胆拖', 'x5', 'x5zsdt', 165, '325.04', '297.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (208, '前三组选胆拖', 'x5', 'x5qsdt', 45, '325.04', '297.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (209, '后二直选复式', 'x5', 'x5hefs', 110, '158', '138.00', 0.000, 0.000, 0.00, 110, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (210, '前二直选复式', 'x5', 'x5qefs', 110, '158', '138.00', 0.000, 0.000, 0.00, 110, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (211, '后二直选单式', 'x5', 'x5heds', 110, '158', '138.00', 0.000, 0.000, 0.00, 110, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (212, '前二直选单式', 'x5', 'x5qeds', 110, '158', '138.00', 0.000, 0.000, 0.00, 110, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (213, '前二组选复式', 'x5', 'x5qezx', 55, '90', '78.00', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (214, '后二组选复式', 'x5', 'x5hezx', 55, '90', '78.00', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (215, '前二组选胆拖', 'x5', 'x5qedt', 10, '90', '78.00', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (216, '后二组选胆拖', 'x5', 'x5hedt', 55, '90', '78.00', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (217, '后三不定位', 'x5', 'x5bdwhs', 11, '7.20', '6.60', 0.000, 0.000, 0.00, 11, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (218, '中三不定位', 'x5', 'x5bdwzs', 11, '7.20', '6.60', 0.000, 0.000, 0.00, 11, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (219, '前三不定位', 'x5', 'x5bdwqs', 11, '7.20', '6.60', 0.000, 0.000, 0.00, 11, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (220, '定位胆', 'x5', 'x5dwd', 33, '12.7', '10', 0.000, 0.000, 0.00, 33, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (221, '任选复式一中一', 'x5', 'x5rx1z1', 11, '4.32', '3.96', 0.000, 0.000, 0.00, 11, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (222, '任选复式二中二', 'x5', 'x5rx2z2', 55, '10.80', '9.90', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (223, '任选复式三中三', 'x5', 'x5rx3z3', 165, '32.51', '29.70', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (224, '任选复式四中四', 'x5', 'x5rx4z4', 330, '130.02', '118.80', 0.000, 0.000, 0.00, 330, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (225, '猜中位', 'x5', 'x5czw', 7, '9', '6', 0.000, 0.000, 0.00, 7, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (226, '定单双', 'x5', 'x5dds', 6, '151.69|12.14|4.55|6.06|30.33|910.14', '138.60|11.08|4.15|5.54|27.72|831.60', 0.000, 0.000, 0.00, 6, 1.00, 10000.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (227, '胆拖八中五', 'x5', 'x5dt8z5', 120, '16.25', '14.85', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (228, '胆拖七中五', 'x5', 'x5dt7z5', 210, '43.34', '39.60', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (229, '任选单式八中五', 'x5', 'x5rxds8z5', 165, '16.35', '14.85', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (230, '任选单式七中五', 'x5', 'x5rxds7z5', 330, '43.30', '39.60', 0.000, 0.000, 0.00, 330, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (231, '任选单式六中五', 'x5', 'x5rxds6z5', 462, '151.60', '120.88', 0.000, 0.000, 0.00, 462, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (232, '任选单式五中五', 'x5', 'x5rxds5z5', 462, '910.14', '831.60', 0.000, 0.000, 0.00, 462, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (233, '任选单式四中四', 'x5', 'x5rxds4z4', 330, '130.02', '118.80', 0.000, 0.000, 0.00, 330, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (234, '任选单式三中三', 'x5', 'x5rxds3z3', 165, '32.51', '29.70', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (235, '任选单式二中二', 'x5', 'x5rxds2z2', 55, '10.80', '9.90', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (236, '任选单式一中一', 'x5', 'x5rxds1z1', 11, '4.32', '3.96', 0.000, 0.000, 0.00, 11, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (237, '任选复式八中五', 'x5', 'x5rx8z5', 165, '16.25', '14.85', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (238, '任选复式七中五', 'x5', 'x5rx7z5', 330, '43.34', '39.60', 0.000, 0.000, 0.00, 330, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (239, '任选复式六中五', 'x5', 'x5rx6z5', 462, '151.69', '138.60', 0.000, 0.000, 0.00, 462, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (240, '任选复式五中五', 'x5', 'x5rx5z5', 462, '910.14', '831.60', 0.000, 0.000, 0.00, 462, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (241, '胆拖二中二', 'x5', 'x5dt2z2', 10, '10.84', '9.90', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (242, '胆拖三中三', 'x5', 'x5dt3z3', 45, '32.51', '29.70', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (243, '胆拖四中四', 'x5', 'x5dt4z4', 120, '130.02', '118.80', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (244, '胆拖五中五', 'x5', 'x5dt5z5', 210, '910.14', '831.60', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (245, '胆拖六中五', 'x5', 'x5dt6z5', 252, '151.60', '128.00', 0.000, 0.000, 0.00, 252, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (246, '前三直选', 'kl10f', 'kl10qszxfs', 6840, '13406.40', '11628.00', 0.000, 0.000, 0.00, 6840, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (247, '后三直选', 'kl10f', 'kl10hszxfs', 6840, '13406.40', '11628.00', 0.000, 0.000, 0.00, 6840, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (248, '前三组选', 'kl10f', 'kl10qszux', 6840, '13406.40', '11628.00', 0.000, 0.000, 0.00, 6840, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (249, '后三组选', 'kl10f', 'kl10hszux', 6840, '13406.40', '11628.00', 0.000, 0.000, 0.00, 6840, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (250, '二星连直', 'kl10f', 'kl10elzx', 380, '744.80', '646.00', 0.000, 0.000, 0.00, 380, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (251, '二星组选', 'kl10f', 'kl10elzux', 190, '372.40', '323.00', 0.000, 0.000, 0.00, 190, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (252, '胆拖五中五', 'kl10f', 'kl10dt5z5', 0, '30.00', '18.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (253, '胆拖四中四', 'kl10f', 'kl10dt4z4', 0, '30.00', '18.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (254, '胆拖三中三', 'kl10f', 'kl10dt3z3', 0, '30.00', '18.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (255, '胆拖二中二', 'kl10f', 'kl10dt2z2', 0, '30.00', '18.00', 0.000, 0.000, 0.00, 0, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (256, '任选五中五', 'kl10f', 'kl10rx5z5', 20, '30.00', '18.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (257, '任选四中四', 'kl10f', 'kl10rx4z4', 20, '30.00', '18.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (258, '任选三中三', 'kl10f', 'kl10rx3z3', 20, '30.00', '18.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (259, '任选二中二', 'kl10f', 'kl10rx2z2', 20, '9.88', '6.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (260, '任选一中一', 'kl10f', 'kl10rx1z1', 20, '2.88', '1.50', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (261, '第八位', 'kl10f', 'kl10dwd8', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (262, '第七位', 'kl10f', 'kl10dwd7', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (263, '第六位', 'kl10f', 'kl10dwd6', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (264, '第五位', 'kl10f', 'kl10dwd5', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (265, '第四位', 'kl10f', 'kl10dwd4', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (266, '第三位', 'kl10f', 'kl10dwd3', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (267, '第二位', 'kl10f', 'kl10dwd2', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (268, '第一位', 'kl10f', 'kl10dwd1', 20, '39.20', '34.00', 0.000, 0.000, 0.00, 20, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (269, '极小', 'xy28', 'xy28_hunhe_ji_small', 1, '0.00', '0.00', 0.000, 0.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (270, '极大', 'xy28', 'xy28_hunhe_ji_big', 1, '0.00', '0.00', 0.000, 0.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (271, '小双', 'xy28', 'xy28_hunhe_small_even', 1, '0.00', '0.00', 0.000, 0.000, 4.10, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (272, '大双', 'xy28', 'xy28_hunhe_big_even', 1, '0.00', '0.00', 0.000, 0.000, 4.10, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (273, '小单', 'xy28', 'xy28_hunhe_small_odd', 1, '0.00', '0.00', 0.000, 0.000, 4.10, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (274, '大单', 'xy28', 'xy28_hunhe_big_odd', 1, '0.00', '0.00', 0.000, 0.000, 4.10, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (275, '双', 'xy28', 'xy28_hunhe_even', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (276, '单', 'xy28', 'xy28_hunhe_odd', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (277, '小', 'xy28', 'xy28_hunhe_small', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (278, '大', 'xy28', 'xy28_hunhe_big', 1, '0.00', '0.00', 0.000, 0.000, 1.95, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (279, '特码27', 'xy28', 'xy28_tm_27', 1, '0.00', '0.00', 0.000, 0.000, 974.81, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (280, '特码26', 'xy28', 'xy28_tm_26', 1, '0.00', '0.00', 0.000, 0.000, 328.55, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (281, '特码25', 'xy28', 'xy28_tm_25', 1, '0.00', '0.00', 0.000, 0.000, 162.38, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (282, '特码24', 'xy28', 'xy28_tm_24', 1, '0.00', '0.00', 0.000, 0.000, 98.61, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (283, '特码23', 'xy28', 'xy28_tm_23', 1, '0.00', '0.00', 0.000, 0.000, 64.94, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (284, '特码22', 'xy28', 'xy28_tm_22', 1, '0.00', '0.00', 0.000, 0.000, 47.07, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (285, '特码21', 'xy28', 'xy28_tm_21', 1, '0.00', '0.00', 0.000, 0.000, 34.88, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (286, '特码20', 'xy28', 'xy28_tm_20', 1, '0.00', '0.00', 0.000, 0.000, 27.55, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (287, '特码19', 'xy28', 'xy28_tm_19', 1, '0.00', '0.00', 0.000, 0.000, 21.64, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (288, '特码18', 'xy28', 'xy28_tm_18', 1, '0.00', '0.00', 0.000, 0.000, 17.99, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (289, '特码17', 'xy28', 'xy28_tm_17', 1, '0.00', '0.00', 0.000, 0.000, 15.44, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (290, '特码16', 'xy28', 'xy28_tm_16', 1, '0.00', '0.00', 0.000, 0.000, 14.27, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (291, '特码15', 'xy28', 'xy28_tm_15', 1, '0.00', '0.00', 0.000, 0.000, 13.29, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (292, '特码14', 'xy28', 'xy28_tm_14', 1, '0.00', '0.00', 0.000, 0.000, 13.14, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (293, '特码13', 'xy28', 'xy28_tm_13', 1, '0.00', '0.00', 0.000, 0.000, 13.01, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (294, '特码12', 'xy28', 'xy28_tm_12', 1, '0.00', '0.00', 0.000, 0.000, 13.49, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (295, '特码11', 'xy28', 'xy28_tm_11', 1, '0.00', '0.00', 0.000, 0.000, 14.06, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (296, '特码10', 'xy28', 'xy28_tm_10', 1, '0.00', '0.00', 0.000, 0.000, 15.64, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (297, '特码9', 'xy28', 'xy28_tm_09', 1, '0.00', '0.00', 0.000, 0.000, 17.70, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (298, '特码8', 'xy28', 'xy28_tm_08', 1, '0.00', '0.00', 0.000, 0.000, 21.91, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (299, '特码7', 'xy28', 'xy28_tm_07', 1, '0.00', '0.00', 0.000, 0.000, 27.12, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (300, '特码6', 'xy28', 'xy28_tm_06', 1, '0.00', '0.00', 0.000, 0.000, 35.42, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (301, '特码5', 'xy28', 'xy28_tm_05', 1, '0.00', '0.00', 0.000, 0.000, 46.50, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (302, '特码4', 'xy28', 'xy28_tm_04', 1, '0.00', '0.00', 0.000, 0.000, 65.73, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (303, '特码3', 'xy28', 'xy28_tm_03', 1, '0.00', '0.00', 0.000, 0.000, 97.41, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (304, '特码2', 'xy28', 'xy28_tm_02', 1, '0.00', '0.00', 0.000, 0.000, 164.34, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (305, '特码1', 'xy28', 'xy28_tm_01', 1, '0.00', '0.00', 0.000, 0.000, 324.75, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (306, '特码0', 'xy28', 'xy28_tm_00', 1, '0.00', '0.00', 0.000, 0.000, 959.18, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (307, '前二和尾', 'ssc', 'hzwsqe', 10, '19.30', '17.00', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (308, '后二和尾', 'ssc', 'hzwshe', 10, '19.30', '17.00', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (309, '和', 'ssc', 'lhwqhe', 1, '9.90', '8.50', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (310, '虎', 'ssc', 'lhwqhu', 1, '2.20', '1.87', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (311, '龙', 'ssc', 'lhwql', 1, '2.20', '1.87', 0.000, 0.000, 0.00, 1, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (312, '三星直选复式', 'dpc', 'pl3zxfs', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (313, '三星直选单式', 'dpc', 'pl3zxds', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (314, '三星组三', 'dpc', 'pl3zux3', 90, '656.60', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (315, '趣味拖拉机', 'dpc', 'pl3qwtlj', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (316, '趣味奇偶', 'dpc', 'pl3qwjo', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (317, '和值大小', 'dpc', 'pl3hzdx', 2, '1.95', '1.95', 0.000, 0.000, 0.00, 2, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (318, '和值组六', 'dpc', 'pl3hzzux6', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (319, '和值组三', 'dpc', 'pl3hzzux3', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (320, '三星直选和值', 'dpc', 'pl3hzzx', 1000, '1070.00', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (321, '定位胆后一', 'dpc', 'pl3dwd1h', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (322, '定位胆中一', 'dpc', 'pl3dwd1z', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (323, '定位胆前一', 'dpc', 'pl3dwd1q', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (324, '不定位', 'dpc', 'pl3bdw', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (325, '后二直选单式', 'dpc', 'pl3hx2ds', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (326, '后二直选复式', 'dpc', 'pl3hx2fs', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (327, '前二直选单式', 'dpc', 'pl3qx2ds', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (328, '前二直选复式', 'dpc', 'pl3qx2fs', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (329, '三星组六拖胆', 'dpc', 'pl3zux6dt', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (330, '三星组三拖胆', 'dpc', 'pl3zux3dt', 90, '350.00', '282.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (331, '三星混合', 'dpc', 'pl3zuxhh', 210, '168.30', '120.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (332, '三星组六', 'dpc', 'pl3zux6', 120, '120.00', '100.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (333, '和值双', 'k3', 'k3hzeven', 1, '', '', 0.000, 0.000, 1.95, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (334, '和值单', 'k3', 'k3hzodd', 1, '', '', 0.000, 0.000, 1.95, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (335, '和值小', 'k3', 'k3hzsmall', 1, '', '', 0.000, 0.000, 1.95, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (336, '和值大', 'k3', 'k3hzbig', 1, '', '', 0.000, 0.000, 1.95, 1, 2.00, 500000.00, 30000.00, '猜3个开奖号相加的和，3-10为小，11-18为大。赔率1.950-189.00倍。', 1);
INSERT INTO `caipiao_wanfa` VALUES (338, '四星一码不定位', 'ssc', 'bdw4x1m', 10, '6.00', '5.23', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (339, '四星二码不定位', 'ssc', 'bdw4x2m', 45, '21.00', '18.48', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (340, '前三二码不定位', 'ssc', 'bdwqs2m', 45, '30.00', '23.33', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (341, '中三二码不定位', 'ssc', 'bdwzs2m', 45, '30.00', '23.33', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (342, '后三二码不定位', 'ssc', 'bdwhs2m', 45, '30.00', '23.33', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (343, '前二组选和值', 'ssc', 'zuxhzqe', 45, '90.00', '80.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (344, '后二组选和值', 'ssc', 'zuxhzhe', 45, '90.00', '80.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (345, '前三组选包胆', 'ssc', 'zuxcsbd', 54, '330', '300', 0.000, 0.000, 0.00, 54, 1.00, 2000000.00, 300000.00, '如3个号码中出现对子号码，则奖金双倍', 1);
INSERT INTO `caipiao_wanfa` VALUES (346, '中三组选包胆', 'ssc', 'zuxzsbd', 54, '330', '300', 0.000, 0.000, 0.00, 54, 1.00, 2000000.00, 300000.00, '如3个号码中出现对子号码，则奖金双倍', 1);
INSERT INTO `caipiao_wanfa` VALUES (347, '后三组选包胆', 'ssc', 'zuxhsbd', 54, '330', '300', 0.000, 0.000, 0.00, 54, 1.00, 2000000.00, 300000.00, '如3个号码中出现对子号码，则奖金双倍', 1);
INSERT INTO `caipiao_wanfa` VALUES (348, '前二组选包胆', 'ssc', 'zuxcebd', 9, '49.5', '45.00', 0.000, 0.000, 0.00, 9, 1.00, 2000000.00, 300000.00, '如3个号码中出现对子号码，则奖金双倍', 1);
INSERT INTO `caipiao_wanfa` VALUES (349, '后二组选包胆', 'ssc', 'zuxhebd', 9, '49.5', '45.00', 0.000, 0.000, 0.00, 9, 1.00, 2000000.00, 300000.00, '如3个号码中出现对子号码，则奖金双倍', 1);
INSERT INTO `caipiao_wanfa` VALUES (350, '前三大小单双', 'ssc', 'dxdsqs', 64, '16.00', '14.40', 0.000, 0.000, 0.00, 64, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (351, '后三大小单双', 'ssc', 'dxdshs', 64, '16.00', '14.40', 0.000, 0.000, 0.00, 64, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (352, '前三组三单式', 'ssc', 'qszsds', 90, '659.99', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (353, '前三组六单式', 'ssc', 'qszlds', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (354, '后三组三单式', 'ssc', 'hszsds', 90, '659.99', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (355, '后三组六单式', 'ssc', 'hszlds', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (356, '中三组三单式', 'ssc', 'zszsds', 90, '659.99', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (357, '中三组六单式', 'ssc', 'zszlds', 120, '329.99', '300.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (358, '前四复式', 'pk10', 'bjpk10qian4', 5040, '9979.2', '9888.48', 0.000, 0.000, 0.00, 5040, 1.00, 10080.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (359, '前四单式', 'pk10', 'bjpk10qian4ds', 5040, '9979.2', '9888.48', 0.000, 0.000, 0.00, 5040, 1.00, 10080.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (360, '前五复式', 'pk10', 'bjpk10qian5', 30240, '59875.2', '54432', 0.000, 0.000, 0.00, 30240, 1.00, 60480.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (361, '前五单式', 'pk10', 'bjpk10qian5ds', 30240, '59875.2', '54432', 0.000, 0.000, 0.00, 30240, 1.00, 60480.00, 30000.00, '', 0);
INSERT INTO `caipiao_wanfa` VALUES (363, '三星组选包胆', 'dpc', 'pl3zuxbd', 54, '656.60', '600.00', 0.000, 0.000, 0.00, 54, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (364, '三星组三单式', 'dpc', 'pl3zsds', 90, '656.60', '600.00', 0.000, 0.000, 0.00, 90, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (365, '三星组六单式', 'dpc', 'pl3zlds', 120, '168.30', '120.00', 0.000, 0.000, 0.00, 120, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (366, '前二组选复式', 'dpc', 'pl3q2zxfs', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (367, '前二组选单式', 'dpc', 'pl3q2zxds', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (368, '前二组选包胆', 'dpc', 'pl3q2zxbd', 9, '98.50', '90.00', 0.000, 0.000, 0.00, 9, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (369, '后二组选复式', 'dpc', 'pl3h2zxfs', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (370, '后二组选单式', 'dpc', 'pl3h2zxds', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (371, '后二组选包胆', 'dpc', 'pl3h2zxbd', 9, '98.50', '90.00', 0.000, 0.000, 0.00, 9, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (372, '三星一码不定位', 'dpc', 'pl3ymbdw', 10, '7.28', '6.64', 0.000, 0.000, 0.00, 10, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (373, '三星二码不定位', 'dpc', 'pl3rmbdw', 45, '36.48', '33.33', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (374, '后二直选和值', 'dpc', 'pl3h2zxhz', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (375, '前二跨度', 'dpc', 'pl3q2kd', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (376, '后二跨度', 'dpc', 'pl3h2kd', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (377, '复式', 'dpc', 'pl3dwdfs', 30, '10.70', '10', 0.000, 0.000, 0.00, 30, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (378, '三星组选和值', 'dpc', 'pl3zuxhz', 210, '268.60', '200.00', 0.000, 0.000, 0.00, 210, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (379, '前二直选和值', 'dpc', 'pl3q2zxhz', 100, '107.00', '100.00', 0.000, 0.000, 0.00, 100, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (380, '前二组选和值', 'dpc', 'pl3q2zuxhz', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (381, '三星跨度', 'dpc', 'pl3kd', 1000, '1070.000', '1000.00', 0.000, 0.000, 0.00, 1000, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (382, '后二组选和值', 'dpc', 'pl3h2zuxhz', 45, '98.50', '90.00', 0.000, 0.000, 0.00, 45, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (383, '前二大小单双', 'dpc', 'dxdsq2', 16, '7.88', '7.20', 0.000, 0.000, 0.00, 16, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (384, '后二大小单双', 'dpc', 'dxdsh2', 16, '7.88', '7.20', 0.000, 0.000, 0.00, 16, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (385, '前三组选单式', 'x5', 'x5qszxds', 165, '168', '120.00', 0.000, 0.000, 0.00, 165, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (386, '前二组选单式', 'x5', 'x5qezxds', 55, '90', '78.00', 0.000, 0.000, 0.00, 55, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (407, '直选', 'lhc', 'tmzx', 49, '', '', 0.000, 0.000, 48.02, 49, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (408, '特码大', 'lhc', 'tmlmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (409, '特码小', 'lhc', 'tmlmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (410, '特码单', 'lhc', 'tmlmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (411, '特码双', 'lhc', 'tmlmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (412, '特码大单', 'lhc', 'tmlmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (413, '特码大双', 'lhc', 'tmlmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (414, '特码小单', 'lhc', 'tmlmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (415, '特码小双', 'lhc', 'tmlmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (416, '特码合大', 'lhc', 'tmlmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (417, '特码合小', 'lhc', 'tmlmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (418, '特码合单', 'lhc', 'tmlmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (419, '特码合双', 'lhc', 'tmlmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (420, '特码尾大', 'lhc', 'tmlmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (421, '特码尾小', 'lhc', 'tmlmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (422, '特码家禽', 'lhc', 'tmlmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (423, '特码野兽', 'lhc', 'tmlmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (424, '特码红波', 'lhc', 'tmlmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (425, '特码绿波', 'lhc', 'tmlmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (426, '特码蓝波', 'lhc', 'tmlmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (427, '特码两面', 'lhc', 'tmlm', 1, '', '', 0.000, 0.000, 1.00, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (428, '任选', 'lhc', 'zmrx', 49, '', '', 0.000, 0.000, 7.92, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (429, '正1特', 'lhc', 'zm1t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (430, '正1大', 'lhc', 'zm1lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (431, '正1小', 'lhc', 'zm1lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (432, '正1单', 'lhc', 'zm1lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (433, '正1双', 'lhc', 'zm1lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (434, '正1大双', 'lhc', 'zm1lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (435, '正1小单', 'lhc', 'zm1lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (436, '正1大单', 'lhc', 'zm1lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (437, '正1小双', 'lhc', 'zm1lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (438, '正1合大', 'lhc', 'zm1lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (439, '正1合小', 'lhc', 'zm1lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (440, '正1合单', 'lhc', 'zm1lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (441, '正1合双', 'lhc', 'zm1lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (442, '正1尾大', 'lhc', 'zm1lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (443, '正1尾小', 'lhc', 'zm1lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (444, '正1家禽', 'lhc', 'zm1lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (445, '正1野兽', 'lhc', 'zm1lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (446, '正1红波', 'lhc', 'zm1lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (447, '正1绿波', 'lhc', 'zm1lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (448, '正1蓝波', 'lhc', 'zm1lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (449, '正2特', 'lhc', 'zm2t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (450, '正3特', 'lhc', 'zm3t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (451, '正2大', 'lhc', 'zm2lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (452, '正2小', 'lhc', 'zm2lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (453, '正2单', 'lhc', 'zm2lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (454, '正2双', 'lhc', 'zm2lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (455, '正2大单', 'lhc', 'zm2lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (456, '正2大双', 'lhc', 'zm2lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (457, '正2小单', 'lhc', 'zm2lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (458, '正2小双', 'lhc', 'zm2lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (459, '正2合大', 'lhc', 'zm2lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (460, '正2合小', 'lhc', 'zm2lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (461, '正2合单', 'lhc', 'zm2lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (462, '正2合双', 'lhc', 'zm2lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (463, '正2尾大', 'lhc', 'zm2lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (464, '正2尾小', 'lhc', 'zm2lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (465, '正2家禽', 'lhc', 'zm2lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (466, '正2野兽', 'lhc', 'zm2lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (467, '正2红波', 'lhc', 'zm2lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (468, '正2绿波', 'lhc', 'zm2lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (469, '正2蓝波', 'lhc', 'zm2lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (470, '正3大', 'lhc', 'zm3lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (471, '正3小', 'lhc', 'zm3lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (472, '正3单', 'lhc', 'zm3lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (473, '正3双', 'lhc', 'zm3lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (474, '正3大单', 'lhc', 'zm3lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (475, '正3大双', 'lhc', 'zm3lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (476, '正3小单', 'lhc', 'zm3lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (477, '正3小双', 'lhc', 'zm3lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (478, '正3合大', 'lhc', 'zm3lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (479, '正3合小', 'lhc', 'zm3lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (480, '正3合单', 'lhc', 'zm3lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (481, '正3合双', 'lhc', 'zm3lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (482, '正3尾大', 'lhc', 'zm3lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (483, '正3尾小', 'lhc', 'zm3lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (484, '正3家禽', 'lhc', 'zm3lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (485, '正3野兽', 'lhc', 'zm3lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (486, '正3红波', 'lhc', 'zm3lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (487, '正3绿波', 'lhc', 'zm3lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (488, '正3蓝波', 'lhc', 'zm3lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (489, '正4大', 'lhc', 'zm4lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (490, '正4小', 'lhc', 'zm4lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (491, '正4单', 'lhc', 'zm4lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (492, '正4双', 'lhc', 'zm4lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (493, '正4大单', 'lhc', 'zm4lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (494, '正4大双', 'lhc', 'zm4lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (495, '正4小单', 'lhc', 'zm4lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (496, '正4小双', 'lhc', 'zm4lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (497, '正4合大', 'lhc', 'zm4lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (498, '正4合小', 'lhc', 'zm4lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (499, '正4合单', 'lhc', 'zm4lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (500, '正4合双', 'lhc', 'zm4lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (501, '正4尾大', 'lhc', 'zm4lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (502, '正4尾小', 'lhc', 'zm4lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (503, '正4家禽', 'lhc', 'zm4lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (504, '正4野兽', 'lhc', 'zm4lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (505, '正4红波', 'lhc', 'zm4lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (506, '正4绿波', 'lhc', 'zm4lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (507, '正4蓝波', 'lhc', 'zm4lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (508, '正5大', 'lhc', 'zm5lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (509, '正5小', 'lhc', 'zm5lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (510, '正5单', 'lhc', 'zm5lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (511, '正5双', 'lhc', 'zm5lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (512, '正5大单', 'lhc', 'zm5lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (513, '正5小单', 'lhc', 'zm5lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (514, '正5小双', 'lhc', 'zm5lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (515, '正5大双', 'lhc', 'zm5lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (516, '正5合小', 'lhc', 'zm5lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (517, '正5合大', 'lhc', 'zm5lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (518, '正5合单', 'lhc', 'zm5lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (519, '正5合双', 'lhc', 'zm5lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (520, '正5尾大', 'lhc', 'zm5lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (521, '正5尾小', 'lhc', 'zm5lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (522, '正5家禽', 'lhc', 'zm5lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (523, '正5红波', 'lhc', 'zm5lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (524, '正5野兽', 'lhc', 'zm5lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (525, '正5绿波', 'lhc', 'zm5lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (526, '正5蓝波', 'lhc', 'zm5lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (527, '正6大', 'lhc', 'zm6lmda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (528, '正6小', 'lhc', 'zm6lmxiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (529, '正6单', 'lhc', 'zm6lmdan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (530, '正6双', 'lhc', 'zm6lmshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (531, '正6大单', 'lhc', 'zm6lmdadan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (532, '正6大双', 'lhc', 'zm6lmdashuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (533, '正6小单', 'lhc', 'zm6lmxiaodan', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (534, '正6小双', 'lhc', 'zm6lmxiaoshuang', 1, '', '', 0.000, 0.000, 3.92, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (535, '正6合大', 'lhc', 'zm6lmheda', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (536, '正6合小', 'lhc', 'zm6lmhexiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (537, '正6合双', 'lhc', 'zm6lmheshuang', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (538, '正6合单', 'lhc', 'zm6lmhedan', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (539, '正6尾大', 'lhc', 'zm6lmweida', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (540, '正6尾小', 'lhc', 'zm6lmweixiao', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (541, '正6家禽', 'lhc', 'zm6lmjiaqin', 1, '', '', 0.000, 0.000, 1.88, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (542, '正6野兽', 'lhc', 'zm6lmyeshou', 1, '', '', 0.000, 0.000, 1.96, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (543, '正6红波', 'lhc', 'zm6lmhongbo', 1, '', '', 0.000, 0.000, 2.77, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (544, '正6绿波', 'lhc', 'zm6lmlvbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (545, '正6蓝波', 'lhc', 'zm6lmlanbo', 1, '', '', 0.000, 0.000, 2.94, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (546, '三全中', 'lhc', 'lm3qz', 18424, '', '', 0.000, 0.000, 654.05, 18424, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (547, '三中二', 'lhc', 'lm3z2', 18424, '', '', 0.000, 0.000, 20.63, 18424, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (548, '二全中', 'lhc', 'lm2qz', 1176, '', '', 0.000, 0.000, 65.85, 1176, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (549, '二中特', 'lhc', 'lm2zt', 1176, '', '', 0.000, 0.000, 32.92, 1176, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (550, '特串', 'lhc', 'lmtc', 1176, '', '', 0.000, 0.000, 158.76, 1176, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (551, '蓝合双', 'lhc', 'lanheshuang', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (552, '蓝合单', 'lhc', 'lanhedan', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (553, '蓝双', 'lhc', 'lanshuang', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (554, '蓝单', 'lhc', 'landan', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (555, '蓝小', 'lhc', 'lanxiao', 1, '', '', 0.000, 0.000, 6.58, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (556, '蓝大', 'lhc', 'landa', 1, '', '', 0.000, 0.000, 5.12, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (557, '绿合双', 'lhc', 'lvheshuang', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (558, '绿合单', 'lhc', 'lvhedan', 1, '', '', 0.000, 0.000, 6.58, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (559, '绿双', 'lhc', 'lvshuang', 1, '', '', 0.000, 0.000, 6.58, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (560, '绿单', 'lhc', 'lvdan', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (561, '绿小', 'lhc', 'lvxiao', 1, '', '', 0.000, 0.000, 6.58, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (562, '绿大', 'lhc', 'lvda', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (563, '红合双', 'lhc', 'hongheshuang', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (564, '红合单', 'lhc', 'honghedan', 1, '', '', 0.000, 0.000, 5.12, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (565, '红双', 'lhc', 'hongshuang', 1, '', '', 0.000, 0.000, 5.12, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (566, '红单', 'lhc', 'hongdan', 1, '', '', 0.000, 0.000, 5.76, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (567, '红小', 'lhc', 'hongxiao', 1, '', '', 0.000, 0.000, 4.61, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (568, '红大', 'lhc', 'hongda', 1, '', '', 0.000, 0.000, 6.58, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (569, '特肖鼠', 'lhc', 'sxtxshu', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (570, '特肖牛', 'lhc', 'sxtxniu', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (571, '特肖虎', 'lhc', 'sxtxhu', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (572, '特肖兔', 'lhc', 'sxtxtu', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (573, '特肖龙', 'lhc', 'sxtxlong', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (574, '特肖蛇', 'lhc', 'sxtxshe', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (575, '特肖马', 'lhc', 'sxtxma', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (576, '特肖羊', 'lhc', 'sxtxyang', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (577, '特肖猴', 'lhc', 'sxtxhou', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (578, '特肖鸡', 'lhc', 'sxtxji', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (579, '特肖狗', 'lhc', 'sxtxgou', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (580, '特肖猪', 'lhc', 'sxtxzhu', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (581, '一肖鼠', 'lhc', 'sx1xshu', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (582, '一肖牛', 'lhc', 'sx1xniu', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (583, '一肖虎', 'lhc', 'sx1xhu', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (584, '一肖兔', 'lhc', 'sx1xtu', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (585, '一肖龙', 'lhc', 'sx1xlong', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (586, '一肖蛇', 'lhc', 'sx1xshe', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (587, '一肖马', 'lhc', 'sx1xma', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (588, '一肖羊', 'lhc', 'sx1xyang', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (589, '一肖猴', 'lhc', 'sx1xhou', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (590, '一肖鸡', 'lhc', 'sx1xji', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (591, '一肖狗', 'lhc', 'sx1xgou', 1, '', '', 0.000, 0.000, 1.99, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (592, '一肖猪', 'lhc', 'sx1xzhu', 1, '', '', 0.000, 0.000, 1.70, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (593, '二肖连', 'lhc', 'sx2xl', 66, '', '', 0.000, 0.000, 3.58, 66, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (594, '三肖连', 'lhc', 'sx3xl', 220, '', '', 0.000, 0.000, 9.06, 220, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (595, '四肖连', 'lhc', 'sx4xl', 495, '', '', 0.000, 0.000, 26.26, 495, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (596, '0头', 'lhc', 'lingtou', 1, '', '', 0.000, 0.000, 5.11, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (597, '1头', 'lhc', 'yitou', 1, '', '', 0.000, 0.000, 4.60, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (598, '2头', 'lhc', 'ertou', 1, '', '', 0.000, 0.000, 4.60, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (599, '3头', 'lhc', 'santou', 1, '', '', 0.000, 0.000, 4.60, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (600, '4头', 'lhc', 'sitou', 1, '', '', 0.000, 0.000, 4.60, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (601, '0尾', 'lhc', 'lingwei', 1, '', '', 0.000, 0.000, 11.51, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (602, '1尾', 'lhc', 'yiwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (603, '2尾', 'lhc', 'erwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (604, '3尾', 'lhc', 'sanwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (605, '4尾', 'lhc', 'siwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (606, '6尾', 'lhc', 'liuwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (607, '5尾', 'lhc', 'wuwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (608, '7尾', 'lhc', 'qiwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (609, '8尾', 'lhc', 'bawei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (610, '9尾', 'lhc', 'jiuwei', 1, '', '', 0.000, 0.000, 9.21, 1, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (611, '二尾连', 'lhc', 'ws2wl', 45, '', '', 0.000, 0.000, 3.58, 45, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (612, '三尾连', 'lhc', 'ws3wl', 120, '', '', 0.000, 0.000, 7.60, 120, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (613, '四尾连', 'lhc', 'ws4wl', 210, '', '', 0.000, 0.000, 18.15, 210, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (614, '五不中', 'lhc', 'bz5bz', 1906884, '', '', 0.000, 0.000, 2.10, 1906884, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (615, '六不中', 'lhc', 'bz6bz', 13983816, '', '', 0.000, 0.000, 2.50, 13983816, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (616, '七不中', 'lhc', 'bz7bz', 85900584, '', '', 0.000, 0.000, 2.99, 85900584, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (617, '八不中', 'lhc', 'bz8bz', 450978066, '', '', 0.000, 0.000, 3.59, 450978066, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (618, '九不中', 'lhc', 'bz9bz', 2054455634, '', '', 0.000, 0.000, 4.33, 2054455634, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (619, '十不中', 'lhc', 'bz10bz', 2147483647, '', '', 0.000, 0.000, 5.24, 2147483647, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (620, '正4特', 'lhc', 'zm4t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (621, '正5特', 'lhc', 'zm5t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (622, '正6特', 'lhc', 'zm6t', 49, '', '', 0.000, 0.000, 46.55, 49, 2.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (623, '第一球-大', 'ssc', 'lmp_d1q_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (624, '第一球-小', 'ssc', 'lmp_d1q_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 300000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (625, '第一球-单', 'ssc', 'lmp_d1q_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (626, '第一球-双', 'ssc', 'lmp_d1q_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (627, '第二球-大', 'ssc', 'lmp_d2q_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (628, '第二球-小', 'ssc', 'lmp_d2q_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (629, '第二球-单', 'ssc', 'lmp_d2q_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (630, '第二球-双', 'ssc', 'lmp_d2q_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (631, '总和-大', 'ssc', 'lmp_zongh_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (632, '总和-小', 'ssc', 'lmp_zongh_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (633, '总和-单', 'ssc', 'lmp_zongh_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (634, '总和-双', 'ssc', 'lmp_zongh_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (635, '第三球-大', 'ssc', 'lmp_d3q_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (636, '第三球-小', 'ssc', 'lmp_d3q_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (637, '第三球-单', 'ssc', 'lmp_d3q_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (638, '第三球-双', 'ssc', 'lmp_d3q_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (639, '第四球-大', 'ssc', 'lmp_d4q_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (640, '第四球-小', 'ssc', 'lmp_d4q_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (641, '第四球-单', 'ssc', 'lmp_d4q_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (642, '第四球-双', 'ssc', 'lmp_d4q_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (643, '第五球-大', 'ssc', 'lmp_d5q_da', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (644, '第五球-小', 'ssc', 'lmp_d5q_xiao', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (645, '第五球-单', 'ssc', 'lmp_d5q_dan', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (646, '第五球-双', 'ssc', 'lmp_d5q_shuang', 1, '', '', 1.980, 1.980, 1.98, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (647, '第一球-0', 'ssc', 'dan_d1q_eq0', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (648, '第一球-1', 'ssc', 'dan_d1q_eq1', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (649, '第一球-2', 'ssc', 'dan_d1q_eq2', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (650, '第一球-3', 'ssc', 'dan_d1q_eq3', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (651, '第一球-4', 'ssc', 'dan_d1q_eq4', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (652, '第一球-5', 'ssc', 'dan_d1q_eq5', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (653, '第一球-6', 'ssc', 'dan_d1q_eq6', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (654, '第一球-7', 'ssc', 'dan_d1q_eq7', 1, '', '', 9.900, 9.000, 9.90, 1, 1.00, 500000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (655, '第一球-8', 'ssc', 'dan_d1q_eq8', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (656, '第一球-9', 'ssc', 'dan_d1q_eq9', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (657, '第二球-0', 'ssc', 'dan_d2q_eq0', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (658, '第二球-1', 'ssc', 'dan_d2q_eq1', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (659, '第二球-2', 'ssc', 'dan_d2q_eq2', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (660, '第二球-3', 'ssc', 'dan_d2q_eq3', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (661, '第二球-4', 'ssc', 'dan_d2q_eq4', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (662, '第二球-5', 'ssc', 'dan_d2q_eq5', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (663, '第二球-6', 'ssc', 'dan_d2q_eq6', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (664, '第二球-7', 'ssc', 'dan_d2q_eq7', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (665, '第二球-8', 'ssc', 'dan_d2q_eq8', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (666, '第二球-9', 'ssc', 'dan_d2q_eq9', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (667, '第三球-1', 'ssc', 'dan_d3q_eq1', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (668, '第三球-2', 'ssc', 'dan_d3q_eq2', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (669, '第三球-3', 'ssc', 'dan_d3q_eq3', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (670, '第三球-4', 'ssc', 'dan_d3q_eq4', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (671, '第三球-5', 'ssc', 'dan_d3q_eq5', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (672, '第三球-6', 'ssc', 'dan_d3q_eq6', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (673, '第三球-7', 'ssc', 'dan_d3q_eq7', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (674, '第三球-8', 'ssc', 'dan_d3q_eq8', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (675, '第三球-9', 'ssc', 'dan_d3q_eq9', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (676, '第四球-0', 'ssc', 'dan_d4q_eq0', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (677, '第四球-1', 'ssc', 'dan_d4q_eq1', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (678, '第四球-2', 'ssc', 'dan_d4q_eq2', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (679, '第四球-3', 'ssc', 'dan_d4q_eq3', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (680, '第四球-4', 'ssc', 'dan_d4q_eq4', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (681, '第四球-5', 'ssc', 'dan_d4q_eq5', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (682, '第四球-6', 'ssc', 'dan_d4q_eq6', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (683, '第四球-7', 'ssc', 'dan_d4q_eq7', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (684, '第四球-8', 'ssc', 'dan_d4q_eq8', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (685, '第四球-9', 'ssc', 'dan_d4q_eq9', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (686, '第五球-0', 'ssc', 'dan_d5q_eq0', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (687, '第五球-1', 'ssc', 'dan_d5q_eq1', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (688, '第五球-2', 'ssc', 'dan_d5q_eq2', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (689, '第五球-3', 'ssc', 'dan_d5q_eq3', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (690, '第五球-4', 'ssc', 'dan_d5q_eq4', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (691, '第五球-5', 'ssc', 'dan_d5q_eq5', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (692, '第五球-6', 'ssc', 'dan_d5q_eq6', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (693, '第五球-7', 'ssc', 'dan_d5q_eq7', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (694, '第五球-8', 'ssc', 'dan_d5q_eq8', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (695, '第五球-9', 'ssc', 'dan_d5q_eq9', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (696, '第三球-0', 'ssc', 'dan_d3q_eq0', 1, '', '', 9.900, 9.000, 9.80, 1, 1.00, 10000.00, 30000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (697, '前三-豹子', 'ssc', 'lmp_qs_bz', 1, '', '', 70.000, 70.000, 70.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (698, '前三-顺子', 'ssc', 'lmp_qs_sz', 1, '', '', 13.000, 13.000, 13.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (699, '前三-对子', 'ssc', 'lmp_qs_dz', 1, '', '', 2.800, 2.800, 2.80, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (700, '前三-半顺', 'ssc', 'lmp_qs_bs', 1, '', '', 2.000, 2.000, 2.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (701, '前三-杂六', 'ssc', 'lmp_qs_z6', 1, '', '', 2.200, 2.200, 2.20, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (702, '中三-豹子', 'ssc', 'lmp_zs_bz', 1, '', '', 70.000, 70.000, 70.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (703, '中三-顺子', 'ssc', 'lmp_zs_sz', 1, '', '', 13.000, 13.000, 13.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (704, '中三-对子', 'ssc', 'lmp_zs_dz', 1, '', '', 2.800, 2.800, 2.80, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (705, '中三-半顺', 'ssc', 'lmp_zs_bs', 1, '', '', 2.000, 2.000, 2.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (706, '中三-杂六', 'ssc', 'lmp_zs_z6', 1, '', '', 2.200, 2.200, 2.20, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (707, '后三-豹子', 'ssc', 'lmp_hs_bz', 1, '', '', 70.000, 70.000, 70.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (708, '后三-顺子', 'ssc', 'lmp_hs_sz', 1, '', '', 13.000, 13.000, 13.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (709, '后三-对子', 'ssc', 'lmp_hs_dz', 1, '', '', 2.800, 2.800, 2.80, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (710, '后三-半顺', 'ssc', 'lmp_hs_bs', 1, '', '', 2.000, 2.000, 2.00, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (711, '后三-杂六', 'ssc', 'lmp_hs_z6', 1, '', '', 2.200, 2.200, 2.20, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (712, '龙虎-龙', 'ssc', 'lmp_lh_l', 1, '', '', 1.950, 1.950, 1.95, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (713, '龙虎-虎', 'ssc', 'lmp_lh_hu', 1, '', '', 1.950, 1.950, 1.95, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (714, '龙虎-和', 'ssc', 'lmp_lh_he', 1, '', '', 9.500, 9.500, 9.50, 0, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (715, '冠军-大', 'pk10', 'lmp_d1m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (716, '冠军-小', 'pk10', 'lmp_d1m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (717, '冠军-单', 'pk10', 'lmp_d1m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (718, '冠军-双', 'pk10', 'lmp_d1m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (719, '冠军-龙', 'pk10', 'lmp_d1m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (720, '冠军-虎', 'pk10', 'lmp_d1m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (721, '亚军-大', 'pk10', 'lmp_d2m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 30000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (722, '亚军-小', 'pk10', 'lmp_d2m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (723, '亚军-单', 'pk10', 'lmp_d2m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (724, '亚军-双', 'pk10', 'lmp_d2m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (725, '亚军-龙', 'pk10', 'lmp_d2m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (726, '亚军-虎', 'pk10', 'lmp_d2m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (727, '第三名-大', 'pk10', 'lmp_d3m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (728, '第三名-小', 'pk10', 'lmp_d3m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (729, '第三名-单', 'pk10', 'lmp_d3m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (730, '第三名-双', 'pk10', 'lmp_d3m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (731, '第三名-龙', 'pk10', 'lmp_d3m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (732, '第三名-虎', 'pk10', 'lmp_d3m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (733, '第四名-大', 'pk10', 'lmp_d4m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (734, '第四名-小', 'pk10', 'lmp_d4m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (735, '第四名-单', 'pk10', 'lmp_d4m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (736, '第四名-双', 'pk10', 'lmp_d4m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (737, '第四名-龙', 'pk10', 'lmp_d4m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (738, '第四名-虎', 'pk10', 'lmp_d4m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (739, '第五名-大', 'pk10', 'lmp_d5m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (740, '第五名-小', 'pk10', 'lmp_d5m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (741, '第五名-单', 'pk10', 'lmp_d5m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (742, '第五名-双', 'pk10', 'lmp_d5m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (743, '第五名-龙', 'pk10', 'lmp_d5m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (744, '第五名-虎', 'pk10', 'lmp_d5m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (745, '第六名-大', 'pk10', 'lmp_d6m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (746, '第六名-小', 'pk10', 'lmp_d6m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (747, '第六名-单', 'pk10', 'lmp_d6m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (748, '第六名-双', 'pk10', 'lmp_d6m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (749, '第六名-龙', 'pk10', 'lmp_d6m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (750, '第六名-虎', 'pk10', 'lmp_d6m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (751, '第七名-大', 'pk10', 'lmp_d7m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (752, '第七名-小', 'pk10', 'lmp_d7m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (753, '第七名-单', 'pk10', 'lmp_d7m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (754, '第七名-双', 'pk10', 'lmp_d7m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (755, '第七名-龙', 'pk10', 'lmp_d7m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (756, '第七名-虎', 'pk10', 'lmp_d7m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (757, '第八名-大', 'pk10', 'lmp_d8m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (758, '第八名-小', 'pk10', 'lmp_d8m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (759, '第八名-单', 'pk10', 'lmp_d8m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (760, '第八名-双', 'pk10', 'lmp_d8m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (761, '第八名-龙', 'pk10', 'lmp_d8m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (762, '第八名-虎', 'pk10', 'lmp_d8m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (763, '第九名-大', 'pk10', 'lmp_d9m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (764, '第九名-小', 'pk10', 'lmp_d9m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (765, '第九名-单', 'pk10', 'lmp_d9m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (766, '第九名-双', 'pk10', 'lmp_d9m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (767, '第九名-龙', 'pk10', 'lmp_d9m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (768, '第九名-虎', 'pk10', 'lmp_d9m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (769, '第十名-大', 'pk10', 'lmp_d10m_da', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (770, '第十名-小', 'pk10', 'lmp_d10m_xiao', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (771, '第十名-单', 'pk10', 'lmp_d10m_dan', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (772, '第十名-双', 'pk10', 'lmp_d10m_shuang', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (773, '第十名-龙', 'pk10', 'lmp_d10m_long', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (774, '第十名-虎', 'pk10', 'lmp_d10m_hu', 10, '', '', 1.980, 1.980, 1.98, 10, 1.00, 1000000.00, 3000000.00, '', 1);
INSERT INTO `caipiao_wanfa` VALUES (775, '冠亚和-号码3', 'pk10', 'gyh_hm3', 1, '', '', 42.300, 42.300, 42.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (776, '冠亚和-号码4', 'pk10', 'gyh_hm4', 1, '', '', 42.300, 42.300, 42.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (777, '冠亚和-号码5', 'pk10', 'gyh_hm5', 1, '', '', 21.300, 21.300, 21.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (778, '冠亚和-号码6', 'pk10', 'gyh_hm6', 1, '', '', 21.300, 21.300, 21.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (779, '冠亚和-号码7', 'pk10', 'gyh_hm7', 1, '', '', 14.300, 14.300, 14.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (780, '冠亚和-号码8', 'pk10', 'gyh_hm8', 1, '', '', 14.300, 14.300, 14.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (781, '冠亚和-号码9', 'pk10', 'gyh_hm9', 1, '', '', 10.300, 10.300, 10.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (782, '冠亚和-号码10', 'pk10', 'gyh_hm10', 1, '', '', 10.300, 10.300, 10.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (783, '冠亚和-号码11', 'pk10', 'gyh_hm11', 1, '', '', 8.300, 8.300, 8.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (784, '冠亚和-号码12', 'pk10', 'gyh_hm12', 1, '', '', 10.300, 10.300, 10.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (785, '冠亚和-号码13', 'pk10', 'gyh_hm13', 1, '', '', 10.300, 10.300, 10.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (786, '冠亚和-号码14', 'pk10', 'gyh_hm14', 1, '', '', 14.300, 14.300, 14.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (787, '冠亚和-号码15', 'pk10', 'gyh_hm15', 1, '', '', 14.300, 14.300, 14.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (788, '冠亚和-号码16', 'pk10', 'gyh_hm16', 1, '', '', 21.300, 21.300, 21.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (789, '冠亚和-号码17', 'pk10', 'gyh_hm17', 1, '', '', 21.300, 21.300, 21.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (790, '冠亚和-号码18', 'pk10', 'gyh_hm18', 1, '', '', 42.300, 42.300, 42.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (791, '冠亚和-号码19', 'pk10', 'gyh_hm19', 1, '', '', 42.300, 42.300, 42.30, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (792, '冠亚和-大', 'pk10', 'gyh_da', 1, '', '', 2.200, 2.200, 2.20, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (793, '冠亚和-小', 'pk10', 'gyh_xiao', 1, '', '', 1.770, 1.770, 1.77, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (794, '冠亚和-单', 'pk10', 'gyh_dan', 1, '', '', 1.770, 1.770, 1.77, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (795, '冠亚和-双', 'pk10', 'gyh_shuang', 1, '', '', 2.200, 2.200, 2.20, 1, 1.00, 10000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (796, '一至五名-冠军-号码1', 'pk10', 'yzwm_d1m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (797, '一至五名-冠军-号码2', 'pk10', 'yzwm_d1m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (798, '一至五名-冠军-号码3', 'pk10', 'yzwm_d1m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (799, '一至五名-冠军-号码4', 'pk10', 'yzwm_d1m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (800, '一至五名-冠军-号码5', 'pk10', 'yzwm_d1m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (801, '一至五名-冠军-号码6', 'pk10', 'yzwm_d1m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (802, '一至五名-冠军-号码7', 'pk10', 'yzwm_d1m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (803, '一至五名-冠军-号码8', 'pk10', 'yzwm_d1m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (804, '一至五名-冠军-号码9', 'pk10', 'yzwm_d1m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (805, '一至五名-冠军-号码10', 'pk10', 'yzwm_d1m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (806, '一至五名-亚军-号码1', 'pk10', 'yzwm_d2m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (807, '一至五名-亚军-号码2', 'pk10', 'yzwm_d2m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (808, '一至五名-亚军-号码3', 'pk10', 'yzwm_d2m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (809, '一至五名-亚军-号码4', 'pk10', 'yzwm_d2m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (810, '一至五名-亚军-号码5', 'pk10', 'yzwm_d2m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (811, '一至五名-亚军-号码6', 'pk10', 'yzwm_d2m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (812, '一至五名-亚军-号码7', 'pk10', 'yzwm_d2m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (813, '一至五名-亚军-号码8', 'pk10', 'yzwm_d2m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (814, '一至五名-亚军-号码9', 'pk10', 'yzwm_d2m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (815, '一至五名-亚军-号码10', 'pk10', 'yzwm_d2m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (816, '一至五名-第三名-号码1', 'pk10', 'yzwm_d3m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (817, '一至五名-第三名-号码2', 'pk10', 'yzwm_d3m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (818, '一至五名-第三名-号码3', 'pk10', 'yzwm_d3m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (819, '一至五名-第三名-号码4', 'pk10', 'yzwm_d3m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (820, '一至五名-第三名-号码5', 'pk10', 'yzwm_d3m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (821, '一至五名-第三名-号码6', 'pk10', 'yzwm_d3m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (822, '一至五名-第三名-号码7', 'pk10', 'yzwm_d3m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (823, '一至五名-第三名-号码8', 'pk10', 'yzwm_d3m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (824, '一至五名-第三名-号码9', 'pk10', 'yzwm_d3m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (825, '一至五名-第三名-号码10', 'pk10', 'yzwm_d3m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (826, '一至五名-第四名-号码1', 'pk10', 'yzwm_d4m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (827, '一至五名-第四名-号码2', 'pk10', 'yzwm_d4m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (828, '一至五名-第四名-号码3', 'pk10', 'yzwm_d4m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (829, '一至五名-第四名-号码4', 'pk10', 'yzwm_d4m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (830, '一至五名-第四名-号码5', 'pk10', 'yzwm_d4m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (831, '一至五名-第四名-号码6', 'pk10', 'yzwm_d4m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (832, '一至五名-第四名-号码7', 'pk10', 'yzwm_d4m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (833, '一至五名-第四名-号码8', 'pk10', 'yzwm_d4m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (834, '一至五名-第四名-号码9', 'pk10', 'yzwm_d4m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (835, '一至五名-第四名-号码10', 'pk10', 'yzwm_d4m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (836, '一至五名-第五名-号码1', 'pk10', 'yzwm_d5m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (837, '一至五名-第五名-号码2', 'pk10', 'yzwm_d5m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (838, '一至五名-第五名-号码3', 'pk10', 'yzwm_d5m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (839, '一至五名-第五名-号码4', 'pk10', 'yzwm_d5m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (840, '一至五名-第五名-号码5', 'pk10', 'yzwm_d5m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (841, '一至五名-第五名-号码6', 'pk10', 'yzwm_d5m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (842, '一至五名-第五名-号码7', 'pk10', 'yzwm_d5m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (843, '一至五名-第五名-号码8', 'pk10', 'yzwm_d5m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (844, '一至五名-第五名-号码9', 'pk10', 'yzwm_d5m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (845, '一至五名-第五名-号码10', 'pk10', 'yzwm_d5m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (846, '六至十名-第六名-号码1', 'pk10', 'yzwm_d6m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (847, '六至十名-第六名-号码2', 'pk10', 'yzwm_d6m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (848, '六至十名-第六名-号码3', 'pk10', 'yzwm_d6m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (849, '六至十名-第六名-号码4', 'pk10', 'yzwm_d6m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (850, '六至十名-第六名-号码5', 'pk10', 'yzwm_d6m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (851, '六至十名-第六名-号码6', 'pk10', 'yzwm_d6m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (852, '六至十名-第六名-号码7', 'pk10', 'yzwm_d6m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (853, '六至十名-第六名-号码8', 'pk10', 'yzwm_d6m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (854, '六至十名-第六名-号码9', 'pk10', 'yzwm_d6m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (855, '六至十名-第六名-号码10', 'pk10', 'yzwm_d6m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (856, '六至十名-第七名-号码1', 'pk10', 'yzwm_d7m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (857, '六至十名-第七名-号码2', 'pk10', 'yzwm_d7m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (858, '六至十名-第七名-号码3', 'pk10', 'yzwm_d7m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (859, '六至十名-第七名-号码4', 'pk10', 'yzwm_d7m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (860, '六至十名-第七名-号码5', 'pk10', 'yzwm_d7m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (861, '六至十名-第七名-号码6', 'pk10', 'yzwm_d7m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (862, '六至十名-第七名-号码7', 'pk10', 'yzwm_d7m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (863, '六至十名-第七名-号码8', 'pk10', 'yzwm_d7m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (864, '六至十名-第七名-号码9', 'pk10', 'yzwm_d7m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (865, '六至十名-第七名-号码10', 'pk10', 'yzwm_d7m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (866, '六至十名-第八名-号码1', 'pk10', 'yzwm_d8m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (867, '六至十名-第八名-号码2', 'pk10', 'yzwm_d8m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (868, '六至十名-第八名-号码3', 'pk10', 'yzwm_d8m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (869, '六至十名-第八名-号码4', 'pk10', 'yzwm_d8m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (870, '六至十名-第八名-号码5', 'pk10', 'yzwm_d8m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (871, '六至十名-第八名-号码6', 'pk10', 'yzwm_d8m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (872, '六至十名-第八名-号码7', 'pk10', 'yzwm_d8m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (873, '六至十名-第八名-号码8', 'pk10', 'yzwm_d8m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (874, '六至十名-第八名-号码9', 'pk10', 'yzwm_d8m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (875, '六至十名-第九名-号码10', 'pk10', 'yzwm_d8m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (876, '六至十名-第九名-号码1', 'pk10', 'yzwm_d9m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (877, '六至十名-第九名-号码2', 'pk10', 'yzwm_d9m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (878, '六至十名-第九名-号码3', 'pk10', 'yzwm_d9m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 30000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (879, '六至十名-第九名-号码4', 'pk10', 'yzwm_d9m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (880, '六至十名-第九名-号码5', 'pk10', 'yzwm_d9m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (881, '六至十名-第九名-号码6', 'pk10', 'yzwm_d9m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (882, '六至十名-第九名-号码7', 'pk10', 'yzwm_d9m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (883, '六至十名-第九名-号码8', 'pk10', 'yzwm_d9m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (884, '六至十名-第九名-号码9', 'pk10', 'yzwm_d9m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (885, '六至十名-第九名-号码10', 'pk10', 'yzwm_d9m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (886, '六至十名-第十名-号码1', 'pk10', 'yzwm_d10m_hm1', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (887, '六至十名-第十名-号码2', 'pk10', 'yzwm_d10m_hm2', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (888, '六至十名-第十名-号码3', 'pk10', 'yzwm_d10m_hm3', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (889, '六至十名-第十名-号码4', 'pk10', 'yzwm_d10m_hm4', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (890, '六至十名-第十名-号码5', 'pk10', 'yzwm_d10m_hm5', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (891, '六至十名-第十名-号码6', 'pk10', 'yzwm_d10m_hm6', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (892, '六至十名-第十名-号码7', 'pk10', 'yzwm_d10m_hm7', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (893, '六至十名-第十名-号码8', 'pk10', 'yzwm_d10m_hm8', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (894, '六至十名-第十名-号码9', 'pk10', 'yzwm_d10m_hm9', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
INSERT INTO `caipiao_wanfa` VALUES (895, '六至十名-第十名-号码10', 'pk10', 'yzwm_d10m_hm10', 10, '', '', 9.800, 9.800, 9.80, 10, 1.00, 1000000.00, 3000000.00, ' ', 1);
COMMIT;

-- ----------------------------
-- Table structure for caipiao_waterlog
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_waterlog`;
CREATE TABLE `caipiao_waterlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `username` char(80) NOT NULL,
  `amount` decimal(10,2) NOT NULL COMMENT '返水金额',
  `valid_bet_amount` decimal(10,2) NOT NULL COMMENT '有效投注金额',
  `water_rate` char(5) NOT NULL COMMENT '返水比例',
  `date` char(10) NOT NULL COMMENT '返水日期',
  `created_at` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='用户返水记录';


-- ----------------------------
-- Table structure for caipiao_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_withdraw`;
CREATE TABLE `caipiao_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `username` char(30) NOT NULL,
  `trano` char(60) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `actualamount` decimal(12,2) NOT NULL COMMENT '实到金额',
  `oldaccountmoney` decimal(12,2) NOT NULL COMMENT '提款前金额',
  `newaccountmoney` decimal(12,2) NOT NULL COMMENT '提款后金额',
  `fee` decimal(12,2) NOT NULL COMMENT '手续费',
  `accountname` varchar(30) NOT NULL COMMENT '银行真实姓名',
  `bankname` varchar(30) NOT NULL COMMENT '银行名称',
  `bankbranch` varchar(40) NOT NULL COMMENT '开户网点',
  `banknumber` char(30) NOT NULL COMMENT '银行账号',
  `remark` varchar(155) NOT NULL,
  `oddtime` int(11) NOT NULL,
  `state` tinyint(4) NOT NULL COMMENT '0未审核 1已审核 -1退回取消',
  `stateadmin` char(30) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `trano` (`trano`) USING BTREE,
  KEY `state` (`state`) USING BTREE,
  KEY `oddtime` (`oddtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for caipiao_xiaoxi
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_xiaoxi`;
CREATE TABLE `caipiao_xiaoxi` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `uid` int(20) NOT NULL,
  `tit` varchar(500) CHARACTER SET utf8 NOT NULL,
  `body` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `time` int(11) NOT NULL COMMENT '发送时间',
  `status` int(11) NOT NULL DEFAULT '2' COMMENT '状态:2为未读,1为已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for caipiao_yanchi
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_yanchi`;
CREATE TABLE `caipiao_yanchi` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `time` int(15) NOT NULL,
  `typeid` varchar(11) NOT NULL,
  `state` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


-- ----------------------------
-- Table structure for caipiao_yukaijiang
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_yukaijiang`;
CREATE TABLE `caipiao_yukaijiang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(30) NOT NULL COMMENT '彩票标识',
  `opencode` char(180) NOT NULL COMMENT '开奖号码',
  `expect` char(60) NOT NULL COMMENT '期号',
  `stateadmin` char(20) DEFAULT NULL,
  `opentime` int(11) NOT NULL COMMENT '开奖时间',
  `hid` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `expect` (`expect`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预开奖管理';

-- ----------------------------
-- Table structure for caipiao_zr_game_order
-- ----------------------------
DROP TABLE IF EXISTS `caipiao_zr_game_order`;
CREATE TABLE `caipiao_zr_game_order` (
  `id` varchar(50) NOT NULL COMMENT '注单ID',
  `game_type_id` varchar(10) DEFAULT NULL COMMENT '游戏ID',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏名称',
  `round_id` varchar(50) DEFAULT NULL COMMENT '牌局ID',
  `round_no` varchar(200) DEFAULT NULL COMMENT '牌局编号',
  `table_code` varchar(20) DEFAULT NULL COMMENT '游戏桌号',
  `platform_name` varchar(200) DEFAULT NULL COMMENT '厅名称',
  `platform_id` varchar(100) DEFAULT NULL COMMENT '厅 id',
  `series_id` bigint(20) DEFAULT NULL COMMENT '彩系id',
  `series_name` varchar(200) DEFAULT NULL COMMENT '彩系名称',
  `bet_amount` decimal(20,4) DEFAULT NULL COMMENT '投注额',
  `valid_bet_amount` decimal(20,4) DEFAULT NULL COMMENT '有效投注额',
  `net_amount` decimal(20,4) DEFAULT NULL COMMENT '输赢金额',
  `pumping_amount` decimal(20,4) DEFAULT NULL COMMENT '抽水',
  `pay_amount` decimal(20,4) DEFAULT NULL COMMENT '派彩额',
  `before_amount` decimal(20,4) DEFAULT NULL COMMENT '下注前余额',
  `currency` varchar(10) DEFAULT NULL COMMENT '币种',
  `create_at` bigint(20) DEFAULT NULL COMMENT '开始时间=当前该注单的投注时间 或该注单创建时间',
  `net_at` bigint(20) DEFAULT NULL COMMENT '结束时间=当前注单被结算的时间',
  `recalcu_at` bigint(20) DEFAULT NULL COMMENT '注单重新结算时间',
  `updated_at` bigint(20) DEFAULT NULL COMMENT '更新时间  如果更新了盘口的状态时间',
  `match_start_time` bigint(20) DEFAULT NULL COMMENT '比赛开始时间',
  `cancel_at` bigint(20) DEFAULT NULL COMMENT '注单撤销时间',
  `risk_unlock_at` bigint(20) DEFAULT NULL COMMENT '风控解锁时间',
  `player_name` varchar(100) DEFAULT NULL COMMENT '玩家账号',
  `nick_name` varchar(200) DEFAULT NULL COMMENT '昵称',
  `player_id` varchar(20) DEFAULT NULL COMMENT '玩家编号',
  `device_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '玩家IP',
  `agent_code` varchar(20) DEFAULT NULL COMMENT '商户编号',
  `agent_id` varchar(50) DEFAULT NULL COMMENT '商户ID',
  `agent_name` varchar(500) DEFAULT NULL COMMENT '商户名称',
  `parent_agent_id` varchar(50) DEFAULT NULL COMMENT '父商户ID',
  `parent_agent_code` varchar(20) DEFAULT NULL COMMENT '父商户编号',
  `bet_status` int(11) DEFAULT NULL COMMENT '注单状态',
  `order_type` int(11) DEFAULT NULL COMMENT '注单类型',
  `cancel_status` int(11) DEFAULT NULL COMMENT '撤单标志',
  `cancel_type` int(11) DEFAULT NULL COMMENT '撤单类型',
  `signature` varchar(100) DEFAULT NULL COMMENT '签名',
  `table_name` varchar(100) DEFAULT NULL COMMENT '桌台名',
  `is_tester` int(11) DEFAULT NULL COMMENT '是否正式账户',
  `play_options_id` varchar(20) DEFAULT NULL COMMENT '投注项ID',
  `play_option_name` text COMMENT '投注项名称',
  `odds_value` varchar(500) DEFAULT NULL COMMENT '赔率',
  `play_id` bigint(20) DEFAULT NULL COMMENT '玩法ID',
  `play_name` varchar(50) DEFAULT NULL COMMENT '玩法名称',
  `play_level_id` varchar(10) DEFAULT NULL COMMENT '玩法级ID',
  `play_level` varchar(20) DEFAULT NULL COMMENT '玩法群名',
  `data_source` varchar(5) DEFAULT NULL COMMENT '注单来源',
  `bd_load_time` bigint(20) DEFAULT NULL COMMENT 'B端同步时间',
  `bd_update_time` bigint(20) DEFAULT NULL COMMENT 'B端修改时间',
  `bet_flag` int(11) DEFAULT NULL COMMENT '重算标志',
  `judge_result` varchar(100) DEFAULT NULL COMMENT '局结果',
  `boot_no` varchar(50) DEFAULT NULL COMMENT '靴号',
  `device_id` varchar(50) DEFAULT NULL COMMENT '设备 id ',
  `record_type` int(11) DEFAULT NULL COMMENT '注单类别',
  `game_mode` int(11) DEFAULT NULL COMMENT '游戏模式  ',
  `dealer_name` varchar(30) DEFAULT NULL COMMENT '荷官名称',
  `judge_result_cn` varchar(100) DEFAULT NULL COMMENT '扩展字段',
  `judge_result1` varchar(100) DEFAULT NULL COMMENT '扩展字段',
  `dama_amount` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '已记录打码金额',
  `dama_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打码状态，已计入打码完成',
  `details` text COMMENT '注单详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
