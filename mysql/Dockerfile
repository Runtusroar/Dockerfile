# 使用官方的 MySQL 8.0 镜像
FROM mysql:8.0

# 设置环境变量，避免在构建过程中提示输入密码
ENV MYSQL_ROOT_PASSWORD=123456
ENV MYSQL_DATABASE=user_logs_db

# 将初始化脚本复制到容器中
COPY init_db.sql /docker-entrypoint-initdb.d/

# 暴露 MySQL 默认端口
EXPOSE 3306