title 开关IE代理
cls
@echo off
:CONFIRM
echo 开启（1）还是关闭（0）IE代理:
set /p "wyh=>"
if %wyh%==1 goto OPENED
if %wyh%==0 goto CLOSED
echo Invalid choice.
goto CONFIRM
:OPENED
:CHOICE
echo 是否设置IE代理地址为"proxy.huawei.com:8080"(Y/N)?
set /p "asw=>"
if %asw%==Y goto PROXY
if %asw%==y goto PROXY
if %asw%==N goto OTHER

if %asw%==n goto OTHER
echo Invalid choice.

goto CHOICE

:PROXY
set regpath="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
set reglist=ProxyEnable\reg_dword\%wyh% ProxyServer\reg_sz\proxy.huawei.com:8080
::添加IE代理
for %%a in (%reglist%) do (
   for /f "tokens=1-3 delims=\" %%b in ("%%a") do (
      reg add %regpath% /v %%b /t %%c /d %%d /f > nul    
   )
)
echo 开启IE代理成功 & pause > nul
goto end
:OTHER
echo 请输入IE代理地址（域名:端口号）
set /p "DIZHI=>"
set regpath="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
set reglist=ProxyEnable\reg_dword\%wyh% ProxyServer\reg_sz\%DIZHI%
for %%a in (%reglist%) do (
   for /f "tokens=1-3 delims=\" %%b in ("%%a") do (
      reg add %regpath% /v %%b /t %%c /d %%d /f > nul    
   )
)
echo 开启IE代理成功 & pause > nul
goto end
:CLOSED
set regpath="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings"
set reglist=ProxyEnable\reg_dword\%wyh% ProxyServer\reg_sz\proxy.huawei.com:8080
for %%a in (%reglist%) do (
   for /f "tokens=1-3 delims=\" %%b in ("%%a") do (
      reg add %regpath% /v %%b /t %%c /d %%d /f > nul    
   )
)
echo 关闭IE代理成功 & pause > nul
goto end
