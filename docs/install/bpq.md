# BPQ

## Set Up Repo

If you have not already done so, set up the repo [as shown here](../repo.md).

## Install

To install LinBPQ from the repo, run the below commands:

```
sudo apt update
sudo apt install linbpq
```

## Configure

```
sudo mv /usr/share/doc/linbpq/examples/bpq32.cfg /etc/bpq32.cfg
sudo nano /etc/bpq32.cfg
sudo chown :linbpq /etc/bpq32.cfg
sudo chmod 644 /etc/bpq32.cfg
```
