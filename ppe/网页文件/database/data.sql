-- 创建数据库
CREATE DATABASE IF NOT EXISTS sports_activity_management;

-- 使用数据库
USE sports_activity_management;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建活动表
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    location VARCHAR(100) NOT NULL,
    organizer_id INT NOT NULL,
    max_participants INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (organizer_id) REFERENCES users(id)
);

-- 创建活动报名表（扩展原有结构）
CREATE TABLE IF NOT EXISTS event_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    company VARCHAR(100),
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    registration_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id),
    UNIQUE (user_id, event_id)
);

-- 创建活动评价表
CREATE TABLE IF NOT EXISTS event_evaluations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    evaluation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- 插入初始管理员用户
INSERT INTO users (username, email, password) VALUES 
('admin', 'admin@sports.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.Mrq4H6x5KJY7e7fB6JQ7J7J7J7J7J7J');

-- 插入初始活动数据（对应HTML中的6个活动）
INSERT INTO events (title, description, date, time, location, organizer_id, max_participants) VALUES
('羽毛球比赛', '本次羽毛球比赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-05-20', '09:00:00', '南京大学鼓楼校区', 1, 50),
('篮球友谊赛', '本次篮球友谊赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-06-15', '09:00:00', '南京大学仙林校区', 1, 40),
('足球联赛', '本次足球联赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-07-10', '09:00:00', '南京大学仙林校区', 1, 60),
('乒乓球比赛', '本次乒乓球比赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-08-05', '09:00:00', '南京大学鼓楼校区', 1, 30),
('马拉松赛', '本次马拉松赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-09-01', '09:00:00', '南京市中心', 1, 200),
('游泳比赛', '本次游泳比赛旨在促进学生之间的交流与合作，增强身体素质，欢迎各位同学踊跃报名参加！', '2025-10-10', '09:00:00', '南京大学苏州校区', 1, 40);

-- 创建活动日程表（用于存储活动时间表）
CREATE TABLE IF NOT EXISTS event_schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    activity_description VARCHAR(255) NOT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id)
);

