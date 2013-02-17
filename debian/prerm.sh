#!/bin/bash

case "$1" in
    remove)
        find /usr/local/lib/python2.7/dist-packages/netifaces -name *.pyc -exec rm {} \;
    ;;
esac
