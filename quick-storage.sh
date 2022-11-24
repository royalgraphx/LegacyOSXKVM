#!/bin/bash

echo Enter Macintosh HDD image name
read varcommit
qemu-img create -f qcow2 harddrives/"$varcommit".img 128G
