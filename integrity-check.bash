#!/bin/bash
export FAILURE=0

function csv_checks {
  echo -e "\e[1;33mChecking $1...\e[0m"
  csvlint "$1"
  if [ $? -gt 0 ] ; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

function xml_checks {
  echo -e "\e[1;33mChecking $1...\e[0m"
  xmllint "$1"
  if [ $? -gt 0 ] ; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --diff-filter=CMART --name-only $current_branch master`

# Run checks over modified file blob
for file in $modified_files; do    
    # CSV file
    if [[ "$file" == *.csv ]] ; then
      csv_checks "$file"
    elif [[ "$file" == *.xml || "$file" == *.xsd || "$file" == *.xlst ]]; then
      xml_checks "$file"
    fi

done

exit $FAILURE
