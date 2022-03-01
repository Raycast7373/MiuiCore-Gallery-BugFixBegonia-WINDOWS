@echo off
:MENU
cls
color a
if not exist backup\ mkdir backup
@ECHO  ----------------------------
@ECHO  MiuiCore and Gallery Fixer
@ECHO  ----------------------------
@ECHO     *UWU*  
@ECHO.
@ECHO  1) Fix Brightness slider bug (first try this one, even if you dont have problems with the brightness slider)
@ECHO  2) Fix Celluar connection bug
@ECHO.
@ECHO  3) Reboot Device
@ECHO.
@ECHO  4) Restore Menu
@ECHO.
@ECHO  ----------------------------
@ECHO  5) Exit         
@ECHO  ----------------------------
@ECHO.
@ECHO  ----------------------------
@ECHO.
ADB\adb.exe devices       
@ECHO  ----------------------------
@ECHO.
@choice /c 12345 /M "Which thing do you want to run? [1-5]: " /n 
if errorlevel 5 goto EXIT
if errorlevel 4 goto RESTOREMENU
if errorlevel 3 goto REBOOTDEVICE
if errorlevel 2 goto FIXCELLUAR
if errorlevel 1 goto FIXBRIGHTNESS
goto MENU

:FIXBRIGHTNESS
cls
ADB\adb.exe devices
echo.
echo Fixing Brightness slider bug...
echo.
echo creating backup...
ADB\adb.exe pull /data/adb/modules/MiuiGallery/service.sh backup\
echo done!
echo.
echo removing old file that causes brightness slider bug...
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiGallery/service.sh
echo done!
echo.
echo copying good file that doesnt cause this stupid bug...
ADB\adb.exe push service.sh /data/adb/modules/MiuiGallery/
echo Done!
echo.
pause
goto MENU

:FIXCELLUAR
cls
ADB\adb.exe devices
echo.
echo creating backup of the lib files...
ADB\adb.exe pull /data/adb/modules/MiuiCore/system/lib backup\
ADB\adb.exe pull /data/adb/modules/MiuiCore/system/lib64 backup\
echo done!
echo.
echo removing files that causes the problems...
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib/libmpbase.so
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib64/libmpbase.so
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib/libc++_shared.so
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib64/libc++_shared.so
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib/libarcsoft_beautyshot.so
ADB\adb.exe shell su -c rm /data/adb/modules/MiuiCore/system/lib64/libarcsoft_beautyshot.so
ADB\adb.exe shell su -c setprop miui.features 0
echo done!
echo.
pause
goto MENU

:REBOOTDEVICE
cls
ADB\adb.exe devices
echo.
ADB\adb.exe reboot
echo Done!
goto MENU

:RESTOREMENU
cls
color b
@ECHO  ----------------------------
@ECHO  MiuiCore and Gallery Fixer
@ECHO  ----------------------------
@ECHO     *UWU*  
@ECHO on
@ECHO off
@ECHO  1) Restore MiuiGallery to normal
@ECHO  2) Restore MiuiCore to normal
@ECHO on
@ECHO off
@ECHO  ----------------------------
@ECHO  3) Back         
@ECHO  ----------------------------
@ECHO.
@ECHO  ----------------------------
@ECHO.
ADB\adb.exe devices       
@ECHO  ----------------------------
@ECHO.
@choice /c 123 /M "Which thing do you want to run? [1-3]: " /n 
if errorlevel 3 goto MENU
if errorlevel 2 goto RESCORE
if errorlevel 1 goto RESGAL
goto RESTOREMENU

:RESCORE
cls
echo Restoring MiuiCore...
ADB\adb.exe push backup\lib /data/adb/modules/MiuiCore/system
ADB\adb.exe push backup\lib64 /data/adb/modules/MiuiCore/system
echo Done!
pause
goto RESTOREMENU

:RESGAL
cls
echo Restoring MiuiGallery...
ADB\adb.exe push backup\service.sh /data/adb/modules/MiuiGallery
echo Done!
pause
goto RESTOREMENU


:EXIT
cls
echo Bye!