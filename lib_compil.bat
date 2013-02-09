set rootPath=%CD%
chdir %fd_sdk% 
compc.exe -load-config+="%rootPath%\PhysicEngine.flex.compc.xml" +rootPath="%rootPath%"

pause