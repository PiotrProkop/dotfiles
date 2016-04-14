#!/usr/bin/env python2

# Copyright 2014 Mike Sampson

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import gtk
import subprocess

class StatusIcon:
    def __init__(self):
        self.blanking_allowed = False

        self.statusicon = gtk.StatusIcon()
        self.statusicon.set_from_stock(gtk.STOCK_MEDIA_STOP)
        self.statusicon.connect("activate", self.left_click_event)
        self.statusicon.connect("popup-menu", self.right_click_event)
        self.statusicon.set_tooltip("Blanking Utility")

    def toggle_blanking(self):
        if self.blanking_allowed:
            self.statusicon.set_from_stock(gtk.STOCK_MEDIA_STOP)
            subprocess.call('xset s on; xset +dpms', shell = True)
        else:
            self.statusicon.set_from_stock(gtk.STOCK_MEDIA_PLAY)
            subprocess.call('xset s off; xset -dpms', shell = True)

        self.blanking_allowed = not self.blanking_allowed

    def left_click_event(self, icon):
        self.toggle_blanking()

    def right_click_event(self, icon, button, time):
        menu = gtk.Menu()

        about = gtk.MenuItem("About")
        quit = gtk.MenuItem("Quit")

        about.connect("activate", self.show_about_dialog)
        quit.connect("activate", gtk.main_quit)

        menu.append(about)
        menu.append(quit)
        menu.show_all()

        menu.popup(None, None, gtk.status_icon_position_menu, button, time, self.statusicon)

    def show_about_dialog(self, widget):
        about_dialog = gtk.AboutDialog()

        about_dialog.set_destroy_with_parent(True)
        about_dialog.set_name("Blanking Utility")
        about_dialog.set_version("1.0")
        about_dialog.set_authors(["Mike Sampson"])

        about_dialog.run()
        about_dialog.destroy()

StatusIcon()
gtk.main()
