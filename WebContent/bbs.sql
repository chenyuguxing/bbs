/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 5.0.96-community-nt : Database - bbs
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bbs` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bbs`;

/*Table structure for table `attachment` */

DROP TABLE IF EXISTS `attachment`;

CREATE TABLE `attachment` (
  `attachment_id` int(11) NOT NULL auto_increment,
  `post_id` int(11) NOT NULL,
  `name` varchar(100) default NULL COMMENT 'åç§°',
  `description` varchar(255) default NULL COMMENT 'æè¿°',
  `file_path` varchar(100) default NULL COMMENT 'è·¯å¾„',
  `file_name` varchar(100) default NULL COMMENT 'æ–‡ä»¶åç§°',
  `file_size` int(11) default NULL COMMENT 'å¤§å°',
  `is_pictrue` tinyint(1) default '0' COMMENT 'æ˜¯å¦æ˜¯å›¾ç‰‡',
  `create_time` datetime default NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  PRIMARY KEY  (`attachment_id`),
  KEY `FK_attachment_post` (`post_id`),
  CONSTRAINT `FK_attachment_post` FOREIGN KEY (`post_id`) REFERENCES `bbs_post` (`POST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attachment` */

/*Table structure for table `bbs_category` */

DROP TABLE IF EXISTS `bbs_category`;

CREATE TABLE `bbs_category` (
  `CATEGORY_ID` int(11) NOT NULL auto_increment,
  `SITE_ID` int(11) NOT NULL,
  `PATH` varchar(20) NOT NULL COMMENT 'è®¿é—®è·¯å¾„',
  `TITLE` varchar(100) NOT NULL COMMENT 'æ ‡é¢˜',
  `PRIORITY` int(11) NOT NULL default '10' COMMENT 'æŽ’åˆ—é¡ºåº',
  `FORUM_COLS` int(11) NOT NULL default '1' COMMENT 'æ¿å—åˆ—æ•°',
  `moderators` varchar(100) default NULL,
  PRIMARY KEY  (`CATEGORY_ID`),
  KEY `FK_BBS_CTG_SITE` (`SITE_ID`),
  CONSTRAINT `FK_BBS_CTG_SITE` FOREIGN KEY (`SITE_ID`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='è®ºå›åˆ†åŒº';

/*Data for the table `bbs_category` */

insert  into `bbs_category`(`CATEGORY_ID`,`SITE_ID`,`PATH`,`TITLE`,`PRIORITY`,`FORUM_COLS`,`moderators`) values (1,1,'service','≡产品服务区≡',0,1,''),(2,1,'use','≡使用交流区≡',0,1,''),(3,1,'Technology','≡技术交流区≡',0,6,'test'),(4,1,'other','≡生活灌水区≡',0,1,''),(5,1,'test1','测试分区',7,1,'');

/*Table structure for table `bbs_category_user` */

DROP TABLE IF EXISTS `bbs_category_user`;

CREATE TABLE `bbs_category_user` (
  `CATEGORY_ID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`CATEGORY_ID`,`user_id`),
  KEY `FK_BBS_CATEGORY_TO_USER` (`user_id`),
  CONSTRAINT `FK_BBS_CATEGORY_TO_USER` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_USER_TO_CATEGORY` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `bbs_category` (`CATEGORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='åˆ†åŒºç‰ˆä¸»';

/*Data for the table `bbs_category_user` */

/*Table structure for table `bbs_common_magic` */

DROP TABLE IF EXISTS `bbs_common_magic`;

CREATE TABLE `bbs_common_magic` (
  `magicid` smallint(6) NOT NULL auto_increment COMMENT 'é“å…·id',
  `available` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¯ç”¨',
  `name` varchar(50) NOT NULL COMMENT 'åç§°',
  `identifier` varchar(40) NOT NULL COMMENT 'å”¯ä¸€æ ‡è¯†',
  `description` varchar(255) NOT NULL COMMENT 'æè¿°',
  `displayorder` tinyint(3) NOT NULL default '0' COMMENT 'é¡ºåº',
  `credit` tinyint(1) NOT NULL default '0' COMMENT 'ä½¿ç”¨çš„ç§¯åˆ†',
  `price` mediumint(8) unsigned NOT NULL default '0' COMMENT 'ä»·æ ¼',
  `num` smallint(6) unsigned NOT NULL default '0' COMMENT 'æ•°é‡',
  `salevolume` smallint(6) unsigned NOT NULL default '0' COMMENT 'é”€å”®é‡',
  `supplytype` tinyint(1) NOT NULL default '0' COMMENT 'è‡ªåŠ¨è¡¥è´§ç±»åž‹',
  `supplynum` smallint(6) unsigned NOT NULL default '0' COMMENT 'è‡ªåŠ¨è¡¥è´§æ•°é‡',
  `useperoid` tinyint(1) NOT NULL default '0' COMMENT 'ä½¿ç”¨å‘¨æœŸ',
  `usenum` smallint(6) unsigned NOT NULL default '0' COMMENT 'å‘¨æœŸä½¿ç”¨æ•°é‡',
  `weight` tinyint(3) unsigned NOT NULL default '1' COMMENT 'é‡é‡',
  `useevent` tinyint(1) NOT NULL default '0' COMMENT '0:åªåœ¨ç‰¹å®šçŽ¯å¢ƒä½¿ç”¨ 1:å¯ä»¥åœ¨é“å…·ä¸­å¿ƒä½¿ç”¨',
  PRIMARY KEY  (`magicid`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `displayorder` (`available`,`displayorder`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='é“å…·æ•°æ®è¡¨';

/*Data for the table `bbs_common_magic` */

insert  into `bbs_common_magic`(`magicid`,`available`,`name`,`identifier`,`description`,`displayorder`,`credit`,`price`,`num`,`salevolume`,`supplytype`,`supplynum`,`useperoid`,`usenum`,`weight`,`useevent`) values (1,1,'喧嚣卡','open','可以将主题开启，可以回复',0,1,10,0,0,2,0,2,0,10,0),(2,1,'悔悟卡','repent','可以删除自己的帖子',0,2,10,2,0,1,0,1,0,10,0),(3,1,'照妖镜','namepost','可以查看一次匿名用户的真实身份。',0,1,10,1,0,1,0,1,0,10,0),(4,1,'金钱卡','money','可以随机获得一些金币',0,2,10,44,0,1,0,1,0,10,1),(5,1,'千斤顶','jack','可以将主题顶起一段时间，重复使用可延长帖子被顶起的时间',0,1,10,0,0,0,0,0,0,10,0),(6,1,'窥视卡','showip','可以查看指定用户的 IP',0,1,10,1,0,1,0,1,0,10,1),(7,1,'抢沙发','sofa','可以抢夺指定主题的沙发',0,1,10,0,0,0,0,0,0,10,0),(8,1,'置顶卡','stick','可以将主题置顶',0,1,10,0,0,0,0,0,0,10,0),(9,1,'变色卡','highlight','可以将帖子或日志的标题高亮，变更颜色',0,1,10,2,0,0,0,0,0,10,0),(10,1,'雷达卡','checkonline','查看某个用户是否在线',0,1,10,1,0,1,0,1,0,10,1),(11,1,'沉默卡','close','可以将主题关闭，禁止回复',0,1,10,2,100,1,0,1,2,10,0),(12,1,'提升卡','bump','可以提升某个主题',0,1,10,0,0,1,0,1,0,10,0),(13,1,'匿名卡','anonymouspost','在指定的地方，让自己的名字显示为匿名。',0,1,10,0,0,0,0,0,0,10,0);

/*Table structure for table `bbs_config` */

DROP TABLE IF EXISTS `bbs_config`;

CREATE TABLE `bbs_config` (
  `CONFIG_ID` bigint(20) NOT NULL,
  `DEF_AVATAR` varchar(100) NOT NULL default '' COMMENT 'é»˜è®¤ä¼šå‘˜å¤´åƒ',
  `AVATAR_WIDTH` int(11) NOT NULL default '160' COMMENT 'å¤´åƒæœ€å¤§å®½åº¦',
  `AVATAR_HEIGHT` int(11) NOT NULL default '160' COMMENT 'å¤´åƒæœ€å¤§é«˜åº¦',
  `TOPIC_COUNT_PER_PAGE` int(11) NOT NULL default '20' COMMENT 'æ¯é¡µä¸»é¢˜æ•°',
  `POST_COUNT_PER_PAGE` int(11) NOT NULL default '10' COMMENT 'æ¯é¡µå¸–å­æ•°',
  `KEYWORDS` varchar(255) NOT NULL default '' COMMENT 'é¦–é¡µå…³é”®å­—',
  `DESCRIPTION` varchar(255) NOT NULL default '' COMMENT 'é¦–é¡µæè¿°',
  `REGISTER_STATUS` smallint(6) NOT NULL default '1' COMMENT 'æ³¨å†ŒçŠ¶æ€ï¼ˆ0ï¼šå…³é—­ï¼Œ1ï¼šå¼€æ”¾ï¼Œ2ï¼šé‚€è¯·ï¼‰',
  `REGISTER_GROUP_ID` int(11) NOT NULL default '1' COMMENT 'æ³¨å†Œä¼šå‘˜ç»„',
  `REGISTER_RULE` longtext COMMENT 'æ³¨å†Œåè®®',
  `CACHE_POST_TODAY` int(11) NOT NULL default '0' COMMENT 'ä»Šæ—¥è´´æ•°',
  `CACHE_POST_YESTERDAY` int(11) NOT NULL default '0' COMMENT 'æ˜¨æ—¥å¸–æ•°',
  `CACHE_POST_MAX` int(11) NOT NULL default '0' COMMENT 'æœ€é«˜å¸–æ•°',
  `CACHE_POST_MAX_DATE` date NOT NULL COMMENT 'æœ€é«˜å¸–æ•°æ—¥',
  `CACHE_TOPIC_TOTAL` int(11) NOT NULL default '0' COMMENT 'æ€»ä¸»é¢˜',
  `CACHE_POST_TOTAL` int(11) NOT NULL default '0' COMMENT 'æ€»å¸–æ•°',
  `CACHE_USER_TOTAL` int(11) NOT NULL default '0' COMMENT 'æ€»ä¼šå‘˜',
  `last_user_id` int(11) default NULL COMMENT 'æœ€æ–°ä¼šå‘˜',
  `site_id` int(11) NOT NULL,
  `DEFAULT_GROUP_ID` bigint(20) NOT NULL default '1' COMMENT 'é»˜è®¤ä¼šå‘˜ç»„',
  `TOPIC_HOT_COUNT` int(11) NOT NULL default '10' COMMENT 'çƒ­å¸–å›žå¤æ•°é‡',
  `AUTO_REGISTER` tinyint(1) default '1' COMMENT 'æ˜¯å¦è‡ªåŠ¨æ³¨å†Œ',
  `EMAIL_VALIDATE` tinyint(1) default '0' COMMENT 'å¼€å¯é‚®ç®±éªŒè¯',
  PRIMARY KEY  (`CONFIG_ID`),
  KEY `FK_BBS_CONFIG_SITE` (`site_id`),
  CONSTRAINT `FK_BBS_CONFIG_SITE` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='è®ºå›é…ç½®';

/*Data for the table `bbs_config` */

insert  into `bbs_config`(`CONFIG_ID`,`DEF_AVATAR`,`AVATAR_WIDTH`,`AVATAR_HEIGHT`,`TOPIC_COUNT_PER_PAGE`,`POST_COUNT_PER_PAGE`,`KEYWORDS`,`DESCRIPTION`,`REGISTER_STATUS`,`REGISTER_GROUP_ID`,`REGISTER_RULE`,`CACHE_POST_TODAY`,`CACHE_POST_YESTERDAY`,`CACHE_POST_MAX`,`CACHE_POST_MAX_DATE`,`CACHE_TOPIC_TOTAL`,`CACHE_POST_TOTAL`,`CACHE_USER_TOTAL`,`last_user_id`,`site_id`,`DEFAULT_GROUP_ID`,`TOPIC_HOT_COUNT`,`AUTO_REGISTER`,`EMAIL_VALIDATE`) values (1,'1',160,160,20,10,'cdsndu','cdsndu',1,1,'',7,0,7,'2011-10-15',7,0,1,10,1,1,10,1,0);

/*Table structure for table `bbs_credit_exchange` */

DROP TABLE IF EXISTS `bbs_credit_exchange`;

CREATE TABLE `bbs_credit_exchange` (
  `eid` int(11) NOT NULL default '0',
  `expoint` int(11) NOT NULL default '0' COMMENT 'å…‘æ¢æ¯”çŽ‡ç§¯åˆ†åŸºæ•°',
  `exprestige` int(11) NOT NULL default '0' COMMENT 'å…‘æ¢æ¯”çŽ‡å¨æœ›åŸºæ•°',
  `pointoutavailable` tinyint(1) NOT NULL default '0' COMMENT 'ç§¯åˆ†æ˜¯å¦å¯ä»¥å…‘å‡º',
  `pointinavailable` tinyint(1) NOT NULL default '0' COMMENT 'ç§¯åˆ†æ˜¯å¦å…è®¸å…‘å…¥',
  `prestigeoutavailable` tinyint(3) NOT NULL default '0' COMMENT 'å¨æœ›æ˜¯å¦å…è®¸å…‘å‡º',
  `prestigeinavailable` tinyint(1) NOT NULL default '0' COMMENT 'å¨æœ›æ˜¯å¦å…è®¸å…‘å…¥',
  `exchangetax` float(2,1) NOT NULL default '0.0' COMMENT 'å…‘æ¢äº¤æ˜“ç¨Ž',
  `mini_balance` int(11) NOT NULL default '0' COMMENT 'å…‘æ¢æœ€ä½Žä½™é¢',
  PRIMARY KEY  (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ç§¯åˆ†äº¤æ˜“è§„åˆ™';

/*Data for the table `bbs_credit_exchange` */

insert  into `bbs_credit_exchange`(`eid`,`expoint`,`exprestige`,`pointoutavailable`,`pointinavailable`,`prestigeoutavailable`,`prestigeinavailable`,`exchangetax`,`mini_balance`) values (1,1,10,1,1,1,1,0.2,0);

/*Table structure for table `bbs_credit_rule` */

DROP TABLE IF EXISTS `bbs_credit_rule`;

CREATE TABLE `bbs_credit_rule` (
  `rid` int(11) NOT NULL auto_increment COMMENT 'è§„åˆ™ID',
  `rulename` varchar(20) NOT NULL default '' COMMENT 'è§„åˆ™åç§°',
  `action` varchar(50) NOT NULL default '' COMMENT 'è§„åˆ™actionå”¯ä¸€KEY',
  `cycletype` tinyint(1) NOT NULL default '0' COMMENT 'å¥–åŠ±å‘¨æœŸ0:ä¸€æ¬¡;1:æ¯å¤©;2:æ•´ç‚¹;3:é—´éš”åˆ†é’Ÿ;4:ä¸é™;',
  `cycletime` int(10) NOT NULL default '0' COMMENT 'é—´éš”æ—¶é—´',
  `rewardnum` tinyint(2) NOT NULL default '1' COMMENT 'å¥–åŠ±æ¬¡æ•°',
  `extcredits1` int(10) NOT NULL default '0' COMMENT 'æ‰©å±•1',
  `extcredits2` int(10) NOT NULL default '0' COMMENT 'æ‰©å±•2',
  `extcredits3` int(10) NOT NULL default '0' COMMENT 'æ‰©å±•3',
  `extcredits4` int(10) NOT NULL default '0' COMMENT 'æ‰©å±•4',
  `ext1name` varchar(20) default NULL COMMENT 'æ‰©å±•1åˆ«å',
  `ext2name` varchar(20) default NULL COMMENT 'æ‰©å±•2åˆ«å',
  `ext3name` varchar(20) default NULL COMMENT 'æ‰©å±•3åˆ«å',
  `ext4name` varchar(20) default NULL COMMENT 'æ‰©å±•4åˆ«å',
  `ext1avai` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¯ç”¨\n(0:ä¸å¯ç”¨ 1:å¯ç”¨ä½†ä¸æ˜¾ç¤º 2:å¯ç”¨å¹¶æ˜¾ç¤º)',
  `ext2avai` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¯ç”¨\n(0:ä¸å¯ç”¨ 1:å¯ç”¨ä½†ä¸æ˜¾ç¤º 2:å¯ç”¨å¹¶æ˜¾ç¤º)',
  `ext3avai` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¯ç”¨\n(0:ä¸å¯ç”¨ 1:å¯ç”¨ä½†ä¸æ˜¾ç¤º 2:å¯ç”¨å¹¶æ˜¾ç¤º)',
  `ext4avai` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¯ç”¨\n(0:ä¸å¯ç”¨ 1:å¯ç”¨ä½†ä¸æ˜¾ç¤º 2:å¯ç”¨å¹¶æ˜¾ç¤º)',
  `ext1exchangeout` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å‡º',
  `ext2exchangeout` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å‡º',
  `ext3exchangeout` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å‡º',
  `ext4exchangeout` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å‡º',
  `ext1exchangein` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å…¥',
  `ext2exchangein` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å…¥',
  `ext3exchangein` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å…¥',
  `ext4exchangein` tinyint(1) default '0' COMMENT 'ç§¯åˆ†å…‘å…¥',
  `credittax` tinyint(2) default NULL COMMENT 'ç§¯åˆ†äº¤æ˜“ç¨Ž',
  `minibalance` int(10) default NULL COMMENT 'å…‘æ¢æœ€ä½Žä½™é¢',
  PRIMARY KEY  (`rid`),
  UNIQUE KEY `action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COMMENT='ç§¯åˆ†è§„åˆ™è¡¨';

/*Data for the table `bbs_credit_rule` */

/*Table structure for table `bbs_forum` */

DROP TABLE IF EXISTS `bbs_forum`;

CREATE TABLE `bbs_forum` (
  `FORUM_ID` int(11) NOT NULL auto_increment,
  `CATEGORY_ID` int(11) NOT NULL COMMENT 'åˆ†åŒºID',
  `SITE_ID` int(11) NOT NULL COMMENT 'ç«™ç‚¹ID',
  `POST_ID` int(11) default NULL COMMENT 'æœ€åŽå›žå¸–',
  `replyer_id` int(11) default NULL COMMENT 'æœ€åŽå›žå¸–ä¼šå‘˜',
  `PATH` varchar(20) NOT NULL COMMENT 'è®¿é—®è·¯å¾„',
  `TITLE` varchar(150) NOT NULL COMMENT 'æ ‡é¢˜',
  `DESCRIPTION` varchar(255) default NULL COMMENT 'æè¿°',
  `KEYWORDS` varchar(255) default NULL COMMENT 'meta-keywords',
  `FORUM_RULE` varchar(255) default NULL COMMENT 'ç‰ˆè§„',
  `PRIORITY` int(11) NOT NULL default '10' COMMENT 'æŽ’åˆ—é¡ºåº',
  `TOPIC_TOTAL` int(11) NOT NULL default '0' COMMENT 'ä¸»é¢˜æ€»æ•°',
  `POST_TOTAL` int(11) NOT NULL default '0' COMMENT 'å¸–å­æ€»æ•°',
  `POST_TODAY` int(11) NOT NULL default '0' COMMENT 'ä»Šæ—¥æ–°å¸–',
  `OUTER_URL` varchar(255) default NULL COMMENT 'å¤–éƒ¨é“¾æŽ¥',
  `POINT_TOPIC` int(11) NOT NULL default '0' COMMENT 'å‘è´´åŠ åˆ†',
  `POINT_REPLY` int(11) NOT NULL default '0' COMMENT 'å›žå¸–åŠ åˆ†',
  `POINT_PRIME` int(11) NOT NULL default '0' COMMENT 'ç²¾åŽåŠ åˆ†',
  `LAST_TIME` datetime default NULL COMMENT 'æœ€åŽå‘è´´æ—¶é—´',
  `TOPIC_LOCK_LIMIT` int(11) NOT NULL default '0' COMMENT 'é”å®šä¸»é¢˜ï¼ˆå¤©ï¼‰',
  `moderators` varchar(100) default NULL COMMENT 'ç‰ˆä¸»',
  `group_views` varchar(100) default NULL COMMENT 'è®¿é—®ä¼šå‘˜ç»„',
  `group_topics` varchar(100) default NULL COMMENT 'å‘å¸–ä¼šå‘˜ç»„',
  `group_replies` varchar(100) default NULL COMMENT 'å›žå¤ä¼šå‘˜ç»„',
  `POINT_AVAILABLE` tinyint(1) default NULL COMMENT 'ç§¯åˆ†æ˜¯å¦å¯ç”¨',
  `PRESTIGE_AVAILABLE` tinyint(1) default NULL COMMENT 'å¨æœ›æ˜¯å¦å¯ç”¨',
  `PRESTIGE_TOPIC` int(11) default '0' COMMENT 'å‘å¸–åŠ å¨æœ›',
  `PRESTIGE_REPLY` int(11) default '0' COMMENT 'å›žå¸–åŠ å¨æœ›',
  `PRESTIGE_PRIME1` int(11) default '0' COMMENT 'ç²¾åŽ1åŠ å¨æœ›',
  `PRESTIGE_PRIME2` int(11) default '0' COMMENT 'ç²¾åŽ2åŠ å¨æœ›',
  `PRESTIGE_PRIME3` int(11) default '0' COMMENT 'ç²¾åŽ3åŠ å¨æœ›',
  `PRESTIGE_PRIME0` int(11) default '0' COMMENT 'è§£é™¤ç²¾åŽæ‰£é™¤å¨æœ›',
  PRIMARY KEY  (`FORUM_ID`),
  KEY `FK_BBS_FORUM_CTG` (`CATEGORY_ID`),
  KEY `FK_BBS_FORUM_USER` (`replyer_id`),
  KEY `FK_BBS_FORUM_POST` (`POST_ID`),
  KEY `FK_BBS_FORUM_WEBSITE` (`SITE_ID`),
  CONSTRAINT `FK_BBS_FORUM_CTG` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `bbs_category` (`CATEGORY_ID`),
  CONSTRAINT `FK_BBS_FORUM_POST` FOREIGN KEY (`POST_ID`) REFERENCES `bbs_post` (`POST_ID`),
  CONSTRAINT `FK_BBS_FORUM_USER` FOREIGN KEY (`replyer_id`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_FORUM_WEBSITE` FOREIGN KEY (`SITE_ID`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='è®ºå›æ¿å—';

/*Data for the table `bbs_forum` */

insert  into `bbs_forum`(`FORUM_ID`,`CATEGORY_ID`,`SITE_ID`,`POST_ID`,`replyer_id`,`PATH`,`TITLE`,`DESCRIPTION`,`KEYWORDS`,`FORUM_RULE`,`PRIORITY`,`TOPIC_TOTAL`,`POST_TOTAL`,`POST_TODAY`,`OUTER_URL`,`POINT_TOPIC`,`POINT_REPLY`,`POINT_PRIME`,`LAST_TIME`,`TOPIC_LOCK_LIMIT`,`moderators`,`group_views`,`group_topics`,`group_replies`,`POINT_AVAILABLE`,`PRESTIGE_AVAILABLE`,`PRESTIGE_TOPIC`,`PRESTIGE_REPLY`,`PRESTIGE_PRIME1`,`PRESTIGE_PRIME2`,`PRESTIGE_PRIME3`,`PRESTIGE_PRIME0`) values (4,3,1,NULL,NULL,'web','Web 开发','Web 开发','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(6,3,1,NULL,NULL,'Java','Java','Java','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(7,3,1,1,10,'Mobile','移动开发','移动开发','','',10,1,1,1,'',5,0,100,'2015-07-20 10:57:07',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(9,3,1,2,10,'otherDB','其他数据库开发','其他数据库开发','','',10,1,1,1,'',5,0,100,'2015-07-20 11:11:55',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(10,3,1,NULL,NULL,'HighPerformanceDev','高性能开发','High-performance development','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(11,3,1,NULL,NULL,'net','.NET技术','.NET技术','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(12,3,1,NULL,NULL,'flash','多媒体/设计/Flash/Silverlight 开发','多媒体/设计/Flash/Silverlight 开发','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(13,1,1,NULL,NULL,'mosesPlan','中小企业内部管理平台','中小企业内部管理平台','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(14,1,1,NULL,NULL,'Produce','生产企业内部管理平台','生产企业内部管理平台','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(15,1,1,NULL,NULL,'webSite','企业门户/宣传网站','企业门户/宣传网站','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(16,1,1,NULL,NULL,'B2B','B2B','','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(17,1,1,NULL,NULL,'P2P','P2P','','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(18,1,1,NULL,NULL,'C2C','C2C','','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(19,1,1,NULL,NULL,'B2C','B2C','','','',10,0,0,0,'',5,0,100,NULL,0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(21,2,1,NULL,NULL,'mosesPlan','中小企业内部管理平台','中小企业内部管理平台','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(22,2,1,NULL,NULL,'Produce','生产企业内部管理平台','生产企业内部管理平台','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(23,2,1,NULL,NULL,'webSite','企业门户/宣传网站','企业门户/宣传网站','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(24,2,1,NULL,NULL,'B2B','B2B','','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(25,2,1,NULL,NULL,'P2P','P2P','','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(26,2,1,NULL,NULL,'C2C','C2C','','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(27,2,1,NULL,NULL,'B2C','B2C','','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0),(28,2,1,NULL,NULL,'CustomizedOutsourci','定制/外包','定制/外包','','',10,0,0,0,'',5,0,100,'2015-01-15 16:07:42',0,'',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',',14,1,2,3,4,5,6,7,8,9,10,11,12,13,',1,1,1,0,1,2,3,0);

/*Table structure for table `bbs_forum_group_reply` */

DROP TABLE IF EXISTS `bbs_forum_group_reply`;

CREATE TABLE `bbs_forum_group_reply` (
  `FORUM_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  PRIMARY KEY  (`FORUM_ID`,`GROUP_ID`),
  KEY `FK_BBS_FORUM_GROUP_REPLY` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_FORUM_GROUP_REPLY` FOREIGN KEY (`GROUP_ID`) REFERENCES `bbs_user_group` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_GROUP_FORUM_REPLY` FOREIGN KEY (`FORUM_ID`) REFERENCES `bbs_forum` (`FORUM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='å›žå¤æƒé™';

/*Data for the table `bbs_forum_group_reply` */

/*Table structure for table `bbs_forum_group_topic` */

DROP TABLE IF EXISTS `bbs_forum_group_topic`;

CREATE TABLE `bbs_forum_group_topic` (
  `FORUM_ID` int(11) NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  PRIMARY KEY  (`FORUM_ID`,`GROUP_ID`),
  KEY `FK_BBS_FORUM_GROUP_TOPIC` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_FORUM_GROUP_TOPIC` FOREIGN KEY (`GROUP_ID`) REFERENCES `bbs_user_group` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_GROUP_FORUM_TOPIC` FOREIGN KEY (`FORUM_ID`) REFERENCES `bbs_forum` (`FORUM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='å‘è´´æƒé™';

/*Data for the table `bbs_forum_group_topic` */

/*Table structure for table `bbs_forum_group_view` */

DROP TABLE IF EXISTS `bbs_forum_group_view`;

CREATE TABLE `bbs_forum_group_view` (
  `GROUP_ID` int(11) NOT NULL,
  `FORUM_ID` int(11) NOT NULL,
  PRIMARY KEY  (`GROUP_ID`,`FORUM_ID`),
  KEY `FK_BBS_GROUP_FORUM_VIEW` (`FORUM_ID`),
  CONSTRAINT `FK_BBS_FORUM_GROUP_VIEW` FOREIGN KEY (`GROUP_ID`) REFERENCES `bbs_user_group` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_GROUP_FORUM_VIEW` FOREIGN KEY (`FORUM_ID`) REFERENCES `bbs_forum` (`FORUM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='æµè§ˆæƒé™';

/*Data for the table `bbs_forum_group_view` */

/*Table structure for table `bbs_forum_user` */

DROP TABLE IF EXISTS `bbs_forum_user`;

CREATE TABLE `bbs_forum_user` (
  `FORUM_ID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`FORUM_ID`,`user_id`),
  KEY `FK_BBS_FORUM_TO_USER` (`user_id`),
  CONSTRAINT `FK_BBS_FORUM_TO_USER` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_USER_TO_FORUM` FOREIGN KEY (`FORUM_ID`) REFERENCES `bbs_forum` (`FORUM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ç‰ˆå—ç‰ˆä¸»';

/*Data for the table `bbs_forum_user` */

/*Table structure for table `bbs_grade` */

DROP TABLE IF EXISTS `bbs_grade`;

CREATE TABLE `bbs_grade` (
  `GRADE_ID` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `POST_ID` int(11) NOT NULL,
  `SCORE` int(11) default NULL,
  `REASON` varchar(100) default NULL,
  `GRADE_TIME` datetime default NULL,
  PRIMARY KEY  (`GRADE_ID`),
  KEY `FK_MEMBER_GRADE` (`user_id`),
  KEY `FK_POST_GRADE` (`POST_ID`),
  CONSTRAINT `FK_MEMBER_GRADE` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_POST_GRADE` FOREIGN KEY (`POST_ID`) REFERENCES `bbs_post` (`POST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bbs_grade` */

/*Table structure for table `bbs_group_type` */

DROP TABLE IF EXISTS `bbs_group_type`;

CREATE TABLE `bbs_group_type` (
  `GROUP_ID` int(11) NOT NULL default '0',
  `TYPE_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`TYPE_ID`,`GROUP_ID`),
  KEY `FK_BBS_GROUP_TYPE_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_GROUP_TYPE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `bbs_user_group` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_GROUP_TYPE_TYPE` FOREIGN KEY (`TYPE_ID`) REFERENCES `bbs_post_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¼šå‘˜ç»„æŠ•ç¥¨åˆ†ç±»å…³è”è¡¨';

/*Data for the table `bbs_group_type` */

insert  into `bbs_group_type`(`GROUP_ID`,`TYPE_ID`) values (1,28),(1,29),(1,30),(1,31),(1,34),(1,35),(1,36),(1,37),(1,38),(2,28),(2,29),(2,30),(2,31),(2,34),(2,35),(2,36),(2,37),(2,38),(2,39),(2,40),(2,41),(2,42),(2,43),(2,44),(2,45),(2,46),(2,47),(2,48),(2,49),(2,50),(11,28),(11,29),(11,30),(11,31),(11,34),(11,35),(11,36),(11,37),(11,38),(12,12),(12,13),(12,14),(12,15),(12,16);

/*Table structure for table `bbs_login_log` */

DROP TABLE IF EXISTS `bbs_login_log`;

CREATE TABLE `bbs_login_log` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL COMMENT 'ç™»å½•ç”¨æˆ·',
  `login_time` datetime default NULL COMMENT 'ç™»å½•æ—¶é—´',
  `logout_time` datetime default NULL COMMENT 'é€€å‡ºæ—¶é—´',
  `ip` varchar(255) character set gbk default NULL COMMENT 'ç™»å½•ip',
  PRIMARY KEY  (`id`),
  KEY `fk_bbs_login_log_user` (`user_id`),
  CONSTRAINT `fk_bbs_login_log_user` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='ç™»å½•æ—¥å¿—';

/*Data for the table `bbs_login_log` */

insert  into `bbs_login_log`(`id`,`user_id`,`login_time`,`logout_time`,`ip`) values (1,9,'2012-04-14 11:16:03','2012-04-14 11:21:12','127.0.0.1'),(2,5,'2012-04-14 13:34:41','2012-04-14 13:37:50','127.0.0.1'),(3,5,'2012-04-14 14:02:55','2012-04-14 14:02:55','127.0.0.1'),(4,5,'2012-04-14 14:05:08','2012-04-14 14:55:09','127.0.0.1'),(5,5,'2012-04-14 14:59:49','2012-04-14 14:59:50','127.0.0.1'),(6,5,'2012-04-14 15:09:36','2012-04-16 14:23:19','127.0.0.1'),(10,5,'2012-04-16 14:46:07','2012-04-16 14:46:09','127.0.0.1'),(11,5,'2012-04-16 16:21:24','2012-04-16 16:21:31','127.0.0.1'),(12,5,'2012-04-16 16:52:11','2012-04-16 18:05:51','127.0.0.1'),(14,5,'2012-04-17 15:18:40','2012-04-18 16:13:45','127.0.0.1'),(16,5,'2012-04-19 09:46:23','2012-04-19 10:09:18','127.0.0.1'),(18,5,'2012-04-19 10:09:28','2012-04-19 11:34:00','127.0.0.1'),(19,5,'2012-04-19 13:36:14','2012-04-19 17:55:43','127.0.0.1'),(21,5,'2012-05-02 09:20:53','2012-05-02 15:06:35','127.0.0.1'),(28,5,'2012-05-03 10:55:56','2015-01-19 11:31:20','127.0.0.1'),(29,9,'2012-05-03 11:19:16','2012-05-03 11:28:10','127.0.0.1'),(30,9,'2012-05-03 11:58:56','2012-05-03 12:00:01','127.0.0.1'),(31,10,'2012-05-03 12:00:27','2012-05-03 13:31:22','127.0.0.1'),(32,9,'2015-01-15 10:15:53','2015-01-15 12:04:13','0:0:0:0:0:0:0:1%0'),(33,5,'2015-03-16 09:22:09','2015-03-16 09:32:37','0:0:0:0:0:0:0:1'),(34,5,'2015-03-16 09:33:10','2015-03-16 10:16:34','0:0:0:0:0:0:0:1'),(35,5,'2015-03-16 10:37:09','2015-03-16 12:41:32','0:0:0:0:0:0:0:1'),(36,5,'2015-07-02 16:17:48','2015-07-02 16:18:08','0:0:0:0:0:0:0:1'),(37,5,'2015-07-02 16:19:52','2015-07-20 10:46:28','0:0:0:0:0:0:0:1'),(38,5,'2015-07-20 10:46:37','2015-07-20 11:29:58','0:0:0:0:0:0:0:1'),(39,9,'2015-07-20 10:50:28','2015-07-20 10:53:52','0:0:0:0:0:0:0:1'),(40,10,'2015-07-20 10:54:01','2015-07-20 10:58:06','0:0:0:0:0:0:0:1'),(41,10,'2015-07-20 10:58:12','2015-07-20 10:58:59','0:0:0:0:0:0:0:1'),(42,10,'2015-07-20 10:59:36','2015-07-20 11:01:01','0:0:0:0:0:0:0:1'),(43,10,'2015-07-20 11:02:04','2015-07-20 11:06:32','0:0:0:0:0:0:0:1'),(44,10,'2015-07-20 11:06:40','2015-07-20 11:17:21','0:0:0:0:0:0:0:1'),(45,10,'2015-07-20 11:17:25','2015-07-20 11:32:21','192.168.1.3');

/*Table structure for table `bbs_magic_config` */

DROP TABLE IF EXISTS `bbs_magic_config`;

CREATE TABLE `bbs_magic_config` (
  `id` int(11) NOT NULL default '1' COMMENT 'ä¸»é”®id',
  `magic_switch` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦å¼€å¯é“å…·',
  `magic_discount` int(3) default NULL COMMENT 'é“å…·å›žæ”¶æŠ˜æ‰£',
  `magic_sofa_lines` varchar(255) character set gbk default NULL COMMENT 'æŠ¢æ²™å‘å°è¯',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='é“å…·é…ç½®è¡¨';

/*Data for the table `bbs_magic_config` */

insert  into `bbs_magic_config`(`id`,`magic_switch`,`magic_discount`,`magic_sofa_lines`) values (1,1,80,'O(∩_∩)O哈哈~，沙发是我的啦O(∩_∩)O');

/*Table structure for table `bbs_magic_log` */

DROP TABLE IF EXISTS `bbs_magic_log`;

CREATE TABLE `bbs_magic_log` (
  `log_id` int(11) NOT NULL auto_increment,
  `magic_id` smallint(5) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `log_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `operator` tinyint(2) default NULL COMMENT 'æ“ä½œ(0å‡ºå”®é“å…·1ä½¿ç”¨é“å…· 2ä¸¢å¼ƒé“å…· 3è´­ä¹°é“å…·,4èµ é€)',
  `price` int(11) default NULL COMMENT 'è´­ä¹°ä»·æ ¼',
  `num` int(11) default NULL COMMENT 'è´­ä¹°æ•°é‡æˆ–è€…èµ é€æ•°é‡',
  `targetuid` int(11) default '0' COMMENT 'èµ é€ç›®æ ‡ç”¨æˆ·',
  PRIMARY KEY  (`log_id`),
  KEY `fk_magic_log_magic` (`magic_id`),
  KEY `fk_magic_log_user` (`user_id`),
  CONSTRAINT `fk_magic_log_magic` FOREIGN KEY (`magic_id`) REFERENCES `bbs_common_magic` (`magicid`),
  CONSTRAINT `fk_magic_log_user` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='é“å…·è®°å½•è¡¨';

/*Data for the table `bbs_magic_log` */

/*Table structure for table `bbs_magic_usergroup` */

DROP TABLE IF EXISTS `bbs_magic_usergroup`;

CREATE TABLE `bbs_magic_usergroup` (
  `magicid` smallint(6) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0' COMMENT 'æœ‰æƒé™ä½¿ç”¨è¯¥é“å…·çš„ç”¨æˆ·ç»„id',
  PRIMARY KEY  (`magicid`,`groupid`),
  KEY `fk_bbs_magic_usergroup_group` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='é“å…·ç»„æƒé™';

/*Data for the table `bbs_magic_usergroup` */

/*Table structure for table `bbs_magic_usergroup_to` */

DROP TABLE IF EXISTS `bbs_magic_usergroup_to`;

CREATE TABLE `bbs_magic_usergroup_to` (
  `magicid` smallint(6) NOT NULL default '0',
  `groupid` int(11) NOT NULL default '0' COMMENT 'å…è®¸è¢«ä½¿ç”¨çš„ç”¨æˆ·ç»„id',
  PRIMARY KEY  (`magicid`,`groupid`),
  KEY `fk_bbs_magic_usergroup_group` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='å…è®¸è¢«ä½¿ç”¨çš„ç”¨æˆ·ç»„';

/*Data for the table `bbs_magic_usergroup_to` */

/*Table structure for table `bbs_member_magic` */

DROP TABLE IF EXISTS `bbs_member_magic`;

CREATE TABLE `bbs_member_magic` (
  `id` int(11) NOT NULL auto_increment,
  `uid` int(11) NOT NULL default '0' COMMENT 'ç”¨æˆ·id',
  `magicid` smallint(6) NOT NULL default '0' COMMENT 'é“å…·id',
  `num` int(11) NOT NULL default '0' COMMENT 'é“å…·æ•°é‡',
  PRIMARY KEY  (`id`),
  KEY `fk_bbs_member_magic_user` (`uid`),
  KEY `fk_bbs_member_magic_magic` (`magicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ç”¨æˆ·é“å…·è¡¨';

/*Data for the table `bbs_member_magic` */

/*Table structure for table `bbs_operation` */

DROP TABLE IF EXISTS `bbs_operation`;

CREATE TABLE `bbs_operation` (
  `OPERATOR_ID` int(11) NOT NULL auto_increment,
  `SITE_ID` int(11) NOT NULL,
  `operater_id` int(11) NOT NULL COMMENT 'æ“ä½œä¼šå‘˜',
  `REF_TYPE` char(4) NOT NULL COMMENT 'å¼•ç”¨ç±»åž‹',
  `REF_ID` int(11) NOT NULL default '0' COMMENT 'å¼•ç”¨ID',
  `OPT_NAME` varchar(100) NOT NULL COMMENT 'æ“ä½œåç§°',
  `OPT_REASON` varchar(255) default NULL COMMENT 'æ“ä½œåŽŸå› ',
  `OPT_TIME` datetime NOT NULL COMMENT 'æ“ä½œæ—¶é—´',
  PRIMARY KEY  (`OPERATOR_ID`),
  KEY `FK_BBS_OPEATTION` (`SITE_ID`),
  KEY `FK_BBS_OPERATION_USER` (`operater_id`),
  CONSTRAINT `FK_BBS_OPEATTION` FOREIGN KEY (`SITE_ID`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `FK_BBS_OPERATION_USER` FOREIGN KEY (`operater_id`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8 COMMENT='ä¸»é¢˜ã€å¸–å­æ“ä½œè®°å½•';

/*Data for the table `bbs_operation` */

insert  into `bbs_operation`(`OPERATOR_ID`,`SITE_ID`,`operater_id`,`REF_TYPE`,`REF_ID`,`OPT_NAME`,`OPT_REASON`,`OPT_TIME`) values (205,1,9,'TOPI',4,'精华','我很赞同','2015-01-15 10:29:08'),(206,1,10,'POST',2,'编辑',NULL,'2015-07-20 11:12:06');

/*Table structure for table `bbs_permission` */

DROP TABLE IF EXISTS `bbs_permission`;

CREATE TABLE `bbs_permission` (
  `GROUP_ID` int(11) NOT NULL,
  `PERM_KEY` varchar(20) NOT NULL COMMENT 'æƒé™key',
  `PERM_VALUE` varchar(255) default NULL COMMENT 'æƒé™value',
  KEY `FK_BBS_PERMISSION_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_BBS_PERMISSION_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `bbs_user_group` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='è®ºå›æƒé™';

/*Data for the table `bbs_permission` */

insert  into `bbs_permission`(`GROUP_ID`,`PERM_KEY`,`PERM_VALUE`) values (10,'post_per_day','0'),(13,'allow_reply','true'),(13,'allow_topic','true'),(13,'attach_max_size','0'),(13,'attach_per_day','0'),(13,'attach_type','0'),(13,'edit_limit_minute','0'),(13,'favorite_count','0'),(13,'msg_count','0'),(13,'msg_interval','0'),(13,'msg_per_day','0'),(13,'post_interval','0'),(13,'post_per_day','0'),(14,'allow_attach','false'),(14,'allow_reply','false'),(14,'allow_topic','false'),(14,'attach_max_size','500'),(14,'attach_per_day','50'),(14,'attach_type','jpg'),(14,'edit_limit_minute','2'),(14,'favorite_count','2'),(14,'msg_count','2'),(14,'msg_interval','2'),(14,'msg_per_day','2'),(14,'post_interval','2'),(14,'post_per_day','2'),(12,'allow_reply','true'),(12,'allow_topic','true'),(12,'attach_max_size','0'),(12,'attach_per_day','0'),(12,'attach_type',''),(12,'edit_limit_minute','0'),(12,'favorite_count','0'),(12,'member_prohibit','true'),(12,'msg_count','0'),(12,'msg_interval','0'),(12,'msg_per_day','0'),(12,'post_interval','0'),(12,'post_limit','true'),(12,'post_per_day','0'),(12,'topic_delete','true'),(12,'topic_edit','true'),(12,'topic_manage','true'),(12,'topic_shield','true'),(12,'topic_top','3'),(12,'view_ip','true'),(3,'allow_attach','true'),(3,'allow_reply','true'),(3,'allow_topic','true'),(3,'attach_max_size','0'),(3,'attach_per_day','0'),(3,'attach_type',''),(3,'edit_limit_minute','0'),(3,'favorite_count','0'),(3,'msg_count','0'),(3,'msg_interval','0'),(3,'msg_per_day','0'),(3,'post_interval','0'),(3,'post_per_day','0'),(4,'allow_attach','true'),(4,'allow_reply','true'),(4,'allow_topic','true'),(4,'attach_max_size','0'),(4,'attach_per_day','0'),(4,'attach_type',''),(4,'edit_limit_minute','0'),(4,'favorite_count','0'),(4,'msg_count','0'),(4,'msg_interval','0'),(4,'msg_per_day','0'),(4,'post_interval','0'),(4,'post_per_day','0'),(5,'allow_attach','true'),(5,'allow_reply','true'),(5,'allow_topic','true'),(5,'attach_max_size','0'),(5,'attach_per_day','0'),(5,'attach_type',''),(5,'edit_limit_minute','0'),(5,'favorite_count','0'),(5,'msg_count','0'),(5,'msg_interval','0'),(5,'msg_per_day','0'),(5,'post_interval','0'),(5,'post_per_day','0'),(6,'allow_attach','true'),(6,'allow_reply','true'),(6,'allow_topic','true'),(6,'attach_max_size','0'),(6,'attach_per_day','0'),(6,'attach_type',''),(6,'edit_limit_minute','0'),(6,'favorite_count','0'),(6,'msg_count','0'),(6,'msg_interval','0'),(6,'msg_per_day','0'),(6,'post_interval','0'),(6,'post_per_day','0'),(7,'allow_attach','true'),(7,'allow_reply','true'),(7,'allow_topic','true'),(7,'attach_max_size','0'),(7,'attach_per_day','0'),(7,'attach_type',''),(7,'edit_limit_minute','0'),(7,'favorite_count','0'),(7,'msg_count','0'),(7,'msg_interval','0'),(7,'msg_per_day','0'),(7,'post_interval','0'),(7,'post_per_day','0'),(9,'allow_attach','true'),(9,'allow_reply','true'),(9,'allow_topic','true'),(9,'attach_max_size','0'),(9,'attach_per_day','0'),(9,'attach_type','0'),(9,'edit_limit_minute','0'),(9,'favorite_count','0'),(9,'msg_count','0'),(9,'msg_interval','0'),(9,'msg_per_day','0'),(9,'post_interval','0'),(9,'post_per_day','0'),(10,'allow_attach','true'),(10,'allow_reply','true'),(10,'allow_topic','true'),(10,'attach_max_size','0'),(10,'attach_per_day','0'),(10,'attach_type',''),(10,'edit_limit_minute','0'),(10,'favorite_count','0'),(10,'msg_count','0'),(10,'msg_interval','0'),(10,'msg_per_day','0'),(10,'post_interval','0'),(11,'allow_attach','true'),(11,'allow_reply','true'),(11,'allow_topic','true'),(11,'attach_max_size','0'),(11,'attach_per_day','0'),(11,'attach_type',''),(11,'edit_limit_minute','0'),(11,'favorite_count','0'),(11,'msg_count','0'),(11,'msg_interval','0'),(11,'msg_per_day','0'),(11,'post_interval','0'),(11,'post_per_day','0'),(1,'allow_attach','true'),(1,'allow_reply','true'),(1,'allow_topic','true'),(1,'attach_max_size','0'),(1,'attach_per_day','0'),(1,'attach_type',''),(1,'edit_limit_minute','0'),(1,'favorite_count','0'),(1,'msg_count','0'),(1,'msg_interval','0'),(1,'msg_per_day','100'),(1,'post_interval','0'),(1,'post_per_day','100'),(2,'allow_reply','true'),(2,'allow_topic','true'),(2,'attach_max_size','0'),(2,'attach_per_day','0'),(2,'attach_type',''),(2,'edit_limit_minute','0'),(2,'favorite_count','0'),(2,'msg_count','0'),(2,'msg_interval','0'),(2,'msg_per_day','0'),(2,'post_interval','0'),(2,'post_per_day','0');

/*Table structure for table `bbs_post` */

DROP TABLE IF EXISTS `bbs_post`;

CREATE TABLE `bbs_post` (
  `POST_ID` int(11) NOT NULL auto_increment,
  `TOPIC_ID` int(11) NOT NULL COMMENT 'ä¸»é¢˜',
  `SITE_ID` int(11) NOT NULL COMMENT 'ç«™ç‚¹',
  `CONFIG_ID` int(11) NOT NULL,
  `EDITER_ID` int(11) default NULL COMMENT 'ç¼–è¾‘å™¨ä¼šå‘˜',
  `CREATER_ID` int(11) NOT NULL COMMENT 'å‘è´´ä¼šå‘˜',
  `CREATE_TIME` datetime NOT NULL COMMENT 'å‘è´´æ—¶é—´',
  `POSTER_IP` varchar(20) NOT NULL default '' COMMENT 'å‘è´´IP',
  `EDIT_TIME` datetime default NULL COMMENT 'ç¼–è¾‘æ—¶é—´',
  `EDITER_IP` varchar(20) default '' COMMENT 'ç¼–è¾‘è€…IP',
  `EDIT_COUNT` int(11) NOT NULL default '0' COMMENT 'ç¼–è¾‘æ¬¡æ•°',
  `INDEX_COUNT` int(11) NOT NULL default '1' COMMENT 'ç¬¬å‡ æ¥¼',
  `STATUS` smallint(6) NOT NULL default '0' COMMENT 'çŠ¶æ€',
  `IS_AFFIX` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ä¸Šä¼ é™„ä»¶',
  `IS_HIDDEN` tinyint(1) default '0' COMMENT 'æ˜¯å¦æœ‰éšè—å†…å®¹',
  `TYPE_ID` int(11) NOT NULL COMMENT 'å¸–å­åˆ†ç±»id',
  `ANONYMOUS` tinyint(1) default NULL COMMENT 'æ˜¯å¦åŒ¿å',
  PRIMARY KEY  (`POST_ID`),
  KEY `FK_BBS_POST_CREATER` (`CREATER_ID`),
  KEY `FK_BBS_POST_EDITOR` (`EDITER_ID`),
  KEY `FK_BBS_POST_TOPIC` (`TOPIC_ID`),
  KEY `FK_BBS_POST_WEBSITE` (`SITE_ID`),
  CONSTRAINT `FK_BBS_POST_CREATER` FOREIGN KEY (`CREATER_ID`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_POST_EDITOR` FOREIGN KEY (`EDITER_ID`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_POST_TOPIC` FOREIGN KEY (`TOPIC_ID`) REFERENCES `bbs_topic` (`TOPIC_ID`),
  CONSTRAINT `FK_BBS_POST_WEBSITE` FOREIGN KEY (`SITE_ID`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='è®ºå›å¸–å­';

/*Data for the table `bbs_post` */

insert  into `bbs_post`(`POST_ID`,`TOPIC_ID`,`SITE_ID`,`CONFIG_ID`,`EDITER_ID`,`CREATER_ID`,`CREATE_TIME`,`POSTER_IP`,`EDIT_TIME`,`EDITER_IP`,`EDIT_COUNT`,`INDEX_COUNT`,`STATUS`,`IS_AFFIX`,`IS_HIDDEN`,`TYPE_ID`,`ANONYMOUS`) values (1,1,1,1,NULL,10,'2015-07-20 10:57:07','0:0:0:0:0:0:0:1',NULL,NULL,0,1,0,1,0,29,0),(2,2,1,1,10,10,'2015-07-20 11:11:55','0:0:0:0:0:0:0:1','2015-07-20 11:12:06','0:0:0:0:0:0:0:1',1,1,0,1,0,40,0);

/*Table structure for table `bbs_post_text` */

DROP TABLE IF EXISTS `bbs_post_text`;

CREATE TABLE `bbs_post_text` (
  `POST_ID` bigint(20) NOT NULL,
  `POST_TITLE` varchar(100) default NULL COMMENT 'å¸–å­æ ‡é¢˜',
  `POST_CONTENT` longtext COMMENT 'å¸–å­å†…å®¹',
  PRIMARY KEY  (`POST_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='è®ºå›å¸–å­å†…å®¹';

/*Data for the table `bbs_post_text` */

insert  into `bbs_post_text`(`POST_ID`,`POST_TITLE`,`POST_CONTENT`) values (1,'测试发帖','测试发帖测试发帖测试发帖'),(2,'测试发帖2','测试发帖2');

/*Table structure for table `bbs_post_type` */

DROP TABLE IF EXISTS `bbs_post_type`;

CREATE TABLE `bbs_post_type` (
  `type_id` int(11) NOT NULL auto_increment,
  `type_name` varchar(255) character set gbk default NULL COMMENT 'å¸–å­åˆ†ç±»åç§°',
  `priority` int(11) default NULL COMMENT 'æŽ’åº',
  `site_id` int(11) default NULL COMMENT 'ç«™ç‚¹id',
  `forum_id` int(11) NOT NULL default '0' COMMENT 'æ¿å—',
  `parent_id` int(11) default NULL COMMENT 'çˆ¶ç±»id',
  PRIMARY KEY  (`type_id`),
  KEY `fk_bbs_post_type_site` (`site_id`),
  KEY `fk_bbs_post_type_parent` (`parent_id`),
  KEY `fk_bbs_type_forum` (`forum_id`),
  CONSTRAINT `fk_bbs_post_type_parent` FOREIGN KEY (`parent_id`) REFERENCES `bbs_post_type` (`type_id`),
  CONSTRAINT `fk_bbs_post_type_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_bbs_type_forum` FOREIGN KEY (`forum_id`) REFERENCES `bbs_forum` (`FORUM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;

/*Data for the table `bbs_post_type` */

insert  into `bbs_post_type`(`type_id`,`type_name`,`priority`,`site_id`,`forum_id`,`parent_id`) values (12,'HTML(CSS)',1,1,4,NULL),(13,'跨浏览器开发',2,1,4,NULL),(14,'Apache',3,1,4,NULL),(15,'JavaScript',4,1,4,NULL),(16,'应用服务器',5,1,4,NULL),(17,'XML/XSL',6,1,4,NULL),(18,'Ajax',7,1,4,NULL),(19,'HTML5',8,1,4,NULL),(20,'非技术区',9,1,4,NULL),(21,'Java EE',1,1,6,NULL),(22,'Java SE',2,1,6,NULL),(23,'Java相关',3,1,6,NULL),(24,'Eclipse',4,1,6,NULL),(25,'J2ME',5,1,6,NULL),(26,'Web 开发',6,1,6,NULL),(27,'非技术区',7,1,6,NULL),(28,'Windows Phone',1,1,7,NULL),(29,'电信IT应用开发',2,1,7,NULL),(30,'iOS',3,1,7,NULL),(31,'移动开发其他问题',11,1,7,NULL),(34,'Android',7,1,7,NULL),(35,'英特尔架构的Android开发',8,1,7,NULL),(36,'微信开发',9,1,7,NULL),(37,'移动广告',10,1,7,NULL),(38,'非技术区',12,1,7,NULL),(39,'Access',1,1,9,NULL),(40,'DB2',2,1,9,NULL),(41,'VFP',3,1,9,NULL),(42,'MongoDB',4,1,9,NULL),(43,'MySQL',5,1,9,NULL),(44,'数据仓库',6,1,9,NULL),(45,'数据库报表',7,1,9,NULL),(46,'Sybase',8,1,9,NULL),(47,'Sybase ASA',9,1,9,NULL),(48,'Informix',10,1,9,NULL),(49,'PostgreSQL',11,1,9,NULL),(50,'非技术区',12,1,9,NULL),(51,'高性能数据库开发',1,1,10,NULL),(52,'分布式计算/Hadoop',2,1,10,NULL),(53,'高性能WEB开发',3,1,10,NULL),(54,'数据结构与算法',4,1,10,NULL),(55,'高性能计算',5,1,10,NULL),(56,'VB.NET',1,1,11,NULL),(57,'.NET技术前瞻',2,1,11,NULL),(58,'Web Services',3,1,11,NULL),(59,'ASP.NET',4,1,11,NULL),(60,'LINQ',5,1,11,NULL),(61,'C#',6,1,11,NULL),(62,'组件/控件开发',7,1,11,NULL),(63,'VC.NET',8,1,11,NULL),(64,'.NET Framework',9,1,11,NULL),(65,'分析与设计',10,1,11,NULL),(66,'非技术区',11,1,11,NULL),(67,'AutoCAD',1,1,12,NULL),(68,'WPF/Silverlight',2,1,12,NULL),(69,'图象工具使用',3,1,12,NULL),(70,'多媒体设计（3DMaX, Maya等）',4,1,12,NULL),(71,'Flash流媒体开发',5,1,12,NULL),(72,'网页设计（Dreamweaver等）',6,1,12,NULL),(73,'Flash流媒体使用',7,1,12,NULL),(74,'交互式设计',8,1,12,NULL),(75,'Flex',9,1,12,NULL);

/*Table structure for table `bbs_private_msg` */

DROP TABLE IF EXISTS `bbs_private_msg`;

CREATE TABLE `bbs_private_msg` (
  `PRIVMSG_ID` bigint(20) NOT NULL,
  `TO_USER` bigint(20) NOT NULL COMMENT 'æ”¶ä¿¡äºº',
  `FROM_USER` bigint(20) NOT NULL COMMENT 'å‘ä¿¡äºº',
  `MSG_TYPE` smallint(6) NOT NULL default '1' COMMENT 'ç±»åž‹ï¼ˆ2ï¼šå·²å‘ï¼Œ1ï¼šå·²é˜…ï¼Œ0ï¼šæœªé˜…ï¼‰',
  `MSG_SUBJECT` varchar(255) default NULL COMMENT 'ä¸»é¢˜',
  `CREATE_TIME` datetime NOT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `MSG_IP` varchar(20) NOT NULL default '' COMMENT 'IPåœ°å€',
  PRIMARY KEY  (`PRIVMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¸ªäººçŸ­æ¶ˆæ¯';

/*Data for the table `bbs_private_msg` */

/*Table structure for table `bbs_private_msg_text` */

DROP TABLE IF EXISTS `bbs_private_msg_text`;

CREATE TABLE `bbs_private_msg_text` (
  `PRIVMSG_ID` bigint(20) NOT NULL,
  `MSG_TEXT` longtext COMMENT 'ä¸ªäººä¿¡æ¯å†…å®¹',
  PRIMARY KEY  (`PRIVMSG_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¸ªäººæ¶ˆæ¯å†…å®¹';

/*Data for the table `bbs_private_msg_text` */

/*Table structure for table `bbs_report` */

DROP TABLE IF EXISTS `bbs_report`;

CREATE TABLE `bbs_report` (
  `id` int(11) NOT NULL auto_increment,
  `report_url` varchar(255) character set gbk NOT NULL default '' COMMENT 'ä¸¾æŠ¥åœ°å€',
  `process_user` int(11) default NULL COMMENT 'å¤„ç†äºº',
  `process_time` datetime default NULL COMMENT 'å¤„ç†æ—¶é—´',
  `process_result` varchar(255) character set gbk default NULL COMMENT 'å¤„ç†ç»“æžœ',
  `status` tinyint(1) default NULL COMMENT 'å¤„ç†çŠ¶æ€0æœªå¤„ç†ã€‚1å·²ç»å¤„ç†',
  `report_time` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'ä¸¾æŠ¥æ—¶é—´',
  PRIMARY KEY  (`id`),
  KEY `fk_bbs_report_process_user` (`process_user`),
  CONSTRAINT `fk_bbs_report_process_user` FOREIGN KEY (`process_user`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¸¾æŠ¥è®°å½•';

/*Data for the table `bbs_report` */

/*Table structure for table `bbs_report_ext` */

DROP TABLE IF EXISTS `bbs_report_ext`;

CREATE TABLE `bbs_report_ext` (
  `id` int(11) NOT NULL auto_increment COMMENT 'ä¸¾æŠ¥id',
  `report_id` int(11) NOT NULL default '0' COMMENT 'reportid',
  `report_user` int(11) NOT NULL default '0' COMMENT 'ä¸¾æŠ¥äºº',
  `report_time` datetime NOT NULL default '0000-00-00 00:00:00' COMMENT 'ä¸¾æŠ¥æ—¶é—´',
  `report_reason` varchar(255) character set gbk default NULL COMMENT 'ä¸¾æŠ¥ç†ç”±',
  PRIMARY KEY  (`id`),
  KEY `fk_bbs_report_ext_report_user` (`report_user`),
  KEY `fk_bbs_report_ext_report` (`report_id`),
  CONSTRAINT `fk_bbs_report_ext_report` FOREIGN KEY (`report_id`) REFERENCES `bbs_report` (`id`),
  CONSTRAINT `fk_bbs_report_ext_report_user` FOREIGN KEY (`report_user`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¸¾æŠ¥æ‰©å±•';

/*Data for the table `bbs_report_ext` */

/*Table structure for table `bbs_topic` */

DROP TABLE IF EXISTS `bbs_topic`;

CREATE TABLE `bbs_topic` (
  `TOPIC_ID` int(11) NOT NULL auto_increment,
  `FORUM_ID` int(11) NOT NULL COMMENT 'æ¿å—',
  `LAST_POST_ID` int(11) default NULL COMMENT 'æœ€åŽå¸–',
  `FIRST_POST_ID` int(11) default NULL COMMENT 'ä¸»é¢˜å¸–',
  `SITE_ID` int(11) NOT NULL COMMENT 'ç«™ç‚¹',
  `CREATER_ID` int(11) NOT NULL COMMENT 'å‘å¸–ä¼šå‘˜',
  `REPLYER_ID` int(11) NOT NULL COMMENT 'æœ€åŽå›žå¸–ä¼šå‘˜',
  `TITLE` varchar(100) NOT NULL COMMENT 'æ ‡é¢˜',
  `CREATE_TIME` datetime NOT NULL COMMENT 'åˆ›å»ºæ—¶é—´',
  `LAST_TIME` datetime NOT NULL COMMENT 'æœ€åŽå›žå¸–æ—¶é—´',
  `SORT_TIME` datetime NOT NULL COMMENT 'ç”¨äºŽæŽ’åº',
  `VIEW_COUNT` bigint(20) NOT NULL default '0' COMMENT 'æµè§ˆæ¬¡æ•°',
  `REPLY_COUNT` int(11) NOT NULL default '0' COMMENT 'æ¢å¤æ¬¡æ•°',
  `TOP_LEVEL` smallint(6) NOT NULL default '0' COMMENT 'å›ºå®šçº§åˆ«',
  `PRIME_LEVEL` smallint(6) NOT NULL default '0' COMMENT 'ç²¾åŽçº§åˆ«',
  `STATUS` smallint(6) NOT NULL default '0' COMMENT 'çŠ¶æ€',
  `OUTER_URL` varchar(255) default NULL COMMENT 'å¤–éƒ¨é“¾æŽ¥',
  `STYLE_BOLD` tinyint(1) NOT NULL default '0' COMMENT 'ç²—ä½“',
  `STYLE_ITALIC` tinyint(1) NOT NULL default '0' COMMENT 'æ–œä½“',
  `STYLE_COLOR` char(6) default NULL COMMENT 'é¢œè‰²',
  `STYLE_TIME` datetime default NULL COMMENT 'æ ·å¼æœ‰æ•ˆæ—¶é—´',
  `IS_AFFIX` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ä¸Šä¼ é™„ä»¶',
  `HAVA_REPLY` longtext COMMENT 'å›žå¤åˆ—è¡¨',
  `moderator_reply` tinyint(1) default '0' COMMENT 'ç‰ˆä¸»æ˜¯å¦å›žå¤',
  `TYPE_ID` int(11) NOT NULL COMMENT 'ä¸»é¢˜åˆ†ç±»id',
  `ALLAY_REPLY` tinyint(1) default NULL COMMENT 'ä¸»é¢˜æ˜¯å¦å…è®¸å›žå¤',
  `HAS_SOFAED` tinyint(1) default NULL COMMENT 'ä¸»é¢˜æ˜¯å¦å·²ç»è¢«æŠ¢èµ°æ²™å‘',
  `CATEGORY` tinyint(1) default NULL COMMENT 'å¸–å­ç±»åž‹(0:æ™®é€šå¸–;1:æŠ•ç¥¨è´´)',
  `TOTAL_COUNT` int(11) default NULL COMMENT 'æ€»ç¥¨æ•°',
  PRIMARY KEY  (`TOPIC_ID`),
  KEY `BBS_SORT_TIME` (`SORT_TIME`),
  KEY `FK_BBS_FIRST_POST` (`FIRST_POST_ID`),
  KEY `FK_BBS_LAST_POST` (`LAST_POST_ID`),
  KEY `FK_BBS_TOPIC_FORUM` (`FORUM_ID`),
  KEY `FK_BBS_TOPIC_USER_CREATE` (`CREATER_ID`),
  KEY `FK_BBS_TOPIC_USER_LAST` (`REPLYER_ID`),
  KEY `FK_BBS_TOPIC_SITE` (`SITE_ID`),
  CONSTRAINT `FK_bbs_topic` FOREIGN KEY (`FIRST_POST_ID`) REFERENCES `bbs_post` (`POST_ID`),
  CONSTRAINT `FK_bbs_topic1` FOREIGN KEY (`FORUM_ID`) REFERENCES `bbs_forum` (`FORUM_ID`),
  CONSTRAINT `FK_bbs_topic2` FOREIGN KEY (`LAST_POST_ID`) REFERENCES `bbs_post` (`POST_ID`),
  CONSTRAINT `FK_BBS_TOPIC_SITE` FOREIGN KEY (`SITE_ID`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `FK_BBS_TOPIC_USER_CREATE` FOREIGN KEY (`CREATER_ID`) REFERENCES `jb_user` (`user_id`),
  CONSTRAINT `FK_BBS_TOPIC_USER_LAST` FOREIGN KEY (`REPLYER_ID`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='è®ºå›ä¸»é¢˜';

/*Data for the table `bbs_topic` */

insert  into `bbs_topic`(`TOPIC_ID`,`FORUM_ID`,`LAST_POST_ID`,`FIRST_POST_ID`,`SITE_ID`,`CREATER_ID`,`REPLYER_ID`,`TITLE`,`CREATE_TIME`,`LAST_TIME`,`SORT_TIME`,`VIEW_COUNT`,`REPLY_COUNT`,`TOP_LEVEL`,`PRIME_LEVEL`,`STATUS`,`OUTER_URL`,`STYLE_BOLD`,`STYLE_ITALIC`,`STYLE_COLOR`,`STYLE_TIME`,`IS_AFFIX`,`HAVA_REPLY`,`moderator_reply`,`TYPE_ID`,`ALLAY_REPLY`,`HAS_SOFAED`,`CATEGORY`,`TOTAL_COUNT`) values (1,7,NULL,1,1,10,10,'测试发帖','2015-07-20 10:57:07','2015-07-20 10:57:07','2015-07-20 10:57:07',2,0,0,0,0,NULL,0,0,NULL,NULL,1,',',0,29,1,0,0,NULL),(2,9,NULL,2,1,10,10,'测试发帖2','2015-07-20 11:11:55','2015-07-20 11:11:55','2015-07-20 11:11:55',1,0,0,0,0,NULL,0,0,NULL,NULL,0,',',0,40,1,0,0,NULL);

/*Table structure for table `bbs_topic_text` */

DROP TABLE IF EXISTS `bbs_topic_text`;

CREATE TABLE `bbs_topic_text` (
  `topic_id` int(11) NOT NULL,
  `title` varchar(100) default NULL COMMENT 'ä¸»é¢˜æ ‡é¢˜',
  PRIMARY KEY  (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='è®ºå›ä¸»é¢˜å†…å®¹';

/*Data for the table `bbs_topic_text` */

insert  into `bbs_topic_text`(`topic_id`,`title`) values (1,'测试发帖'),(2,'测试发帖2');

/*Table structure for table `bbs_user_group` */

DROP TABLE IF EXISTS `bbs_user_group`;

CREATE TABLE `bbs_user_group` (
  `GROUP_ID` int(11) NOT NULL auto_increment,
  `site_id` int(11) NOT NULL,
  `NAME` varchar(20) NOT NULL COMMENT 'å¤´è¡”',
  `GROUP_TYPE` smallint(6) NOT NULL default '0' COMMENT 'ç»„ç±»åˆ«',
  `GROUP_IMG` varchar(100) default NULL COMMENT 'å›¾ç‰‡',
  `GROUP_POINT` int(11) NOT NULL default '0' COMMENT 'å‡çº§ç§¯åˆ†',
  `IS_DEFAULT` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦é»˜è®¤ç»„',
  `GRADE_NUM` int(11) default '0' COMMENT 'è¯„åˆ†',
  `magic_packet_size` int(11) default NULL COMMENT 'ç”¨æˆ·ç»„é“å…·åŒ…å®¹é‡',
  PRIMARY KEY  (`GROUP_ID`),
  KEY `FK_BBS_GROUP_SITE` (`site_id`),
  CONSTRAINT `FK_BBS_GROUP_SITE` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='è®ºå›ä¼šå‘˜ç»„';

/*Data for the table `bbs_user_group` */

insert  into `bbs_user_group`(`GROUP_ID`,`site_id`,`NAME`,`GROUP_TYPE`,`GROUP_IMG`,`GROUP_POINT`,`IS_DEFAULT`,`GRADE_NUM`,`magic_packet_size`) values (1,1,'白丁',1,'1',0,1,0,0),(2,1,'童生',1,'2',10,0,0,20),(3,1,'秀才',1,'3',50,0,0,30),(4,1,'举人',1,'4',100,0,0,40),(5,1,'解元',1,'5',200,0,0,50),(6,1,'贡士',1,'6',400,0,0,60),(7,1,'会元',1,'7',800,0,0,70),(8,1,'进士',1,'8',1600,0,0,0),(9,1,'探花',1,'9',3200,0,0,80),(10,1,'榜眼',1,'10',6400,0,0,90),(11,1,'状元',1,'11',12800,0,0,100),(12,1,'版主',2,'21',0,0,0,0),(13,1,'VIP会员',3,'10',0,0,0,100),(14,1,'游客',0,'1',0,0,2,10);

/*Table structure for table `bbs_user_online` */

DROP TABLE IF EXISTS `bbs_user_online`;

CREATE TABLE `bbs_user_online` (
  `user_id` int(11) NOT NULL auto_increment,
  `online_latest` double(10,2) default NULL COMMENT 'æœ€åŽç™»å½•æ—¶é•¿',
  `online_day` double(10,2) default NULL COMMENT 'ä»Šæ—¥åœ¨çº¿æ—¶é•¿',
  `online_week` double(10,2) default NULL COMMENT 'æœ¬å‘¨åœ¨çº¿',
  `online_month` double(10,2) default NULL COMMENT 'æœ¬æœˆåœ¨çº¿',
  `online_year` double(10,2) default NULL COMMENT 'æœ¬å¹´åœ¨çº¿',
  `online_total` double(10,2) default NULL COMMENT 'æ€»åœ¨çº¿æ—¶é•¿',
  PRIMARY KEY  (`user_id`),
  CONSTRAINT `fk_bbs_user_online_user` FOREIGN KEY (`user_id`) REFERENCES `jb_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=gbk COMMENT='ç”¨æˆ·åœ¨çº¿æ—¶é•¿ç»Ÿè®¡';

/*Data for the table `bbs_user_online` */

insert  into `bbs_user_online`(`user_id`,`online_latest`,`online_day`,`online_week`,`online_month`,`online_year`,`online_total`) values (5,20.00,929.23,929.23,929.23,929.23,929.23),(9,3.38,114.46,114.46,114.46,114.46,114.46),(10,15.00,124.34,124.34,124.34,124.34,124.34);

/*Table structure for table `bbs_vote_item` */

DROP TABLE IF EXISTS `bbs_vote_item`;

CREATE TABLE `bbs_vote_item` (
  `item_id` int(11) NOT NULL auto_increment,
  `topic_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `vote_count` int(11) NOT NULL default '0' COMMENT 'ç¥¨æ•°',
  PRIMARY KEY  (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `bbs_vote_item` */

insert  into `bbs_vote_item`(`item_id`,`topic_id`,`name`,`vote_count`) values (1,3,'非常多',0),(2,3,'很多',0),(3,3,'一般般',0),(4,3,'少',0);

/*Table structure for table `bbs_vote_record` */

DROP TABLE IF EXISTS `bbs_vote_record`;

CREATE TABLE `bbs_vote_record` (
  `record_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `topic_id` int(11) default NULL,
  `vote_time` datetime default NULL COMMENT 'æŠ•ç¥¨æ—¶é—´',
  PRIMARY KEY  (`record_id`),
  KEY `fk_vote_record_user` (`user_id`),
  KEY `fk_vote_record_topic` (`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bbs_vote_record` */

/*Table structure for table `jb_friendship` */

DROP TABLE IF EXISTS `jb_friendship`;

CREATE TABLE `jb_friendship` (
  `friendship_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `friend_id` int(11) NOT NULL default '0',
  `status` tinyint(1) NOT NULL default '0' COMMENT 'å¥½å‹çŠ¶æ€(0:ç”³è¯·ä¸­;1:æŽ¥å—;2:æ‹’ç»)',
  PRIMARY KEY  (`friendship_id`),
  KEY `fk_jb_friendship_friend` (`friend_id`),
  KEY `fk_jb_friendship_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jb_friendship` */

/*Table structure for table `jb_message` */

DROP TABLE IF EXISTS `jb_message`;

CREATE TABLE `jb_message` (
  `msg_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `sender` int(11) default NULL COMMENT 'å‘é€äºº',
  `receiver` int(11) NOT NULL default '0' COMMENT 'æŽ¥æ”¶äºº',
  `content` longtext character set gbk NOT NULL COMMENT 'å†…å®¹',
  `create_time` datetime default NULL COMMENT 'å‘é€æ—¶é—´',
  `is_sys` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ä¸ºç³»ç»Ÿæ¶ˆæ¯(0:ä¸æ˜¯;1:æ˜¯)',
  `msg_type` int(2) NOT NULL default '1' COMMENT '1æ¶ˆæ¯ï¼Œ2ç•™è¨€,3æ‰“æ‹›å‘¼',
  `is_read` tinyint(1) default '0' COMMENT 'ä¿¡æ¯çŠ¶æ€ 0æœªè¯» 1å·²è¯»',
  PRIMARY KEY  (`msg_id`),
  KEY `fk_jb_message_user` (`user_id`),
  KEY `fk_jb_message_receiver` (`receiver`),
  KEY `fk_jb_message_sender` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jb_message` */

/*Table structure for table `jb_message_reply` */

DROP TABLE IF EXISTS `jb_message_reply`;

CREATE TABLE `jb_message_reply` (
  `reply_id` int(11) NOT NULL auto_increment,
  `msg_id` int(11) NOT NULL default '0',
  `sender` int(11) default NULL,
  `receiver` int(11) NOT NULL default '0',
  `content` longtext NOT NULL,
  `create_time` datetime default NULL,
  PRIMARY KEY  (`reply_id`),
  KEY `fk_jb_reply_sender` (`sender`),
  KEY `fk_jb_reply_receiver` (`receiver`),
  KEY `fk_jb_reply_msg` (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jb_message_reply` */

/*Table structure for table `jb_user` */

DROP TABLE IF EXISTS `jb_user`;

CREATE TABLE `jb_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT 'ç”¨æˆ·å',
  `email` varchar(100) default NULL COMMENT 'é‚®ç®±',
  `register_time` datetime NOT NULL COMMENT 'æ³¨å†Œæ—¶é—´',
  `register_ip` varchar(50) NOT NULL default '127.0.0.1' COMMENT 'æ³¨å†ŒIP',
  `last_login_time` datetime NOT NULL COMMENT 'æœ€åŽç™»å½•æ—¶é—´',
  `last_login_ip` varchar(50) NOT NULL default '127.0.0.1' COMMENT 'æœ€åŽç™»å½•IP',
  `login_count` int(11) NOT NULL default '0' COMMENT 'ç™»å½•æ¬¡æ•°',
  `upload_total` bigint(20) NOT NULL default '0' COMMENT 'ä¸Šä¼ æ€»å¤§å°',
  `upload_size` int(11) NOT NULL default '0' COMMENT 'ä¸Šä¼ å¤§å°',
  `upload_date` date default NULL COMMENT 'ä¸Šä¼ æ—¥æœŸ',
  `is_admin` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ç®¡ç†å‘˜',
  `is_disabled` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ç¦ç”¨',
  `PROHIBIT_POST` smallint(6) NOT NULL default '0' COMMENT 'ç¦è¨€(0:ä¸ç¦è¨€;1:æ°¸ä¹…ç¦è¨€;2:å®šæœŸç¦è¨€)',
  `PROHIBIT_TIME` datetime default NULL COMMENT 'è§£ç¦æ—¶é—´',
  `GRADE_TODAY` int(11) default '0' COMMENT 'ä»Šæ—¥è¯„åˆ†',
  `UPLOAD_TODAY` int(11) default '0' COMMENT 'ä»Šæ—¥ä¸Šä¼ ',
  `POINT` bigint(20) default '0' COMMENT 'ç§¯åˆ†',
  `INTRODUCTION` varchar(255) default NULL COMMENT 'ä¸ªäººä»‹ç»',
  `SIGNED` varchar(255) default NULL COMMENT 'ä¸ªæ€§ç­¾å',
  `AVATAR` varchar(100) default NULL COMMENT 'ä¸ªäººå¤´åƒ',
  `AVATAR_TYPE` smallint(6) default '0' COMMENT 'å¤´åƒç±»åž‹',
  `TOPIC_COUNT` int(11) default '0' COMMENT 'ä¸»é¢˜æ€»æ•°',
  `REPLY_COUNT` int(11) default '0' COMMENT 'å›žå¤æ€»æ•°',
  `PRIME_COUNT` int(11) default '0' COMMENT 'ç²¾åŽæ€»æ•°',
  `POST_TODAY` int(11) default '0' COMMENT 'ä»Šæ—¥å‘å¸–',
  `LAST_POST_TIME` datetime default NULL COMMENT 'æœ€åŽå›žå¸–æ—¶é—´',
  `PRESTIGE` bigint(20) default '0' COMMENT 'å¨æœ›',
  `magic_packet_size` int(11) default NULL COMMENT 'ç”¨æˆ·é“å…·åŒ…çŽ°æœ‰å®¹é‡',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `ak_username` (`username`),
  KEY `FK_BBS_MEMBER_MEMBERGROUP` (`group_id`),
  CONSTRAINT `FK_BBS_MEMBER_MEMBERGROUP` FOREIGN KEY (`group_id`) REFERENCES `bbs_user_group` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BBSç”¨æˆ·è¡¨';

/*Data for the table `jb_user` */

insert  into `jb_user`(`user_id`,`group_id`,`username`,`email`,`register_time`,`register_ip`,`last_login_time`,`last_login_ip`,`login_count`,`upload_total`,`upload_size`,`upload_date`,`is_admin`,`is_disabled`,`PROHIBIT_POST`,`PROHIBIT_TIME`,`GRADE_TODAY`,`UPLOAD_TODAY`,`POINT`,`INTRODUCTION`,`SIGNED`,`AVATAR`,`AVATAR_TYPE`,`TOPIC_COUNT`,`REPLY_COUNT`,`PRIME_COUNT`,`POST_TODAY`,`LAST_POST_TIME`,`PRESTIGE`,`magic_packet_size`) values (5,1,'admin',NULL,'2011-03-17 12:02:04','127.0.0.1','2015-07-20 11:06:17','0:0:0:0:0:0:0:1',181,0,0,'2011-03-17',1,0,0,NULL,NULL,0,22,NULL,NULL,'/mosesBBS/user/images/201507/06105447xi0r.jpg',0,2,12,0,14,NULL,0,0),(9,12,'test','123@123.com','2011-04-11 00:38:08','127.0.0.1','2015-07-20 10:50:28','0:0:0:0:0:0:0:1',64,0,0,'2011-04-11',0,0,0,NULL,5,0,118,NULL,'','none.gif',0,23,7,1,30,NULL,3,0),(10,2,'chen','chen@163.com','2012-05-03 11:38:45','127.0.0.1','2015-07-20 11:17:25','192.168.1.3',7,0,0,'2012-05-03',0,0,0,NULL,NULL,0,15,NULL,NULL,NULL,0,3,0,0,3,NULL,3,0);

/*Table structure for table `jb_user_ext` */

DROP TABLE IF EXISTS `jb_user_ext`;

CREATE TABLE `jb_user_ext` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(100) default NULL COMMENT 'çœŸå®žå§“å',
  `gender` tinyint(1) default NULL COMMENT 'æ€§åˆ«',
  `avatar` varchar(100) default NULL COMMENT 'ç”¨æˆ·å¤´åƒ',
  `birthday` datetime default NULL COMMENT 'å‡ºç”Ÿæ—¥æœŸ',
  `intro` varchar(255) default NULL COMMENT 'ä¸ªäººä»‹ç»',
  `comefrom` varchar(150) default NULL COMMENT 'æ¥è‡ª',
  `qq` varchar(100) default NULL COMMENT 'QQ',
  `msn` varchar(100) default NULL COMMENT 'MSN',
  `phone` varchar(50) default NULL COMMENT 'ç”µè¯',
  `moble` varchar(50) default NULL COMMENT 'æ‰‹æœº',
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='BBSç”¨æˆ·æ‰©å±•ä¿¡æ¯è¡¨';

/*Data for the table `jb_user_ext` */

insert  into `jb_user_ext`(`user_id`,`realname`,`gender`,`avatar`,`birthday`,`intro`,`comefrom`,`qq`,`msn`,`phone`,`moble`) values (5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `jc_config` */

DROP TABLE IF EXISTS `jc_config`;

CREATE TABLE `jc_config` (
  `config_id` int(11) NOT NULL,
  `context_path` varchar(20) default '/JeeCms' COMMENT 'éƒ¨ç½²è·¯å¾„',
  `servlet_point` varchar(20) default NULL COMMENT 'ServletæŒ‚è½½ç‚¹',
  `port` int(11) default NULL COMMENT 'ç«¯å£',
  `db_file_uri` varchar(50) NOT NULL default '/dbfile.svl?n=' COMMENT 'æ•°æ®åº“é™„ä»¶è®¿é—®åœ°å€',
  `is_upload_to_db` tinyint(1) NOT NULL default '0' COMMENT 'ä¸Šä¼ é™„ä»¶è‡³æ•°æ®åº“',
  `def_img` varchar(255) NOT NULL default '/JeeCms/r/cms/www/default/no_picture.gif' COMMENT 'å›¾ç‰‡ä¸å­˜åœ¨æ—¶é»˜è®¤å›¾ç‰‡',
  `login_url` varchar(255) NOT NULL default '/login.jspx' COMMENT 'ç™»å½•åœ°å€',
  `process_url` varchar(255) default NULL COMMENT 'ç™»å½•åŽå¤„ç†åœ°å€',
  `mark_on` tinyint(1) NOT NULL default '1' COMMENT 'å¼€å¯å›¾ç‰‡æ°´å°',
  `mark_width` int(11) NOT NULL default '120' COMMENT 'å›¾ç‰‡æœ€å°å®½åº¦',
  `mark_height` int(11) NOT NULL default '120' COMMENT 'å›¾ç‰‡æœ€å°é«˜åº¦',
  `mark_image` varchar(100) default '/r/cms/www/watermark.png' COMMENT 'å›¾ç‰‡æ°´å°',
  `mark_content` varchar(100) NOT NULL default 'www.jeecms.com' COMMENT 'æ–‡å­—æ°´å°å†…å®¹',
  `mark_size` int(11) NOT NULL default '20' COMMENT 'æ–‡å­—æ°´å°å¤§å°',
  `mark_color` varchar(10) NOT NULL default '#FF0000' COMMENT 'æ–‡å­—æ°´å°é¢œè‰²',
  `mark_alpha` int(11) NOT NULL default '50' COMMENT 'æ°´å°é€æ˜Žåº¦ï¼ˆ0-100ï¼‰',
  `mark_position` int(11) NOT NULL default '1' COMMENT 'æ°´å°ä½ç½®(0-5)',
  `mark_offset_x` int(11) NOT NULL default '0' COMMENT 'xåæ ‡åç§»é‡',
  `mark_offset_y` int(11) NOT NULL default '0' COMMENT 'yåæ ‡åç§»é‡',
  `count_clear_time` date NOT NULL COMMENT 'è®¡æ•°å™¨æ¸…é™¤æ—¶é—´',
  `count_copy_time` datetime NOT NULL COMMENT 'è®¡æ•°å™¨æ‹·è´æ—¶é—´',
  `download_code` varchar(32) NOT NULL default 'jeecms' COMMENT 'ä¸‹è½½é˜²ç›—é“¾md5æ··æ·†ç ',
  `download_time` int(11) NOT NULL default '12' COMMENT 'ä¸‹è½½æœ‰æ•ˆæ—¶é—´ï¼ˆå°æ—¶ï¼‰',
  `email_host` varchar(50) default NULL COMMENT 'é‚®ä»¶å‘é€æœåŠ¡å™¨',
  `email_encoding` varchar(20) default NULL COMMENT 'é‚®ä»¶å‘é€ç¼–ç ',
  `email_username` varchar(100) default NULL COMMENT 'é‚®ç®±ç”¨æˆ·å',
  `email_password` varchar(100) default NULL COMMENT 'é‚®ç®±å¯†ç ',
  `email_personal` varchar(100) default NULL COMMENT 'é‚®ç®±å‘ä»¶äºº',
  PRIMARY KEY  (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMSé…ç½®è¡¨';

/*Data for the table `jc_config` */

insert  into `jc_config`(`config_id`,`context_path`,`servlet_point`,`port`,`db_file_uri`,`is_upload_to_db`,`def_img`,`login_url`,`process_url`,`mark_on`,`mark_width`,`mark_height`,`mark_image`,`mark_content`,`mark_size`,`mark_color`,`mark_alpha`,`mark_position`,`mark_offset_x`,`mark_offset_y`,`count_clear_time`,`count_copy_time`,`download_code`,`download_time`,`email_host`,`email_encoding`,`email_username`,`email_password`,`email_personal`) values (1,'/mosesBBS',NULL,8080,'/dbfile.svl?n=',0,'/r/cms/www/no_picture.gif','/login.jspx',NULL,1,120,120,'/r/cms/www/watermark.png','www.jeecms.com',20,'#FF0000',50,1,0,0,'2011-12-26','2011-12-26 13:32:26','jeecms',12,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `jc_friendlink` */

DROP TABLE IF EXISTS `jc_friendlink`;

CREATE TABLE `jc_friendlink` (
  `friendlink_id` int(11) NOT NULL auto_increment,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_id` int(11) NOT NULL,
  `site_name` varchar(150) NOT NULL COMMENT 'ç½‘ç«™åç§°',
  `domain` varchar(255) NOT NULL COMMENT 'ç½‘ç«™åœ°å€',
  `logo` varchar(150) default NULL COMMENT 'å›¾æ ‡',
  `email` varchar(100) default NULL COMMENT 'ç«™é•¿é‚®ç®±',
  `description` varchar(255) default NULL COMMENT 'æè¿°',
  `views` int(11) NOT NULL default '0' COMMENT 'ç‚¹å‡»æ¬¡æ•°',
  `is_enabled` char(1) NOT NULL default '1' COMMENT 'æ˜¯å¦æ˜¾ç¤º',
  `priority` int(11) NOT NULL default '10' COMMENT 'æŽ’åˆ—é¡ºåº',
  PRIMARY KEY  (`friendlink_id`),
  KEY `fk_jc_ctg_friendlink` (`friendlinkctg_id`),
  KEY `fk_jc_friendlink_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMSå‹æƒ…é“¾æŽ¥';

/*Data for the table `jc_friendlink` */

/*Table structure for table `jc_friendlink_ctg` */

DROP TABLE IF EXISTS `jc_friendlink_ctg`;

CREATE TABLE `jc_friendlink_ctg` (
  `friendlinkctg_id` int(11) NOT NULL auto_increment,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_name` varchar(50) NOT NULL COMMENT 'åç§°',
  `priority` int(11) NOT NULL default '10' COMMENT 'æŽ’åˆ—é¡ºåº',
  PRIMARY KEY  (`friendlinkctg_id`),
  KEY `fk_jc_friendlinkctg_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMSå‹æƒ…é“¾æŽ¥ç±»åˆ«';

/*Data for the table `jc_friendlink_ctg` */

/*Table structure for table `jc_sensitivity` */

DROP TABLE IF EXISTS `jc_sensitivity`;

CREATE TABLE `jc_sensitivity` (
  `sensitivity_id` int(11) NOT NULL auto_increment,
  `site_id` int(11) default NULL,
  `search` varchar(255) NOT NULL COMMENT 'æ•æ„Ÿè¯',
  `replacement` varchar(255) NOT NULL COMMENT 'æ›¿æ¢è¯',
  PRIMARY KEY  (`sensitivity_id`),
  KEY `fk_sensitivity_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMSæ•æ„Ÿè¯è¡¨';

/*Data for the table `jc_sensitivity` */

/*Table structure for table `jc_site` */

DROP TABLE IF EXISTS `jc_site`;

CREATE TABLE `jc_site` (
  `site_id` int(11) NOT NULL auto_increment,
  `config_id` int(11) NOT NULL COMMENT 'é…ç½®ID',
  `ftp_upload_id` int(11) default NULL COMMENT 'ä¸Šä¼ ftp',
  `domain` varchar(50) NOT NULL COMMENT 'åŸŸå',
  `site_path` varchar(20) NOT NULL COMMENT 'è·¯å¾„',
  `site_name` varchar(100) NOT NULL COMMENT 'ç½‘ç«™åç§°',
  `short_name` varchar(100) NOT NULL COMMENT 'ç®€çŸ­åç§°',
  `protocol` varchar(20) NOT NULL default 'http://' COMMENT 'åè®®',
  `dynamic_suffix` varchar(10) NOT NULL default '.jhtml' COMMENT 'åŠ¨æ€é¡µåŽç¼€',
  `static_suffix` varchar(10) NOT NULL default '.html' COMMENT 'é™æ€é¡µåŽç¼€',
  `static_dir` varchar(50) default NULL COMMENT 'é™æ€é¡µå­˜æ”¾ç›®å½•',
  `is_index_to_root` char(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ä½¿ç”¨å°†é¦–é¡µæ”¾åœ¨æ ¹ç›®å½•ä¸‹',
  `is_static_index` char(1) NOT NULL default '0' COMMENT 'æ˜¯å¦é™æ€åŒ–é¦–é¡µ',
  `locale_admin` varchar(10) NOT NULL default 'zh_CN' COMMENT 'åŽå°æœ¬åœ°åŒ–',
  `locale_front` varchar(10) NOT NULL default 'zh_CN' COMMENT 'å‰å°æœ¬åœ°åŒ–',
  `tpl_solution` varchar(50) NOT NULL default 'default' COMMENT 'æ¨¡æ¿æ–¹æ¡ˆ',
  `final_step` tinyint(4) NOT NULL default '2' COMMENT 'ç»ˆå®¡çº§åˆ«',
  `after_check` tinyint(4) NOT NULL default '2' COMMENT 'å®¡æ ¸åŽ(1:ä¸èƒ½ä¿®æ”¹åˆ é™¤;2:ä¿®æ”¹åŽé€€å›ž;3:ä¿®æ”¹åŽä¸å˜)',
  `is_relative_path` char(1) NOT NULL default '1' COMMENT 'æ˜¯å¦ä½¿ç”¨ç›¸å¯¹è·¯å¾„',
  `is_recycle_on` char(1) NOT NULL default '1' COMMENT 'æ˜¯å¦å¼€å¯å›žæ”¶ç«™',
  `domain_alias` varchar(255) default NULL COMMENT 'åŸŸååˆ«å',
  `domain_redirect` varchar(255) default NULL COMMENT 'åŸŸåé‡å®šå‘',
  `creditex_id` int(11) default '1' COMMENT 'ç§¯åˆ†äº¤æ˜“è§„åˆ™id',
  PRIMARY KEY  (`site_id`),
  UNIQUE KEY `ak_domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='ç«™ç‚¹è¡¨';

/*Data for the table `jc_site` */

insert  into `jc_site`(`site_id`,`config_id`,`ftp_upload_id`,`domain`,`site_path`,`site_name`,`short_name`,`protocol`,`dynamic_suffix`,`static_suffix`,`static_dir`,`is_index_to_root`,`is_static_index`,`locale_admin`,`locale_front`,`tpl_solution`,`final_step`,`after_check`,`is_relative_path`,`is_recycle_on`,`domain_alias`,`domain_redirect`,`creditex_id`) values (1,1,NULL,'localhost','www','国防大学防务学院论坛','cdsndu bbs','http://','.jhtml','.html',NULL,'0','0','zh_CN','zh_CN','blue',2,2,'1','1','','',1);

/*Table structure for table `jo_authentication` */

DROP TABLE IF EXISTS `jo_authentication`;

CREATE TABLE `jo_authentication` (
  `authentication_id` char(32) NOT NULL COMMENT 'è®¤è¯ID',
  `userid` int(11) NOT NULL COMMENT 'ç”¨æˆ·ID',
  `username` varchar(100) NOT NULL COMMENT 'ç”¨æˆ·å',
  `email` varchar(100) default NULL COMMENT 'é‚®ç®±',
  `login_time` datetime NOT NULL COMMENT 'ç™»å½•æ—¶é—´',
  `login_ip` varchar(50) NOT NULL COMMENT 'ç™»å½•ip',
  `update_time` datetime NOT NULL COMMENT 'æ›´æ–°æ—¶é—´',
  PRIMARY KEY  (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='è®¤è¯ä¿¡æ¯è¡¨';

/*Data for the table `jo_authentication` */

insert  into `jo_authentication`(`authentication_id`,`userid`,`username`,`email`,`login_time`,`login_ip`,`update_time`) values ('0012afbd46e242ceb74c3025903b4cb3',5,'admin',NULL,'2015-07-02 16:53:08','0:0:0:0:0:0:0:1','2015-07-02 16:53:09'),('06e5c772c4ca4a88a782c2ddf128cd97',5,'admin',NULL,'2015-07-20 11:06:17','0:0:0:0:0:0:0:1','2015-07-20 11:29:58'),('135e397b26e74a78ac776ecbc719633b',10,'chen','chen@163.com','2015-07-20 11:17:25','192.168.1.3','2015-07-20 11:31:44'),('1527d7463b564caeb3646e442c85fbd1',5,'admin',NULL,'2015-01-15 10:12:14','0:0:0:0:0:0:0:1%0','2015-01-15 10:28:31'),('21b96bacb7f34947b219fc57e5feff5e',5,'admin','wudily2010@1631.com','2012-04-19 10:09:28','127.0.0.1','2012-04-19 11:34:00'),('22cc4c8f46b841d4934272523d9e3d33',18,'xinyonghu','pass@pa.comaaa','2012-05-02 10:28:18','127.0.0.1','2012-05-02 12:10:35'),('2b2eabe4321048eca710b55fc01232d4',5,'admin',NULL,'2015-07-10 17:19:53','0:0:0:0:0:0:0:1','2015-07-10 17:27:06'),('3f3ee764616141b8b531e1c49327e45b',5,'admin',NULL,'2015-07-02 16:21:30','0:0:0:0:0:0:0:1','2015-07-02 16:21:57'),('48d01318dae84b70b8ee6025719b3171',9,'test','123@123.com','2012-05-03 11:19:16','127.0.0.1','2012-05-03 11:28:10'),('50666fcc6ea04bd49d4c0d5f3d637c62',5,'admin',NULL,'2015-01-14 19:25:30','0:0:0:0:0:0:0:1%0','2015-01-14 19:27:49'),('56d083abcecd4a15ab6454e8ee8d8a17',5,'admin',NULL,'2015-01-15 12:08:09','0:0:0:0:0:0:0:1%0','2015-01-15 12:08:19'),('58b897237f5045a3bd14b002b55fbd4b',5,'admin','dlycmsmoses@163.com','2015-01-16 16:19:31','0:0:0:0:0:0:0:1%0','2015-01-16 18:41:07'),('5fa33a1c21eb49db8f4151f4e7aaaeaf',5,'admin',NULL,'2015-07-20 10:46:37','0:0:0:0:0:0:0:1','2015-07-20 11:00:27'),('69b54e32ffaf48409bbfdb60bb733000',5,'admin',NULL,'2012-05-03 10:55:56','127.0.0.1','2012-05-03 11:27:09'),('759d42085c5749cfa7e76de5c4e1d72e',19,'xinxin','ad@la.com','2012-04-19 09:48:58','127.0.0.1','2012-04-19 11:33:13'),('7cee23f8ed6346bfa9d6d8a12ae07cdb',5,'admin',NULL,'2015-01-15 14:24:22','0:0:0:0:0:0:0:1%0','2015-01-15 18:23:14'),('7e6eda8d541e46fbb7372b0c4442c058',5,'admin','dlycmsmoses@163.com','2015-01-19 11:23:54','0:0:0:0:0:0:0:1%0','2015-01-19 11:25:44'),('7f9dcf59208041188cddd7d35787a849',6,'korven','jeecms@163.com','2012-05-02 17:50:06','127.0.0.1','2012-05-02 18:04:09'),('830f6b6990b34b028347e234b0098e2f',5,'admin','dlycmsmoses@163.com','2015-03-16 10:31:48','0:0:0:0:0:0:0:1','2015-03-16 11:34:41'),('84b9c779add84c339d0fc870cb92311d',19,'xinxin','ad@la.com','2012-04-18 09:41:29','127.0.0.1','2012-04-18 16:43:50'),('89ac7b01196b45869e7962c02a9c082c',5,'admin',NULL,'2015-01-14 19:12:12','0:0:0:0:0:0:0:1%0','2015-01-14 19:15:58'),('92020a1ede2247348883184184e1b37b',5,'admin',NULL,'2012-05-02 09:20:53','127.0.0.1','2012-05-02 12:18:54'),('9dbeb2282a2d478a948785ef507b7101',10,'chen','chen@163.com','2015-07-20 10:59:36','0:0:0:0:0:0:0:1','2015-07-20 11:01:01'),('a2b4a46a0f684a35877e96860c4b1282',5,'admin',NULL,'2012-05-03 11:40:45','127.0.0.1','2012-05-03 13:35:57'),('a3459e00d5c24b558290e747f8c96c74',9,'test','123@123.com','2015-01-15 10:15:53','0:0:0:0:0:0:0:1%0','2015-01-15 12:04:13'),('a8b69877d7d64b119e04755f18f33c49',5,'admin',NULL,'2015-03-16 12:03:59','0:0:0:0:0:0:0:1','2015-03-16 12:41:32'),('ad9dca6021b74d66bf16c67f00a2e4d0',5,'admin',NULL,'2015-07-02 16:27:43','0:0:0:0:0:0:0:1','2015-07-02 16:27:43'),('b107c45fb51a4d6687f047fab4eecc4c',5,'admin',NULL,'2015-07-03 10:09:02','0:0:0:0:0:0:0:1','2015-07-03 10:10:50'),('b1ebc61b056942ea888aac49c4b71cc9',5,'admin',NULL,'2015-07-02 16:17:47','0:0:0:0:0:0:0:1','2015-07-02 16:18:08'),('bcf1e070828f4d5cad7f162575c8249e',5,'admin',NULL,'2012-05-02 15:12:38','127.0.0.1','2012-05-02 15:26:25'),('bd59a64dbe4041feb2f889699d48bfea',18,'xinyonghu','pass@pa.comaaa','2012-05-02 17:14:46','127.0.0.1','2012-05-02 18:04:55'),('c92570362f874af7bd56e796cf7cc63a',10,'chen','chen@163.com','2015-07-20 11:06:40','0:0:0:0:0:0:0:1','2015-07-20 11:32:21'),('cc1cf3e7221c4796a0d55954e50ac0a8',5,'admin','dlycmsmoses@163.com','2015-01-15 14:41:33','0:0:0:0:0:0:0:1%0','2015-01-15 18:22:22'),('d04d06caef91422ab3783a9eed440ade',5,'admin','dlycmsmoses@163.com','2015-03-16 10:25:22','0:0:0:0:0:0:0:1','2015-03-16 10:25:55'),('db2fd3ef98884fbb90b0d04f1e29f1b2',5,'admin',NULL,'2015-07-06 10:53:31','0:0:0:0:0:0:0:1','2015-07-06 11:10:35'),('dd54b46b56514a4ab4210abb7fdde92c',10,'chen','chen@163.com','2012-05-03 12:00:27','127.0.0.1','2012-05-03 13:31:22'),('de78276f70274671997c4b9c250bf88d',5,'admin','dlycmsmoses@163.com','2015-01-19 11:30:30','0:0:0:0:0:0:0:1%0','2015-01-19 11:31:20'),('e2064f6f68184195a8267b6818fcf45a',5,'admin','dlycmsmoses@163.com','2015-03-16 10:30:07','0:0:0:0:0:0:0:1','2015-03-16 10:30:07'),('e3039521f1584c028a1ab0782cf0d155',5,'admin',NULL,'2015-07-02 16:19:52','0:0:0:0:0:0:0:1','2015-07-02 16:20:48'),('e3f5d77a1697496c954fd66c45bc8876',5,'admin','dlycmsmoses@163.com','2015-03-16 10:26:32','0:0:0:0:0:0:0:1','2015-03-16 10:30:06'),('e5cdce6555bf4bed8f30d4a4e3e460d4',5,'admin',NULL,'2015-07-02 16:26:05','0:0:0:0:0:0:0:1','2015-07-02 16:26:31'),('e824a829f66f4976bae1e3edc90ec835',5,'admin',NULL,'2015-07-02 16:23:04','0:0:0:0:0:0:0:1','2015-07-02 16:23:15'),('ea7ad6046095409b8165a871fe36828c',5,'admin','dlycmsmoses@163.com','2015-01-19 11:28:07','0:0:0:0:0:0:0:1%0','2015-01-19 11:28:27'),('f38daf4ce4764861ba087ac8107ff01e',5,'admin','wudily2010@1631.com','2012-04-19 13:36:14','127.0.0.1','2012-04-19 18:00:43'),('fd25e10b5f8a4031b6834799553b8b4b',5,'admin','dlycmsmoses@163.com','2015-03-16 10:12:01','0:0:0:0:0:0:0:1','2015-03-16 10:24:26'),('fe00d4a7dfeb4f77af6833071fe01b30',5,'admin',NULL,'2015-01-14 19:28:46','0:0:0:0:0:0:0:1%0','2015-01-14 19:40:58');

/*Table structure for table `jo_config` */

DROP TABLE IF EXISTS `jo_config`;

CREATE TABLE `jo_config` (
  `cfg_key` varchar(50) NOT NULL COMMENT 'é…ç½®KEY',
  `cfg_value` varchar(255) default NULL COMMENT 'é…ç½®VALUE',
  PRIMARY KEY  (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='é…ç½®è¡¨';

/*Data for the table `jo_config` */

insert  into `jo_config`(`cfg_key`,`cfg_value`) values ('email_encoding','utf-8'),('email_host','smtp.163.com'),('email_password','jeecms2012strong'),('email_personal','moses'),('email_port',NULL),('email_username','dlycmsmoses@163.com'),('login_error_interval','30'),('login_error_times','2'),('message_forgotpassword_subject','会员密码找回信息'),('message_forgotpassword_text','感谢您使用系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost:8080/jeebbs3beta/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n'),('message_register_subject','会员注册信息'),('message_register_text','${username}您好：\r\n欢迎您注册系统会员\r\n请点击以下链接进行激活\r\nhttp://localhost:8080/jeebbs3beta/active.jspx?username=${username}&key=${activationCode}\r\n'),('message_subject','JEECMS会员密码找回信息'),('message_text','感谢您使用JEECMS系统会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n');

/*Table structure for table `jo_ftp` */

DROP TABLE IF EXISTS `jo_ftp`;

CREATE TABLE `jo_ftp` (
  `ftp_id` int(11) NOT NULL auto_increment,
  `ftp_name` varchar(100) NOT NULL COMMENT 'åç§°',
  `ip` varchar(50) NOT NULL COMMENT 'IP',
  `port` int(11) NOT NULL default '21' COMMENT 'ç«¯å£å·',
  `username` varchar(100) default NULL COMMENT 'ç™»å½•å',
  `password` varchar(100) default NULL COMMENT 'ç™»é™†å¯†ç ',
  `encoding` varchar(20) NOT NULL default 'UTF-8' COMMENT 'ç¼–ç ',
  `timeout` int(11) default NULL COMMENT 'è¶…æ—¶æ—¶é—´',
  `ftp_path` varchar(255) default NULL COMMENT 'è·¯å¾„',
  `url` varchar(255) NOT NULL COMMENT 'è®¿é—®URL',
  PRIMARY KEY  (`ftp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTPè¡¨';

/*Data for the table `jo_ftp` */

/*Table structure for table `jo_template` */

DROP TABLE IF EXISTS `jo_template`;

CREATE TABLE `jo_template` (
  `tpl_name` varchar(150) NOT NULL COMMENT 'æ¨¡æ¿åç§°',
  `tpl_source` longtext COMMENT 'æ¨¡æ¿å†…å®¹',
  `last_modified` bigint(20) NOT NULL COMMENT 'æœ€åŽä¿®æ”¹æ—¶é—´',
  `is_directory` tinyint(1) NOT NULL default '0' COMMENT 'æ˜¯å¦ç›®å½•',
  PRIMARY KEY  (`tpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='æ¨¡æ¿è¡¨';

/*Data for the table `jo_template` */

/*Table structure for table `jo_upload` */

DROP TABLE IF EXISTS `jo_upload`;

CREATE TABLE `jo_upload` (
  `filename` varchar(150) NOT NULL COMMENT 'æ–‡ä»¶å',
  `length` int(11) NOT NULL COMMENT 'æ–‡ä»¶å¤§å°(å­—èŠ‚)',
  `last_modified` bigint(20) NOT NULL COMMENT 'æœ€åŽä¿®æ”¹æ—¶é—´',
  `content` longblob NOT NULL COMMENT 'å†…å®¹',
  PRIMARY KEY  (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ä¸Šä¼ é™„ä»¶è¡¨';

/*Data for the table `jo_upload` */

/*Table structure for table `jo_user` */

DROP TABLE IF EXISTS `jo_user`;

CREATE TABLE `jo_user` (
  `user_id` int(11) NOT NULL auto_increment COMMENT 'ç”¨æˆ·ID',
  `username` varchar(100) NOT NULL COMMENT 'ç”¨æˆ·å',
  `email` varchar(100) default NULL COMMENT 'ç”µå­é‚®ç®±',
  `password` char(32) NOT NULL COMMENT 'å¯†ç ',
  `register_time` datetime NOT NULL COMMENT 'æ³¨å†Œæ—¶é—´',
  `register_ip` varchar(50) NOT NULL default '127.0.0.1' COMMENT 'æ³¨å†ŒIP',
  `last_login_time` datetime NOT NULL COMMENT 'æœ€åŽç™»å½•æ—¶é—´',
  `last_login_ip` varchar(50) NOT NULL default '127.0.0.1' COMMENT 'æœ€åŽç™»å½•IP',
  `login_count` int(11) NOT NULL default '0' COMMENT 'ç™»å½•æ¬¡æ•°',
  `reset_key` char(32) default NULL COMMENT 'é‡ç½®å¯†ç KEY',
  `reset_pwd` varchar(10) default NULL COMMENT 'é‡ç½®å¯†ç VALUE',
  `activation` tinyint(1) NOT NULL default '0' COMMENT 'æ¿€æ´»çŠ¶æ€',
  `activation_code` char(32) default NULL COMMENT 'æ¿€æ´»ç ',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `ak_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='ç”¨æˆ·è¡¨';

/*Data for the table `jo_user` */

insert  into `jo_user`(`user_id`,`username`,`email`,`password`,`register_time`,`register_ip`,`last_login_time`,`last_login_ip`,`login_count`,`reset_key`,`reset_pwd`,`activation`,`activation_code`) values (5,'admin',NULL,'e10adc3949ba59abbe56e057f20f883e','2011-03-17 12:02:04','127.0.0.1','2015-07-20 11:06:17','0:0:0:0:0:0:0:1',181,NULL,NULL,1,NULL),(9,'test','123@123.com','e10adc3949ba59abbe56e057f20f883e','2011-04-11 00:38:08','127.0.0.1','2015-07-20 10:50:28','0:0:0:0:0:0:0:1',64,NULL,NULL,1,NULL),(10,'chen','chen@163.com','e10adc3949ba59abbe56e057f20f883e','2012-05-03 11:38:45','127.0.0.1','2015-07-20 11:17:25','192.168.1.3',7,NULL,NULL,1,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
