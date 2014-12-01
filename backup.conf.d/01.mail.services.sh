#!/usr/bin/bash

export NAME="Mail"
export ARCHIVE="mail.services"

. /home/backup/functions.sh

#return 0

rcopy  "/etc/dovecot"  || return 1
rcopy  "/etc/postfix"  || return 1
rcopy  "/home/vmail"   || return 1
dbcopy "postfix_db"    || return 1
dbcopy "roundcubemail" || return 1
tarify                 || return 1
