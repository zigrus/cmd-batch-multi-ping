@echo off
:: varianta redactata din 3 aprilie 2015
echo.
IF [%9] NEQ [] (set n1=1
goto Start2)
IF [%8] NEQ [] (set n1=1
goto Start2)
IF [%7] NEQ [] (set n1=1
goto Start2)
IF [%6] NEQ [] (set n1=2
goto Start2)
IF [%5] NEQ [] (set n1=2
goto Start2)
IF [%4] NEQ [] (set n1=3
goto Start2)
IF [%3] NEQ [] (set n1=3
goto Start2)
IF [%2] NEQ [] (set n1=4
goto Start2)
IF [%1] NEQ [] set n1=4

:Start2

SET "_result=0"
IF [%1] == [] goto Help

:Start1
SET /A "_result+=1"
echo Проверка адреса(ов), попытка %_result%. Для выхода нажмите CTRL+C
echo.

call :VerPingOnOff "%1%"

echo.                      
IF [%2] == [] goto Time1
call :VerPingOnOff "%2%"

echo.                      
IF [%3] == [] goto Time1
call :VerPingOnOff "%3%"

echo.                      
IF [%4] == [] goto Time1
call :VerPingOnOff "%4%"

echo.                      
IF [%5] == [] goto Time1
call :VerPingOnOff "%5%"

echo.                      
IF [%6] == [] goto Time1
call :VerPingOnOff "%6%"

echo.                      
IF [%7] == [] goto Time1
call :VerPingOnOff "%7%"

echo.                      
IF [%8] == [] goto Time1
call :VerPingOnOff "%8%"

echo.                      
IF [%9] == [] goto Time1
call :VerPingOnOff "%9%"

:Time1
timeout 4 > nul
echo.
goto Start1

goto Exit
:Help
echo Использование:
echo        sping [до 9 IP-адресов или Hostname разделенные пробелом]
echo        sping без параметров выводит это сообщение 
echo Пример:
echo        sping 10.10.10.1 10.10.10.2 10.10.10.3 mail.com google.com

:VerPingOnOff
setlocal
set s1=%~1

call :UpperCase "%s1%" "s1"

FOR /L %%n IN (1,1,%n1%) DO (
ping -n 1 %s1% -w 1000 | find "TTL=" >nul 
if errorlevel 1 ( echo %s1% #offline
) else ( 
if %%n == 1 (echo %s1%)
ping -n 1 %s1% -w 1000 | find "TTL=")
)
exit /b 0

:UpperCase
setlocal
set s=%~1
for /f "tokens=2* delims=:" %%a in ('find "" ":%~1\" 2^>^&1') do set s=%%b
endlocal & set %~2=%s:~0,-1%
exit /b 0
:Exit
