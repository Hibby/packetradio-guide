# Hibby's Repo
## Install Signing Key

First, you need tell your machine to trust the signature I verify the packages with:

```
wget -q https://online-amateur-radio-club-m0ouk.github.io/oarc-packages/hibby.key
sudo mv hibby.key /etc/apt/trusted.gpg.d/hibby.asc
```

You can trust this key - it is contained in [Debian](https://salsa.debian.org/debian-keyring/keyring/-/blob/master/debian-keyring-gpg/0x03A1FB7A1904771B?ref_type=heads) and signed as trusted by other developers in the project.

## Set up Repo
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

## Update

Once the repo is setup, refresh your package lists and we're good to go:

```
sudo apt update
```
