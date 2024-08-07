# Linux Native Stack

The linux native stack is highly configurable and can be easily installed on
all Debian distros. Beware! Most of the tooling is for the command line.

More detailed configuration instructions and explanations can be found
[here](../config/linux.md).

## Install

To get a basic node setup, the minimum viable software is:

!!! note "Terminal Command"
	`apt install libax25 ax25-tools ax25-apps uronode`

### BBS

To set up a BBS install fbb
!!! note "Terminal Command"
	`apt install fbb`

## Basic Config

We shall set up a single AX.25 port to receive calls and display Uronode to
calling stations.

Setting up and attaching a port is a prerequisite to monitoring, sending calls
and receiving calls.

### ax25 ports

Set up your ax25 ports in `/etc/ax25/axports`

The following example is for a NinoTNC:
```
# /etc/ax25/axports
#
# The format of this file is:
#
# name callsign speed paclen window description
#
uhf	UR0CAL-10	57600	255	2	UHF 9600bd
```

Modify the callsign to your own or your station's call.

This has to be attached as to the modem, in effect telling the computer to
listen to the modem's output. Run the below:
!!! note "Terminal Command"
	`sudo kissattach /dev/ttyACM0 uhf`

## Monitoring Traffic

The application that will show traffic picked up by your port is `axlisten`.

!!! note "Terminal Command"
	`axlisten -ac`

Running the above will show in the terminal all traffic successfully decoded by
your modem, and everything you're trying to send to the outside world. 

`axlisten` can be run beside the below commands - just open a new terminal for them!

## Outbound Calls

You can call another station by running `axcall` in the terminal:

!!! note "Terminal Command"
	`axcall <port> <remote station>`

In the case of calling my station from the port we configured above, this would be 
!!! note "Terminal Command"
	`axcall uhf GB7HIB`	

## Inbound Calls

ax25d (ax25 daemon) listens to incoming data and directs calling stations to
the application you want them to use.  It can present different applications
based on any combination of the callsign calling you, the callsign and SSID the
calling station is calling and the port they are calling to.

ax25d is controlled by `/etc/ax25/ax25d.conf`

```
# /etc/ax25/ax25d.conf
#
# ax25d Configuration File.
#
# AX.25 Ports begin with a '['.
#
[UR0CAL-10 via uhf]
NOCALL   * * * * * *  L
default  * * * * * *  - root  /usr/sbin/uronode uronode
```

Note the callsign, SSID and port are aligned with the axport in this example.
Similar to axports, modify UR0CAL to our own callsign or your station's
callsign.

ax25d is started by running the below:

!!! note "Terminal Command"
	`sudo ax25d`

Stations should be able to call uronode on your system using AX.25 and be
presented with the basic uronode.
