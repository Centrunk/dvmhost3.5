**Flashing Firmware**

For flashing, refer to https://www.centrunk.net/getting-started

**Create DVMhost 3.5**

`sudo apt update`

`sudo apt install -y cmake build-essential git libasio-dev libncurses-dev`

`sudo mkdir -p /opt/centrunk`

`cd /opt/centrunk`

`sudo git clone --recurse-submodules https://github.com/DVMProject/dvmhost.git`

`cd dvmhost`

`sudo cmake -DENABLE_DMR=0 -DENABLE_NXDN=0 -DENABLE_TUI_SUPPORT=0`

`sudo make`

Refer to spread sheet for Updated `rid_acl.dat`. Download sheet as csv, change extension to `.dat`, put in dvmhost directory.

For `tg_acl.yml`, copy from github and put in dvmhost directory as tg_acl.yml

`sudo nano /opt/centrunk/dvmhost/tg_acl.yml` copy and pasta
