#!/usr/bin/env bash
set -e

mkdir --parents /media/samba/public
mkdir --parents /media/samba/restricted

if [ -z "$SAMBA_PASSWORD" ]; then
    echo "SAMBA_PASSWORD is empty. You need to set a password."
    exit 1
fi

echo "configuring samba server for user \"$SAMBA_USER\""

cat > /etc/samba/smb.conf << EOF
[global]
workgroup = ${SAMBA_WORKGROUP}
server role = standalone server
create mask = 0644
directory mask = 0755
security = user

[restricted]
path = /media/samba/restricted
read only = no
valid users = ${SAMBA_USER}
guest ok = no

[public]
path = /media/samba/public
read only = no
guest ok = yes
guest only = yes

EOF

id "$SAMBA_USER" || true
if ! (id "$SAMBA_USER" > /dev/null 2>&1); then
    adduser "$SAMBA_USER" --quiet --disabled-password --disabled-login --no-create-home --gecos ""
fi
(echo "$SAMBA_PASSWORD"; echo "$SAMBA_PASSWORD") |smbpasswd -s -a "$SAMBA_USER"

testparm -s

exec "$@"