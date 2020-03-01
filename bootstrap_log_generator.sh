#!/bin/bash



pushd  /etc
git clone https://github.com/vbichov/log_generator.git


mkdir -p /usr/lib/systemd/system/

cat << EOF > /usr/lib/systemd/system/log_generator.service
[Unit]
Description=Python log generator service

[Service]
# Command to execute when the service is started
ExecStart=/usr/bin/python3 generator.py
Restart=on-failure
WorkingDirectory= /etc/log_generator
EOF

systemctl daemon-reload
systemctl start log_generator.service