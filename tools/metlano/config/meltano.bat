@rem
@rem Meltano.bat - a simple wrapper for dockerizing meltano commands
@rem

@if "%DEBUG%" == "" @echo off

@rem Getting the script's parent directory (regardless of current path):
set DIRNAME=%~dp0

echo Running dockerized command: meltano %*
echo Using project directory:    %DIRNAME%

docker run ^
    -v %DIRNAME%:/project ^
    --rm -it ^
    -w /project ^
    -p 5000:5000 ^
    meltano/meltano %*
