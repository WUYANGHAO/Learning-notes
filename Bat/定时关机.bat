title 定时关机
cls
@echo off
echo 设置定时关机
:B
echo 请选择输入时间格式(H/M/S)
set /p "GES=>"
if %GES%==H goto H
if %GES%==h goto H
if %GES%==M goto M
if %GES%==m goto M
if %GES%==S goto S
if %GES%==s goto S
echo Invalid choice.
goto B
:H
echo 请输入关机倒计时(小时）
set /p "DJS=>"
set /a shuttime = %DJS%*3600
shutdown -s -t %shuttime%
echo 本机将于%DJS%小时后关机 & pause > nul
goto C
:M
echo 请输入关机倒计时（分钟）
set /p "DJS=>"
set /a shuttime = %DJS%*60
shutdown -s -t %shuttime%
echo 本机将于%DJS%分钟后关机 & pause > nul
goto C
:S
echo 请输入关机倒计时（秒）
set /p "DJS=>"
shutdown -s -t %DJS%
echo 本机将于%DJS%秒后关机 & pause > nul
goto C
:C
echo 是否取消定时关机任务(Y/N)
set /p "cs=>"
if %cs%==Y goto CANCLE
if %cs%==y goto CANCLE
if %cs%==N goto end
if %cs%==n goto end
:CANCLE
shutdown -a
echo 已取消计划任务 & pause > nul
goto end
