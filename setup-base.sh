# Bash instead of Dash
echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

# apt using ustc mirror
cp sources.ustc.list /etc/apt/sources.list

apt-get update

# workaround for make 3.81/3.82
apt-get install -y wget && \
    wget http://mirrors.ustc.edu.cn/ubuntu/pool/main/m/make-dfsg/make_3.81-8.2ubuntu3_amd64.deb -O /tmp/make.deb && \
    dpkg -i /tmp/make.deb

apt-get install -y git gnupg flex bison gperf build-essential\
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    libncurses5-dev lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip python \
    vim subversion dos2unix bc expect lzop && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && apt-get update && apt-get install -y --allow-unauthenticated openjdk-7-jdk && \
    add-apt-repository -y ppa:webupd8team/java && apt-get update && \
    echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && apt-get install -y oracle-java6-installer
#apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
apt-get clean


# 4.9 kernel for bbr
echo deb http://mirrors.ustc.edu.cn/ubuntu/ zesty main restricted universe multiverse >> /etc/apt/sources.list
apt-get update
apt-get install linux-image-4.9.0-12-generic linux-image-extra-4.9.0-12-generic linux-headers-4.9.0-12
sed -i '$ d' /etc/apt/sources.list
apt-get update
# bbr
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

# docker
apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
cat <<EOF > /etc/apt/sources.list.d/docker.list
deb http://mirrors.ustc.edu.cn/apt.dockerproject.org/repo ubuntu-$(lsb_release -c|cut -f2) main
EOF
apt-get install -y linux-image-extra-$(uname -r)
apt-get update; apt-get install -y docker-engine
