# HTTP3-Stream Attack

This script performs an HTTP/3 stream-based attack using the `aioquic` library.  
It abuses stream-level features by opening multiple streams with continuous or malformed data.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.  
  See the root [`CaddySetup.md`](../docs/CaddySetup.md) for setup instructions.

- Before running this attack, **modify** the `MAX_TABLE_CAPACITY` in `aioquic/src/aioquic/h3/connection.py` (line 370) and set it to `16`.

- Edit the attack script `http3-stream.sh` and replace the placeholder with your server's address:
```bash
sudo seq 1 100 | timeout 5s xargs -n1 -P100 python3 examples/http3_client.py https://<your-server-ip>
```

## ✅ Optional:
Modify and run the included timer_script.sh in another terminal to monitor server response behavior during the attack.

## 🚀 How to Run

```bash
cd ../../aioquic
./http3-stream/http3-stream.sh
```