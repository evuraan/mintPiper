#!/usr/bin/python3 -u

# /* Copyright (C) 2022  Evuraan, <evuraan@gmail.com> */
import sys
import os
import pathlib
import subprocess
from datetime import datetime
import warnings
import gi
gi.require_versions({'Gtk': '3.0','XApp': '1.0'})
from gi.repository import Gtk, XApp
from gi.repository.GdkPixbuf import Pixbuf


warnings.filterwarnings("ignore")

NAME = "mintPiper"
DESC =  f"{NAME} Linux TTS"
VERSION = "1.3c"
WEBSITE = "https://github.com/evuraan/MintPiper"


wd = pathlib.Path(__file__).parent
pngPath = wd / "orange_piper.png"
ICON = str(pngPath.resolve())
execPath = wd / "playSelectedTTS.sh"
runThis = str(execPath.resolve())

class MintPiper:
    def __init__(self):
        self.state = False
        self.leftMenu()
        self.rightMenu()
        self.status_icon = XApp.StatusIcon()
        self.status_icon.set_icon_name(ICON)
        self.status_icon.props.icon_size = 16
        self.status_icon.set_primary_menu(self.left_menu)
        self.status_icon.set_secondary_menu(self.right_menu)
        self.status_icon.set_tooltip_text(DESC)
        self.state = True


    def leftMenu(self):
        self.left_menu = Gtk.Menu()
        about = Gtk.ImageMenuItem(label="🗣🔊 Run Piper TTS", image=Gtk.Image.new_from_icon_name("audio-speakers-symbolic", 16))
        about.connect("activate", self.runPiper)
        self.left_menu.append(about)
        self.left_menu.show_all()
        
    def quitter(self,x):
        try:
            Gtk.main_quit()
        except:
            pass
        os._exit(0)

    def runPiper(self,x):
        print(f"Running {runThis}")
        subprocess.getstatusoutput(f"xterm -T {NAME} -e {runThis}")
        

    def rightMenu(self):
        self.right_menu = Gtk.Menu()

        about = Gtk.ImageMenuItem(label="About", image=Gtk.Image.new_from_icon_name("help-about", 16))
        about.connect("activate", self.aboutDialog)
        self.right_menu.append(about)

        quit = Gtk.ImageMenuItem(label="Quit", image=Gtk.Image.new_from_icon_name("application-exit", 16))
        quit.connect("activate", self.quitter)
        self.right_menu.append(quit)
        

        self.right_menu.show_all()
        

    def aboutDialog(self, widget):
        about_dialog = Gtk.AboutDialog()

        about_dialog.set_destroy_with_parent(True)
        about_dialog.set_name(DESC)
        about_dialog.set_program_name(NAME)
        about_dialog.set_comments(DESC + "\n\nMany thanks to https://github.com/rhasspy/piper for Piper!")
        about_dialog.set_version(VERSION)
        about_dialog.set_copyright("Copyright © 2021 - {} evuraan".format(datetime.now().year))
        about_dialog.set_authors(["evuraan"])
        about_dialog.set_website(WEBSITE)
        about_dialog.set_website_label(WEBSITE)
        about_dialog.set_logo(PIXBUF)
 
        about_dialog.run()
        about_dialog.destroy()




if __name__ == "__main__":
    print(f"ICON: {ICON} exec: {runThis}")
    PIXBUF = Pixbuf.new_from_file(ICON)
    app = MintPiper()
    Gtk.main()
