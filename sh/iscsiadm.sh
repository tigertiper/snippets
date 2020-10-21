#!/bin/bash
discoveryIP()
{
   ISCSI_IP=$1
   iscsiadm -m discovery -t st -p ${ISCSI_IP}
}
showDiscovery()
{
   iscsiadm -m node
}
showIPDiscovery()
{
   ISCSI_IP=$1
   iscsiadm -m node|grep ${ISCSI_IP}
}
loginIP()
{
   ISCSI_IP=$1
   iscsiadm -m discovery -t st -p ${ISCSI_IP} -l
}
loginIPLUN()
{
   ISCSI_IP=$1
   LUN_NAME=$2
   iscsiadm -m node -T ${LUN_NAME} -p ${ISCSI_IP} -l	
}
logoutIP()
{
   ISCSI_IP=$1
   iscsiadm -m node  -p ${ISCSI_IP} -u
}
logoutIPLUN()
{
   ISCSI_IP=$1
   LUN_NAME=$2
   iscsiadm -m node -T ${LUN_NAME} -p ${ISCSI_IP} -u
}
logoutALL()
{
   iscsiadm -m node -U all
}
deleteIPDiscovery()
{
   ISCSI_IP=$1
   iscsiadm -m node -o delete -p ${ISCSI_IP}
}
deleteIPLUNDiscovery()
{
   ISCSI_IP=$1
   LUN_NAME=$2
   iscsiadm -m node -o delete -T ${LUN_NAME} -p ${ISCSI_IP}
}
deleteDiscovery()
{
   iscsiadm -m node -o delete
}
showSessions()
{
   iscsiadm -m session
}
setAutoLogin()
{
   ISCSI_IP=$1
   LUN_NAME=$2
   iscsiadm -m node -T ${LUN_NAME} -p ${ISCSI_IP} --op update -n node.startup -v automatic
}
setManualLogin()
{
   ISCSI_IP=$1
   LUN_NAME=$2
   iscsiadm -m node -T ${LUN_NAME} -p ${ISCSI_IP} --op update -n node.startup -v manual
}
iscsiadmHelp()
{
	echo ""
	echo "欢迎使用 iscsiadm 管理程序 Author:tianpeng"
	echo ""
	echo "1.发现指定IP的iscsi存储"
	echo "2.查看所有iscsi发现记录"
	echo "3.查看指定IP的iscsi发现记录"
	echo "4.登录指定IP的所有iscsi存储"
	echo "5.登录指定IP和target的iscsi存储"
	echo "6.登出指定IP的所有iscsi存储"
	echo "7.登出指定IP和target的iscsi存储"
	echo "8.登出iscsi所有登录"
	echo "9.删除指定IP的iscsi发现记录"
	echo "a.删除所有iscsi发现记录"
	echo "b.查看iscsi所有登录"
	echo "c.设置iscsi自动登录"
	echo "d.设置iscsi手动登录"
	echo "请输入数字或字母选择功能(按回车键退出)："

	while :; do echo
		read -p "请选择： " choice
		if [[ ! $choice =~ ^[1-9a-d]$ ]]; then
			if [[ -z ${choice} ]];then
				exit 0
			fi
			echo "输入错误! 请输入正确的数字或字母!"
		else
			break	
		fi
	done
	
	if [[ ${choice} == 1 ]]; then
		read -p "请输入IP：" IP
		discoveryIP $IP
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi
	
	if [[ ${choice} == 2 ]]; then
		showDiscovery
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	
	
	if [[ ${choice} == 3 ]]; then
		read -p "请输入IP：" IP
		showIPDiscovery $IP
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	
	
	if [[ ${choice} == 4 ]]; then
		read -p "请输入IP：" IP
		loginIP $IP
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	

	if [[ ${choice} == 5 ]]; then
		read -p "请输入IP：" IP
		read -p "请输入target：" target
		logoutIPLUN $IP $target
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi

	if [[ ${choice} == 6 ]]; then
		read -p "请输入IP：" IP
		logoutIP $IP
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	

	if [[ ${choice} == 7 ]]; then
		read -p "请输入IP：" IP
		read -p "请输入target：" target
		logoutIPLUN $IP $target
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	
	
	if [[ ${choice} == 8 ]]; then
		logoutALL
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	
	
	if [[ ${choice} == 9 ]]; then
		read -p "请输入IP：" IP
		deleteIPDiscovery $IP
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	

	if [[ ${choice} == a ]]; then
		deleteDiscovery
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi
	
	if [[ ${choice} == b ]]; then
		showSessions
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	

	if [[ ${choice} == c ]]; then
		read -p "请输入IP：" IP
		read -p "请输入target：" target
		setAutoLogin $IP $target
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi	

	if [[ ${choice} == d ]]; then
		read -p "请输入IP：" IP
		read -p "请输入target：" target
		setManualLogin $IP $target
		read -p "已完成，按任意键继续"
		iscsiadmHelp
	fi		
}
iscsiadmHelp
