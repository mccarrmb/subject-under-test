#!/bin/bash
export FAILURE=0

#CSV verification
function csv_checks {
  csvlint "$1" 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

# XML verification
function xml_checks {
  xmllint "$1" 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

# Crontab verification
function crontab_checks {
  crontab "$1" 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --diff-filter=CMART --name-only master $current_branch`

# Run checks over modified file blob
for file in $modified_files; do
  # Since git diff is comparing to master, a file technically counts as being added 
  # even if it is added and then subsequently deleted in this branch.
  if [ -f "$file" ]; then
    
    if [[ -f "$file" && \
          ( "$file" == *.csv || \
          "$file" == *.xml || \
          "$file" == *.xsd || \
          "$file" == *.xlst || \
          "$file" == *crontab* ) ]]; then
      echo -e "\e[1;33mChecking $file...\e[0m"
      # CSV file
      if [[ "$file" == *.csv ]]; then
        csv_checks "$file"
      # XML file
      elif [[ "$file" == *.xml || "$file" == *.xsd || "$file" == *.xlst ]]; then
        xml_checks "$file"
      # Crontab file 
      elif [[ "$file" == *crontab* ]]; then
        crontab_checks "$file"
      fi
    fi
  fi
done

exit $FAILURE
