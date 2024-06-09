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

CREATE TABLE IF NOT EXISTS nyse_delta(
    ticker VARCHAR(255),
    tradedate INT,
    openprice FLOAT,
    highprice FLOAT,
    lowprice FLOAT,
    closeprice FLOAT,
    volume BIGINT   
) USING DELTA
PARTITIONED BY (trademonth INT);

REFRESH TABLE nyse_stg;

INSERT INTO TABLE nyse_delta PARTITION (trademonth)
SELECT ns.*, substr(tradedate, 1, 6) AS trademonth FROM nyse_stg AS ns;

SELECT count(*) FROM nyse_stg;

SELECT trademonth, count(*) AS tradecount FROM nyse_delta
GROUP BY trademonth
ORDER BY trademonth;