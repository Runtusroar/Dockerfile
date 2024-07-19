-- 创建数据库
CERATE DATABASE IF NOT EXISTS user_logs_db;

-- 使用数据库
USE user_logs_db;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID，唯一标识',
    username VARCHAR(255) NOT NULL UNIQUE COMMENT '用户名，唯一',
    password VARCHAR(255) NOT NULL COMMENT '用户密码',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 访问记录表
CREATE TABLE IF NOT EXISTS access_logs (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '访问记录唯一标识',
    host VARCHAR(255) NOT NULL COMMENT '访问的主机名或域名',
    uri VARCHAR(2083) DEFAULT NULL COMMENT '请求的URI，最大长度2083符合RFC规范',
    ip VARBINARY(16) NOT NULL COMMENT 'IP地址，IPv4为4字节，IPv6为16字节',
    agent TEXT DEFAULT NULL COMMENT '用户代理字符串，存储用户浏览器信息',
    referrer VARCHAR(2083) DEFAULT NULL COMMENT '引荐来源URL，最大长度2083符合RFC规范',
    event_type TINYINT DEFAULT 1 COMMENT '事件类型（1: visit, 2: click, 3: purchase, 4: download）',
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
    INDEX `idx_host` (host),
    INDEX `idx_access_time` (access_time),
    INDEX `idx_event_type` (event_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网站访问记录表';

-- 域名状态表
CREATE TABLE IF NOT EXISTS domain_status (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '唯一标识',
    domain_name VARCHAR(255) NOT NULL COMMENT '域名',
    taiwan_dns_ip VARBINARY(16) NOT NULL COMMENT '台湾DNS服务器查询到的IP值',
    status_code SMALLINT NOT NULL DEFAULT 0 COMMENT '网站状态码，0表示未知',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX `idx_domain_name` (domain_name),
    INDEX `idx_taiwan_dns_ip` (taiwan_dns_ip),
    INDEX `idx_status_code` (status_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='域名状态表';
