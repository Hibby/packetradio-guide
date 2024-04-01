# QtTermTCP

## Set Up Repo

If you have not already done so, set up the repo [as shown here](../repo.md).

## Install

To install QtTermTCP from the repo, run the below commands:

```
sudo apt update
sudo apt install qttermtcp
```

## First Run

From your application menu, open the hamradio menu and highlight QtTermTCP.

The terminal is split into 3 key panes - a monitor window, a terminal scrollback and an input line.

### Monitor Pane

The monitor pane allows you see traffic from your modems or AX.25 ports as it is received and sent.

This pane can be scrolled to see historic traffic, and it will allow you to monitor NET/ROM NODES broadcasts, what you are sending and receiving (to compare with the terminal pane below) and if information is corrupt.

### Terminal Pane

The terminal pane presents received data after your computer has acknowledged receipt to the remote computer. This might be the interactive menu of the remote station, the list of bulletins on a messageboard or live chat.

This data may be incomplete, and is displayed as soon as packets are received and decoded. It often leads to part of a menu being displayed - keep an eye on the monitor to see what and if is going to/from your radio.

### Input Pane

The input pane is where you interact with the remote computer. An entry in here, followed by the return key, will be sent to the computer you are interacting with. Commands often take the form of a single letter or short entry like `bbs` or `chat` at a remote system's menu, or `lm` (list mine) or `sp MM0RFN` (send personal message to MM0RFN).

Pressing up in this pane might recall previous commands you have input.

## BPQNode Integration

QtTermTCP pairs very well with BPQ as a command and control method and is worth trying.

### Setup

Configure a connection to BPQ by selecting the 'Setup' menu, Hosts and any of the host entries in the menu that appears.

I assume you are connecting to a local BPQ Node, so I recommend the following settings, where the User and Password are the telnet access details you configured during the [first set up of your BPQ Node](../install/bpq.md).

Host Name: 127.0.0.1
Port: 8011
User: <username>
Password: <password>
Session Name: BPQ Local

### Helpful Hints

Select the AX.25 ports that LinBPQ presents you in the Monitor Pane by selecting monitor from the menu and selecting some ports. This means you don't need to enter `listen 2` to see feedback from port 2, as an example, and you can monitor what is happening when you try to connect through that port.

## KISS Setup

KISS set up allows you to use a modem directly with QtTermTCP as a lightweight client with any modem that presents a KISS Interface. This can be both KISS by serial or kiss by IP.
