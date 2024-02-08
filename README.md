# SetLEDs Karabiner for Mac OS X

This is for those who use Karabiner and want the _NumLk_ key on their keypad to not only remap the keys
(which Karabiner can do) but also set the NumLk led correctly on the keyboard (which, as of this writing, Karbiner can't do).
# Overview
To get this to work there is a script called setleds_karabiner.sh that can be run from Karabiner (or the command line for that matter).
This script works be first selecting a profile in Karabiner that does not include any keyboards - you must define this yourself.
Then it uses setleds to set the numlock led to the desired state. Then it sets the Karbiner profile back to whatever was
active when you ran the shell script.

The script is fairly bullet-proof, e.g
* It should work even if there are spaces in things like path names
* If you run it with the wrong number of arguments it prints out a usage message
* It checks that the 'no keyboard' profile you want it to use actually exists before it does anything
* It will keep trying the _setleds_ command until it either works or 2s have passed (there is a delay between
when Karabiner returns from the set profile command and when it actually takes itself out of the way).
# Installation
Download the zip from the releases. It contains:
* setleds binary
* setleds_karabiner.sh
* enable_numlock_toggle.json
* numpad_keys.json

In no particular order:

* Create a bin folder directly under your home directory and put both the _setleds_ binary and _setleds_karabiner.sh_ in it. If you don't do this you will have to edit enable_numlock_toggle.json and if setelds and setleds_karabiner.sh are in different directories, you will have to edit the shell script too.
* Create a profile in Karabiner that does not contain any devices. Call it _No keyboard_. If you call it something else, you will have to edit enable_numlock_toggle.json.
* Load enable_numlock_toggle.json as a complex rule in Karabiner. If you have already loaded 'Enable Num Lock Toggle', replace it with enable_numlock_toggle.json.
* Optionally load numpad_keys.json as a complex rule. If you already have 'Numpad keys' installed, you can just use that. I only provide it so this zip is a one-stop-shop.
* Read the Notes section below before you go hammering the numlock key - it will help avoid any issues.

## Notes
* If you haven't run setleds before, you will need to get the Mac to allow it. The easiest way is to run it from the finder by selecting 'Open' on the context menu. You should be given the option of adding it to the safe list.
* The first time you hit the numlock key, assuming everything works, you should see a popup telling you you need to add _karabiner_console_user_server_ to the list of 'allowed applications' in the 'Input Monitoring' part of System Settings. It won't work if you don't do this. You can also just got to Input Monitoring and add it yourself.

# Troubleshooting
If it doesn't work, look in the _logs_ section of Karabiner