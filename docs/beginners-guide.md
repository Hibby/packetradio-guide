# Beginner's Guide

## Key Concepts

In packet radio, we connect our computers together over the air to transmit data wirelessly. As it's not as polished as Wifi (but much more fun), there are a few things you'll need to be familiar with before you can get stuck in to the network.

### Equipment

You'll need a Radio, and a computer with a cable to connect them together. Sometimes these are easy to buy online, and the moreadventurous can make them. If you've done [FT-8](https://en.wikipedia.org/wiki/FT8) or another datamode, you might already have this cable.

### Modem

You'll need a modem of some variety. For more advanced users this of often a piece of hardware such as a [NinoTNC](modems/ninotnc.md), but as a beginner you're better suited to a piece of software such as [QtSoundModem](modems/qtsm.md). As the software costs nothing and takes no time to be delivered, it's quicker to get started with!

### Client Software

You'll need a client of some form to be able to connect to the network. I would recommend [QtTermTCP](clients/qttcp.md) to start with. Again, it's free and it works with QtSoundModem, a NinoTNC and other hardware & software offerings too.

### Addresses

Every station on the network has an address. The Government issued yours when you passed your ham exam (or if you've not sat it, they will do once you pass!). My station, as an example, is MM0RFN on the air.

Sometimes, when we want to offer a service from our computer, such as a messageboard or chatroom, we will add a number afterwards. We call this an SSID, a Service Set IDentifier. Due to the limitations of AX.25, we can have from number 1 to 15. 

If you want to connect to my messageboard, you can tell your client to connect straight to MM0RFN-1, or if you want to connect to my chatroom it might be MM0RFN-4. 

SSIDs are not necessary - some stations have a frontend that will let you choose what service you want to use when you connect.

When you call your local node or a nearby station, it is most likely they will have an SSID and you will have to call that.

### Modes

Similar to normal radio, we have different Modes too. 

Instead of AM, FM, etc, we break to them down to 3 categories:

  * Protocol: How our data is encoded
  * Speed: How fast our data will travel (tied to bandwidth)
  * Modulation: what manner of sound we generate to achieve communication. 

Both stations must use the same protocol, speed and modulation to communicate on a shared frequency.

#### Protocol

We use two main protocols: AX.25 (legacy) and IL2P (modern).

##### AX.25

AX.25 is an umbrella term often used for all packet radio, but really it refers to the specification written between the 70s and 90s that defines the basics of packet.

It has a long legacy and is rather simple, but is reliable, embedded in a lot of old hardware and will likely be in use until the heat death of the universe.

Learn more [here](detail/ax25.md).

##### IL2P

IL2P, the 'Improved Layer 2 Protocol' is by Nino KK4HEJ and is an evolution of AX.25. It includes nice things such as error correction of data and allows for, theoretically, more reliable communications but isn't compatible with AX.25.

There are a number of varieties of IL2P in the wild too - learn more [here](detail/il2p.md).

#### Speeds

We often use '1200', '1200bd' or similar as shorthand for how fast our data is sending and received. The 'bd' is baud, or the number of symbols a second. For most of our communications, 1 baud is equivalent to 1 bit per second. 

We 3 broad speed categories at the moment:

  * 300bd - used on HF.
  * 1200bd - used on VHF
  * 9600bd - used on UHF and beyond

#### Modulation

Modulation is a little more complicated than the others as there are many ways to modulate a signal!

If you've played with datamodes on a radio already, you will have a reasonable feeling for this already.

The key modulations we use are:

**AFSK**

Audio Frequncy Shift Keying - Multiple audible tones. This is commonly found on VHF, FM 1200bd links.

**FSK**

Frequency Shift Keying - Multiple tones, not necessarily audible. Commonly found on UHF, FM 9600bd links.

**PSK**

Phase Shift Keying - Data encoded into changes of phase. Often found on HF links.

## Radio Set Up

Find out your local packet radio frequency first, and tune your radio to see if you can hear any activity. This will be a good indicator as to whether you need to think about HF instead of VHF/UHF.

If you're in the UK, this will be listed at [ukpacketradio.network](https://nodes.ukpacketradio.network/packet-network-map.html) or  [UKRepeater](https://ukrepeater.net/packetlist.html).

If information is available online, also take note of the details of the mode as this will come in handy setting up your modem

## Software Set Up

### Installation

If you're using Debian, Ubuntu or a Raspberry Pi it will be easiest if you install [hibby's repo](repo.md).

Once you have done that you can install the prerequisites:

`sudo apt install qtsoundmodem qttermtcp`

### Configure QtSoundModem

We shall set up QtSoundModem to understand the type of signal we are trying to receive. 

If you have details of the mode as suggested above, QtSoundModem allows easy configuration of the key details.

### Configure QtTermTCP

Open QtTermTCP and set up a Kiss Connection to your Modem. This will work for QtSoundModem or a physical modem.

#### Set up Kiss Connection

Click Setup then KISS Configuration.

Ensure 'Enable Kiss Interface' is selected, put your callsign in MYCALL and put select your modem from the 'Serial TNC' dropdown. If using a NinoTNC, the speed will be 57600.

Press OK to save setting.

At this stage, I recommend Monitoring the frequency to see if you can decode any information. Local stations will likely be beaconing and this is a good way to test you have set up correctly without interfering with other users transmissions.

Decoded data shall look like:

## Connect

Press Connect and select 'xxx'

You should be presented with some choices in the bottom pane. 

Congratulations, you are on the air!
