FROM jupyter/datascience-notebook:notebook-6.5.2
ARG DEVIAN_FRONTEND=nointeractive

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        zsh=5.8.1-1 \
        vim=2:8.2.3995-1ubuntu2.3 \
        fzf=0.29.0-1 \
        tmux=3.2a-4ubuntu0.1 \
        tzdata=2022g-0ubuntu0.22.04.1 && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip && \
    pip3 install --no-cache-dir \
        opencv-python

ENV TZ=Asia/Tokyo

RUN useradd -m -s /usr/bin/zsh endo && \
    gpasswd -a endo sudo && \
    echo "endo:endo" | chpasswd && \
    echo 'endo ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers.d/endo

USER endo
ENV HOME /home/endo
WORKDIR /home/endo

RUN git clone https://github.com/skipbit/dots.git && \
    cd dots && \
    make install

