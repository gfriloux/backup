#!/usr/bin/bash

export NAME="Social"
export ARCHIVE="social"

. ../functions.sh

rcopy  "/home/www/social.friloux.me" || return 1
dbcopy "humhub"                      || return 1
tarify                               || return 1
