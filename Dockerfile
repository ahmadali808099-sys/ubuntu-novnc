FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    sudo \
    xfce4 \
    xfce4-goodies \
    dbus-x11 \
    tigervnc-standalone-server \
    novnc \
    websockify \
    xterm \
    curl \
    wget \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

RUN mkdir -p /home/user/.vnc && \
    chown -R user:user /home/user

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV DISPLAY=:1

CMD ["/start.sh"]
