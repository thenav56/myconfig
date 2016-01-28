#!/usr/bin/env python3

import sys
import os
import subprocess
import time

def execute(command):
    command = command.strip().split()
    output, error =subprocess.Popen(command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
            ).communicate()
    return output.decode('utf-8').strip(), error.decode('utf-8').strip()

def load(filename):
    b = None
    try:
        with open(filename, 'r') as f:
            b = f.readline()
    except FileNotFoundError:
        with open(filename, 'w') as f:
            f.write('0')
        b = 0
    return b

def download():
    path = "/home/paradox/.config/i3blocks/rx"
    rx1 = load(path)
    rx2, err = execute("cat /sys/class/net/wlan0/statistics/rx_bytes")
    with open(path, 'w') as f:
        f.write(rx2)
    recv = ( float(rx2) - float(rx1)) / 1024
    return recv

def main():
    print( "{0:.2f}".format(download()), "KB/s")



if __name__=="__main__":
    main()

