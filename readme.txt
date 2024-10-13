Пример инициализации источника данных с кредами из окружения в приложении на Lucee

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo
$ git init
Initialized empty Git repository in D:/wwwroot/container-demo/.git/

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
$ git add .

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
$ git commit -m "initial commit"
[master (root-commit) 96cc843] initial commit
 5 files changed, 172 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Application.cfc
 create mode 100644 index.cfm
 create mode 100644 query.cfm
 create mode 100644 readme.txt

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
$ git config --local http.sslVerify false

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
$ git remote add origin https://gitea.adl.nubes.ru/smishchuk/container-demo.git

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
$ git push -u origin master
warning: ----------------- SECURITY WARNING ----------------
warning: | TLS certificate verification has been disabled! |
warning: ---------------------------------------------------
warning: HTTPS connections may not be secure. See https://aka.ms/gcm/tlsverify for more information.
warning: ----------------- SECURITY WARNING ----------------
warning: | TLS certificate verification has been disabled! |
warning: ---------------------------------------------------
warning: HTTPS connections may not be secure. See https://aka.ms/gcm/tlsverify for more information.
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (7/7), 2.56 KiB | 2.56 MiB/s, done.
Total 7 (delta 0), reused 0 (delta 0), pack-reused 0
remote: . Processing 1 references
remote: Processed 1 references in total
To https://gitea.adl.nubes.ru/smishchuk/container-demo.git
 * [new branch]      master -> master
branch 'master' set up to track 'origin/master'.

root@dat-n-smishch1 MINGW64 /d/wwwroot/container-demo (master)
