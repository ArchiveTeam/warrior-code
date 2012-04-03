#!/bin/bash
mkdir -p /home/warrior/projects/memac
cd /home/warrior/projects/memac

echo
echo
echo "  ****************************************************************"
echo "  *                                                              *"
echo "  *   ArchiveTeam MeMac Warrior                                  *"
echo "  *                                                              *"
echo "  *   memac.heroku.com                                           *"
echo "  *                                                              *"
echo "  ****************************************************************"
echo

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

ln -s /data/data data
rm -rf data/*

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

echo
echo "Who are you? Choose a nickname (letters and numbers only)"

nickname=""
while [[ ! $nickname =~ ^[-A-Za-z0-9_]+$ ]]
do
  echo -n "Nickname: "
  read nickname
done

echo
echo "Do you want to limit the upload speed? (Leave empty for unlimited uploads.)"

bwlimit="X"
while [[ ! $bwlimit =~ ^[0-9]*$ ]]
do
  echo -n "Limit (KBytes/second): "
  read bwlimit
done

echo
echo
echo "Starting two clients..."
echo
echo

tmux new true \; \
     set set-remain-on-exit on \
     new-window "./seesaw.sh $nickname $bwlimit" \; \
     split-window "./seesaw.sh $nickname $bwlimit" \; \
     attach

