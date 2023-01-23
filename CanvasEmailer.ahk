#SingleInstance, Force ; Run only a single instance at a time.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Include the images in the binary for portability
img1 := "contactsearch1.png"
img2 := "contactsearch2.png"
FileInstall, contactsearch1.png, %A_Temp%\%img1%, 1
FileInstall, contactsearch2.png, %A_Temp%\%img2%, 1

; Check the images extracted properly before continuing
if (FileExist(A_Temp . "\" . img1))
{
	img1 := A_Temp . "\" . img1
}

if (FileExist(A_Temp . "\" . img2))
{
	img2 := A_Temp . "\" . img2
}

if (!FileExist(img1) || !FileExist(img2))
{
	Msgbox, 4096, Image error,
(
"contactsearch1.png" and "contactsearch2.png" did not extract properly.
Please download them manually and try again.
)
	ExitApp
}

Hotkey, *$Esc, stop
Hotkey, *$Esc, Off

; Use the full desktop for image searching and clicking
SysGet, VirtualWidth, 78
SysGet, VirtualHeight, 79
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

Gui, Main:Font, s11
Gui, Main:Add, Text, x10 y10, This script adds all students in Canvas to 1 email.
Gui, Main:Add, Text, yp+27, Students in class:
Gui, Main:Add, Edit, xp+175 yp-3 w139 vTotalStudents, %1%
Gui, Main:Add, Button, x10 yp+33 w100 gLoad, Instructions
Gui, Main:Add, Button, xp+107 w100 gReset, Reset
Gui, Main:Add, Button, xp+107 w100 gStart, Start
Gui, Main:Add, Text, x10 yp+33 w165 vProgressText, Not started.
Gui, Main:Add, Progress, xp+175 w139 cBlue vProgressBar Range0-1, 1

Gui, Main:+AlwaysOnTop
Gui, Main:Show, AutoSize, Canvas Emailer
return

load:
	Gui, Instructions:Font, s11
	Gui, Instructions:Add, Picture, x10 y10, %img1%
	Gui, Instructions:Add, Picture, xp+25, %img2%
	Gui, Instructions:Add, Text, xp+25, << Contacts Icons
	Gui, Instructions:Add, Link, x10 yp+25,
(
First, open <a href="https://csulb.instructure.com/">Canvas</a> and select your class.
Open the People tab, and check the number of students in the class.
You can click "All Roles" to easily find it.
You'll need this to add the correct number of students.
Open the <a href="https://csulb.instructure.com/conversations">Canvas Inbox</a> to create the email.
Select your course under Favorite Courses.
With the course selected, click "Add Students" in this script to add them to the email.
The script will search for the Contacts icon and simulate the keypresses to add all student emails.
This will only add student emails, but you can check the list if the keypresses went out of sync.
If the list is good, then format the email as desired and send it.
)
	Gui, Instructions:Add, Button, gUnload w200, OK
	
	Gui, Main:Hide
	Gui, Instructions:+AlwaysOnTop -SysMenu
	Gui, Instructions:Show, AutoSize Center, Instructions
return

unload:
	Gui, Instructions:Destroy
	Gui, Main:Show
return

start:
	Gui, Submit, Nohide
	
	if TotalStudents is not integer
	{
		Msgbox, 4096, Invalid student total, Number of students must be greater than 0.
		return
	} 
	
	if (TotalStudents < 1)
	{
		Msgbox, 4096, Invalid student total, Number of students must be greater than 0.
		return
	}
	
	imgX := imgY := ""
	
	if (!searchImg(img1, imgX, imgY)) {
		if (!searchImg(img2, imgX, imgY)) {
			MsgBox, 4096, No image found,
(
Could not find contacts icon. Is the page open?
Move any windows that may be blocking it.
Check the instructions to see what the icon looks like.
)
			return
		}
	}
	
	Hotkey, *$Esc, On
	GuiControl,, ProgressText, Adding students.
	GuiControl, +cGreen +Range0-%TotalStudents%, ProgressBar, 0
	
	; Close any menus on the page to reset menu navigation
	sleep 300
	Click, %imgX% %imgY%
	sleep 300
	Send {Escape}
	
	Loop %TotalStudents%
	{
		; Open Contacts menu
		sleep 500
		Click, %imgX% %imgY%
		
		; Select Course Sections
		sleep 500
		Loop 3
		{
			Send {Down}
			sleep 25
		}
		Send {Return}
		
		; Select the 1st section
		sleep 500
		Loop 2
		{
			Send {Down}
			sleep 25
		}
		Send {Return}
		
		; Select Students
		sleep 500
		Loop 3
		{
			Send {Down}
			sleep 25
		}
		Send {Return}
		
		; Reset the arrow keys
		sleep 500
		Send {Down}
		sleep 30
		Loop 2
		{
			Send {Up}
			sleep 30
		}
		
		; Select the n-th student
		Loop %A_Index%
		{
			Send {Down}
			sleep 25
		}
		Send {Return}
		
		; Update the progress bar
		GuiControl,, ProgressText, Added %A_Index%/%TotalStudents% students.
		GuiControl,, ProgressBar, +1
	}
	
	GuiControl, +cBlue, ProgressBar
	Hotkey, *$Esc, Off
return

; Pressing Escape during the student adding resets the script, but will save the old student count
stop:
	Run, %A_ScriptFullPath% %TotalStudents%
return

reset:
	reload
return

/*
Return true if coordinates are found
Return false if coordinates are blank
*/
searchImg(image, ByRef imgX, ByRef imgY)
{
	global VirtualWidth, VirtualHeight
	ImageSearch, imgX, imgY, 0, 0, %VirtualWidth%, %VirtualHeight%, %image%
	return (imgX != "")
}

GuiClose:
MainGuiClose:
	ExitApp