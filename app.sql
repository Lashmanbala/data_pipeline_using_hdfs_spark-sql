CREATE DATABASE IF NOT EXISTS nyse_db;

USE nyse_db;

CREATE EXTERNAL TABLE IF NOT EXISTS nyse_stg(
    ticker VARCHAR(255),
    tradedate INT,
    openprice FLOAT,
    highprice FLOAT,
    lowprice FLOAT,
    closeprice FLOAT,
    volume BIGINT
) USING CSV
OPTIONS (
    path='/user/${USERNAME}/nyse_data'
);