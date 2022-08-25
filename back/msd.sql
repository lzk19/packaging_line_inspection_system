/*
 Navicat Premium Data Transfer

 Source Server         : yijing
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : localhost:3306
 Source Schema         : msd

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 25/08/2022 10:33:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `size` bigint(0) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` VALUES ('coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');
INSERT INTO `sys_dict` VALUES ('setting', 'el-icon-setting', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-s-data', 'el-icon-s-data', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-thumb', 'el-icon-thumb', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-data-analysis', 'el-icon-data-analysis', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-guide', 'el-icon-guide', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-edit', 'el-icon-edit', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-chat-line-round', 'el-icon-chat-line-round', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-suitcase', 'el-icon-suitcase', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-takeaway-box', 'el-icon-takeaway-box', 'icon');
INSERT INTO `sys_dict` VALUES ('el-icon-delete', 'el-icon-delete', 'icon');

-- ----------------------------
-- Table structure for sys_efficiency
-- ----------------------------
DROP TABLE IF EXISTS `sys_efficiency`;
CREATE TABLE `sys_efficiency`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `effiq1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `effiq2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `effiq3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `effiq4answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_efficiency
-- ----------------------------
INSERT INTO `sys_efficiency` VALUES (12, '张三', '2022-04-07', '白班', '1号线', '1', '1', '1', '0.3');
INSERT INTO `sys_efficiency` VALUES (13, '张三', '2022-04-08', '白班', '1号线', '2', '21', '2', '0.5');
INSERT INTO `sys_efficiency` VALUES (14, '张三', '2022-04-09', '白班', '1号线', '1', '11', '1', '0.6');
INSERT INTO `sys_efficiency` VALUES (15, '张三', '2022-04-10', '白班', '1号线', '1', '1', '1', '0.9');
INSERT INTO `sys_efficiency` VALUES (16, NULL, '2022-04-11', '白班', '2号线', '+4', '+2', 'T30596', '0.8');

-- ----------------------------
-- Table structure for sys_event
-- ----------------------------
DROP TABLE IF EXISTS `sys_event`;
CREATE TABLE `sys_event`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `machineName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机器名',
  `eventName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '事件名',
  `eventType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `describe1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `happenPlace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `problemDefect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `actions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tracks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `isCloseEvent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fileName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_event
-- ----------------------------
INSERT INTO `sys_event` VALUES (41, '6', '2020.4.1', '检测器', '损坏', '设备', '检测器的显示屏损坏', '一号线', '进水了', '不能使用', '进行修复', '', '0', '皮辊损坏.png', 'http://localhost:9000/2e6bbdce8e6b45be9d44bae910279887');

-- ----------------------------
-- Table structure for sys_guidance
-- ----------------------------
DROP TABLE IF EXISTS `sys_guidance`;
CREATE TABLE `sys_guidance`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gdq1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gdq2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `gdq3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_guidance
-- ----------------------------
INSERT INTO `sys_guidance` VALUES (23, '王五', '2022-04-01', '白班', '1号线', '1号线员工CUCO操作流程正确', '已完成抽查', '否');
INSERT INTO `sys_guidance` VALUES (24, '李四', '2022-04-11', '夜班', '6号线', '6号线员工CUCO操作流程正确', '已完成抽查', '是');
INSERT INTO `sys_guidance` VALUES (25, '张三', '2022-04-12', '白班', '2号线', '2号线员工CUCO操作流程正确', '已完成抽查', '是');

-- ----------------------------
-- Table structure for sys_handover
-- ----------------------------
DROP TABLE IF EXISTS `sys_handover`;
CREATE TABLE `sys_handover`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `common` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '通用通知',
  `special` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '专线通知',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_handover
-- ----------------------------
INSERT INTO `sys_handover` VALUES (4, '张三', '2022-04-01', '白班', '1号线', '1', '1');
INSERT INTO `sys_handover` VALUES (5, '李四', '2022-04-04', '白班', '1号线', '今天是阴天', '今天是晴天');
INSERT INTO `sys_handover` VALUES (6, '张三', '2022-04-01', '白班', '1号线', '今天全线放假', '今天1号线留下来加班');
INSERT INTO `sys_handover` VALUES (7, '张三', '2022-04-01', '白班', '1号线', '全线员工于今日15:30前往会议室开会', '二号线线长请尽快提交记录日志');

-- ----------------------------
-- Table structure for sys_headerdata
-- ----------------------------
DROP TABLE IF EXISTS `sys_headerdata`;
CREATE TABLE `sys_headerdata`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL COMMENT '日期',
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '班次',
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '线号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_headerdata
-- ----------------------------
INSERT INTO `sys_headerdata` VALUES (88, '张三', '2022-04-01', '白班', '1号线');
INSERT INTO `sys_headerdata` VALUES (89, 'KK', '2022-04-02', '夜班', '4号线');
INSERT INTO `sys_headerdata` VALUES (90, '张三', '2022-04-01', '白班', '3号线');
INSERT INTO `sys_headerdata` VALUES (91, '张三', '2022-04-01', '白班', '3号线');
INSERT INTO `sys_headerdata` VALUES (92, '李四', '2022-04-04', '白班', '1号线');
INSERT INTO `sys_headerdata` VALUES (93, '张三', '2022-04-01', '白班', '1号线');
INSERT INTO `sys_headerdata` VALUES (94, '张三', '2022-04-21', '白班', '2号线');
INSERT INTO `sys_headerdata` VALUES (95, '刘正凯', '2022-08-02', '白班', '2号线');

-- ----------------------------
-- Table structure for sys_inspect
-- ----------------------------
DROP TABLE IF EXISTS `sys_inspect`;
CREATE TABLE `sys_inspect`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sfq1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sfq2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sfq3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq4answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq5answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `qlq6answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_inspect
-- ----------------------------
INSERT INTO `sys_inspect` VALUES (6, '张三', '2022-04-01', '白班', '1号线', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `sys_inspect` VALUES (7, '李四', '2022-04-04', '白班', '1号线', '2222', '11', '11', '11', '11', '11', '11', '11', '11');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `pid` int(0) NULL DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '页面路径',
  `sort_num` int(0) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (4, '系统管理', NULL, 'el-icon-menu', NULL, NULL, NULL, 300);
INSERT INTO `sys_menu` VALUES (5, '用户管理', '/user', 'el-icon-user', NULL, 4, 'User', 301);
INSERT INTO `sys_menu` VALUES (6, '角色管理', '/role', 'el-icon-s-custom', NULL, 4, 'Role', 302);
INSERT INTO `sys_menu` VALUES (7, '巡检普通板块', '', 'el-icon-guide', NULL, NULL, '', 400);
INSERT INTO `sys_menu` VALUES (8, 'Tier会议', '/tier', 'el-icon-data-analysis', NULL, 7, 'Tier', 401);
INSERT INTO `sys_menu` VALUES (9, '巡检管理', '/inspect', 'el-icon-takeaway-box', NULL, 7, 'Inspect', 402);
INSERT INTO `sys_menu` VALUES (10, '主页', '/home', 'el-icon-house', NULL, NULL, 'Home', 0);
INSERT INTO `sys_menu` VALUES (11, '指导抽查', '/guidance', 'el-icon-thumb', NULL, 7, 'Guidance', 404);
INSERT INTO `sys_menu` VALUES (12, '交接内容', '/handover', 'el-icon-s-data', NULL, 7, 'Handover', 405);
INSERT INTO `sys_menu` VALUES (13, '巡检事件板块', '', 'el-icon-suitcase', NULL, NULL, '', 500);
INSERT INTO `sys_menu` VALUES (14, '设备事件', '/event', 'el-icon-setting', NULL, 13, 'Event', 501);
INSERT INTO `sys_menu` VALUES (15, '效率评价', '/efficiency', 'el-icon-chat-line-round', NULL, 7, 'Efficiency', 403);

-- ----------------------------
-- Table structure for sys_problem
-- ----------------------------
DROP TABLE IF EXISTS `sys_problem`;
CREATE TABLE `sys_problem`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `problem` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_problem
-- ----------------------------
INSERT INTO `sys_problem` VALUES (1, '问题1: 上班组长是否完成Tier1看板信息更新?');
INSERT INTO `sys_problem` VALUES (2, '问题2: 各个表格是否完整更新?');
INSERT INTO `sys_problem` VALUES (3, '问题3: 是否有Kaizen?');
INSERT INTO `sys_problem` VALUES (4, '问题4: QIO/UBUC/Tapin');
INSERT INTO `sys_problem` VALUES (5, '问题1: 计算产线进度并更新Tier2信息?');
INSERT INTO `sys_problem` VALUES (6, '问题2: 参加Tier2会议并下达沟通信息?');
INSERT INTO `sys_problem` VALUES (7, '问题3: 更新表扬T2表扬记录excel?');
INSERT INTO `sys_problem` VALUES (8, '问题4: 表扬记录?');
INSERT INTO `sys_problem` VALUES (9, '问题1: 产线员工佩戴PPE情况?');
INSERT INTO `sys_problem` VALUES (10, '问题2: 检查设备，防护罩，安全门，电器是否正常上锁(月初首批或过程中大修)?');
INSERT INTO `sys_problem` VALUES (11, '问题3: 产线各类垃圾处理是否正确?');
INSERT INTO `sys_problem` VALUES (12, '问题1: 换批清洁检查情况?');
INSERT INTO `sys_problem` VALUES (13, '问题2: 检查产线记录是否完整准确:校正记录(如有),纸质批报,产线logbook?');
INSERT INTO `sys_problem` VALUES (14, '问题3: 检查区域内是否有过期/不必要的文件,程序,标签;现场是否有临时记录的小纸片?');
INSERT INTO `sys_problem` VALUES (15, '问题4: 审计追踪数据审核?');
INSERT INTO `sys_problem` VALUES (16, '问题5: 出口产品特殊质量要求是否和TS一致?');
INSERT INTO `sys_problem` VALUES (17, '问题6: 随机抽检一盒产品及留样,按照市场包装检查要求检查?');
INSERT INTO `sys_problem` VALUES (18, '问题1: 当班生产进度? (填数字,包含正负)');
INSERT INTO `sys_problem` VALUES (19, '问题2: 本周生产进度? (填数字,包含正负)');
INSERT INTO `sys_problem` VALUES (20, '问题3: 当前批号?');
INSERT INTO `sys_problem` VALUES (21, '问题4: 前一班P值? (0——1)');
INSERT INTO `sys_problem` VALUES (22, '问题1: 抽查并观察员工CUCO的操作流程');
INSERT INTO `sys_problem` VALUES (23, '问题2: 抽查日常过程控制规范操作要点');
INSERT INTO `sys_problem` VALUES (24, '问题3: 所有GMP设备/计算机在吃饭/茶歇/下班时是否登出或锁屏');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', '管理员', 'ROLE_ADMIN');
INSERT INTO `sys_role` VALUES (3, '线长', '线长', 'ROLE_TEACHER');
INSERT INTO `sys_role` VALUES (4, '员工', '员工', 'ROLE_STUDENT');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int(0) NOT NULL COMMENT '角色id',
  `menu_id` int(0) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 9);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 11);
INSERT INTO `sys_role_menu` VALUES (1, 12);
INSERT INTO `sys_role_menu` VALUES (1, 13);
INSERT INTO `sys_role_menu` VALUES (1, 14);
INSERT INTO `sys_role_menu` VALUES (1, 15);
INSERT INTO `sys_role_menu` VALUES (3, 4);
INSERT INTO `sys_role_menu` VALUES (3, 5);
INSERT INTO `sys_role_menu` VALUES (3, 6);
INSERT INTO `sys_role_menu` VALUES (3, 10);

-- ----------------------------
-- Table structure for sys_tier
-- ----------------------------
DROP TABLE IF EXISTS `sys_tier`;
CREATE TABLE `sys_tier`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `shift` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t1q1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t1q2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t1q3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t1q4answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t2q1answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t2q2answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t2q3answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `t2q4answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_tier
-- ----------------------------
INSERT INTO `sys_tier` VALUES (52, '张三', '2022-04-01', '白班', '1号线', '122', '1', '11', '1', '1', '1', '1', '1');
INSERT INTO `sys_tier` VALUES (53, 'KK', '2022-04-02', '夜班', '4号线', '2', '2', '22', '2', '2', '2', '2', '2');
INSERT INTO `sys_tier` VALUES (54, 'KK', '2022-04-02', '夜班', '4号线', '2111111', '2', '2', '2', '2', '2', '2', '2');
INSERT INTO `sys_tier` VALUES (55, '李四', '2022-04-04', '白班', '1号线', '222', '11', '11', '11', '11', '11', '11', '11');
INSERT INTO `sys_tier` VALUES (56, '张三', '2022-04-21', '白班', '2号线', '否', '是', '是', '完成', '是', '是', '完成', '完成');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', 'Kocyousnb', '女', 'admin@qq.com', '13988997788', '安徽合肥1', 'ROLE_ADMIN', '');
INSERT INTO `sys_user` VALUES (16, '222', '123', '虞姬', '女', '2', '2', '2', 'ROLE_TEACHER', NULL);
INSERT INTO `sys_user` VALUES (30, '11', '123', '22', '11', '1620406762@qq.com', '18257397912', '1', 'ROLE_ADMIN', NULL);
INSERT INTO `sys_user` VALUES (31, '22', '123', '3', '3', '3', '18257397912', '3', 'ROLE_STUDENT', NULL);

SET FOREIGN_KEY_CHECKS = 1;
