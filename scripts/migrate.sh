#!/bin/bash

cp -rfv ./configurations/home/. $HOME

mkdir -p /etc/keyd
cp -rv ./configurations/default.conf /etc/keyd

echo "OK"
