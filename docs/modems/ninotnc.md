# NinoTNC

The NinoTNC is a modern hardware modem that can come in either kit form or assembled.
It connects to a computer by USB, and to a radio by a cable that is usually custom built buy the operator.

It supports traditional 300, 1200 and 9600 baud packet modes as well as some more modern experimental modes designed to be more efficient that also include forward error correction. The NinoTNC has become an integral part of many new packet radio deployments in the UK and further afield.

## Buying one

Information is available on the [TARPN Website Ordering Page](https://tarpn.net/t/nino-tnc/n9600a/n9600a_info.html).

For the UK & Ireland, boards are are available from [Tom, M0LTE](https://ko-fi.com/s/981d919ea3).


## Build

The build gide for the NinoTNC is available on the [TARPN Website](https://tarpn.net/t/nino-tnc/nino-tnc.html).

## Operation

The Through Hole NinoTNC has 2 banks of switches: Mode and Signals, explanation below.

USB is always 57600 baud

### Mode Switch

Current modes as of firmware release 3.3.1:

| Mode | Baud | bps  | Mod  | Protocol | Intended mode | BW     | Typical use |
| ---- | ---- | ---  | ---- | -------- | ------------- | ------ | ----------- |
| 0010 | 9600 | 9600 | GFSK | IL2P+CRC | FM            | 25k    | Current recommended mode for new 70cm (25kHz) links where both ends are compatible         |
| 0100 | 4800 | 4800 | GFSK | IL2P+CRC | FM            | 12.5k  | Current recommended mode for new 2m (12.5kHz) links where both ends are compatible         |
| 0101 | 2400 | 2400 | DPSK | IL2P     | FM            | 12.5k  | For situations where only a speaker/mic connection is available but > 1200 baud is desired |
| 1011 | 1200 | 2400 | QPSK | IL2P+CRC | SSB/FM        | 2.4kHz | HF - quadrature version of 1200 BPSK, twice the throughput for +3dB SNR.                   |
| 1010 | 1200 | 1200 | BPSK | IL2P+CRC | SSB/FM        | 2.4kHz | HF - use for circuits where wider transmission is acceptable.                              |
| 1001 | 300  | 600  | QPSK | IL2P+CRC | SSB           | 500Hz  | HF - quadrature version of 300 BPSK, twice the throughput for +3dB SNR                     |
| 1000 | 300  | 300  | BPSK | IL2P+CRC | SSB           | 500Hz  | HF - slowest but best performing mode. ~7dB better than classic 300 baud FSK AX.25         |
| 1110 | 300  | 300  | AFSK | IL2P+CRC | SSB           | 500Hz  | CRC improvement of IL2P 300 baud AX.25. Recommended if you can't do BPSK / QPSK on HF.     |

Superseded (but still supported) modes:

| Mode | Baud | bps  | Mod  | Protocol | Superseded By | Intended mode | BW     | Typical use |
| ---- | ---- | ---  | ---- | -------- | ------------- | ------------- | ------ | ----------- |
| 0000 | 9600 | 9600 | GFSK | AX.25    | 9600 GFSK IL2P     | FM            | 25k    | Backwards compatibility with legacy G3RUH modems                                   |
| 0001 | 9600 | 9600 | GFSK | IL2P     | 9600 GFSK IL2P+CRC | FM            | 25k    | Backwards compatibility. Obsoleted by 9600 GFSK IL2P+CRC                           |
| 0011 | 4800 | 4800 | GFSK | IL2P     | 4800 GFSK IL2P+CRC | FM            | 12.5k  | Debugging against 4800 GFSK IL2P+CRC in case of issues with the CRC mode           |
| 1111 | 1200 | 1200 | BPSK | IL2P     | 1200 BPSK IL2P+CRC | SSB/FM        | 2.4kHz | Backwards compatibility                                                            |
| 0111 | 1200 | 1200 | AFSK | IL2P     | 4800 GFSK IL2P+CRC | FM            | 12.5k  | Improvement over 1200 AFSK IL2P, where none of the GFSK modes are possible         |
| 0110 | 1200 | 1200 | AFSK | AX.25    | 1200 AFSK IL2P     | FM            | 12.5k  | VHF APRS, backwards compatibility with classic / legacy TNCs like PK232            |
| 1100 | 300  | 300  | AFSK | AX.25    | 300 AFSK IL2P      | SSB           | 500Hz  | Backwards compatibility with legacy HF packet modems. Modulation invented c. 1962! |
| 1101 | 300  | 300  | AFSK | IL2P     | 300 AFSK IL2P+CRC  | SSB           | 500Hz  | IL2P improvement of AFSK 300 baud AX.25.                                           |

Prefer:
  * QPSK > BPSK > DPSK > AFSK
  * IL2P+CRC > IL2P > IL2P > AX.25
  * SSB > FM

### Signals Switch

#### Switch 1 - Transmit audio range selection - DATA/MIC

The data / on / up position increases the TXA level so the TX-LEVEL potentiometer adjustment is in the range needed by the Data radio.

The mic / off / down position reduces transmit audio to the range needed by a microphone-level-input radio.

#### Switch 2 - Receive audio sensitivity - 1x/11x

The on / up / 1x position is about the right level for a speaker output, and is also appropriate for a data radio output.

The off / down / 11x position is used for radios which have a very low level of receive audio, e.g. perhaps when taken from a speaker mic connection.

#### Switch 3 - Transmit audio coupling control - DC/AC

Leave in the off / down / AC position unless you have a rare case where having the voltage into the modulator track the TNC’s output, exactly, is required (DC coupling).

#### Switch 4 - External carrier detect - EN/CD

Leave in the off / down / CD position unless you want to provide external transmit inhibit using pin 2 of the DB9 connector.
