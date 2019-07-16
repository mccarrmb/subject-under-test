#!/bin/bash
export FAILURE=0
export CLASSPATH="./java;$CLASSPATH"

echo -e "\e[1;33mChecking Java project...\e[0m"
# Java compiler
javac java/*.java 1>/dev/null
if [ $? -gt 0 ]; then
  echo -e "\e[1;31m$file failed check.\e[0m"
  FAILURE=1
else
  echo -e "\e[1;32m$file passed checks.\e[0m"
fi

exit $FAILURE
