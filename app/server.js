'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

//PG
const { Pool, Client } = require("pg");

const pool = new Pool({
    user: process.env.POSTGRES_USER,
    host: process.env.DB_URL,
    database: process.env.POSTGRES_DB,
    password: process.env.POSTGRES_PASSWORD,
    port: 5432,
});

// App
const app = express();
app.get('/', (req, res) => {
    res.send('Hello World');
});

app.get('/db', async (req, res) => {
    pool.query('SELECT * FROM pg_catalog.pg_user', (error, results) => {
        if (error) {
            res.send(`${error}`);
        }
        else {
            res.status(200).json(results.rows)
        }
    })
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);