
#!/bin/bash
export FAILURE=0

function postgresql_check() {
  result=`psql -U postgres -d postgresql_test -f $1 2>&1`
  if echo "$result" | grep -q "ERROR: syntax error" ; then
    echo $result
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo $result
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi;
}

# Get diff of changed files in this branch compared to master
git fetch origin master
current_branch=`git rev-parse --abbrev-ref HEAD`
modified_files=`git diff --diff-filter=CMART --name-only master $current_branch`

# Run checks over modified file blob
for file in $modified_files; do
  # Since git diff is comparing to master, a file technically counts as being added 
  # even if it is added and then subsequently deleted in this branch.
  if [[ -f "$file" && "$file" == postgresql/*.sql ]]; then
    echo -e "\e[1;33mChecking $file...\e[0m"
    # Perl compile only
    postgresql_check "$file"
  fi
done

exit $FAILURE
