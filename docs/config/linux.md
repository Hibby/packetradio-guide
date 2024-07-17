# Linux Native AX.25 Stack

For Debian-alikes, see [installation instructions](../install/linux.md).

Each of the below components are required to make the complete node, but they
are (generally) not all interdependent, and most of the unique components will
work to make a stripped down version.

!!! warning 
	It can be assumed that most of this is not for the Linux newbie, and
	that commands here are to be run as
	[root](../linux.md/#users-permissions-and-sudo), exercise good judgement!

## axports

Setting up basic AX.25 on Debian is relatively simple - the key file to edit here is `/etc/ax25/axports`. 

GB7HIB currently runs the following below config. Each port has been given an internal reference, I like to detail what connection they are providing. Other people map them out by number or other methods, but I find having a pretty consistent set of references to the radio/interface I'm using keeps my brain in check. 

The callsign&SSID is, in this case, the physical address for the port, akin to a MAC address on Ethernet. It shows under `ifconfig` as a mac address for the link.

Speed is the speed of the serial port on the interface. In the case of the NinoTNC, this is 57600.

Paclen is the packet length - for V/UHF links, 255 bytes is a nice length. For HF, 60-80 is more common. It means for shorter packets that aren't as likely to be impacted by changes in propagation.

Window is the number of packets that can be sent in one burst. The more reliable
the link,the higher the number. This is limited by the version of ax25 you're
running - 2.0 has a lower window than 2.2. If you're running Linux, at the
moment you're on ax25 2.0.

```
hibby@raspberrypi:~ $ cat /etc/ax25/axports
# /etc/ax25/axports
#
# The format of this file is:
#
# name callsign speed paclen window description
#
uhf	GB7HIB-10	57600	255	2	UHF 9600bd
ip	GB7HIB-11	115200	255	7	IP
```

### kissattach

`kissattach` binds the axport to a physical kiss device.

I attach my UHF port to my NinoTNC with:
!!! note "Terminal Command"
	`kissattach /dev/ttyACM0 uhf`


### axcall

With the basic port configured, you can use `axcall` to place a call. 

`hibby@raspberrypi:~ $ axcall uhf gm0nrt-7` calls my neighbour bill over layer 2/ax.25 point to point.

You can go via someone too as a digipeter, `axcall uhf gm0cqv-7 via gm0nrt` calls gm0cqv using gm0nrt as a digipeter!

## ax25ipd

`ax25ipd` manages point to point links over the internet between myself and other stations. These can be UDP and TCP. In effect, we are creating a virtual modem to handle communication with other stations, just like we are doing with software or hardware modems when dealing with 'real radios'.

There are a couple of parts needed to make this work as an interface on my system - `socat`, `ax25ipd` and `kissattach`. 

This can be a little abstract, but the mode of interaction as is follows:

We create a virtual modem with `ax25ipd`, a virtual pipe with `socat` that lets us connect to it similar to a physically attached modem and then run `kissattach` to make that relationship.

### socat

I create a socket pair to connect `ax25ipd` and `kissattach` to connect the `ip` ax25 port to the axudp tunnel.

The command I run for this is:
!!! note "Terminal Command"
	`socat -d -d -ly pty,raw,echo=0,link=/var/ax25/pty/axip1 pty,raw,echo=0,link=/var/ax25/pty/axip2`

!!! tip
	If you are copying this, you might need to make the `/var/ax25/pty` - `mkdir -p /var/ax25/pty`

This is brought up at boottime by systemd:

```
hibby@raspberrypi:~ $ cat /etc/systemd/system/kiss-socat-axip.service
[Unit]
Description=Socat interconnect for AX25 AXIP
After=network-online.target
Wants=network-online.target

[Service]
WorkingDirectory=/var/ax25
ExecStart=socat -d -d -ly pty,raw,echo=0,link=/var/ax25/pty/axip1 pty,raw,echo=0,link=/var/ax25/pty/axip2
ExecStartPost=/usr/bin/bash -c 'while ! [ -h /var/ax25/pty/axip2 ]; do sleep 1 ; done'
ExecStopPost=rm /var/ax25/pty/axip1 /var/ax25/pty/axip2

[Install]
WantedBy=multi-user.target 
```

### ax25ipd.conf

`ax25ipd.conf` is the core configuration file for this component. Below you can see that I connect to udp port 10095 of the remote station, and locally ax25ipd is in 'tnc' mode, binding to the previously created `axip1`. The route allows broadcasts `b` and is my default route `d`.

I beacon what the station is periodically, and I also allow NET/ROM NODES broadcasts and FBB broadcasts to go over the link.

```
hibby@raspberrypi:~ $ cat /etc/ax25/ax25ipd.conf
socket udp 10095
mode tnc
device /var/ax25/pty/axip1
speed 115200
loglevel 2
beacon after 3600
loglevel 2
btext ax25ip -- hibby/GB7HIB-2 -- AXIP Interface
broadcast QST-0 NODES-0 FBB-0
route MM3NDH 10.13.37.2 bd
```

### Running ax25ipd

This is run from the command line as follows:
!!! note "Terminal Command"
	`ax25ipd`

### kissattach

We need to attach the axip port to the virtual modem we've created with ax25ipd once it's running, and this is a simple case of:
!!! note Terminal Command
	`kissattach /var/ax25/pty/axip2 axip`

## NET/ROM

NET/ROM covers functionality analogous to OSI layer3/layer 4.

What it means in reality is that my node has a knowledge of its neighbours and what their neighbours are, and automates routing calls. To use the earlier example, I can call directly to gm0cqv and my machine will know the best path - 
!!! note "Terminal Command"
	`axcall nrnod GM0CQV-7`

Each NET/ROM sends a 'NODES' broadcast periodically. This details what systems it can hear, what the gateway to the remote nodes is and a 'quality' value.
Nodes on the network can have an alias too - GM0CQV's node on -7 above is
PTRNOD, so I can do the following to end up at the same location -

!!! note "Terminal Command"
	`axcall nrnod PTRNOD`

NET/ROM ports are largely independent of ax25 ports in that a user can call any given nrport without going through a specific axport. You can essentially define per-application nrports, and as many as you wish (assuming you have free unique SSIDs to offer them as mac addresses).

### nrports

`/etc/ax25/nrports`,similar to axports, defines the netrom ports the system has available. I expect primary incoming connections to be through netrom, so mine are lower numbered. 

netrom ports **should not** share SSID numbers with axports. This will make your system rather unstable. 

```
hibby@raspberrypi:~ $ cat /etc/ax25/nrports
# /etc/ax25/nrports
#
# The format of this file is:
#
# name callsign alias paclen description
#
nrnod   GB7HIB-1  HIBNOD        235     Netrom node Port
nrbbs   GB7HIB-2  HIBBBS        235     Netrom BBS Port
```

I have a port for my service, the callsign and port, and an up to 6 letter alias
for the service. The packet length is 20 bytes shorter than the ax25 packet to
account for overheads, and then there's a wee description. 

### nrbroadcast

`/etc/ax25/nrbroadcast` defines how often `netromd` sends a NODES broadcast and
what port it sends them over.

It also defines the default quality of stations received directly over that
port, the worst quality it will broadcast, how long without hearing a nodes
broadcast the station will remain in your routing table. 

I have set some sensible defaults, things that come over the ip link are quite
high, but I limit the worst quality so that my NODES table isn't too big.

```
hibby@raspberrypi:~ $ cat /etc/ax25/nrbroadcast
# /etc/ax25/nrbroadcast
#
# The format of this file is:
#
# ax25_name min_obs def_qual worst_qual verbose
#
uhf     5       192     100     1
ip      3       200     130     1
```

### nrattach

Like AX.25, we need to attach the port to a device - our tool for this is `nrattach`.

`nrattach` is simple - you nrattach a port and that's it. 
!!! note "Terminal Command"
	`nrattach nrnod`  

### netromd

`netromd` handles incoming and outgoing broadcasts.

I should really make this systemd unit come up after nrattach.

I run it as below:

!!! note "Terminal Command"
	`netromd -i -l -d -t 30` 

This broadcasts almost immediately, creates debug logs and broadcasts every 30 minutes.

## ax25d

ax25d is the Daemon that routes incoming connection requests and spins up a
process for the caller.

Interestingly, it isn't tied to the incoming port that the call is coming
through, so you can have any port or interface handle calls to any callsign,
alias or other word. 

`/etc/ax25/ax25d.conf` is the config file that controls this, and it handles
ax25 ports and netrom ports slightly differently. The default config we ship
with debian is full of great examples, see online
[here](https://salsa.debian.org/debian-hamradio-team/ax25-tools/-/blob/master/ax25/ax25d.conf.in?ref_type=heads)
- mine is configured as below. 

Reading it, you can see that GB7HIB is in [] and nrnod is in <>. They define the
type of port.  This means if you connect to GB7HIB over ax25, you get uronode.
If you connect to HIBNOD, or GB7HIB-1 over netrom, you get uronode! 

I am really interested in exploring some other applications, including
`axspawn`, which lets you spawn a bash (or other) shell and effectively gives
shell access over ax25/netrom to a user.

There's lots of options here, and it's an incredibly flexible piece of software
and is the core of why the Linux stack is so interesting to me. You can present
any binary on your system to a connecting user!

```
hibby@raspberrypi:~ $ cat /etc/ax25/ax25d.conf
# /etc/ax25/ax25d.conf
#
# ax25d Configuration File.
#
# AX.25 Ports begin with a '['.
#
[GB7HIB via uhf]
NOCALL   * * * * * *  L
default  * * * * * *  - root  /usr/sbin/uronode uronode
#
[GB7HIB via ip]
NOCALL   * * * * * *  L
default  * * * * * *  - root  /usr/sbin/uronode uronode
#
# NET/ROM Ports begin with a '<'.
#
<nrnod>
NOCALL  * * * * * *  L
default * * * * * *  -  root  /usr/sbin/uronode uronode
#
```
### Running ax25d

This is an easy one to start - 
!!! note "Terminal Command"
	`ax25d`

## Uronode Frontend

I use uronode both as a frontend for users connecting and for me connecting to
the node and to neighbouring stations, essentially over telnet. When someone
connects to my system, Uronode generates the menu that they see.

I also have it configured as my local client - i can run `uronode` in a terminal
and be presented with a helpful control interface.

### uronode.conf

This is the core config file for uronode that details what uronode can do. I'm
running mine very stripped back, and have cut a lot of the defaults out:

You can see the BBS command is just a uronode call out to GB7HIB-2 over netrom,
and there are external commands for netstat and the 'nodesearch' program I quite
like. 

The rest is pretty much default.

```
hibby@raspberrypi:~ $ cat /etc/ax25/uronode.conf
# /etc/ax25/uronode.conf - URONode example configuration file
#
# see uronode.conf(5)
# "Local" network.
# This is your local amprnet subnet in full. Do NOT use 44.0.0.0/8!

LocalNet        10.66.66.0/24

# Command aliases. See uronode.conf(5) for the meaning of the uppercase
# letters in the name of the alias. Examples below:
Alias           BBS     "c GB7HIB-2"
# External commands. See uronode.conf(5) for the meaning of the uppercase
# letters in the name of the extcmd.
#
# Flags:        1       Run command through pipe
#               2       Reconnected flag
#               3       Run through pipe and reconnect
#
ExtCmd          NEtstat 3       nobody  /bin/netstat netstat --ax25 --netrom
ExtCmd          NSearch 3       root    /usr/local/bin/nodesearch nodesearch %1

# Node ID.
# This displays before all output texts when the user connects into
# your node via NetRom. Set to "" to leave blank.
# Note: This -must- be defined or will display as "(null)". A space
# is hardcoded in. Example: UROHUB:N1URO-2 do NOT add the bracket
# afterwards "}" this is predefined in URONode.
#
NodeId          HIBNOD:GB7HIB-1

# Ax25/Flex ID.
# This displays before some strings and at logout to the end user when
# they connect in via ax25 as defined in your ax25d.conf file. If
# you don't define this "(null)" will be presented to the end user. Its
# suggested you take this from your ax25d config which either faces a
# flexnet system OR your 2-meter user interface. Note: do NOT make this
# ssid the same as your NetRom SSID here or in ax25d.conf.

FlexId          GB7HIB-10

# Netrom port name. This port is used for outgoing netrom connects.

NrPort          nrnod

ReConnect on

# Syslog Logging level - suggest leaving this at 3 for debugging. 0
# halts logging.

LogLevel        3

PassPrompt "yes"

# The default escape character (CTRL-T)
#
EscapeChar      ^T
```

### Other Uronode Config Files

I have modified some other files that are worth highlighting -

#### uronode.perms

I have added the below line which allows me to login without password from the localhost by starting from shell and gets me nice colours! 

`mm0rfn  host    *       *       255`

#### uronode.announce

This has local announcements in it!

#### uronode.info

This has information about the system in it

#### uronode.motd

This is the welcome message displayed on every login

#### uronode.users

This defines shell access for me as a sysop. I've never actually spawned a shell from uronode, but apparently it's possible?!

### Uronode as a local interface

I use uronode as my local packet radio terminal - instead of turning on and
typing `axcall nrnod salbbs` to get to gm0nrt, I log in, type uronode, feed it
my callsign and I am met with the uronode command interface, from which I can
type `c salbbs`. It's a much nicer place to be!

This required `xinetd` for me to set up easily - you'll need to install it.

#### xinetd config
I think the below two config files are the only things required to make uronode
listen on port 3964 . `xinetd` must be enabled and started by systemd to be listening 

!!! note "Terminal Command"
	`systemctl enable xinetd`, `systemctl start xinetd`

There is probably a systemd native way of doing this, but I couldn't see that in
the docs.

```
hibby@raspberrypi:~ $ cat /etc/xinetd.d/uronode
service uronode
{
        disable         = no
        socket_type     = stream
        protocol        = tcp
        user            = root
        server          = /usr/sbin/uronode
        wait            = no
        instances       = 20
}
```

```
hibby@raspberrypi:~ $ cat /etc/services | grep uronode
uronode         3694/tcp                        # Uronode
```

## FBB BBS

`fbb` is my BBS software of choice! It is an oddity in that it binds directly to
the ports you tell it exist, so it's listening on my ax25 and netrom ports
without an entry in `ax25d.conf`. This mostly seems like magic to me and I am
happy to let it run this way!

It has a few config files - fbb.conf, which is populated by the first run,
`ports.sys` which defines the ports available and then `bbs.sys` and
`forward.sys` which defines how you route to the outside world. 

### ports.sys

My reference for this file was [this website](https://www.febo.com/packet/linux-ax25/fbb-config.html), which was a
helpful resource!

I have incremented the number of TNCs where appropriate and added my ports as
1,2,3. I have left the COM 1 Interface 9 etc alone. 

``` 
hibby@raspberrypi:~ $ cat /etc/ax25/fbb/port.sys
# FBB7.0.11
#
#Ports TNCs
 1     3
#
#Com Interface Adress (Hex) Baud
 1   9         ****            9600
#
#TNC NbCh Com MultCh Pacln Maxfr NbFwd MxBloc M/P-Fwd Mode  Freq
 0   0    0   0     0     0     0     0      00/01   ----  File-fwd.
 1   8    1   uhf     250   2     1     10     00/15   XUWYL 433.6250
 2   8    1   ip    250   2     1     10     00/15   XUWYL ip port
 3   8    1   nrbbs    236   2     1     10     00/15   XUWYL netrom port
#
# End of file.
#
```

### bbs.sys, forward.sys

[The Documentation](https://web.archive.org/web/20230629033740/https://www.f6fbb.org/fbbdoc/fmtforwa.htm) is the best reference I've got for it, and I can't improve upon it.


## Running Everything

I used to use systemd to bring things up, but now I run it with a bash script run as root:

```
#!/bin/bash
echo -n 'Creating socat sockets...'
socat -d -d -ly pty,raw,echo=0,link=/var/ax25/pty/axip1 pty,raw,echo=0,link=/var/ax25/pty/axip2 &
sleep 1
echo Done
echo -n 'Starting ax25ipd'
ax25ipd
sleep 1
kissattach /dev/ttyACM0 uhf
kissattach /var/ax25/pty/axip2 ip
kissparms -c 1 -p uhf
kissparms -c 1 -p ip
sleep 1
echo 'Done'
echo -n 'Bringing up NET/ROM runtime...'
modprobe netrom
nrattach nrnod
nrattach nrbbs
nrattach nrterm
netromd -i -l -d -t 30
echo -n Starting mheard daemon...
mheardd -l
echo Done
echo -n Starting ax25 daemon...
ax25d -l
echo Done
echo -n 'Starting fbb'
sudo fbb -f -l /home/hibby/fbb.log
echo Done
```
