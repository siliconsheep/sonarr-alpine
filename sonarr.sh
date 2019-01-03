#!/bin/sh

echo "Starting Sonarr..."
exec su -pc  "mono /opt/NzbDrone/NzbDrone.exe --no-browser -data=/config" sonarr