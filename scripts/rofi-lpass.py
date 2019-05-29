#!/bin/env python3

import json
import re
import os
import subprocess
import sys

# ----- Configuration -----
lpass_path = '/usr/bin/lpass'
lpass_user = 'example@email.com'
rofi_args  = ''
rofi_path  = '/usr/bin/rofi'
# -------------------------

# Helper function for processes
def _run_process(cmd, splitlines=False):
    '''
    Runs the specified command as a subprocess, returning the output of the
    command (optionally split by lines) and its exit code.
    '''
    process = subprocess.Popen(
        cmd,
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT,
        shell = True
    )
    output = process.communicate()[0].decode("ascii")
    exit_code = process.returncode
    if splitlines:
        return (output.splitlines(), exit_code)
    else:
        return (output, exit_code)

# Helper function for displaying a message via rofi
def rofi_message(msg):
    try:
        (msg_out, msg_ec) = _run_process(
            cmd = "{rofi} {args} -e '{msg}'".format(
                rofi = rofi_path,
                args = rofi_args,
                msg = msg
            )
        )
    except:
        pass

# Get the current login status
try:
    (stat_out, stat_ec) = _run_process(
        cmd = lpass_path + ' status --color=never'
    )
except Exception as e:
    rofi_message('Unable to get current LastPass login status - ' + str(e))
    sys.stdout.write('ERROR')
    sys.exit(1)

# Log in if needed
if stat_ec != 0:
    try:
        (login_out, login_ec) = _run_process(
            cmd = '{lpass} login --force --color=never {user}'.format(
                lpass = lpass_path,
                user = lpass_user
            )
        )
    except Exception as e:
        rofi_message('Unable to log-in to LastPass - ' + str(e))
        sys.stdout.write('ERROR')
        sys.exit(1)
    if login_ec != 0:
        if not login_out:
            rofi_message('Unable to log-in to LastPass - subprocess returned non-zero exit status')
        else:
            rofi_message('Unable to log-in to LastPass - ' + login_out.strip())
        sys.stdout.write('ERROR')
        sys.exit(1)

# Get the list of sites
try:
    (list_out, list_ec) = _run_process(
        cmd = lpass_path + " show -G '.*' -x -j"
    )
except Exception as e:
    rofi_message('Unable to get site list - ' + str(e))
    sys.stdout.write('ERROR')
    sys.exit(1)
if list_ec != 0:
    rofi_message('Unable to get site list - subprocess returned non-zero exit code')
    sys.stdout.write('ERROR')
    sys.exit(1)

# Parse the site list
try:
    sites = json.loads(list_out)
except Exception as e:
    rofi_message('Unable to parse site list - ' + str(e))
    sys.stdout.write('ERROR')
    sys.exit(1)

# Display the site list
choices_str = 'CANCEL|LOGOUT|' + '|'.join(sorted([s['fullname'].replace('\\', '/') for s in sites if not s['fullname'].endswith('/')]))
#sys.stdout.write('Displaying the site list...'+ choices_str)
try:
    #sys.stdout.write('Displaying the site list...')
    (rofi_out, rofi_ec) = _run_process(
        cmd = "echo '{choices}' | {rofi} -sep '|' -dmenu -i -no-custom -p 'password :' {args}".format(
            choices = choices_str,
            rofi = rofi_path,
            args = rofi_args
        ),
        splitlines = False
    )
    #sys.stdout.write('Displaying the parsed site list...' + rofi_out)
    #sys.stdout.write('Exit Code...' + rofi_ec)
except Exception as e:
    rofi_message('Unable to display sites - ' + str(e))
    sys.stdout.write('ERROR')
    sys.exit(1)

# Get the password, quit, or logout
rofi_out = rofi_out.strip()
if rofi_out == 'CANCEL':
    sys.stdout.write('CANCEL')
    sys.exit(0)
if rofi_out == 'LOGOUT':
    try:
        (rofi_out, rofi_ec) = _run_process(
            cmd = "{lpass} logout --force".format(
                lpass = lpass_path
            )
        )
    except Exception as e:
        rofi_message('Unable to log-out - ' + str(e))
        sys.stdout.write('ERROR')
        sys.exit(1)
    sys.stdout.write('LOGOUT')
    sys.exit(0)
for site in sites:
    if site['fullname'].replace('\\', '/') == rofi_out:
        sys.stdout.write(site['password'])
        sys.exit(0)
sys.exit(0)
