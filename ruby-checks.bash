#!/bin/bash
export FAILURE=0

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --diff-filter=CMART --name-only master $current_branch`

# Run checks over modified file blob
for file in $modified_files; do
  # Since git diff is comparing to master, a file technically counts as being added 
  # even if it is added and then subsequently deleted in this branch.
  
  if [[ -f "$file" && "$file" == *.rb ]]; then
    echo -e "\e[1;33mChecking $file...\e[0m"
    #Ruby compiler
    ruby -c "$file" 1>/dev/null
    if [ $? -gt 0 ]; then
      echo -e "\e[1;31m$file failed check.\e[0m"
      FAILURE=1
    else
      echo -e "\e[1;32m$file passed checks.\e[0m"
    fi
  fi
done

exit $FAILURE
