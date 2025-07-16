# ⚙️ Caddy Server Setup for HTTP/3 Testing

This guide explains how to set up a local or cloud-based Caddy server with HTTP/3 support.  
You can run this either:
- ✅ Locally on your Ubuntu machine
- 🌐 Or on a remote cloud VM (e.g., Oracle Cloud)

---

## 🧩 Step 1: Install Caddy

```bash
sudo apt update
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | \
  sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | \
  sed 's/^deb /deb [signed-by=\/usr\/share\/keyrings\/caddy-stable-archive-keyring.gpg] /' | \
  sudo tee /etc/apt/sources.list.d/caddy-stable.list
```
> ⚠️ One of the commands above causing apt update fail due to malformed entries, fix it by running:
```bash
sudo nano /etc/apt/sources.list.d/caddy-stable.list
```
> Replace the two lines in the file with:
```bash
deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main
deb-src [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main
```
Then continue:
```bash
sudo apt update
sudo apt install caddy
```

## 🧾 Step 2: Configure the Caddyfile

# Create a directory for certs (if not exists)
```bash
sudo mkdir -p /etc/caddy
```
# Generate a self-signed certificate
```bash
openssl req -x509 -newkey rsa:4096 -nodes -keyout /etc/caddy/self_signed.key -out /etc/caddy/self_signed.crt -days 365 -subj "/CN=localhost"
```
# Edit the Caddyfile
```bash
sudo nano /etc/caddy/Caddyfile
```

# Paste this into the file:
```bash
:443 {
    tls /etc/caddy/self_signed.crt /etc/caddy/self_signed.key
    respond "Caddy Server is running" 200
}
```

# ▶️ Step 3: Start the Server
```bash
sudo caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
```

> ⚠️ Note: If port 443 is in use:
```bash
sudo lsof -i :443
sudo systemctl stop <service-name>
```

## 📡 Capturing Traffic on the Caddy Server (Optional Monitoring)
To monitor incoming attack traffic on the server side (e.g., Oracle Cloud), you can capture QUIC packets using tshark.

- 1. Install Tshark (Wireshark CLI)
```bash
sudo apt update
sudo apt install tshark
```
- 2. Record Traffic
Use the following command to record traffic:
```bash
sudo tshark -i any -f "port 443" -w /tmp/caddy_side.pcap
```
> This saves all traffic to /tmp/caddy_side.pcap.
To stop recording, press Ctrl + C.

- 3. Copy the PCAP File to Your Local Machine
From your local machine (the one running the server’s VM):
```bash
scp -i /path/to/your/ssh-key.pem ubuntu@<CLOUD_VM_IP>:/tmp/caddy_side.pcap ~/Downloads/
```
Replace:

- /path/to/your/ssh-key.pem with your actual SSH private key path

- <CLOUD_VM_IP> with your Oracle Cloud server’s IP



> ℹ️ Learn more about Caddy: [https://caddyserver.com](https://caddyserver.com)


