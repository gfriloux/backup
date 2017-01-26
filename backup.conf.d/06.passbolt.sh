#!/usr/bin/bash

export NAME="Pass"
export ARCHIVE="pass"

. ../functions.sh

rcopy "/usr/share/webapps/passbolt" || return 1
dbcopy "pass"                       || return 1
tarify                              || return 1
