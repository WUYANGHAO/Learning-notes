title 设置DNS
cls
@ECHO OFF
:CONFIRM
echo 设置（1）or 还原（0）DNS
set /p "wyh=>"
if %wyh%==1 goto SHEZHI
if %wyh%==0 goto HUANYUAN
echo Invalid choice.
goto CONFIRM
:SHEZHI
echo 请输入DNS地址：
set /p "dns=>"
netsh interface ip set dns name="本地连接" source=static addr=%dns%
echo 设置DNS:%dns%成功 & pause > nul
goto end
:HUANYUAN
netsh interface ip set dns name="本地连接" source=dhcp
echo 已还原为默认自动获取DNS & pause > nul
goto end
