#!/bin/bash
self="prepare"

function log {
    line=`date`" :${self}: $@"
    echo $line
#    echo $line >> $log_file
}

function die_with_error {
    if [ "$1" != "0" ]; then
        log $2
        exit 1
    fi
}


function start {
    log "--------------------------------------------start------------------------------------------------------------"
}

function finish {
    log "--------------------------------------------finish-----------------------------------------------------------"
}

function usage {
    echo "release.sh -n projectname -v 0.0.0 -p path_to_package_dir -r path_to_repository"
    echo " -n : project_name"
    echo " -v : version"
    echo " -p : package path"
    echo " -r : repository path"
    exit 1
}

while getopts "n:v:r:p:t:" OPTION
do
     case $OPTION in
         h)
             usage
             ;;
         n)
             project_name=$OPTARG
             ;;
         v)
             version=$OPTARG
             ;;
         d)
             dependency_file=$OPTARG
             ;;
         r)
             repository_directory=$OPTARG
             ;;
         p)
             package_directory=$OPTARG
             ;;
         ?)
             usage
             ;;
     esac
done

if [ "$project_name"x == "x" ] || [ "$version"x == "x" ] || [ "$repository_directory"x == "x" ] || [ "$package_directory"x == "x" ]; then
    usage
fi

log "Starting to prepare ${package_directory} directory"
rm -rf ${package_directory}
mkdir -p ${package_directory}
rsync -a --exclude=.git --exclude=debian/ --exclude=.idea --exclude=.DS_Store --exclude=src/ ${repository_directory}/ ${package_directory}
