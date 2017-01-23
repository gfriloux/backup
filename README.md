INSTALL
======

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/136e9d4cf5aa48868fcd6489e381d73b)](https://www.codacy.com/app/gfriloux/backup?utm_source=github.com&utm_medium=referral&utm_content=gfriloux/backup&utm_campaign=badger)

Create a file named *~/.backup.conf*.
Inside this file, put something like this :
```
BACKUPDIR="/home/backup/"
CONFDIR="${BACKUPDIR}/backup.conf.d/"
```
Give execution rights on it.

If you wish to use mysqldump, create *~/.my.cnf* :
```
[mysqldump]
user=root
password=mywonderfullpassword
```

Write your own modules in *backup.conf.d*.
The examples you're seeing are my real ones.

Have cron (or anything you want) to run *run.sh* when you
wish the backup to be done.

Output will be put inside backup.log.
I personnaly display it through my finger server.

Get another server to connect to your server to grab the archives.

