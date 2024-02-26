@ECHO OFf

:begin
cls
ECHO RUN AS ADMINISTRATOR
ECHO =============
ECHO 1. STOP UPDATE SERVICES AND RENAME FOLDERS
ECHO 2. Reboot
ECHO 3. DISM /online /cleanup-image /scanhealth
ECHO 4. DISM /online /cleanup-image /restorehealth
ECHO 5. DISM /online /cleanup-image /startcomponentcleanup
ECHO 6. SFC SCAN
ECHO =============
ECHO -
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4
if "%op%"=="5" goto op5
if "%op%"=="6" goto op6

ECHO Please Pick an option:
goto begin


:op1
ECHO Stopping Services
net stop bits
net stop wuauserv
net stop cryptsvc
ECHO Renaming Folders

REM Deletes old folders in case they exist
del softwaredistribution.bak
del catroot2.bak

REM Actual Rename
ren %systemroot%\softwaredistribution softwaredistribution.bak
ren %systemroot%\system32\catroot2 catroot2.bak

ECHO NOW REBOOT
pause
GOTO begin

:op2
ECHO REBOOTING
shutdown -f -t 30
pause
GOTO begin

:op3
dism.exe /online /cleanup-image /scanhealth
pause
ECHO Look at any Errors
GOTO begin

:op3
dism.exe /online /cleanup-image /scanhealth
pause
ECHO Look at any Errors
GOTO begin

:op4
dism.exe /online /cleanup-image /restorehealth
pause
ECHO Look at any Errors
GOTO begin

:op5
dism.exe /online /cleanup-image /startcomponentcleanup
pause
ECHO Look at any Errors
GOTO begin

:op6
sfc /scannow
pause
ECHO Look at any Errors
GOTO begin
