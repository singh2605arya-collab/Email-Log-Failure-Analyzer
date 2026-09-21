create database notification_analysis;
use notification_analysis;
show tables;
CREATE TABLE email_notification_logs (
    Log_ID INT PRIMARY KEY,
    Timestamp DATETIME,
    Service_Name VARCHAR(100),
    Notification_Type VARCHAR(50),
    Recipient_Type VARCHAR(50),
    Status VARCHAR(20),
    Failure_Reason VARCHAR(100),
    Response_Code INT,
    Retry_Count INT,
    Delivery_Time_ms INT
);
SHOW TABLES;

SELECT COUNT(*) AS total_records
FROM email_notification_logs;

SELECT COUNT(*) AS total_records
FROM email_notification_logs;

SELECT *
FROM email_notification_logs
LIMIT 10;

DESCRIBE email_notification_logs;

SELECT 
    Status,
    COUNT(*) AS total_notifications
FROM email_notification_logs
GROUP BY Status;

SELECT
    COUNT(*) AS total_notifications,
    SUM(CASE WHEN Status = 'Failed' THEN 1 ELSE 0 END) AS failed_notifications,
    ROUND(
        SUM(CASE WHEN Status = 'Failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS failure_rate
FROM email_notification_logs;

SELECT
    Failure_Reason,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Failure_Reason
ORDER BY total_failures DESC;

SELECT
    Notification_Type,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Notification_Type
ORDER BY total_failures DESC;

SELECT
    Recipient_Type,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Recipient_Type
ORDER BY total_failures DESC;

SELECT
    Response_Code,
    COUNT(*) AS total_notifications
FROM email_notification_logs
GROUP BY Response_Code
ORDER BY total_notifications DESC;


SELECT
    Retry_Count,
    COUNT(*) AS total_notifications
FROM email_notification_logs
GROUP BY Retry_Count
ORDER BY Retry_Count;

SELECT
    Status,
    ROUND(AVG(Delivery_Time_ms), 2) AS average_delivery_time_ms
FROM email_notification_logs
GROUP BY Status;

SELECT
    HOUR(Timestamp) AS hour,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY HOUR(Timestamp)
ORDER BY hour;

SELECT
    Service_Name,
    Failure_Reason,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Service_Name, Failure_Reason
ORDER BY total_failures DESC;

SELECT
    Response_Code,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Response_Code

SELECT
    Service_Name,
    Notification_Type,
    COUNT(*) AS total_failures
FROM email_notification_logs
WHERE Status = 'Failed'
GROUP BY Service_Name, Notification_Type
ORDER BY total_failures DESC;
ORDER BY total_failures DESC;

SELECT
    COUNT(*) AS total_notifications,
    SUM(CASE WHEN Status = 'Success' THEN 1 ELSE 0 END) AS successful_notifications,
    SUM(CASE WHEN Status = 'Failed' THEN 1 ELSE 0 END) AS failed_notifications,
    ROUND(
        SUM(CASE WHEN Status = 'Failed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS failure_rate,
    ROUND(AVG(Delivery_Time_ms), 2) AS average_delivery_time_ms,
    ROUND(AVG(Retry_Count), 2) AS average_retry_count
FROM email_notification_logs;