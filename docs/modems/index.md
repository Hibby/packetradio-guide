# About Modems

Modems are the part of a packet radio system that encodes data into audio for your radio to transmit and decodes audio received by your radio and generates control signals such at triggering the PTT so your radio knows when to transmit.

Modems have traditionally been dedicated hardware devices in packet radio, and in the last 20 years some software modems have been written as computers have become flexible and fast!

Moden modems come in many shapes and sizes. As long as the modem at each end of the link knows what they are sending and receiving, these are interchangable parts. Nothing stops you and a friend from experimenting with new modes in the UK, as long as you stay within given bandwidths and aren't intentionally obfuscating/encrypting data.

The key choices of modem as I'm presenting are:

  * [NinoTNC](ninotnc.md)
  * [QtSoundmodem](qtsm.md)
  * [Direwolf](direwolf.md)

Other modems are available however, including but not limited to

  * ARDOPc
  * VARA
  * New Packet Radio
  * Robust Packet
  * TAPR TNC2
  * KANTRONICS KAM+ and family

## What is a TNC?

A term that appears regularly is 'TNC' or Terminal Node Controller, and often Modem & TNC are used interchangably, however I have made a choice to not conflate the two items.

A TNC is a device containing not only the modem hardware, but often the Node software, personal mail, the entire logic for the AX.25 system and higher level protocols such as NET/ROM. It is effectively a complete networking computer in a box that you connected to with your computer over a serial link when computational power was a luxury not a right.

In more modern packet systems, all of these roles are taken by the software we use - BPQ entirely handles AX.25, NET/ROM, node functionality and messaging.

### KISS Mode

We can still make use of legacy TNC units - KISS mode (Keep It Simple Stupid!) strips away all of the AX.25 and other functionality of the TNC and makes it only pass serial data it is given. We use the same serial commands of KISS mode now for the majority of modems as it is simple and well documented.

Alternative modem command sets exist - onces I can name easily are:

| Command Protocol | Description
| ---------------- | -----------
| AGW or AGWPE | From AGW Packet Engine. A properitary command set that was originally released to interact with the software it is named after
| 6pack | 6pack offers more control over the radio and more awareness for the PC what is happening at the cost of greater complexity
