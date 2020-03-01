#!/bin/bash


mkdir -p /etc/log_generator
pushd  /etc/log_generator
git clone git@github.com:vbichov/log_generator.git


cat <<EOF >> /usr/lib/systemd/system/log_generator.service
[Unit]
Description=Python log generator service

[Service]
# Command to execute when the service is started
ExecStart=/usr/bin/python3 /etc/log_generator/gerator.py
EOF

systemctl daemon-reload
systmctl start log_generator.service