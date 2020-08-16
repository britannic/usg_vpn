# **Ubiquiti USG Pro Fail Over or Load Balance VPN Recovery Workaround**

Often after multiple WAN fail overs, our client site to site VPNs will often reconnect with one way traffic only, causing loss of service over the link.

Usually we just manually restart the USGs at either end of the VPN, but during working hours this is disruptive. Also, the fail-over detection settings were too sensitive for our use case, so the config.gateway.json file contains our preferred parameters.

We created wan-event-vpn-reset.sh reusing /config/scripts/wan-event-report.sh and adding the commands required to get the site to site VPN working again. The script is called whenever a fail over event occurs. /config is preserved when upgrading EdgeOS and the config.gateway.json ensures the configuration is provisioned after reboots etc.

Be sure to set the execute bit when you install wan-event-vpn-reset.sh:

```bash
chmod +x /config/scripts/wan-event-vpn-reset.sh
```

For information on how to use a config.gateway.json file, browse to Ubiquiti's help article [here](https://help.ui.com/hc/en-us/articles/215458888-UniFi-How-to-further-customize-USG-configuration-with-config-gateway-json).

After you install the config.gateway.json to your UniFi controller's site directory, be sure to change ownership, so that your backups continue working:

```bash
chown unifi:unifi /usr/lib/unifi/data/sites/<your site directory here>/config.gateway.json
```
