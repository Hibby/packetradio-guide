# What are my choices?

Currently the choices for software boil down to 3 major stacks

## LinBPQ

LinBPQ is written by John G8BPQ and allows a computer to act as a node in a NET/ROM and AX.25 network.
It is being actively developed with both new features and bugfixes being rolled out on a regular basis.

It offers the following applications:

  * BBS
  * Chat

For details on how to use it:

  * Installation information can be found [here](install/bpq.md).
  * Configuration can be found [here](config/bpq.md).
  * The project website can be found [here](https://www.cantab.net/users/john.wiseman/Documents/)

!!! info
	BPQ has a good community, plenty of features and is well supported
	within the UK Packet Radio Network. It is a good starting point for
	beginners and old hands alike! It is available in the repo and kept up
	to date for you by me!

## XROUTER

XROUTER is written by Paula G8PZT and allows a computer to act as a node in a NET/ROM and AX.25 network.
It is being actively developed with new features and bug fixes.

It offers the following applications:

  * Chat
  * Personal Message Server


For details on how to use it:

  * Installation information can be found [here](install/xrouter.md).
  * Configuration can be found [here](config/xrouter.md).
  * The project website can be found [here](https://groups.io/g/xrouter/topics)

!!! info
	XROUTER has a good community, plenty of features and is well supported
	with an active groups.io. It has an excellent user interface and is
	quick to get up and running with! It is a good starting point for
	beginners and old hands alike! It is not available in the repo and you
	will need to remember to update it periodically.
	
## Linux Native Stack

The Linux native AX.25 stack has been authored by many over the years, and is shipped as a standard part of Debian.

It comprises kernel modules and userland code, and is not bundled as a single big monolithic application.

The system offers the following applications:

  * Node frontend via Uronode
  * BBS via FBB
  * Bash or any other terminal with axspawn
  * Many applications with axwrapper


For details on how to use it:

  * Installation information can be found [here](install/linux.md).
  * Configuration can be found [here](config/linux.md).

!!! info
	The Linux stack is deep and powerful in its featureset and nearly
	infinitely configurable, but this is both a blessing and a curse.
	It has less community than the others and is harder to get support for.
	It has been known to have bugs that cause issues with stability which
	might impact your neighbours. It is probably worth avoiding if you're a
	beginner and only exploring if you're a keen experimenter!
