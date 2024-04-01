# mintPiper

Make Linux speak what's on the screen: clearly and securely. 

## Overview

mintPiper is for Linux desktop users who want a safe and trustworthy way to read the screen text in high quality, legible audio.

1. **High-Quality Audio:** Ensuring crisp and clear audio output.
2. **Privacy and Security:** Keeping user data within the local machine.

## Features

- **Quality Audio Output:** Enjoy clear and understandable audio playback.
- **Privacy-First:** Your data remains within your machine, ensuring privacy and security.
- **Fast and Local:** Utilizes a local neural text-to-speech system for efficient processing.

Now, with a simple keyboard shortcut (ctrl+alt+p) or by clicking the convenient icon on my panel, I can instantly generate and enjoy high-quality audio playback of any selected text on my screen. Thanks to piper's remarkable work and my mintPiper adaptation, I've found the perfect solution to enhance my Linux experience.

![image](https://github.com/evuraan/mintPiper/assets/39205936/ea611c7a-6cbf-40dd-a132-c0e2b553ea6c)


## Demo
Here's a [short demo video.](https://evuraan.info/evuraan/stuff/mintPiperDemo.mp4)

## Setup

Cone this repo:
<pre>
  $ git clone https://github.com/evuraan/mintPiper.git
  $ cd mintPiper
</pre>

Run setup.sh with the arguments of (1) a folder to create and write to, and (2) your h/w arch:
<pre>
  $ ./setup.sh /tools/piper amd64
</pre>
`setup.sh` will check for dependencies and when it completes, it would have something like this as its last lines of output:
<pre>
✅ ... Complete
🟢 For keyboard shortcut: xterm -e "/tools/piper/piper/playSelectedTTS.sh"
🟢 For panel startup application: /tools/piper/piper/mintPiper.py
</pre>
We need the last two lines, so make a note of those. 
### Add a keyboard shortcut
Launch `Keyboard Shortcuts` from your menu, and add a new shortcut. 

The command would be what was shown in your `🟢 For keyboard shortcut:` output. 

So, in my case, the command would be: `xterm -e "/tools/piper/piper/playSelectedTTS.sh"`. Map this shortcut to a keycombo of your choice. 

I preferred `ctrl alt p` as the shortcut. 

Once you save,  highlight some legible text and press your keyboard shortcut. It should play that back in high-quality, locally created audio. 


![image](https://github.com/evuraan/mintPiper/assets/39205936/c86a7a5e-b422-417d-9122-94ee60165c9b)


### Add a Desktop Launchers
Add a desktop launcher (the icon that would appear on the left side of your desktop window). 

Point this launcher to  `xterm -e "/tools/piper/piper/playSelectedTTS.sh"`. Use an image from the images folder as the icon thumbnail. 

![image](https://github.com/evuraan/mintPiper/assets/39205936/b0ab7046-2be1-4c35-bdb9-53c853831668)



### Add a panel icon 

Optionally, you can create a Desktop Icon too, which appears on the right side of the desktop screen:

Find and launch `Startup Applications Preferences` from your menu. Add a startup application. 

The command should be what was shown in your `🟢 For panel startup application:` output from above. 

In my example, the command then would be `/tools/piper/piper/mintPiper.py`:

![image](https://github.com/evuraan/mintPiper/assets/39205936/c205524f-5075-4d07-9f65-36e08baca46c)

When you login to the desktop next time, you should see the panel icon as in my screenshot above. Left click and select `Run Piper TTS`, and it should play clear audio of your selected text. 

## Uninstall:
1. Remove the startup application from your `Startup Applications Preferences`.
2. Remove the keyboard shortcut you added.
3. Remove the folder you installed `mintPiper` into. In my example, that would be `/tools/piper` directory. 

# Footnotes
1. Many thanks to piper team at https://github.com/rhasspy/piper.
2. This PoC may work for Cinnamon, xfce et al.

## Credits

mintPiper is inspired by the <a href="https://github.com/rhasspy/piper">piper</a> project. Special thanks to the developers for their fantastic work.

