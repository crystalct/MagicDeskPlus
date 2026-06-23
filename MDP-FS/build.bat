@echo off
echo =========================================
echo Compilazione progetto MagicDesk Plus FS
echo =========================================

echo.
echo [1/3] Assemblaggio di mdp-hook (Lingua: ITA)
64tass -D LANG=ITA -a mdp-hook.asm -o mdp-hook.prg
if %ERRORLEVEL% neq 0 goto :error

echo [2/3] Assemblaggio di mdp-init (Lingua: ITA)
64tass -D LANG=ITA -a mdp-init.asm -o mdp-init.prg
if %ERRORLEVEL% neq 0 goto :error

echo [3/3] Generazione immagine floppy mdp.d64
echo Formattazione disco come "MDP FILE SYSTEM" e iniezione eseguibili...
"H:\GTK3VICE-3.10-win64\bin\c1541.exe" -format "mdp file system,md" d64 mdp.d64 -write mdp-init.prg mdp-init -write mdp-hook.prg mdp-hook
if %ERRORLEVEL% neq 0 goto :error

echo.
echo =========================================
echo BUILD COMPLETATA CON SUCCESSO!
echo Immagine pronta: mdp.d64
echo =========================================
exit /b 0

:error
echo.
echo ! ERRORE DURANTE LA COMPILAZIONE O CREAZIONE DEL DISCO !
exit /b 1
