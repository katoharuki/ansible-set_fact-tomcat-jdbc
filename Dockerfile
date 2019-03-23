FROM ubuntu:16.04

## nginx
ARG nginx_version="1.12.0-1~trusty"

# Install packages
## Setup
RUN apt-get update && \
    apt-get install -y  curl \
                        wget \
                        git \
                        build-essential \
                        openssh-server \
                        openssh-client \
                        sysv-rc-conf \
                        vim \
                        maven \
                        python \
                        python-pip
RUN pip install boto
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin .*$/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN apt-get update && apt-get install -y cmake
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8
EXPOSE 22 80 443

## nginx
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN sh -c "echo 'deb http://nginx.org/packages/ubuntu/ trusty nginx' >> /etc/apt/sources.list"
RUN sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ trusty nginx' >> /etc/apt/sources.list"
RUN apt-cache policy nginx
RUN apt-get update && apt-get install nginx=${nginx_version}

CMD service ssh start && nginx && tail -f /dev/null
