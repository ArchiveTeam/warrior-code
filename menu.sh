#!/bin/bash

stop() {
  while true
  do
    sleep 120
  done
}

version=$( git show --quiet --pretty="format:version %h (updated %cr)" )

# there could be more than one project to work on;
# this script could show a menu to choose from

project=$(
  whiptail \
    --nocancel \
    --backtitle "ArchiveTeam Warrior -- $version" \
    --title 'How can you help us?' \
    --menu '\nThanks for running an ArchiveTeam Warrior!\n\nBy running a Warrior you help the ArchiveTeam to save the web.\nYour computer downloads part of a site and uploads it to the\nArchiveTeam servers. Visit www.archiveteam.org to find out more.\n\nWhich project do you want to run?' \
    0 0 4 -- \
      tabblo   "-- archiving Tabblo      ($(./time-to-deadline.py 2012-05-30T23:59:59Z)) " \
      memac    "-- archiving MobileMe    ($(./time-to-deadline.py 2012-06-30T23:59:59Z)) " \
  3>&1 1>&2 2>&3 \
)

case $project in
  tabblo)
    projects/tabblo-boot.sh
    ;;
  memac)
    projects/memac-boot.sh
    ;;

esac

stop

