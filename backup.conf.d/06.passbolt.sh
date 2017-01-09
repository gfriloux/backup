#!/usr/bin/bash

export NAME="Pass"
export ARCHIVE="pass"

. ../functions.sh

rcopy "/home/www/pass.friloux.me" || return 1
dbcopy "pass"                     || return 1
tarify                            || return 1
