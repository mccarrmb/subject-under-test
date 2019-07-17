#!/bin/bash
export FAILURE=0

echo -e "\e[1;33mChecking Java project...\e[0m"
# Java compiler
javac java/*.java 1>/dev/null
if [ $? -gt 0 ]; then
  echo -e "\e[1;31mJava project failed check.\e[0m"
  FAILURE=1
else
  echo -e "\e[1;32mJava project passed checks.\e[0m"
fi

exit $FAILURE
