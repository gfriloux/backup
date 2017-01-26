#!/usr/bin/bash

export NAME="Cloud"
export ARCHIVE="cloud"

. ../functions.sh

rcopy  "/home/www/cloud.friloux.me" || return 1
dbcopy "owncloud"                   || return 1
tarify                              || return 1
