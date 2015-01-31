:: map_vdrive_to_network_then_delete.bat
:: Windows / DOS script to set up network drive as local
REM cd to root
cd C:\

REM set %TMP% to desired network target
set tmp=Z:\username\tmp

REM start <application> from cmd (shell)
"C:\Program Files\<application folder>\bin\<application .exe>

REM use subst command to make dummy (virtual) local drive
REM target drive must exist as physical drive to OS
subst E: C:\<application or system tmp dir>

REM set application temp path to E:\
:: from app GUI or via config file, if available for app

REM delete virtual local drive
subst E: /d

REM run app
:: from GUI or with <application.exe> <proc_file> at cmd line 
:: e.g. AlteryxEngineCmd.exe ModuleX.yxwz AppValues.xml
