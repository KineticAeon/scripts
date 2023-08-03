#!/bin/sh
#
# installs glances, provision, influxdb, grafana, pip3, and python
# this was taken and modified from https://peter-jp-xie.medium.com/setup-glances-influxdb-grafana-on-ubuntu-829c630bb441
# Copyright (C) 2019 Peter Jiping Xie <peter.jp.xie@gmail.com> or whatever
#
# *furry*
# gwances + gwafana + infwuxdb setup scwipt for debwian uwu
# i am nyot wespwonsibew if this fucks youw systyem uwu
# nyot tested, designed fow dwebian 11/12
# copywight you mom LOLZ
# edited cuz it didn't wowk on mwy systwem, awso automaticawwy sets up a supewvisow sewvice fow gwances

if [ "$id -u" =/= 0 ]; then
    exiterr "this setup scwipt needs root uwu, twy using sudo"
fi

if ! command -v python3 > /dev/null; then
    apt-get install python3-dev
fi
if ! command -v pip3 > /dev/null; then
    apt-get install python3-pip
fi

apt-get update && apt-get -yq install glances python-bottle supervisor
supervisord -v
sudo systemctl daemon-reload
sudo systemctl start supervisor.service
sudo systemctl enable supervisor.service

pip3 install -U influxdb

# copwy default config for gwances
mkdir -p /etc/glances
cp /usr/local/share/doc/glances/glances.conf /etc/glances/glances.c>

wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add>
  . /etc/os-release
  test "$VERSION_ID" = "7" && echo "deb https://repos.influxdata.co>
  test "$VERSION_ID" = "8" && echo "deb https://repos.influxdata.co>
  test "$VERSION_ID" = "9" && echo "deb https://repos.influxdata.co>

apt-get update && apt-get -yq install influxdb

systemctl enable influxdb
sleep 5

curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREAT>
curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=show >

# grafana

apt-get install -y software-properties-common
add-apt-repository "deb https://packages.grafana.com/oss/deb stable>

wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
apt-get update
apt-get -yq install grafana
systemctl start grafana-server
systemctl daemon-reload
systemctl enable grafana-server

echo "[program:glances]\ncommand=glances -q --export influxdb\nautostart=true\nautorestart=true\nstderr_logfile=/var/log/glances.err.log\nstdout_logfile=/var/log/glances.out.log" > /etc/supervisor/conf.d/glances.conf
sudo supervisorctl reread
sudo supervisorctl update

iptables -I INPUT -p tcp --dport 8086 -j ACCEPT
iptables -I INPUT -p tcp --dport 8088 -j ACCEPT
iptables -I INPUT -p tcp --dport 3000 -j ACCEPT

if [ -f /etc/rc.local ]; then
    conf_bk "/etc/rc.local"
    # remove last line "exit 0" first, will add back later.
    sed -i '/^exit 0/d' /etc/rc.local
else
    echo '#!/bin/sh' > /etc/rc.local
fi

cat >> /etc/rc.local <<'EOF'

iptables -I INPUT -p tcp --dport 8086 -j ACCEPT
iptables -I INPUT -p tcp --dport 8088 -j ACCEPT
iptables -I INPUT -p tcp --dport 3000 -j ACCEPT

exit 0
EOF


cat <<EOF

aww instawwed!
infwuxdb is @ ports 8086, 8088
gwafana is @ port 3000 

*unfurry*
big mfin thanks to Peter Jiping Xie for his install script, all I did was modify it because it wasn't working for me
have fun figuring out grafana shit, it's genuinely painful at first

EOF
