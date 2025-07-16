# HTTP3-Stream Attack

This script performs an HTTP/3 stream-based attack using the `aioquic` library.  
It abuses stream-level features by sending continuous or malformed data on new streams.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.  
  If not yet set up, refer to the root [`caddysetup`](../docs/CaddySetup.md) for installation and configuration instructions.

- Before running this attack, you **must lower** `MAX_TABLE_CAPACITY` parameter.  
  Edit the 370 line in: aioquic/src/aioquic/h3/connection.py
  to `16`.

- Customize the attack script URL in `http3-loris.sh`.  
```bash
sudo seq 1 100 | timeout 5s xargs -n1 -P100 python3 examples/http3_client.py https://<your-server-ip>
```

## ✅ Optional:
Modify and run the included timer_script.sh in another terminal to monitor server response times during the attack

## 🚀 How to Run

```bash
cd ../../aioquic
./http3-stream/http3-stream.sh
```