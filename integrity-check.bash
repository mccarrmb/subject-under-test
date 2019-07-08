#!/bin/bash

# Get diff of changed files in this branch compared to master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --name-only origin/master $current_branch`

# Run checks over modified file blob
for file in $modified_files; do
    echo "Checking $file..."
    if [[ $file == *.csv ]] ; then
      csvlint "$file"
    fi
    echo "Check complete."
done

#find . -type f -name "*."
    # sudo apt install golang-go
    # export PATH="$PATH:$HOME/go/bin"
    # go get github.com/Clever/csvlint/cmd/csvlint
    # csvlint [loop over blob]
function csv_checks {
  csvlint $1
}