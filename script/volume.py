#!/usr/bin/env python3

import subprocess
import sys


MAX = 100
MIN = 0
GET_VOLUME = 'amixer -D pulse get Master | grep -o "\[.*%\]" |'\
             ' grep -o "[0-9]*" | head -n1'
IS_MUTED = 'amixer -D pulse get Master | grep -o "\[on\]" | head -n1'


def get_active_sink():
    return 'pacmd list-sinks | grep "* index" | awk \'{print $3}\''


def get_volume():
    process = subprocess.Popen(GET_VOLUME, stdout=subprocess.PIPE, shell=True)
    volume = process.communicate()[0].decode('ascii')
    return volume


def set_volume(percentage):
    if percentage >= MIN and percentage <= MAX:
        subprocess.run('pactl set-sink-volume $(' + get_active_sink() + ') ' +
                       str(percentage) + '%', shell=True)
        emit_signal()


def toggle_volume():
    subprocess.run('amixer -D pulse set Master Playback Switch toggle',
                   shell=True)
    emit_signal()


def is_muted():
    process = subprocess.Popen(IS_MUTED, stdout=subprocess.PIPE,
                               shell=True)
    mute = process.communicate()[0].decode('ascii')
    try:
        mute.index('[on]')
        return False
    except:
        return True


def write(message):
    sys.stdout.write(message)
    sys.stdout.flush()


def trim_to_range(volume):
    volume = int(volume)
    if volume < MIN:
        volume = MIN
    elif volume > MAX:
        volume = MAX
    return volume


def status():
    if int(get_volume()) == 0 or is_muted():
        return 'muted'
    else:
        return 'on'


def emit_signal():
    subprocess.run('pkill -RTMIN+1 i3blocks', shell=True)


if __name__ == '__main__':
    command = sys.argv[1] if len(sys.argv) > 1 else ''

    output = get_volume() + ' '
    if command == 'set':
        set_volume(trim_to_range(sys.argv[2]))
    elif command == 'up':
        new_volume = trim_to_range(int(get_volume()) + int(sys.argv[2]))
        set_volume(new_volume)
    elif command == 'down':
        new_volume = trim_to_range(int(get_volume()) - int(sys.argv[2]))
        set_volume(new_volume)
    elif command == 'toggle':
        toggle_volume()
    elif command == 'read':
        write(get_volume())
    elif command == 'status':
        write(status())
    elif command == 'i3blocks':
        output = get_volume() + ' '
    if is_muted():
        # output += '\n\n#000000'
        write(output)
    elif command == 'signal':
        emit_signal()
    elif command == 'help':
        write('Usage: ' + sys.argv[0] +
              ' [set|up|down|toggle|read|status] [value]\n')
