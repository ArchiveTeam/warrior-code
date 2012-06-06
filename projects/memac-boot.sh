#!/bin/bash
mkdir -p /home/warrior/projects/memac
cd /home/warrior/projects/memac

whiptail --infobox '\n  ArchiveTeam MeMac Warrior\n\n  memac.heroku.com\n  www.archiveteam.org' 11 52


if [[ -d .git ]]
then
  echo "Updating code..."
  if ! git pull
  then
    echo
    echo "ERROR: Could not update the code."
    echo "Is your network connection OK?"
    echo
    exit
  fi
else
  echo "Getting code..."
  if ! git clone https://github.com/ArchiveTeam/mobileme-grab.git .
  then
    echo
    echo "ERROR: Could not update the code."
    echo "Is your network connection OK?"
    echo
    exit
  fi
fi
echo

rm -f data
rm -f wget-warc

ln -s /data/data data
rm -rf data/*
ln -s /usr/bin/wget-warc wget-warc

echo "Checking rsync connection..."
if ! ( rsync fos.textfiles.com:: > /dev/null )
then
  echo
  echo "ERROR: Could not contact fos.textfiles.com."
  echo "Is your network connection OK?"
  echo
  exit
fi
echo

nickname=""
first=true
while $first || [[ ! $nickname =~ ^[-A-Za-z0-9_]+$ ]]
do
  first=false
  nickname=$(
    whiptail \
      --nocancel \
      --backtitle "ArchiveTeam Warrior -- MobileMe" \
      --title "Choose a nickname" \
      --inputbox '\nWe use your nickname to show your results on our tracker.\n\nEnter your nickname (letters and numbers only):' 0 0 \
      "$nickname" \
      3>&1 1>&2 2>&3 \
  )
done

bwlimit=""
first=true
while $first || [[ ! $bwlimit =~ ^[0-9]*$ ]]
do
  first=false
  bwlimit=$(
    whiptail \
      --nocancel \
      --backtitle "ArchiveTeam Warrior -- MobileMe" \
      --title "Do you want a bandwidth limit?" \
      --inputbox '\nYou can set a maximum upload bandwidth.\n\nEnter a limit (kilobytes/s) or leave empty:' 0 0 \
      "$bwlimit" \
      3>&1 1>&2 2>&3 \
  )
done

echo
echo
echo "Starting two clients..."
echo
echo

/home/warrior/warrior-code/tmux-two-clients.sh "MobileMe" "/home/warrior/projects/memac/STOP" "./seesaw.sh $nickname $bwlimit" "Visit our leaderboard for live statistics:\nhttp://memac.heroku.com/"

