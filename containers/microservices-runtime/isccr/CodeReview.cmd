@echo off
rem webMethods Integration Server Continuous Code Review
rem Software AG Global Consulting Services
rem Copyright (C)2015 Software AG.  All rights reserved
rem Author: Dave.Pemberton@SoftwareAG.com
rem -------------------------------------
rem Set the code review home directory
rem for where to find the files
rem 
rem If using jenkins, this will need
rem changing to the fully qualified path
rem -------------------------------------
set CODEREVIEW_HOME=.

::get javaw.exe from the latest properly installed jre
for /f tokens^=2^ delims^=^" %%i in ('reg query HKEY_CLASSES_ROOT\jarfile\shell\open\command /ve') do (
set JAVA_PATH=%%i
)

::if reg entry is not found, java is not installed
if "%JAVA_PATH%"=="" goto NotFound

::then strip "\javaw.exe" from the JAVAW_PATH obtained above
set JAVA_HOME=%JAVA_PATH:\bin\javaw.exe=%


set str1="%JAVA_HOME%"

:v18
rem -----------------------------
rem check for v1.8
rem -----------------------------
echo Looking for JREv1.8
if not x%str1:jre1.8=%==x%str1% GOTO FoundJVM

:v17
rem -----------------------------
rem check for v1.7
rem -----------------------------
echo Looking for JREv1.7
if not x%str1:jre1.7=%==x%str1% GOTO FoundJVM

:NotFound
echo.
echo +--------------------------------------------------------------------+
echo ^| !WARNING! Unable to locate a compatible JRE.                       ^|
echo +--------------------------------------------------------------------+
echo ^| Please download a JRE (v1.8 or v1.7) from                          ^|
echo ^| http://www.oracle.com/technetwork/java/javase/downloads/index.html ^|
echo +--------------------------------------------------------------------+
echo Assuming JAVA_HOME is already set!
GOTO Execute

:FoundJVM
echo %JAVA_HOME%
Echo Found Compatible JVM at: %JAVA_HOME%
Echo Starting Continuous Code Review Using discovered JVM

:Execute
if [%1]==[-?] GOTO Usage
if [%1]==[-help] GOTO Usage
if [%1]==[--help] GOTO Usage
"%JAVA_HOME%\bin\java.exe" %* -classpath %CODEREVIEW_HOME%\lib\GCS_ContinuousCodeReview-Common.jar;%CODEREVIEW_HOME%\lib\GCS_ContinuousCodeReview-Pub.jar;%CODEREVIEW_HOME%\lib\GCS_ContinuousCodeReview-impl.jar;%CODEREVIEW_HOME%\classes\;%CODEREVIEW_HOME%\lib\lm.jar;%CODEREVIEW_HOME%\lib\xom-1.2.10.jar com.softwareag.gcs.wm.codereview.CodeReview
GOTO End

:Usage
echo Parameter not supplied
echo Usage
echo ---------------------
echo CodeReview [Parameters] 
echo.
echo Where Parameters can be any java system property, e.g.
echo  CodeReview 
echo.
echo      -Dcode.review.directory=c:\Jenkins\jobs\IotDemo\workspace [CODE LOCATION       ]
echo      -Dcode.review.pkgname=IotDemo                             [PACKAGE NAME        ]
echo      -Dcode.review.pkgprefix=Iot                               [PACKAGE PREFIX      ]
echo      -Dcode.review.options=customOptions.xml                   [OVERRIDE CONFIG FILE]
echo ---------------------
:End
echo Complete
