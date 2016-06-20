#!/usr/bin/env python3
import subprocess
import sys
from subprocess import call

def execute(input):
    command = subprocess.call(input, shell=True)
    dupa = str(command).split('\n')[0]
    return dupa
def get_active_sink():
  return execute('pacmd list-sinks | grep "* index" | awk \'{print $3}\'')

def get_volume():
    return execute('amixer -D pulse get Master | grep -o "\[.*%\]" | grep -o "[0-9]*" | head -n1')

def set_volume(percentage):
  execute('pactl set-sink-volume ' + get_active_sink() + ' ' + str(percentage) + '%')
  emit_signal()

def toggle_volume():
  execute('amixer -D pulse set Master Playback Switch toggle')
  emit_signal()

def is_muted():
  return not execute('amixer -D pulse get Master | grep -o "\[on\]" | head -n1')

def write(message):
    print(message)
def trim_to_range(volume):
  volume = int(volume)
  if volume < 0:
    volume = 0
  elif volume > 200:
    volume = 200
  return volume

def status():
  if int(get_volume()) == 0 or is_muted():
    return 'muted'
  else:
    return 'on'

def emit_signal():
  execute('pkill -RTMIN+1 i3blocks')

if __name__ == '__main__':
  command = sys.argv[1]

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
    output = get_volume()
    write(str(output))
  elif command == 'signal':
    emit_signal()
  else:
    write('Usage: ' + sys.argv[0] + ' [set|up|down|toggle|read|status] [value]\n')
