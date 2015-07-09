REM 设置Home目录路径
@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

REM 设置APP_PATH变量
@set APP_PATH=%HOME%\.boobo
IF NOT EXIST "%APP_PATH%" (
    call git clone https://github.com/Jianboo/boobo.vim.git %APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating boobo.vim 
    REM 切换目录
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\_vimrc" "%APP_PATH%\.vimrc"

REM  mklink /J 创建目录联接(软链接)
call mklink /J "%HOME%\.vim" "%APP_PATH%\.vim"

IF NOT EXIST "%APP_PATH%\.vim\bundle" (
    call mkdir "%APP_PATH%\.vim\bundle"
)

IF NOT EXIST "%HOME%/.vim/bundle/vundle" (
    call git clone https://github.com/gmarik/vundle.git "%HOME%/.vim/bundle/vundle"
) ELSE (
  call cd "%HOME%/.vim/bundle/vundle"
  call git pull
  call cd %HOME%
)

call vim -u "%APP_PATH%/.vimrc.bundles" +BundleInstall! +BundleClean +qall

