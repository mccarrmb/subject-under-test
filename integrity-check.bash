#!/bin/bash
export FAILURE=0

function csv_checks {
  csvlint $1
  if [ $? -gt 0 ] ; then
    echo "$1 failed check."
    FAILURE=1
  fi
}

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --name-only $current_branch master`

# Run checks over modified file blob
for file in $modified_files; do
    echo "Checking $file..."
    
    # CSV file
    if [[ $file == *.csv ]] ; then
      csv_checks "$file"
    fi

    echo "Check complete."
done

exit $FAILURE

#find . -type f -name "*."
    # sudo apt install golang-go
    # export PATH="$PATH:$HOME/go/bin"
    # go get github.com/Clever/csvlint/cmd/csvlint
    # csvlint [loop over blob]
