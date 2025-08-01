const express = require('express');
const mysql = require('mysql2/promise');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// 数据库连接配置
const pool = mysql.createPool({
host: 'localhost',
  user: 'root',       // 替换为您的MySQL用户名
  password: 'password', // 替换为您的MySQL密码
database: 'sports_activity_management',
waitForConnections: true,
connectionLimit: 10,
queueLimit: 0
});

// 用户注册接口
app.post('/api/register', async (req, res) => {
    try {
    const { username, email, password } = req.body;
    const [result] = await pool.execute(
        'INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
        [username, email, password]
    );
    res.json({ success: true, userId: result.insertId });
    } catch (error) {
    res.status(400).json({ success: false, message: error.message });
    }
});

// 用户登录接口
app.post('/api/login', async (req, res) => {
    try {
    const { username, password } = req.body;
    const [rows] = await pool.execute(
      'SELECT * FROM users WHERE username = ? AND password = ?',
        [username, password]
    );
    if (rows.length > 0) {
        res.json({ success: true, user: rows[0] });
    } else {
        res.status(401).json({ success: false, message: '用户名或密码错误' });
    }
    } catch (error) {
    res.status(500).json({ success: false, message: error.message });
    }
});

// 获取活动列表
app.get('/api/events', async (req, res) => {
    try {
    const [rows] = await pool.execute('SELECT * FROM events');
    res.json({ success: true, events: rows });
    } catch (error) {
    res.status(500).json({ success: false, message: error.message });
    }
});

// 活动报名接口
app.post('/api/register-event', async (req, res) => {
    try {
    const { userId, eventId, fullName, company, email, phone } = req.body;
    const [result] = await pool.execute(
        'INSERT INTO event_registrations (user_id, event_id, full_name, company, email, phone) VALUES (?, ?, ?, ?, ?, ?)',
        [userId, eventId, fullName, company, email, phone]
    );
    res.json({ success: true, registrationId: result.insertId });
    } catch (error) {
    res.status(400).json({ success: false, message: error.message });
    }
});

// 提交评价接口
app.post('/api/submit-evaluation', async (req, res) => {
    try {
    const { userId, eventId, rating, comment } = req.body;
    const [result] = await pool.execute(
        'INSERT INTO event_evaluations (user_id, event_id, rating, comment) VALUES (?, ?, ?, ?)',
        [userId, eventId, rating, comment]
    );
    res.json({ success: true, evaluationId: result.insertId });
    } catch (error) {
    res.status(400).json({ success: false, message: error.message });
    }
});

// 获取用户订单
app.get('/api/user-orders/:userId', async (req, res) => {
    try {
    const [rows] = await pool.execute(
        'SELECT er.*, e.title, e.date, e.location FROM event_registrations er JOIN events e ON er.event_id = e.id WHERE er.user_id = ?',
        [req.params.userId]
    );
    res.json({ success: true, orders: rows });
    } catch (error) {
    res.status(500).json({ success: false, message: error.message });
    }
});

// 启动服务器
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});