ARG CODENAME=bullseye
FROM debian:${CODENAME}

RUN apt-get update && \
    apt-get install -y \
        gnupg \
        python3 \
        ca-certificates \
        systemd \
        systemd-sysv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /lib/systemd/system/sysinit.target.wants/ && \
    rm $(ls | grep -v systemd-tmpfiles-setup)

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [/sys/fs/cgroup]

CMD ["/sbin/init"]
