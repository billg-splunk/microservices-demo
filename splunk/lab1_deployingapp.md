# Lab 0: Deploying the Online Boutique App

## Pre-requisites
This example will use multipass to run the application. You could alter these labs to work with GKE or other environments.

## Setup
We will use multipass (on Windows and Mac). If you are already running on Linux you can skip to here.
* Install Multipass
  * Mac Instructions
  * Windows Instructions
* Deploy a VM

These instructions were tested on a Mac.

---

### Install Multipass (Mac)
* **Install Brew**

Install [brew package manager](https://brew.sh):  

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` 

Make sure brew is fully upgraded (to at least v1.5): `brew upgrade`

Verify installation
```
$ brew --version
Homebrew 2.6.0
```

* **Install Multipass**

Install [Multipass](https://multipass.run):

`brew cask install multipass`

### Install Multipass (Windows)

* Follow instructions from [here](https://multipass.run/docs/installing-on-windows).

---

### Launch Multipass Ubuntu VM

Create your VM:  
`multipass launch -n onlineboutique -c 4 -d 20G -m 7G`

This will download Ubuntu and may take a few minute the first time.

This makes a VM named `onlineboutique`

Shell into VM:  
`multipass shell onlineboutique`

You can exit VM by typing `exit` at the command line.

To manage multipass VM:  
`multipass stop onlineboutique` stops the VM  
`multipass delete onlineboutique` deletes the VM from the hypervisor  
`multipass purge` purges created images but leaves the ubuntu template intact  

* **Install Workshop On Ubuntu VM**

A bootstrap script will install everything needed and clone this repo. Feel free to review the script before executing.

First, shell into the VM:
`multipass shell onlineboutique`

Then run the workshop setup:
```
bash <(curl -s https://raw.githubusercontent.com/billg-splunk/microservices-demo/master/splunk/utils/setup-workshop.sh)
```
You can run the commands ```docker```, ```kubectl```, ```kind```, and ```skaffold``` to confirm everything was setup correctly. You will also have a new folder with the workshop material.

* **Running the application**

To run the application, do the following:
```
cd ~/microservices-demo
sudo kind create cluster
sudo skaffold run
sudo kubectl port-forward deployment/frontend 8080:8080
```

It will take a very long time to build the application the first time.

If for some reason the skaffold command fails try running it again.

You can test if the application is running with:
```
curl localhost:8080
```
from inside the VM.

* **Accessing the application from the host**

First you will need to get the IP Address of the VM and use that to setup the ssh tunnel. Then you will be able to access the app from your host. Run the following from your host (either exiting out of the VM or in another shell).
```
multipass list
>> ...and get tyhe ip address of the onlineboutique vm. You will use it in the next command:

sudo ssh \
      -i /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa \
      -L 8080:localhost:8080 \
      ubuntu@<IP Address from above>

curl localhost:8080
```

You can tunnel it to a different port if you prefer.

## Credits
The instructions for this setup are adapted from the [APM Instrumentation Workshop](https://github.com/signalfx/apmworkshop/blob/master/apm/workshop-steps/1-prep.md) by Steve Lerner.

Updates may be found there.
