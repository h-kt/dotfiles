#!/usr/bin/env sh

. ${HOME}/.profile

mkReloadService.sh
mkWallpaperSerice.sh

echo STARTED > /tmp/STARTED
