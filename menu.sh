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

whiptail \
  --backtitle "ArchiveTeam Warrior -- $version" \
  --title "Sorry, this is out of date" \
  --msgbox '\nThanks for running an ArchiveTeam Warrior!\n\nUnfortunately, you are running an old version.\nThere will be no new projects on this warrior.\n\nA brand new version is waiting for you on\n\n  http://archive.org/details/archiveteam-warrior\n\n(look for the file with v2)' 18 60

stop

