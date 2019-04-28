### Dockerfile to run container with SSH
### Container created to run in structurer of Moodle in Isesp

FROM alpine:3.9.3

MAINTAINER Cassio Jose de Jesus <cassio.jjesus@tidescontraida.com.br>

RUN apk --update add --no-cache openssh bash \
    #&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
    && rm -rf /var/cache/apk/* \
    && sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config \
    && sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config \
    && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config \
    && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config \
    && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config \
    && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config \
    && /usr/bin/ssh-keygen -A \
    && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key \
    && deluser xfs \
    && adduser www-data -D -u 33 \
    && echo "www-data:KR26z1q3Il6suBu" | chpasswd \


EXPOSE 22

#CMD ["/usr/sbin/sshd","-D"]

### References:
# https://hub.docker.com/r/gotechnies/alpine-ssh/dockerfile (2019-04-17 at 13:36)
