FROM ubuntu:14.04

# Очищаем мусор ESM и хардкодим оригинальные живые репозитории
RUN rm -rf /etc/apt/sources.list.d/* && \
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://security.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list

# Отключаем проверку протухших ключей безопасности и ставим весь тулчейн
RUN apt-get update -o Acquire::Check-Valid-Until=false -o APT::Get::AllowUnauthenticated=true && apt-get install -y --force-yes \
    openjdk-6-jdk \
    python2.7 \
    git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib \
    libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev \
    libx11-dev lib32z-dev ccache libgl1-mesa-dev \
    libxml2-utils xsltproc unzip make bc nano vim \
    && apt-get clean

# Базовая настройка Git для repo sync
RUN git config --global user.name "FrizkOS Builder" && \
    git config --global user.email "build@localhost" && \
    git config --global color.ui false

ENV GIT_SSL_NO_VERIFY=true
ENV USE_CCACHE=1

WORKDIR /build
CMD ["/bin/bash"]
