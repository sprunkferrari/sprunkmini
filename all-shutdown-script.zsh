# # # # # # # # # # # # # # #  
#
#  SPRUNKMINI 
#  all-shutdown-script
#
#  Purpose of this script: Remote shutdown of known SSH device, if present, and subsequent shutdown of the local machine.
#
#  Note: Before operating, it is necessary:
#  1. To allow SSH to run without asking for password (for istance, enabling authentication via SSH-keys)
#  2. That the remote user can be granted root privileges (sudo) without asking for a password
#
#  Usage: ./all-shutdown-script.zsh <SSH IP address>


#! /bin/zsh

if [[ $1 == "" ]]; then
    echo "Please provide a valid IP address as argument."
    kill 9
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
    ssh $IP_ADDRESS sudo shutdown -h now
    echo "Success. Shutting down local machine in 5 seconds."
    sleep 5
    shutdown -h now
  fi
