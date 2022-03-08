#!/bin/bash

# Let's watch our thief's face n.n


ts=$(date +"%m_%d_%Y_%H_%M_%S")

ffmpeg -f video4linux2 -s vga -i /dev/video0 -vframes 3 -update /home/estrox1/.login-fails/login-$ts.jpg

exit 0  
