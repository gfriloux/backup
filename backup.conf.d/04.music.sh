#!/usr/bin/bash

export NAME="Music"
export ARCHIVE="music"

. ../functions.sh

rcopy  "/home/www/music.friloux.me"  || return 1
dbcopy "music"                       || return 1
tarify                               || return 1
