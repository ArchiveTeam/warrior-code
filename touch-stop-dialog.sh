#!/bin/bash

project=$1
stopfile=$2

result=-1
while [[ $result -ne 1 ]]
do
  whiptail --backtitle "ArchiveTeam Warrior -- $project" \
           --yes-button  'Keep running' \
           --no-button 'Stop gracefully' \
           --title 'Your Warrior is working...' \
           --yesno '\nThe Warrior is now archiving. It will keep working\nuntil you stop it (or until all the work is done).\n\nThere are two ways to stop early:\n\n1. Stop the virtual machine immediately.\n   You lose the work that has not been uploaded.\n\n2. Wait for the current jobs to complete,\n   then stop the virtual machine.\n\nTo stop gracefully, you should tell the workers to\nstop accepting new jobs from now on.' 0 0
  result=$?
done

touch $stopfile

whiptail --backtitle "ArchiveTeam Warrior -- $project" \
         --title 'Your Warrior is stopping...' \
         --msgbox '\nYou have asked the workers to stop.\n\nWait until the workers finish uploading,\nthen shut down your virtual machine.\n' 0 0

