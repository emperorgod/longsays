#!/bin/bash
#你要修改的地方从这里开始
MYSQL_USER=root                             #mysql用户名
MYSQL_PASS=                      #mysql密码
WEB_DATA=/domains                          #要备份的网站数据
#你要修改的地方从这里结束

#定义数据库的名字和旧数据库的名字
DataBakName=Data_$(date +%Y%m%d).tar.gz
WebBakName=Web_$(date +%Y%m%d).tar.gz
OldData=Data_$(date -d -5day +%Y%m%d).tar.gz
OldWeb=Web_$(date -d -5day +%Y%m%d).tar.gz
#删除本地3天前的数据
rm -rf /home/backup/Data_$(date -d -3day +%Y%m%d).tar.gz /home/backup/Web_$(date -d -3day +%Y%m%d).tar.gz
cd /home/backup
#导出数据库,一个数据库一个压缩文件
/usr/local/mysql/bin/mysql -u$MYSQL_USER -p$MYSQL_PASS -B -N -e 'SHOW DATABASES' | xargs > mysqldata
sed -i 's/information_schema //g' mysqldata
sed -i 's/performance_schema //g' mysqldata
sed -i 's/mysql //g' mysqldata
for db in `cat mysqldata`; do
    (/usr/local/mysql/bin/mysqldump -u$MYSQL_USER -p$MYSQL_PASS --databases ${db} | gzip -9 > ${db}.sql.gz)
done
#压缩数据库文件为一个文件
tar zcf /home/backup/$DataBakName /home/backup/*.sql.gz
rm -rf /home/backup/*.sql.gz mysqldata
#压缩网站数据
tar zcf /home/backup/$WebBakName $WEB_DATA