-- 为每个活动插入日程数据
-- 羽毛球比赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(1, '09:00:00', '10:00:00', '开幕式及热身活动'),
(1, '10:00:00', '12:00:00', '羽毛球比赛第一轮'),
(1, '12:00:00', '13:00:00', '午餐休息'),
(1, '13:00:00', '15:00:00', '羽毛球比赛第二轮'),
(1, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 篮球友谊赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(2, '09:00:00', '10:00:00', '开幕式及热身活动'),
(2, '10:00:00', '12:00:00', '篮球友谊赛第一轮'),
(2, '12:00:00', '13:00:00', '午餐休息'),
(2, '13:00:00', '15:00:00', '篮球友谊赛第二轮'),
(2, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 足球联赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(3, '09:00:00', '10:00:00', '开幕式及热身活动'),
(3, '10:00:00', '12:00:00', '足球联赛第一轮'),
(3, '12:00:00', '13:00:00', '午餐休息'),
(3, '13:00:00', '15:00:00', '足球联赛第二轮'),
(3, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 乒乓球比赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(4, '09:00:00', '10:00:00', '开幕式及热身活动'),
(4, '10:00:00', '12:00:00', '乒乓球比赛第一轮'),
(4, '12:00:00', '13:00:00', '午餐休息'),
(4, '13:00:00', '15:00:00', '乒乓球比赛第二轮'),
(4, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 马拉松赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(5, '09:00:00', '10:00:00', '开幕式及热身活动'),
(5, '10:00:00', '12:00:00', '马拉松赛第一轮'),
(5, '12:00:00', '13:00:00', '午餐休息'),
(5, '13:00:00', '15:00:00', '马拉松赛第二轮'),
(5, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 游泳比赛日程
INSERT INTO event_schedules (event_id, start_time, end_time, activity_description) VALUES
(6, '09:00:00', '10:00:00', '开幕式及热身活动'),
(6, '10:00:00', '12:00:00', '游泳比赛第一轮'),
(6, '12:00:00', '13:00:00', '午餐休息'),
(6, '13:00:00', '15:00:00', '游泳比赛第二轮'),
(6, '15:00:00', '16:00:00', '颁奖典礼及闭幕式');

-- 创建视图：活动详情视图
CREATE VIEW event_details_view AS
SELECT 
    e.id,
    e.title,
    e.description,
    e.date,
    e.time,
    e.location,
    e.max_participants,
    u.username AS organizer_name,
    COUNT(er.id) AS registered_participants,
    IFNULL(AVG(ev.rating), 0) AS average_rating
FROM 
    events e
JOIN 
    users u ON e.organizer_id = u.id
LEFT JOIN 
    event_registrations er ON e.id = er.event_id
LEFT JOIN 
    event_evaluations ev ON e.id = ev.event_id
GROUP BY 
    e.id;

-- 创建存储过程：用户注册
DELIMITER //
CREATE PROCEDURE register_user(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(255),
    OUT p_result INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE user_count INT;
    
    -- 检查用户名是否已存在
    SELECT COUNT(*) INTO user_count FROM users WHERE username = p_username;
    IF user_count > 0 THEN
        SET p_result = 0;
        SET p_message = '用户名已存在';
    ELSE
        -- 检查邮箱是否已存在
        SELECT COUNT(*) INTO user_count FROM users WHERE email = p_email;
        IF user_count > 0 THEN
            SET p_result = 0;
            SET p_message = '邮箱已存在';
        ELSE
            -- 插入新用户
            INSERT INTO users (username, email, password) VALUES (p_username, p_email, p_password);
            SET p_result = 1;
            SET p_message = '注册成功';
        END IF;
    END IF;
END //
DELIMITER ;

-- 创建存储过程：用户登录
DELIMITER //
CREATE PROCEDURE login_user(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    OUT p_result INT,
    OUT p_user_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE user_count INT;
    
    -- 检查用户是否存在
    SELECT COUNT(*), id INTO user_count, p_user_id 
    FROM users 
    WHERE username = p_username AND password = p_password;
    
    IF user_count > 0 THEN
        SET p_result = 1;
        SET p_message = '登录成功';
    ELSE
        SET p_result = 0;
        SET p_user_id = NULL;
        SET p_message = '用户名或密码错误';
    END IF;
END //
DELIMITER ;

-- 创建存储过程：活动报名
DELIMITER //
CREATE PROCEDURE register_for_event(
    IN p_user_id INT,
    IN p_event_id INT,
    IN p_full_name VARCHAR(100),
    IN p_company VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    OUT p_result INT,
    OUT p_message VARCHAR(255)
BEGIN
    DECLARE registration_count INT;
    DECLARE max_participants INT;
    DECLARE current_participants INT;
    
    -- 检查是否已报名
    SELECT COUNT(*) INTO registration_count 
    FROM event_registrations 
    WHERE user_id = p_user_id AND event_id = p_event_id;
    
    IF registration_count > 0 THEN
        SET p_result = 0;
        SET p_message = '您已经报名过此活动';
    ELSE
        -- 检查活动人数限制
        SELECT max_participants, COUNT(*) INTO max_participants, current_participants
        FROM events e
        LEFT JOIN event_registrations er ON e.id = er.event_id
        WHERE e.id = p_event_id;
        
        IF max_participants IS NOT NULL AND current_participants >= max_participants THEN
            SET p_result = 0;
            SET p_message = '活动报名人数已满';
        ELSE
            -- 报名活动
            INSERT INTO event_registrations (user_id, event_id, full_name, company, email, phone)
            VALUES (p_user_id, p_event_id, p_full_name, p_company, p_email, p_phone);
            
            SET p_result = 1;
            SET p_message = '报名成功';
        END IF;
    END IF;
END //
DELIMITER ;

-- 创建存储过程：提交评价
DELIMITER //
CREATE PROCEDURE submit_evaluation(
    IN p_user_id INT,
    IN p_event_id INT,
    IN p_rating INT,
    IN p_comment TEXT,
    OUT p_result INT,
    OUT p_message VARCHAR(255))
BEGIN
    DECLARE registration_count INT;
    
    -- 检查用户是否参加过该活动
    SELECT COUNT(*) INTO registration_count 
    FROM event_registrations 
    WHERE user_id = p_user_id AND event_id = p_event_id;
    
    IF registration_count = 0 THEN
        SET p_result = 0;
        SET p_message = '您未参加此活动，无法评价';
    ELSE
        -- 检查是否已评价过
        SELECT COUNT(*) INTO registration_count 
        FROM event_evaluations 
        WHERE user_id = p_user_id AND event_id = p_event_id;
        
        IF registration_count > 0 THEN
            SET p_result = 0;
            SET p_message = '您已经评价过此活动';
        ELSE
            -- 提交评价
            INSERT INTO event_evaluations (user_id, event_id, rating, comment)
            VALUES (p_user_id, p_event_id, p_rating, p_comment);
            
            SET p_result = 1;
            SET p_message = '评价提交成功';
        END IF;
    END IF;
END //
DELIMITER ;