#########################################################################
# File Name: create_file_server.sh
# Author: Wu Yanghao
# mail: 939806382@qq.com
# Created Time: Wed Feb  8 09:27:08 2017
#########################################################################
#!/bin/bash
SCRIPT_PATH=$(cd $(dirname $0);pwd)
JDK_RPM=$SCRIPT_PATH/package$(ls $SCRIPT_PATH/package | grep jdk)
TOMCAT_PKG=$SCRIPT_PATH/package$(ls $SCRIPT_PATH/package | grep tomcat)

LOG_FILE=$SCRIPT_PATH/log/install.log
#创建文件服务器
echo -e "[ $(date) ] Start create_file_server" | tee $LOG_FILE
nohup python -m SimpleHTTPServer &
sleep 5
function install_jdk(){
    #检查jdk
    echo -e "[ $(date) ] Check jdk" | tee -a $LOG_FILE
    java -version
    if [ $? != 0 ];then
        echo -e "[ $(date) ] jdk does not install\n[ $(date) ] Start install jdk ..." | tee -a $LOG_FILE
        rm -rf /usr/java
        rpm -ivh $JDK_RPM --force --nodeps | tee -a $LOG_FILE
        JDK_NAME=$(rpm -qa | grep jdk | awk -F "-" '{print $1}')
        if [ ! -d /usr/java/$JDK_NAME ];then
            echo -e "[ $(date) ] install jdk failed, please check it "  | tee -a $LOG_FILE
            exit 1
        else
            #修改/etc/profile
            sed -i "/JAVA/d" /etc/profile
            echo -e "export JAVA_HOME=/usr/java/$JDK_NAME" >>/etc/profile
            echo -e "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >>/etc/profile
            echo -e "export PATH=\$JAVA_HOME/bin:\$PATH" >>/etc/profile
            source /etc/profile
            java -version | tee -a $LOG_FILE
            if [ $? != 0 ];then
                echo -e "[ $(date) ] install jdk failed, please check it" | tee -a $LOG_FILE
                exit 1
            else
                echo -e "[ $(date) ] install jdk succeed" | tee -a $LOG_FILE
            fi
        fi
    else
        JDK_NAME=$(rpm -qa | grep jdk | awk -F "-" '{print $1}')
        #修改/etc/profile
        sed -i "/JAVA/d" /etc/profile
        echo -e "export JAVA_HOME=/usr/java/$JDK_NAME" >>/etc/profile
        echo -e "export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >>/etc/profile
        echo -e "export PATH=\$JAVA_HOME/bin:\$PATH" >>/etc/profile
        source /etc/profile
        java -version | tee -a $LOG_FILE
        if [ $? != 0 ];then
            echo -e "[ $(date) ] install jdk failed, please check it" | tee -a $LOG_FILE
            exit 1
        else
            echo -e "[ $(date) ] install jdk succeed" | tee -a $LOG_FILE
        fi
    fi
}
function install_tomcat(){
    echo -e "[ $(date) ] Start install tomcat" | tee -a $LOG_FILE
    echo -e "[ $(date) ] Start uncompress tomcat package" | tee -a $LOG_FILE
    tar -zxvf $TOMCAT_PKG -C /usr/local 1>/dev/null 2>&1
    if [ -f /usr/local/$(ls /usr/local/| grep tomcat)/bin/catalina.sh ];then
        echo -e "[ $(date) ] tomcat install succeed" | tee -a $LOG_FILE
        /usr/local/$(ls /usr/local/| grep tomcat)/bin/catalina.sh start
        if [ $? = 0 ];then
            echo -e "[ $(date) ] tomcat start succeed" | tee -a $LOG_FILE
        else
            echo -e "[ $(date) ] tomcat start failed" | tee -a $LOG_FILE
            exit 1
        fi
    else
        echo -e "[ $(date) ] tomcat install failed" | tee -a $LOG_FILE
        exit 1
    fi
}
function config_file_server(){
    echo -e "[ $(date) ] Start config_file_server" | tee -a $LOG_FILE
    read -p "[ $(date) ] Do you need to set up a path?(yes/no) " P_AS
    while [ "$P_AS" != "yes" ] && [ "$P_AS" != "no" ];do
        read -p "[ $(date) ] Please enter yes or no " P_AS
    done
    if [ "$P_AS" = "yes" ];then
        read -p "[ $(date) ] Please enter the absolute path " A_PATH
        echo -e "[ $(date) ] The path set up $A_PATH" | tee -a $LOG_FILE
    else
        echo -e "[ $(date) ] The default setting path is '/opt/download'" | tee -a $LOG_FILE
        A_PATH="/opt/download"
    fi
    mkdir -p $A_PATH
    echo -e "This is a test file" >$A_PATH/readme
    if [ -d $A_PATH ];then
        echo -e "[ $(date) ] create the path $A_PATH" | tee -a $LOG_FILE
    else
        echo -e "[ $(date) ] create the path failed, please check it" | tee -a $LOG_FILE
        exit 1
    fi
    #创建文件列表配置
    echo -e "[ $(date) ] Configuration file list function" | tee -a $LOG_FILE
    DOWNLOAD_CONFIG_FILE=/usr/local/$(ls /usr/local/| grep tomcat)/conf/Catalina/localhost/download.xml
    echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" >$DOWNLOAD_CONFIG_FILE
    echo -e "<Context path=\"/download\" docBase=\"/$A_PATH\" crossContext=\"true\">" >>$DOWNLOAD_CONFIG_FILE
    echo -e "</Context>" >>$DOWNLOAD_CONFIG_FILE
    #修改web.xml
    echo -e "[ $(date) ] change web.xml" | tee -a $LOG_FILE
    WEB_FILE=/usr/local/$(ls /usr/local/| grep tomcat)/conf/web.xml
    cat $WEB_FILE | grep -n "<param-value>true</param-value>" | grep 112 1>/dev/null 2>&1
    if [ $? = 0 ];then
        echo -e "[ $(date) ] Config file list function succeed " | tee -a $LOG_FILE
    else
        sed -i "112s/false/true/" $WEB_FILE
        echo -e "[ $(date) ] Config file list function succeed " | tee -a $LOG_FILE
    fi
}
function restart_tomcat(){
    echo -e "[ $(date) ] Restart Tomcat " | tee -a $LOG_FILE
    /usr/local/$(ls /usr/local/| grep tomcat)/bin/catalina.sh stop
    /usr/local/$(ls /usr/local/| grep tomcat)/bin/catalina.sh start
    if [ $? != 0 ];then
        echo -e "[ $(date) ] create_file_server failed" | tee -a $LOG_FILE
    else
        echo -e "[ $(date) ] create_file_server succeed" | tee -a $LOG_FILE
        MACHINE_IP=$(hostname -i)
        echo -e "[ $(date) ] Address \" http://$MACHINE_IP:8080/download \"" | tee -a $LOG_FILE
    fi
}
install_jdk
install_tomcat
config_file_server
restart_tomcat
