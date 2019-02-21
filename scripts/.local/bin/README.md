## Notes for using the HDMI script

Make a new service `/etc/systemd/system/hot_plug.service` (replace `USER` with your user):

```
[Unit]
Description=Monitor hotplug

[Service]
Type=simple
RemainAfterExit=no
User=USER
Environment="DISPLAY=:0"
ExecStart=toggle_hdmi

[Install]
WantedBy=multi-user.target
```

Make the rule in `/etc/udev/rules.d/98-monitor-hotplug.rules` (replace `USER` with your user):

`KERNEL=="card0", SUBSYSTEM=="drm", ACTION=="change", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/USER/.Xauthority", RUN+="/bin/systemctl start hot_plug.service"`


