#!/usr/bin/bash

DATE=$(date +%Y"/"%m"/"%d)

. ~/.backup.conf

cd ${BACKUPDIR}

. functions.sh

if [ ${EUID} -ne 0 ]; then
   exit 1
fi

if [ ! -e "${TMPDIRSCRIPT}" ]; then
   mkdir "${TMPDIRSCRIPT}"
fi

if [ ! -e "${ARCHIVEDIR}" ]; then
   mkdir "${ARCHIVEDIR}"
fi

rm ${LOGFILE} >/dev/null 2>&1
rm ${LOGFILE}.error 2>/dev/null 2>&1

draw_table_title "Module" "Date" "Size" "Duration" >>${LOGFILE}

cd ${CONFDIR}
for file in *; do
   BEGIN=$(date +%s)
   END=""
   RET=""
   TIMEDIFF=""

   . ./${file} >>${LOGFILE}.error
   RET=$?

   END=$(date +%s)
   TIMEDIFF=$((${END}-${BEGIN}))
   SIZE=$(filesize ${ARCHIVEDIR}/${ARCHIVE}.tar)

   if [ ${RET} -ne 0 ]; then
     draw_table_line_error "${NAME}" "${DATE}" "${SIZE}" "${TIMEDIFF}s" >>${LOGFILE}
   else
     draw_table_line "${NAME}" "${DATE}" "${SIZE}" "${TIMEDIFF}s" >>${LOGFILE}
   fi
done
