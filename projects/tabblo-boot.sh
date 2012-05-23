#!/bin/bash
mkdir -p /home/warrior/projects/tabblo
cd /home/warrior/projects/tabblo

whiptail --infobox '\n  ArchiveTeam Tabblo Warrior\n\n  tabb.heroku.com\n  www.archiveteam.org' 11 52

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
  if ! git clone https://github.com/ArchiveTeam/tabblo-grab.git .
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

ln -s /data/data data
rm -rf data/*

if [[ ! -f wget-warc-lua ]]
then
  echo "Installing the Lua library..."
  sudo apt-get -y install liblua5.1-0
  echo "Downloading wget-warc-lua..."
  curl --location https://github.com/downloads/ArchiveTeam/tabblo-grab/wget-warc-lua.warrior > wget-warc-lua
  chmod +x wget-warc-lua
fi

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
      --backtitle "ArchiveTeam Warrior -- Tabblo" \
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
      --backtitle "ArchiveTeam Warrior -- Tabblo" \
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

/home/warrior/warrior-code/tmux-two-clients.sh "Tabblo" "/home/warrior/projects/tabblo/STOP" "./seesaw.sh $nickname $bwlimit"

