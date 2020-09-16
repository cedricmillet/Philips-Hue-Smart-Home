:: Ce script permet de copier le package (contenu du dossier lib) dans le dossier selectionné
@echo off
title SCRIPT DEPLOIEMENT PACKAGE


:: SOURCE PATH
set CURRENT_PATH=%cd%
set SOURCE_PACKAGE_PATH=%CURRENT_PATH%\lib\Hue

:: TARGET PATH
set DEPLOY_PATH=C:\Users\mille\Desktop\DEV\morphy\lib
set TARGET_PACKAGE_PATH=%DEPLOY_PATH%\Hue

:: USER CONFIRMATION
echo.
echo /!\ Verifiez les chemins avant de poursuivre /!\
echo.
echo SOURCE_PACKAGE_PATH             %SOURCE_PACKAGE_PATH% (!! ce dossier sera supprime !!)
echo TARGET_PACKAGE_PATH             %TARGET_PACKAGE_PATH%
echo.
echo.
PAUSE

::  DELETE
echo ---- Suppression ancien package....
rmdir %TARGET_PACKAGE_PATH% /s /q

:: COPY
echo ---- Copie nouveau package....
robocopy %SOURCE_PACKAGE_PATH% %TARGET_PACKAGE_PATH% /s /e
::echo ---- Copie de pubspec.yaml....
::copy pubspec.yaml %TARGET_PACKAGE_PATH%\pubspec.yaml


echo.
echo.
echo COPIE TERMINEE.
echo.
echo.
PAUSE
EXIT