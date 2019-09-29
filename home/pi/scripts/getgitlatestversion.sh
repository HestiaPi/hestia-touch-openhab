#!/bin/bash

curl --silent "https://api.github.com/repos/hestiapi/hestia-touch-openhab/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
exit 0;
