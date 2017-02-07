#!/usr/bin/env bash

KRBCONF_NAME="edu.mit.Kerberos"
rm -f "/Library/Preferences/$KRBCONF_NAME"
sudo ln -s "/etc/krb5.conf" "$KRBCONF_NAME"
