#!/bin/bash
export FAILURE=0

export CLASSPATH=".:/antlr/antlr.jar:$CLASSPATH"
alias antlr4='java -jar antlr/antlr.jar'
alias grun='java org.antlr.v4.gui.TestRig'

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

# Ruby verification
function ruby_checks {
  ruby -c "$1" 1>/dev/null
  if [ $? -gt 0 ]; then
    echo -e "\e[1;31m$1 failed check.\e[0m"
    FAILURE=1
  else
    echo -e "\e[1;32m$1 passed checks.\e[0m"
  fi
}

# Python verification
function python_checks {
  python -m py_compile "$1" 1>/dev/null
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

# Crontab verification
function java_checks {
  javac "$1" 1>/dev/null
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
    # CSV file
    echo -e "\e[1;33mChecking $1...\e[0m"
    if [[ "$file" == *.csv || "$file" == *.xml || || "$file" == *.xsd || "$file" == *.xlst || \
      "$file" == *.rb || "$file" == Rakefile || "$file" == *.py || "$file" == *crontab* || "$file" == *.java ]]; then

      if [[ "$file" == *.csv ]]; then
        csv_checks "$file"
      # XML file
      elif [[ "$file" == *.xml || "$file" == *.xsd || "$file" == *.xlst ]]; then
        xml_checks "$file"
      # Ruby file
      elif [[ "$file" == *.rb || "$file" == Rakefile ]]; then
        ruby_checks "$file"
      # Python file
      elif [[ "$file" == *.py ]]; then
        python_checks "$file"
      # Crontab file 
      # TODO: should really be regex
      elif [[ "$file" == *crontab* ]]; then
        crontab_checks "$file"
      elif [[ "$file" == *.java ]]; then
        java_checks "$file"
      fi

    else
      echo -e "\e[1;33m$1 has no verification defined.\e[0m"
    fi
  fi
done

exit $FAILURE
