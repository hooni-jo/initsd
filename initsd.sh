#!/usr/bin/env bash

SDCARD_PATH=/media/user/bootfs
CONFIG_TXT=config.txt 
CMDLINE_TXT=cmdline.txt 

# sd카드를 인식한다
function detectSD(){
	while true;do
		if [ -d "${SDCARD_PATH}" ];then   #mount가 됐을때
			echo "SD 카드가 발견되었습니다."
			return
		fi
		sleep 1
	done
}
echo before detectSD
detectSD
echo after detectSD

# find config.txt cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/CMDLINE_TXT" ];then   #mount가 됐을때
		echo "CMDLINE_TXT가 발견되었습니다."
		echo 0 # find
	else
		echo 1 # no found
	fi
}

echo "cmdline.txt 'detectCMDLINE'"

isCMDLINE='detectCMDLINE'
IPADDR=192.168.81.1
if [ $isCMDLINE -eq 0 ];then

# find 192.168.81.1 & modify
	sed -i "s/${IPADDR}/111.111.111.111/" "${SDCARD_PATH}/${CMDLINE_TXT}"
	if [ $? -eq 0 ];then
		echo "${CMDLINE_TXT} 문서가 수정되었습니다"
	else
		echo "${CMDLINE_TXT} 문서가 수정되지 않았습니다"
	fi
fi

# umount /media/user/bootfs
umount /media/user/bootfs
echo "SD카드를 분리해도 됩니다"