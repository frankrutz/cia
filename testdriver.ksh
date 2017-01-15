#!/usr/bin/bash
echo start

date
echo "MY_DB_SERVER   ::${MY_DB_SERVER}::"
echo "MY_DB_PASSWD   ::${MY_DB_PASSWD}::"
echo "MY_TEST_TARGET ::${MY_TEST_TARGET}::"

sleep 1

for COUNTER in {1..25}
do
date
sqlcmd -S ${MY_DB_SERVER} -U SA -P ${MY_DB_PASSWD} -Q "select getDate()";
echo "MY_TEST_TARGET ::${MY_TEST_TARGET}::loop ${COUNTER}"
sleep 1
done


echo end
