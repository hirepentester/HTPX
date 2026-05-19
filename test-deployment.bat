@echo off
setlocal enabledelayedexpansion

echo Waiting 60 seconds for Server Manager to start...
timeout /t 60 /nobreak

echo.
echo Testing http://167.99.13.48:8001...
echo.

curl -s -I http://167.99.13.48:8001 | findstr "HTTP" || (
  echo Port 8001 not responding yet - may still be building
  echo.
  echo Waiting another 30 seconds...
  timeout /t 30 /nobreak
  echo.
  curl -s -I http://167.99.13.48:8001 | findstr "HTTP" || (
    echo Still not ready - Docker build may still be in progress
  )
)

echo.
echo If successful, access your application at:
echo http://167.99.13.48:8001
echo.
echo Login: admin@servermanager.local / admin123
echo.
