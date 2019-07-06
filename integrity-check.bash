#!/bin/bash

# Get list of changed files in this branch
git diff --name-only master `git rev-parse --abbrev-ref HEAD`

find . -type f -name "*.sql"




function check_mysql {

}

function check_postgresql {

}

function check_csv {

}

function check_xml {
    
}

function check_scala {
    
}

function check_java {
    
}

function check_ruby {
    
}

function check_perl {
    
}

function check_nodejs {
    
}

function check_javascript {
    
}

function check_python {
    
}

function check_cron {
    
}

