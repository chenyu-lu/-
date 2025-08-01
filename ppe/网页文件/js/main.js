const express = require('express');
const mysql = require('mysql2/promise');
const app = express();
const port = 3000;

// 解析JSON请求体
app.use(express.json());

// 创建数据库连接池
const pool = mysql.createPool({
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'sports_activity_management'
});

// 注册接口
app.post('/register', async (req, res) => {
    const { username, email, password } = req.body;
    try {
        const [rows] = await pool.execute('SELECT * FROM users WHERE username = ?', [username]);
        if (rows.length > 0) {
            return res.json({ success: false, message: '用户名已存在，请选择其他用户名。' });
        }
        await pool.execute('INSERT INTO users (username, email, password) VALUES (?, ?, ?)', [username, email, password]);
        res.json({ success: true, message: '注册成功，请登录。' });
    } catch (error) {
        console.error('注册出错:', error);
        res.json({ success: false, message: '注册出错，请稍后重试。' });
    }
});

// 登录接口
app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [rows] = await pool.execute('SELECT * FROM users WHERE username = ? AND password = ?', [username, password]);
        if (rows.length > 0) {
            res.json({ success: true, message: '登录成功！' });
        } else {
            res.json({ success: false, message: '用户名或密码错误，请重试。' });
        }
    } catch (error) {
        console.error('登录出错:', error);
        res.json({ success: false, message: '登录出错，请稍后重试。' });
    }
});

// 启动服务器
app.listen(port, () => {
    console.log(`服务器运行在端口 ${port}`);
});