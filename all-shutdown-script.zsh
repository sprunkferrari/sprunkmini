# # # # # # # # # # # # # # #  
#
#  SPRUNKMINI 
#  all-shutdown-script
#
#  Purpose of this script: Remote shutdown of known SSH device, if present, and subsequent shutdown of the local machine.
#
#  Note: Before operating, it is necessary to allow SSH to run without asking for password (for istance, enabling ROOT authentication via SSH-keys)
#  Script must be run as root.
#
#  Usage: sudo ./all-shutdown-script.zsh <SSH IP address>


#! /bin/zsh

if [[ $1 == "" ]]; then
    echo "Please provide a valid IP address as argument."
    exit 1
  else
    IP_ADDRESS=$1 && echo "all-shutdown-script now running."
  fi

PING_RESULT=$(ping -c 2 -t 2 $IP_ADDRESS | grep "ttl")

if [[ $PING_RESULT == "" ]]; then
    echo "Remote machine not found. Proceeding to shutdown local machine in 5 seconds."
    sleep 5
    shutdown -h now
  else
    echo "Shutting down remote machine."
    ssh $IP_ADDRESS shutdown -h now
    echo "Success. Shutting down local machine in 5 seconds."
    sleep 5
    shutdown -h now
  fi
