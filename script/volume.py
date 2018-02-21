#!/usr/bin/env python3

import subprocess
import sys


MAX = 100
MIN = 0
NOTIFY_ID_FILE = '/tmp/volume-notify'
NOFITY = 'dunstify -p {id} -u low -a volume -i '\
         'audio-volume-high Volume \'{action} {volume}\' > {file}'
GET_VOLUME = 'amixer -D pulse get Master | grep -o "\[.*%\]" |'\
             ' grep -o "[0-9]*" | head -n1'
IS_MUTED = 'amixer -D pulse get Master | grep -o "\[on\]" | head -n1'


def get_notify_id():
    try:
        with open(NOTIFY_ID_FILE, 'r+') as file:
            return file.read()
    except:
        return None


def purify_number(string):
    if string:
        return string.replace('\n', '')
    return ''


def send_notification(action, show_volume=True):
    n_id = purify_number(get_notify_id())
    r_id = '-r '+n_id
    if not n_id:
        r_id = ''
    volume = purify_number(get_volume()) if show_volume else ''
    notify_cmd = NOFITY.format(
        file=NOTIFY_ID_FILE, volume=volume,
        action=action,
        id=r_id)
    subprocess.run(notify_cmd, shell=True)


def get_active_sink():
    return 'pacmd list-sinks | grep "* index" | awk \'{print $3}\''


def get_volume():
    process = subprocess.Popen(GET_VOLUME, stdout=subprocess.PIPE, shell=True)
    volume = process.communicate()[0].decode('ascii')
    return volume


def set_volume(percentage, action=''):
    if percentage >= MIN and percentage <= MAX:
        subprocess.run('pactl set-sink-volume $(' + get_active_sink() + ') ' +
                       str(percentage) + '%', shell=True)
        emit_signal()
        send_notification(action)


def toggle_volume():
    subprocess.run('amixer -D pulse set Master Playback Switch toggle',
                   shell=True)
    emit_signal()
    if is_muted():
        send_notification('Mute', show_volume=False)
    else:
        send_notification('Unmute', show_volume=False)


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
        set_volume(new_volume, 'Up')
    elif command == 'down':
        new_volume = trim_to_range(int(get_volume()) - int(sys.argv[2]))
        set_volume(new_volume, 'Down')
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
