#!/bin/bash

RED_COLOR='\E[1;31m' #红
YELOW_COLOR='\E[1;33m' #黄
BLUE_COLOR='\E[1;34m'  #蓝
RES='\E[0m'

# 启动celery-worker
if [ "$1" == "start_celery_worker" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf start celery-worker:*
    exit
fi

# 启动celery-beat
if [ "$1" == "start_celery_beat" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf start celery-beat:*
    exit
fi

# 启动celery-flower
if [ "$1" == "start_celery_flower" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf start sep-flower
    exit
fi

# 启动python-daemon后台任务
if [ "$1" == "start_python_daemon" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf start python-daemon*
    exit
fi

# 启动所有supervisor任务
if [ "$1" == "start_all" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf start all
    exit
fi

# 重启supervisord,重新加载篇配置文件
if [ "$1" == "restart_supervisord" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf reload
    exit
fi

# 重启celery-worker
if [ "$1" == "restart_celery_worker" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart celery-worker:*
    exit
fi

# 重启celery-beat
if [ "$1" == "restart_celery_beat" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart celery-beat:*
    exit
fi

# 重启celery-flower
if [ "$1" == "restart_celery_flower" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart sep-flower
    exit
fi

# 重启python-daemon后台任务
if [ "$1" == "restart_python_daemon" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart python-daemon*
    exit
fi

# 重启所有supervisor任务
if [ "$1" == "restart_all" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart all
    exit
fi

# 停止celery-worker
if [ "$1" == "stop_celery_worker" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf stop celery-worker:*
    exit
fi

# 停止celery-beat
if [ "$1" == "stop_celery_beat" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf stop celery-beat:*
    exit
fi

# 停止celery-flower
if [ "$1" == "stop_celery_flower" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf stop sep-flower
    exit
fi

# 停止python-daemon后台任务
if [ "$1" == "stop_python_daemon" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf stop python-daemon*
    exit
fi

# 停止所有supervisor任务
if [ "$1" == "stop_all" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf stop all
    exit
fi

# 查看supervisor-status
if [ "$1" == "view_supervisor_status" ]; then
    ../venv/bin/supervisorctl -c etc/supervisor.conf status
    exit
fi

# 更新代码，更新pip依赖，重启所有supervisor任务
if [ "$1" == "update_restart_all" ]; then
    git pull
    ../venv/bin/pip install -r requirements.txt | grep -v "Requirement already satisfied"
    ../venv/bin/supervisorctl -c etc/supervisor.conf restart all
    exit
fi

# 直接执行传入的命令
if [ "$1" == "eval" ]; then
    if [ $# != 2 ] ; then
        printf "${RED_COLOR}eval后只支持一个参数，如果命令由多个词组成请使用''括起来${RES}\n"
    else
        source /opt/django/venv/bin/activate
        eval $2
    fi
    exit
fi

printf "参数:\n"
printf "${BLUE_COLOR}start_celery_worker${RES}       ${YELOW_COLOR}启动celery-worker${RES}\n"
printf "${BLUE_COLOR}start_celery_beat${RES}         ${YELOW_COLOR}启动celery-beat${RES}\n"
printf "${BLUE_COLOR}start_celery_flower${RES}       ${YELOW_COLOR}启动celery-flower${RES}\n"
printf "${BLUE_COLOR}start_python_daemon${RES}       ${YELOW_COLOR}启动所有python-daemon开头的python后台进程${RES}\n"
printf "${BLUE_COLOR}start_all${RES}                 ${YELOW_COLOR}启动所有supervisor任务${RES}\n"
printf "${BLUE_COLOR}restart_supervisord${RES}       ${YELOW_COLOR}重启supervisord,重新加载篇配置文件${RES}\n"
printf "${BLUE_COLOR}restart_celery_worker${RES}     ${YELOW_COLOR}重启celery-worker${RES}\n"
printf "${BLUE_COLOR}restart_celery_beat${RES}       ${YELOW_COLOR}重启celery-beat${RES}\n"
printf "${BLUE_COLOR}restart_celery_flower${RES}     ${YELOW_COLOR}重启celery-flower${RES}\n"
printf "${BLUE_COLOR}restart_python_daemon${RES}     ${YELOW_COLOR}重启所有python-daemon开头的python后台进程${RES}\n"
printf "${BLUE_COLOR}restart_all${RES}               ${YELOW_COLOR}重启所有supervisor任务${RES}\n"
printf "${BLUE_COLOR}stop_celery_worker${RES}        ${YELOW_COLOR}停止celery-worker${RES}\n"
printf "${BLUE_COLOR}stop_celery_beat${RES}          ${YELOW_COLOR}停止celery-beat${RES}\n"
printf "${BLUE_COLOR}stop_celery_flower${RES}        ${YELOW_COLOR}停止celery-flower${RES}\n"
printf "${BLUE_COLOR}stop_python_daemon${RES}        ${YELOW_COLOR}停止所有python-daemon开头的python后台进程${RES}\n"
printf "${BLUE_COLOR}stop_all${RES}                  ${YELOW_COLOR}停止所有supervisor任务${RES}\n"
printf "${BLUE_COLOR}view_supervisor_status${RES}    ${YELOW_COLOR}查看view_supervisor_status${RES}\n"
printf "${BLUE_COLOR}update_restart_all${RES}        ${YELOW_COLOR}更新代码，更新pip依赖，重启所有supervisor任务${RES}\n"
printf "${BLUE_COLOR}eval 'some shell cmd'${RES}     ${YELOW_COLOR}直接执行传入的命令${RES}\n"
