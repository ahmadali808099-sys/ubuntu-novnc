#!/bin/bash

set -e

PORT="${PORT:-8006}"

mkdir -p /home/user/.vnc
chown -R user:user /home/user

cat > /home/user/.vnc/xstartup <<'EOF'
#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

xrdb "$HOME/.Xresources" 2>/dev/null || true

startxfce4 &
EOF

chmod +x /home/user/.vnc/xstartup
chown user:user /home/user/.vnc/xstartup

rm -f /tmp/.X1-lock
rm -f /tmp/.X11-unix/X1

su - user -c "vncserver :1 -geometry 1280x720 -depth 24 -localhost no"

sleep 3

websockify --web=/usr/share/novnc \
    "$PORT" \
    localhost:5901 &

echo "Ubuntu + XFCE + TigerVNC + noVNC started"
echo "Listening on port: $PORT"

wait
