echo off

set /a count=0
javac -version
set vr=%javac -version%
if %errorlevel% equ 0 goto :next

echo(
echo Java Development Kit is not found on this computer. 
set /a count=0
pause
exit /b

:next	
rem echo JAVA_HOME = %JAVA_HOME%
echo(
echo Found Java Development Kit on this computer
echo continuing...

set /a count=0
:loop
if %count% LEQ  4000 (
	set /a count=%count%+1
	)
if %count% LEQ 4000 goto :loop
rem echo %count%


rem set path=%JAVA_HOME%\bin;%path%

if exist ..\launch4j\hodoku.jar del /q ..\launch4j\hodoku.jar
if exist ..\launch4j\hodoku.exe del /q ..\launch4j\hodoku.exe
if exist ..\launch4j\scratch\ rmdir /s/q ..\launch4j\scratch\
mkdir ..\launch4j\scratch\
rem xcopy ..\src\sudoku\*.form ..\launch4j\scratch\sudoku\ /h/s/e/y
xcopy ..\src\help\*.* ..\launch4j\scratch\help\ /h/s/e/y
xcopy ..\src\img\*.* ..\launch4j\scratch\img\ /h/s/e/y
xcopy ..\src\intl\*.* ..\launch4j\scratch\intl\ /h/s/e/y
copy /y ..\src\templates.dat ..\launch4j\scratch\
javac -d ..\launch4j\scratch -cp ..\src\ ..\src\sudoku\*.java ..\src\generator\*.java ..\src\solver\*.java
cd ..\launch4j\scratch
jar -cfe ..\hodoku.jar sudoku.Main *
cd..\..\setup
rem pause
rem rmdir /s/q scratch
if exist ..\launch4j\hodoku.jar (
	echo The hodoku.jar file can now be found in the launch4j folder
	)else (
		echo Building hodoku.jar failed . . .
		)

set /a count=0
:loop2
if %count% LEQ  5000 (
	set /a count=%count%+1
	)
if %count% LEQ 5000 goto :loop2
rem echo %count%
exit /b