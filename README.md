# Official DVM3.5 FNE2 Test Server
**ZT IP: 10.147.17.245 Port: 63030**

---

**Flashing Firmware**

For flashing, refer to https://www.centrunk.net/getting-started

**Create DVMhost 3.5**

`sudo apt update`

`sudo apt install -y cmake build-essential git libasio-dev libncurses-dev`

`sudo mkdir -p /opt/centrunk/configs`

`cd /opt/centrunk`

`sudo git clone --recurse-submodules https://github.com/DVMProject/dvmhost.git`

`cd dvmhost`

`sudo cmake -DENABLE_DMR=0 -DENABLE_NXDN=0 -DENABLE_TUI_SUPPORT=0`

`sudo make`

Refer to spread sheet for Updated `rid_acl.dat`. Download sheet as csv, change extension to `.dat`, put in `/opt/centrunk/configs` directory.

For `tg_acl.yml`, copy from github and put in `/opt/centrunk/configs` directory as tg_acl.yml

`sudo nano /opt/centrunk/configs/tg_acl.yml` copy and pasta

Copy the appropriate config file you are wanting to use and save it in `/opt/centrunk/configs`

---

# Compiled DVMhost 3.5 32-bit

`wget https://10.147.17.100/compiled.sh`

This will pull a script from Juan's host server that will create appropriate directories if not already made and pull complied dvmhost.

Follow steps above for tg_acl.yml, rid_acl.dat, and configs.

`sudo sh -x compiled.sh`

You can run compiled.sh again for another dvmhost update if one is pushed from DVMProject.

