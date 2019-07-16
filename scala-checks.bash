#!/bin/bash
export FAILURE=0

echo -e "\e[1;33Checking Scala project...\e[0m"
# Scala compiler
sbt compile "$file" 1>/dev/null
if [ $? -gt 0 ]; then
  echo -e "\e[1;31mScala project failed check.\e[0m"
  FAILURE=1
else
  echo -e "\e[1;32mScala project passed checks.\e[0m"
fi
done

exit $FAILURE
