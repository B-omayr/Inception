CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'iomayr'@'%' IDENTIFIED BY 'user42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'iomayr'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root42';
FLUSH PRIVILEGES;