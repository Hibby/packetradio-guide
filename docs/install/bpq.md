# BPQ
## Raspberry Pi
### Install Key

**Do this once, only.**

Our very own Hibby MM0RFN, also a Debian maintainer, has kindly packaged and is maintaining various Linux packet radio software, among them LinBPQ.

To start using his repo, you need tell your machine to trust the repo:

```
wget -q https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key
sudo mv hibby.key /etc/apt/trusted.gpg.d/hibby.asc
```

### Set up Repo
Then you need to add the repo for your OS:

```
# Ubuntu 22.04 LTS amd64
sudo sh -c 'echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages jammy main" >> /etc/apt/sources.list'

# Raspberry Pi OS 12 - 'Bookworm'
sudo sh -c 'echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bookworm main" >> /etc/apt/sources.list'

# Raspberry Pi OS 11 - 'Bullseye'
sudo sh -c 'echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bullseye main" >> /etc/apt/sources.list'

# Debian 13 amd64
sudo sh -c 'echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages testing main" >> /etc/apt/sources.list'

# Debian 12 amd64
sudo sh -c 'echo "deb https://online-amateur-radio-club-m0ouk.github.io/oarc-packages bookworm main" >> /etc/apt/sources.list'
```

### Install

After following the above steps, to install LinBPQ, run the below commands:

```
sudo apt update
sudo apt install linbpq
```

### Configure

```
sudo mv /usr/share/doc/linbpq/examples/bpq32.cfg /etc/bpq32.cfg
sudo nano /etc/bpq32.cfg
sudo chown :linbpq /etc/bpq32.cfg
sudo chmod 644 /etc/bpq32.cfg
```
