#!/bin/bash
export FAILURE=0

function csv_checks {
  echo -e "\e[1;33mChecking $1...\e[0m"
  csvlint $1
  if [ $? -gt 0 ] ; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  fi
  echo -e "\e[1;33mCheck complete.\e[0m"
}

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --name-only $current_branch master`

# Run checks over modified file blob
for file in $modified_files; do    
    # CSV file
    if [[ $file == *.csv ]] ; then
      csv_checks "$file"
    fi

done

exit $FAILURE

#find . -type f -name "*."
    # sudo apt install golang-go
    # export PATH="$PATH:$HOME/go/bin"
    # go get github.com/Clever/csvlint/cmd/csvlint
    # csvlint [loop over blob]
