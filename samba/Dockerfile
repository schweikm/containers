FROM registry.access.redhat.com/ubi8/ubi:latest

LABEL maintainer="Marc Schweikert <schweikm@gmail.com>"

ARG USER=project
ARG UID=1012
ARG GROUP=project
ARG GID=1012
ARG SHELL=/sbin/nologin
ARG EXPORT=/export/samba
ARG SMBPASS=password

RUN yum -y upgrade && \
    yum -y install samba && \
    mkdir -p $EXPORT && \
    groupadd --gid $GID $GROUP && \
    useradd --uid $UID --gid $GID --home-dir $EXPORT --shell $SHELL $USER && \
    rm -fr /var/cache/yum

COPY smb.conf /etc/samba/smb.conf

RUN testparm -v -s && \
    (echo $SMBPASS ; echo $SMBPASS) | smbpasswd -s -a $USER && \
    umask 0022 && \
    chown $USER:$GROUP $EXPORT

VOLUME $EXPORT

ENV KRB5CCNAME FILE:/run/samba/krb5cc_samba

EXPOSE 137/udp 138/udp 139 445

CMD ["/usr/sbin/smbd", "--interactive", "--no-process-group", "--debuglevel=2"]
