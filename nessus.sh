#!/bin/bash

# Script for starting and stopping the Nessus vulnerability scanner

arg1=$1

raise_error() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

show_options() {
    echo 
    echo "Usage: $0 [start/stop] [firefox/chrome] <-- optional "
    echo ""
    echo " -st, --start       Start the nessusd daemon"
    echo " -sp, --stop        Stop the nessusd daemon"
    echo
    echo "Optional Parameters"
    echo " -f,  --firefox     Open login page on Firefox"
    echo " -c,  --chrome      Open login page on Chrome"
    echo " -h,  --help        Shows options"
    echo 
}

start_nessus() {
    sudo /etc/init.d/nessusd start || echo "nessusd not found, do you have it installed?" 
}

stop_nessus() {
    sudo /etc/init.d/nessusd stop 
}

start_firefox() {
    # Allows nessusd time to intialize
    if [[ $arg1 == "-st" || "--start" ]] ; then
        sleep 3
    fi 
    firefox -new-tab "https://${HOSTNAME}:8834"
    echo "Successfully opened Firefox at https://${HOSTNAME}:8834 "
}

start_chrome() {
    # Allows nessusd time to intialize
    if [[ $arg1 == "-st" || "--start" ]] ; then
    sleep 3
    fi
    google-chrome "https://${HOSTNAME}:8834"
    echo "Successfully opened Chrome at https://${HOSTNAME}:8834"
}

# If no input given

if [[ -z $1 ]] ; then 
    raise_error "No argument given, aborting..."
    exit 0

# If more than 2 positional arguments
elif [ "$#" -gt 2 ]; then
    echo "Too many arguments, aborting..."
    exit 0

# Cannot have the same inputs


# If valid number of positional arguments
else
    for argument in "$@"
        do 
            case $argument in
                -st|--start)
                start_nessus
                ;;

                -sp|--stop)
                stop_nessus
                ;;

                -h|--help)
                show_options
                ;;

                -f|--firefox)
                start_firefox
                ;;

                -c|--chrome)
                start_chrome
                ;;
             *)
                raise_error "Unknown argument: ${argument}"
                ;;
             esac
        done
fi
