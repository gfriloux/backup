#!/usr/bin/bash

. ~/.backup.conf

ARCHIVEDIR="${BACKUPDIR}/archives/"
export LOGFILE="${BACKUPDIR}/backup.log"
TMPDIR="${BACKUPDIR}/tmp/"
TMPDIRSCRIPT="${TMPDIR}${ARCHIVE}"
COPY_CMD="rsync -avzr --delete-after"
DBDUMP_CMD="mysqldump "

COLS="80"

export RED="\e[31m"
export BLACK="\e[30m"
export GREEN="\e[32m"
export YELLOW="\e[33m"
export BLUE="\e[34m"
export MAGENTA="\e[35m"
export CYAN="\e[36m"
export LIGHTGRAY="\e[37m"
export DARKGRAY="\e[90m"
export LIGHTRED="\e[91m"
export LIGHTGREEN="\e[92m"
export LIGHTYELLOW="\e[93m"
export LIGHTBLUE="\e[94m"
export LIGHTMAGENTA="\e[95m"
export LIGHTCYAN="\e[96m"
export WHITE="\e[97m"
export CANCEL="\e[39m"

filesize()
{
   FILESIZE=$(stat -c %s ${1})
   FILESIZEH=$(numfmt --to=iec-i --suffix=B --format="%3f" ${FILESIZE})
   echo "${FILESIZEH}"
}

rcopy()
{
   local LOG=$(mktemp /tmp/backuplog.XXXXXX)
   ${COPY_CMD} "${1}" "${TMPDIRSCRIPT}" 2>${LOG} 1>&2
   RET=$?
   if [ ${RET} -ne 0 ]; then
      echo "Failed to copy ${1} :"
      cat ${LOG}
   fi
   rm ${LOG}
   return ${RET}
}

dbcopy()
{
   local LOG=$(mktemp /tmp/backuplog.XXXXXX)
   echo ${DBDUMP_CMD} "${1}" >${TMPDIRSCRIPT}/${1}.sql
   ${DBDUMP_CMD} "${1}" >${TMPDIRSCRIPT}/${1}.sql 2>${LOG} 1>&2
   RET=$?
   if [ ${RET} -ne 0 ]; then
      echo "Failed to dump ${1} :"
      cat ${LOG}
   fi
   rm ${LOG}
   return ${RET}
}

tarify()
{
   local LOG=$(mktemp /tmp/backuplog.XXXXXX)
   local FROM=$(pwd)

   cd "${TMPDIR}"
   tar cvf ${ARCHIVEDIR}${ARCHIVE}.tar ${ARCHIVE} 2>${LOG} 1>&2
   RET=$?
   if [ ${RET} -ne 0 ]; then
      echo "Failed to dump ${1} :"
      cat ${LOG}
   fi

   rm ${LOG}
   cd ${FROM}
   return ${RET}
}

draw_table_title()
{
   COL=$(((COLS-4)/$#))
   COLORS=("${LIGHTCYAN}" "${WHITE}")

   COUNT=0
   for ITEM in $*
   do
      COLITEM=$((COL*COUNT+5))
      ITEMF="${ITEM:0:1}"
      ITEMR="${ITEM:1}"

      echo -en "\033[${COLITEM}G${COLORS[0]}${ITEMF}${COLORS[1]}${ITEMR}${CANCEL}"
      COUNT=$((COUNT+1))
   done
   echo -e "\033[0G┃\033[${COLS}G┃"
}

draw_table_line()
{
   COL=$(((COLS-4)/$#))
   COLORS=("${LIGHTCYAN}" "${LIGHTGREY}" "${LIGHTGREY}" "${LIGHTGREY}")

   COUNT=0
   for ITEM in $*
   do
      COLITEM=$((COL*COUNT+5))
      echo -en "\033[${COLITEM}G${COLORS[${COUNT}]}${ITEM}${CANCEL}"
      COUNT=$((COUNT+1))
   done
   echo -e "\033[0G┃\033[${COLS}G┃"
}

draw_table_line_error()
{
   COL=$(((COLS-4)/$#))
   COLORS=("${LIGHTRED}" "${LIGHTRED}" "${LIGHTRED}" "${LIGHTRED}")

   COUNT=0
   for ITEM in $*
   do
      COLITEM=$((COL*COUNT+5))
      echo -en "\033[${COLITEM}G${COLORS[${COUNT}]}${ITEM}${CANCEL}"
      COUNT=$((COUNT+1))
   done
   echo -e "\033[0G┃\033[${COLS}G┃"
}
