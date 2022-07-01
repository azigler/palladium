#! /bin/bash
# https://github.com/docker-mailserver/docker-mailserver/issues/2545#issuecomment-1097590082
# and
# https://github.com/docker-mailserver/docker-mailserver/issues/2515?page=2
sed -i 's/mydestination\s=\s$myhostname,\slocalhost\.$mydomain,\slocalhost/mydestination=localhost.,localhost/g' /etc/postfix/main.cf
echo "user-patches.sh successfully executed with custom main.cf hotfix"
