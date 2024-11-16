#!/usr/bin/env sh

. "${HOME}"/.profile

mkReloadService.sh
mkWallpaperSerice.sh

systemctl status --user refreshWallpaper.timer
systemctl status --user setWallpaper.service
systemctl status --user sunset.service
systemctl status --user sunsetReload.timer

