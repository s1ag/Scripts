#!/bin/bash

# Script for starting and stopping the Nessus vulnerability scanner

arg1=$1
arg2=$2

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
    sleep 2s
    firefox -new-tab "https://$HOSTNAME:8834"
}

start_chrome() {
    sleep 2s
    google-chrome "https://$HOSTNAME:8834"
}

# If no input
if [[ -z $arg1 ]] ; then 
    raise_error "No argument given, aborting..."

# If more than 2 positional arguments
elif [ "$#" -gt 2 ]; then
    echo "Too many arguments, aborting..."

# If valid number of positional arguments
else
    # First argument
    case $arg1 in
        -st|--start)
        start_nessus
        ;;

        -sp|--stop)
        stop_nessus
        ;;

        -h|--help)
        show_options
        ;;
        *)
            raise_error "Unknown argument: ${argument}"
            ;;
        esac
    
    # Second argument (if given)
    case $arg2 in
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
fi
# if [$1 == ""] ; then
#      echo "Insufficient arguments, choose -start or -stop"
#     exit 1
#         ;;
#     -start ) echo "Initializing Nessus..."
#             sudo /etc/init.d/nessusd start || echo "nessusd not found, do you have it installed?" 
#             sleep 4 
#             firefox -new-tab "https://$HOSTNAME:8834"

#         ;;
#     -stop ) echo "Shutting down Nessus..."
#             sudo /etc/init.d/nessusd stop 
#         ;;
#     * ) echo "You did not enter a number between 1 and 3."
# esac

