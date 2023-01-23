#!/bin/bash

# Short pause to move any windows as needed.
echo "Move your cursor to the contact icon."
echo "Will begin in 3 seconds..."
sleep 3

# Add students 1-35, adjust for the class size
class_size=35
index_array=$(seq 1 ${class_size})

# Save the current mouse coordinates to click
eval $(xdotool getmouselocation --shell)
click_X=$X
click_Y=$Y

# Override the old coordinates and use these instead
#click_X=1260
#click_Y=860

echo "Mouse coords set to X:${click_X}, Y:${click_Y}"

# Test coordinates before proceeding (comment them out to continue the script)
xdotool mousemove ${click_X} ${click_Y} click 1
exit

for i in ${index_array[@]}; do
    echo "Adding Student #${i}"

    # Open Contacts
    sleep 0.4
    xdotool mousemove ${click_X} ${click_Y} click 1

    # Select Sections
    sleep 0.4
    xdotool key --repeat 3 --repeat-delay 30 Down
    sleep 0.1
    xdotool key Return

    # Select 1st section
    sleep 0.4
    xdotool key --repeat 3 --repeat-delay 30 Down
    sleep 0.1
    xdotool key Return

    # Select Students
    sleep 0.4
    xdotool key --repeat 3 --repeat-delay 30 Down
    sleep 0.1
    xdotool key Return

    # Reset Arrow Keys
    sleep 0.5
    xdotool key --repeat 1 --repeat-delay 30 Down
    xdotool key --repeat 2 --repeat-delay 30 Up

    # Select student at i-index
    sleep 0.05
    xdotool key --repeat $i --repeat-delay 35 Down
    sleep 0.1
    xdotool key Return
done
