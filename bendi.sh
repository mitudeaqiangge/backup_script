#!/bin/bash
log_name="back_log/`date +%Y%m%d-%H%M%S`.log"
check_dir()
{
   if [ ! -d $1 ]; then
      echo "没有那个目录，开始创建目录"
      mkdir -p $1 >& /dev/null 
   fi
}
bendiback()
{
echo -n  "请输入备份文件/目录地址："
read  b_source
#log_name="back_log/log-`date +%Y%m%d-%H%M%S`"
echo "------`date`--------" >>$log_name

#echo $b_source
if [ -d "$b_source" ];then
  source_d=`echo "$b_source" |awk -F '/' '{print $NF}'`
  echo "备份源为目录：$source_d"
  back_name=bak-`date +%Y%m%d-%H%M%S`_$source_d.tar.gz
  echo "开始压缩打包:$back_name 请稍等... .... "
  echo "开始压缩打包:$back_name" >>$log_name
  tar -zcf   $back_name  $b_source   2&>>$log_name 
  check_s=`md5sum  $back_name | awk '{print $1}'`
  echo "打包完成，To start backup..."
  echo -n  "输入存放备份文件地址："
  read  b_destination
  check_dir $b_destination
  cp $back_name  $b_destination
  if [ $? == 0 ];then
     rm -rf $back_name
     check_d=`md5sum $b_destination/$back_name |awk '{print $1}'` 
     echo "校验备份文件：` find $b_destination  -name $back_name`"
     if [ "$check_s" == "$check_d" ] ;then 
        echo "The backup successful"
        echo "$b_source backup sucessful --- $b_destination" >>$log_name
     else
        echo "backup erro ...."
         echo "$b_source backup erro --- $b_destination" >>$log_name
    fi
  fi
else
   test -e $b_source
   if [ $? == 0 ];then
     source_d=`echo "$b_source" |awk -F '/' '{print $NF}'`
     back_name=bak-`date +%Y%m%d-%H%M%S`_$source_d
     check_s=`md5sum  $source_d | awk '{print $1}'`
     echo "备份源为文件：$source_d"
     read -p "输入存放备份文件地址：" b_destination
     check_dir $b_destination
     echo "To start backup...."
     cp $b_source  $back_name
     cp $back_name  $b_destination
     if [ $? == 0 ];then
#       ls $b_destination |grep $back_name
         rm -rf  $back_name
         echo "校验备份文件：` find $b_destination -name $back_name `" 
         check_d=`md5sum $b_destination/$back_name |awk '{print $1}'`
         if [ "$check_s" == "check_d" ] ;then
            echo "The backup successful"
            echo "$b_source backup sucessful --- $b_destination" >>$log_name
         fi
      fi
   else
      echo "没有那个文件或目录"
    fi
fi
}
while true; do
	read -p "开始备份...yes|no  [yes]" yn
	case $yn in
		y|Y|yes|YES)bendiback ;;
		n|N|no)exit;;
		*)echo "Please answer y or n"
	esac
done


