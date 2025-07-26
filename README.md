# HTTP/3 Attacks Framework
This project implements and extends multiple attack techniques targeting HTTP/3 servers over QUIC, inspired by the research in [efchatz/HTTP3-attacks](https://github.com/efchatz/HTTP3-attacks).  
It includes Loris, Stream, and Flood attacks tested against a Caddy server in both local and cloud environments.

> 🔍 This framework is intended for educational and research purposes only.

## 🌐 Target Server Setup (Caddy on Oracle Cloud or Localhost)

The attacks were tested against a **Caddy server** with HTTP/3 support:

- Hosted on an **Oracle Cloud VM** (Ubuntu)
- Also works **locally** on any Ubuntu machine

> ℹ️ We no longer maintain the Oracle VM, but you can test attacks on any HTTP/3-capable server (like [Caddy](https://caddyserver.com)).

📄 Full setup instructions for Caddy (including HTTPS self-signed TLS and port configs) are in [`aioquic/docs/CaddySetup.md`](aioquic/docs/CaddySetup.md).

---

## 🔧 Installation Guide

> ℹ️ Tested on: Ubuntu 22.04 · Python 3.10.12 · Caddy 2.10.0

### 1. Clone the repository

```bash
git clone https://github.com/LiorJerbi/http3-attacks-framework.git
cd http3-attacks-framework/aioquic
```

### 2. Install system dependencies
```bash
sudo apt update
sudo apt install -y libssl-dev python3-pip
```

### 3. Install Python requirements
```bash
pip install -e .
pip install asgiref dnslib httpbin starlette wsproto
```
---

### ⚙️ Caddy Server Setup

All attacks in this project require a running HTTP/3-compatible server.  
We used [Caddy](https://caddyserver.com) for this purpose, both locally and in the Oracle Cloud.

➡️ To install and configure Caddy with a self-signed TLS certificate (local or cloud), follow the detailed instructions in [`caddysetup`](aioquic/docs/CaddySetup.md).

> 🔄 Remember to start the Caddy server before launching any attack scripts.

---

## 📂 Attack Modules

Each attack has its own folder with detailed instructions:

- [HTTP3-Loris](aioquic/http3-loris/README.md)
- [HTTP3-Stream](aioquic/http3-stream/README.md)
- [HTTP3-Flood](aioquic/http3-flood/README.md)

---

Feel free to explore each module and adapt the framework for further testing or extension.
