# HTTP3-Loris Attack

This script performs an HTTP/3 Loris-style attack by sending requests with slow headers using the `aioquic` library.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.  
  If not yet set up, refer to the root [`caddysetup`](../docs/CaddySetup.md) for installation and configuration instructions.

- Confirm the `MAX_TABLE_CAPACITY` parameter in: aioquic/src/h3/connection.py
  is set to the default value `4096`.

- Customize the attack script URL in `http3-loris.sh`.  
```bash
sudo seq 1 40 | timeout 5s xargs -n1 -P40 python3 examples/http3_client.py https://<your-server-ip> -d $x
```

## ✅ Optional:
Modify and run the included timer_script.sh in another terminal to monitor server response times during the attack

## 🚀 How to Run

```bash
cd ../../aioquic
./http3-loris/http3-loris.sh
```

