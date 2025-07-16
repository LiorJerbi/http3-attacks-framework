# HTTP3-Att-FinProj
“This project is based on and extends the work in [efchatz/HTTP3-attacks](https://github.com/efchatz/HTTP3-attacks)”

## 🌐 Target Server Setup (Oracle Cloud + Caddy)

The attacks were tested against a **Caddy server** hosted on an **Oracle Cloud VM** running Ubuntu, with HTTP/3 (QUIC) support enabled.
We no longer maintain this specific cloud instance. If you'd like to test the attacks externally, you can create your own VM using any free cloud service of your choice.
Alternatively, you can run the Caddy server **locally** on your own machine.

- The Caddy server was configured to serve traffic over HTTP/3.
- All attacks are compatible with both **local (internal)** and **remote (cloud-based)** deployments.

> ⚠️ Note: Full instructions for setting up an Oracle Cloud VM are not included, as the process depends on your cloud account and preferences.  
> You may use any HTTP/3-capable server for testing (such as Caddy).


## 🔧 Installation

## Clone this repo
git clone https://github.com/LiorJerbi/HTTP3-Att-FinProj
cd final_proj/aioquic

## Install required system packages
sudo apt update
sudo apt install -y libssl-dev python3-pip

## Install Python requirements
pip install -e .
pip install asgiref dnslib httpbin starlette wsproto


## 🔧 Setting Up the Caddy Server

All attacks in this project require a running HTTP/3-compatible server.  
We used [Caddy](https://caddyserver.com) for this purpose, both locally and in the Oracle Cloud.

➡️ To install and configure Caddy with a self-signed TLS certificate (local or cloud), follow the detailed instructions in [`caddysetup`](aioquic/docs/CaddySetup.md).

> Note: Caddy must be running before starting any of the attack scripts.
