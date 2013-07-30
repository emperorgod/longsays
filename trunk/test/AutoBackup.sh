#!/bin/bash
#你要修改的地方从这里开始
MYSQL_USER=root                             #mysql用户名
MYSQL_PASS=123456                      #mysql密码
MAIL_TO=i@moper.me                 #数据库发送到的邮箱
FTP_USER=moper                              #ftp用户名
FTP_PASS=123456                         #ftp密码
FTP_IP=imcat.in                          #ftp地址
FTP_backup=backup                          #ftp上存放备份文件的目录,这个要自己得ftp上面建的
WEB_DATA=/home/www                          #要备份的网站数据
#你要修改的地方从这里结束

#定义数据库的名字和旧数据库的名字
DataBakName=Data_$(date +"%Y%m%d").tar.gz
WebBakName=Web_$(date +%Y%m%d).tar.gz
OldData=Data_$(date -d -5day +"%Y%m%d").tar.gz
OldWeb=Web_$(date -d -5day +"%Y%m%d").tar.gz
#删除本地3天前的数据
rm -rf /home/backup/Data_$(date -d -3day +"%Y%m%d").tar.gz /home/backup/Web_$(date -d -3day +"%Y%m%d").tar.gz
cd /home/backup
#导出数据库,一个数据库一个压缩文件
/usr/local/mysql/bin/mysql -u$MYSQL_USER -p$MYSQL_PASS -B -N -e 'SHOW DATABASES' | xargs > mysqldata
sed -i 's/information_schema //g' mysqldata
sed -i 's/performance_schema //g' mysqldata
sed -i 's/mysql //g' mysqldata
for db in `cat mysqldata`; do
    (/usr/local/mysql/bin/mysqldump -u$MYSQL_USER -p$MYSQL_PASS --databases ${db}> ${db}.sql)
done
#压缩数据库文件为一个文件
tar zcf /home/backup/$DataBakName /home/backup/*.sql
rm -rf /home/backup/*.sql mysqldata
#发送数据库到Email,如果数据库压缩后太大,请注释这行
echo "数据库备份，有问题可访问http://moper.me咨询" | mutt $MAIL_TO -s "数据库备份" -a /home/backup/$DataBakName
#压缩网站数据
tar zcf /home/backup/$WebBakName $WEB_DATA
#上传到FTP空间,删除FTP空间5天前的数据
ftp -v -n $FTP_IP << END
user $FTP_USER $FTP_PASS
type binary
cd $FTP_backup
delete $OldData
delete $OldWeb
put $DataBakName
put $WebBakName
bye
END