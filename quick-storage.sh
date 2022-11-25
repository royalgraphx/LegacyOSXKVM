#!/bin/bash

echo Enter Macintosh HDD image name
read varcommit
qemu-img create -f raw harddrives/"$varcommit".img 128G
