Notice: This repo is Warrior version 1 which is now **obsolete**.

The new code is now located at [archiveteam/warrior-code2](https://github.com/archiveteam/warrior-code2) and [archiveteam/seesaw-kit](https://github.com/ArchiveTeam/seesaw-kit). The latest information and download link is located at [**☞ArchiveTeam Warrior wiki page**](http://archiveteam.org/index.php?title=Warrior).

---

The ArchiveTeam Warrior is a virtual archiving appliance. You can run it to help with the ArchiveTeam archiving efforts.

Download [the appliance (242MB)](http://archive.org/download/archiveteam-warrior/archiveteam-warrior-v1.ova) and run it with your favorite virtualization tool (VirtualBox, VMware etc.).

At this moment the Warrior can only be used to archive MobileMe, but this could be extended to other projects in the future.

## The Warrior ##

The virtual appliance uses 400MB of memory and up to 70GB of disk space. Start it and follow the instructions on screen. If you have enough, simply stop or reboot the machine.

There's no need to log in, but should you want to do that: use `Alt + F2` to switch to the login prompt and log in as `root` with password `archiveteam`.


## The Warrior Code ##

On boot, the Warrior will auto-login as `warrior` and run the `boot.sh` script, which will

1. download a copy of this repository to `/home/warrior/warrior-code/`
2. run `menu.sh` in that directory

In the future, `menu.sh` could show a menu of the active projects. The projects have boot scripts located in `/home/warrior/warrior-code/projects/`, e.g., `memac-boot.sh'. The boot script can git clone the repository of the project and will then run the project.

Projects should store their code in `/home/warrior/projects/<PROJECTNAME>/`. Data should be stored in `/data/data/`, a 60GB drive reserved for this purpose.

The `/data/data/` directory will be cleared on boot and the machine can be killed at any moment, so the project scripts should follow the seesaw download-upload cycle.

wget-warc is available in `/usr/bin/wget-warc`. curl and rsync are installed. Projects could run `sudo apt-get` to install additional packages if needed.

(See the discussions on the [ArchiveBox](http://www.archiveteam.org/index.php?title=ArchiveBox) for inspiration.)

