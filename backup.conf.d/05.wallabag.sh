#!/usr/bin/bash

export NAME="Read"
export ARCHIVE="read"

. ../functions.sh

rcopy  "/home/www/read.friloux.me"   || return 1
tarify                               || return 1
