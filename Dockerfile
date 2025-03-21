FROM josh5/steam-headless:debian

# syntax=docker/dockerfile:1.3-labs
ARG DEBIAN_FRONTEND=noninteractive

RUN cat <<EOF > /etc/apt/source.list
deb https://mirrors.aliyun.com/debian/ bookworm main non-free contrib
EOF

RUN <<EOF
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/*
echo "**** Update apt database ****" \
    && apt-get update \
&& \
echo "**** Install fonts ****" \
    && apt-get install -y fonts-wqy-zenhei fonts-wqy-microhei \
    && apt-get -y dist-upgrade \
&& \
echo "**** Section cleanup ****" \
    && apt-get clean autoclean -y \
    && apt-get autoremove -y \
    && rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*
EOF

ADD overlay/ /
