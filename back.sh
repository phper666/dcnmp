#!/bin/sh

OUT_DIR=/app/backup/mongo_data/ #mongo数据备份目录

TAR_DIR=/app/data/mongo #mongo数据存放路径

DATE=`date +%Y_%m_%d` #获取当前系统时间

DAYS=7 #DAYS=7代表删除7天前的备份，即只保留最近7天的备份

TAR_BAK="mongod_bak_$DATE.tar.gz" #最终保存的数据库备份文件名

mkdir -p $OUT_DIR/$DATE

cd $OUT_DIR/$DATE

tar -zcvf $OUT_DIR/$DATE/$TAR_BAK $TAR_DIR #压缩为.tar.gz格式

find $OUT_DIR/ -mtime +$DAYS -delete #删除7天前的备份文件
