#############################
# author : WUYANGHAO        #
# time : 11:05 2018-01-17   #
# version : 2.0.1           #
#############################
#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
PATCH_PKG=${SCRIPT_DIR}/pkg
#Check Env
function Check_Env(){
    if [ ! -f /etc/named.conf ];then
        cd $PATCH_PKG && ls | grep rpm | xargs rpm -ihv --force --nodeps 1>/dev/null
    fi
}
function Create_New_Conf(){
    rm /var/lib/named/*.zone
cat > /etc/named.conf << EOF
//by wuyanghao
options {
        directory "/var/lib/named";
        allow-query { any; };
        allow-recursion { any; };
};
EOF
}
function GET_DATA(){
    read -p "=====请输入规划的二级域名（如：bdpaas.com）：" DNS_NAME
    read -p "=====请输入LVS浮动IP地址：" LVS_IP
    read -p "=====请输入ManageCore04/05浮动IP地址：" PORTAL_IP
    read -p "=====请输入ManageLB01/02浮动IP地址：" REPOSITORY_IP
}
function ADD_CONF(){
    local DNS_NAME=$1
    cat /etc/named.conf | grep -w "$DNS_NAME" 1>/dev/null
    if [ $? -ne 0 ];then
cat >>/etc/named.conf<<EOF    
zone "${DNS_NAME}" in {
        type master;
        file "${DNS_NAME}.zone";
};
EOF
    else
        echo -e "=====域名已存在，请重新规划或者重新执行脚本选择清空之前的配置"
        echo -e "=====程序结束，Bye"
        exit 1
    fi
}
function ADD_IP_CONF(){
    local LVS_IP=$1
    local PORTAL_IP=$2
    local REPOSITORY_IP=$3
    local IP_LIST="$LVS_IP $PORTAL_IP $REPOSITORY_IP"
    for IP_ADDR in $IP_LIST;do
        cat /etc/named.conf | grep -w "$(echo $IP_ADDR | awk -F. '{print $3"."$2"."$1}')" 1>/dev/null 2>&1
        if [ $? -ne 0 ];then
cat >>/etc/named.conf <<EOF
zone "$(echo $IP_ADDR | awk -F. '{print $3"."$2"."$1}').in-addr.arpa" in {
        type master;
        file "$(echo $IP_ADDR | awk -F. '{print $1"."$2"."$3}').zone";
};
EOF
        fi
    done
}
function ADD_ZONE(){
    local DNS_NAME=$1
    local LVS_IP=$2
    local PORTAL_IP=$3
    local REPOSITORY_IP=$4
    if [ ! -f /var/lib/named/${DNS_NAME}.zone ];then
cat >/var/lib/named/${DNS_NAME}.zone<<EOF
\$TTL 7200
@ IN SOA ${DNS_NAME}. wuyanghao.huawei.com. (222 1H 15M 1W 1D)
@ IN NS ${DNS_NAME}.
portal IN A ${PORTAL_IP}
repository IN A ${REPOSITORY_IP}
* IN A ${LVS_IP}
EOF
    else
        echo -e "=====域名已存在，请重新规划或者重新执行脚本选择清空之前的配置"
        echo -e "=====程序结束，Bye"
        exit 1
    fi
}
function ADD_IP_ZONE() {
    local DNS_NAME=$1
    local LVS_IP=$2
    local PORTAL_IP=$3
    local REPOSITORY_IP=$4
    local IP_LIST="$LVS_IP $PORTAL_IP $REPOSITORY_IP"

    for IP_ADDR in $IP_LIST;do
        if [ ! -f /var/lib/named/$(echo $IP_ADDR | awk -F. '{print $1"."$2"."$3}').zone ];then
cat >/var/lib/named/$(echo $IP_ADDR | awk -F. '{print $1"."$2"."$3}').zone<<EOF
\$TTL 7200
@ IN SOA ${DNS_NAME}. wuyanghao.huawei.com. (222 1H 15M 1W 1D)
@ IN NS ${DNS_NAME}.
EOF
        else
            cat /var/lib/named/$(echo $IP_ADDR | awk -F. '{print $1"."$2"."$3}').zone |grep -w $DNS_NAME 1>/dev/null 2>&1
            if [ $? -ne 0 ];then
cat >>/var/lib/named/$(echo $IP_ADDR | awk -F. '{print $1"."$2"."$3}').zone<<EOF
\$TTL 7200
@ IN SOA ${DNS_NAME}. wuyanghao.huawei.com. (222 1H 15M 1W 1D)
@ IN NS ${DNS_NAME}.
EOF
            fi
        fi
    done
cat >>/var/lib/named/$(echo $PORTAL_IP | awk -F. '{print $1"."$2"."$3}').zone<<EOF
$(echo $PORTAL_IP |awk -F. '{print $4}') IN PTR portal.
EOF
cat >>/var/lib/named/$(echo $REPOSITORY_IP | awk -F. '{print $1"."$2"."$3}').zone<<EOF
$(echo $REPOSITORY_IP |awk -F. '{print $4}') IN PTR repository.
EOF
cat >>/var/lib/named/$(echo $LVS_IP | awk -F. '{print $1"."$2"."$3}').zone<<EOF
$(echo $LVS_IP |awk -F. '{print $4}') IN PTR *.
EOF
}
function Main(){
    clear
    echo -e "================此程序仅做大数据DNS配置================"
    echo -e "====================开始配置DNS服务===================="
    Check_Env
    read -p "=====是否清空之前的DNS配置（yes/no）：" CLEAR_CONF
    if [ "X$CLEAR_CONF" == "Xyes" ];then
        Create_New_Conf && echo -e "=====清理完毕，已创建新的配置文件/etc/named.conf"
    fi
    GET_DATA
    ADD_CONF $DNS_NAME && ADD_IP_CONF $LVS_IP $PORTAL_IP $REPOSITORY_IP && echo -e "=====添加DNS配置成功"
    ADD_ZONE $DNS_NAME $LVS_IP $PORTAL_IP $REPOSITORY_IP && ADD_IP_ZONE $DNS_NAME $LVS_IP $PORTAL_IP $REPOSITORY_IP && echo -e "=====添加DNS服务zone文件完成"
    service named restart && echo -e "====================配置DNS服务成功===================="
}
#####程序开始#####
Main
