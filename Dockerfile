FROM debian:11

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install openssh-server zsh tmux aria2 htop pv speedtest-cli vim curl wget netcat iperf3 iputils-ping iputils-tracepath iputils-arping iproute2 -y && \
    rm -rf /var/lib/apt

RUN cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$" > /sshd_config && \
    echo "PermitRootLogin yes" >> /sshd_config && \
    echo "" > /etc/motd && \
    rm -rf /etc/ssh /root && \
    mkdir -p /run/sshd && \
    ln -s /data/ssh /etc/ssh && \
    ln -s /data/root /root && \
    ln -s /data/log /var/log

ENTRYPOINT /entry.sh
VOLUME /data

COPY ./entry.sh /