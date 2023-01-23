# Canvas-Emailer
Most Canvas courses disable students from selecting the whole class to email at once. This script gets around that by simulating the keystrokes to add each individual student.

Downloads are available under [releases](https://github.com/krez-sch/Canvas-Emailer/releases)

## Supported Operating Systems
+ Windows
+ Linux (other Unix-based systems such as Mac should work, but only Linux was tested)

## Windows Instructions
+ (Optional) Install AutoHotkey and download **CanvasEmailer.Windows.zip**. Extract the full zip.
+ If not installing AutoHotkey, download **CanvasEmailer.exe**
+ Run the .ahk or .exe and follow the directions.
+ You can press Escape to cancel the automated keystrokes at any time.

## Linux/Unix Instructions
+ [Install xdotool](https://github.com/jordansissel/xdotool#installation) (required for sending the keystrokes)
+ Download **CanvasEmailer.Linux_Unix.tar.gz** and extract the archive.
+ If you don't know how many students are in your class, check the People tab from the Canvas page.
+ Open the [Canvas Inbox](https://csulb.instructure.com/conversations)
+ Create a new message and select the course you'll be emailing.
+ Run **CanvasEmailer.sh** (If it doesn't start you may need to run **chmod a+x CanvasEmailer.sh**)
+ Move your mouse to the contacts icon next to the To field (this version does not use image detection)
+ After 3 seconds it will print the coordinates
+ Edit the script in any text editor
+ Modify the class size for your class
+ (Optional) Modify click_X and click_Y to the coordinates printed earlier. This will save you needing to move the mouse each time.
+ Comment or delete the **xdotool mousemove** and **exit** lines before the for-loop when you've made the above changes.
+ Run the script again and the students should be added one at a time.
+ To cancel the script, switch to the terminal and press Ctrl-C. (Cmd-C for Mac)

## Disclaimer & Final Notes
+ **This script has no warranty.** You are using this with your own Canvas account, and are solely responsible for any actions or unintended behavior caused by the script. By running this script in any form, you agree to this condition.
+ This script's sole purpose is to add students to an email you are voluntarily creating. You need to format the email and send it yourself.
+ Occasionally some students may not be added properly. (Including but not limited to browser freezing, slow computer, poor network connection, etc.) It is your responsibility to ensure the correct people are added.
