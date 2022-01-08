call conda activate "C:\Users\mayberc\Anaconda3\envs\virtue-build-docs"

REM Rebuild to start with a clean slate
call make.bat clean
call make.bat html

start chrome http://127.0.0.1:8000
call sphinx-autobuild source build/html

call conda deactivate
