#!/bin/bash
# A small boot script.
# Pulls the latest code from GitHub, then runs ./menu.sh

stop() {
  while true
  do
    sleep 120
  done
}

cd /home/warrior/warrior-code
echo
echo "  ****************************************************************"
echo "  *                                                              *"
echo "  *   Welcome to the ArchiveTeam Warrior                         *"
echo "  *                                                              *"
echo "  *   www.archiveteam.org                                        *"
echo "  *                                                              *"
echo "  ****************************************************************"
echo
echo "      The Warrior Code is launching. Please wait..."
echo
echo "      Press Alt + F2 if you really want to login."
echo
echo
echo "Loading the ArchiveTeam Warrior..."
echo "Updating the warrior code..."
if ! git pull
then
  echo "ERROR: Could not update the code. Is your network connection OK?"
  stop
fi
git show --quiet --pretty="format:Warrior version %h -- %cr"
echo
echo
echo "Removing stale data..."
rm -rf /data/data/*
echo
echo "Starting the warrior..."

./menu.sh

stop

