# Notifiarr Forest

This is where you'll find the scripts and github action that create the forest package(s) for Notifiarr.

There's nothing very useful in this repo for the public. 
The forest is simply a web of proxies running [Mulery](https://github.com/golift/mulery).

## System Package

GitHub Actions runs the [build.sh](build.sh) script which turns the [root/](root/) folder into a deb package and uploads it to package cloud.

- The package installs a few dependencies such as `docker-compose`.
- Also installed is a user named `abc` with an [authorized_keys ssh](root/home/abc/.ssh/authorized_keys)
    file and a [sudoers](root/etc/sudoers.d/workers) entry that allows the website to restart things.
- Telegraf is also [partially configured](root/etc/telegraf/telegraf.d/notifiarr.conf) during package installation.
  You need to install an output plugin.

## Use

Then run the included install script. Like this:
```bash
curl -sL https://raw.githubusercontent.com/Notifiarr/forest/main/install.sh | sudo bash
```

In addition to installing the [notifiarr-forest](https://packagecloud.io/app/golift/nonpublic/search?q=notifiarr-forest)
package, the [install.sh](install.sh) script installs and configures:

- [Notifiarr Client](https://github.com/Notifiarr/notifiarr)


# License

- This software is Copyright 2024 Notifiarr, LLC.
- Read the [license](LICENSE) if you intend to make copies.