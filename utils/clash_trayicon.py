#!/usr/bin/python

# ./clash_trayicon.py "google-chrome-stable 127.0.0.1:9090/ui" "/home/ring/.config/clash/yacd/yacd.ico"


import os
import subprocess
import sys
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3


def gen_tray_icon():
    icon_path = sys.argv[2]
    indicator = AppIndicator3.Indicator.new("Clash Tray Icon", icon_path, AppIndicator3.IndicatorCategory.APPLICATION_STATUS)
    indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
    indicator.set_menu(menu())
    Gtk.main()


def menu():
    menu = Gtk.Menu()

    command_one = Gtk.MenuItem()
    command_one.set_label('Dashboard')
    command_one.connect('activate', open_dashboard)
    menu.append(command_one)

    exittray = Gtk.MenuItem()
    exittray.set_label('Exit')
    exittray.connect('activate', quit)
    menu.append(exittray)
    
    menu.show_all()
    return menu
  

def open_dashboard(_):
    os.popen(sys.argv[1])


def quit(_):
    Gtk.main_quit()


def main():
    proc = subprocess.Popen(['clash'], shell=True)
    gen_tray_icon()
    proc.terminate()

    # time.sleep(3) # <-- There's no time.wait, but time.sleep.
    # pid = proc.pid

    # pid = os.fork()
    # if  pid==0:
    #     print('I am child process (%s) and my parent is %s.' % (os.getpid(), os.getppid()))
    #     os.system("clash")
    # else:
    #     print('I (%s) just created a child process (%s).' % (os.getpid(), pid))
    #     gen_tray_icon()
    #     # os.system("kill -9 " + str(pid))


if __name__ == "__main__":
    if(len(sys.argv) < 3):
        print("invalide argument!")
        print("cmd <dashboard event> <icon path>")
        exit(1)
    main()

