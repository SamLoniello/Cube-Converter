
; Coordinates based on 1920x1080 monitor resolution, if any other, XY positions will need to be changed, you can use MousePos (google it)
; Upgrading runs left to right starting from the upper left inventory slot, then jumps to the next row
; F1 starts, F3 resets (cancels) the script if running, F5 exits. Change as needed. 

F1::startUpgrade()
F3::reloadScript()
F5::abortScript()

startUpgrade() {
	; Small delay between clicks to account for ping
	; Delay is random between 100-120 ms, change as needed
	sleep1 := 100
	sleep2 := 120
	; Inventory start 1428,583
	invStartX := 1428
	invStartY := 583
	; Current inventory position, starts as the start position, updates as items are upgraded
	invX := 1428
	invY := 583
	; Next Space right 50
	nextItemX := 50
	; Next Space down 100
	nextItemY := 100
	; Fill button 720,840
	fillX := 720
	fillY := 840
	; Transmute/Accept button 245,830
	transmuteX := 245
	transmuteY := 830
	; Items to run, set by input box
	itemCount := 0
	; Current item number
	currentItem := 0
	; Cube left recipe button 580,840
	leftX := 580
	leftY := 840
	; Cube right recipe button 850,840
	rightX := 850
	rightY := 840
	MsgBox, 4, Item Size, Are items 2 slots or 1 slot (rings/ammys)? (click Yes for 2 or No for 1)
	IfMsgBox No
		nextItemY := 50
	InputBox itemCount, Item Count, Enter # of items to upgrade., , , , , , , , 10
	If (itemCount > 0)
	{
		Loop, %itemCount%
		{
			++currentItem
			; Move to new row
			If (currentItem = 11 OR currentItem = 21 OR currentItem = 31 OR currentItem = 41 OR currentItem = 51)
			{
				invX := invStartX
				invY += nextItemY
			}
			clickTarget(invX,invY, 1, "Right")
			randomSleepTime(sleep1, sleep2)
			clickTarget(fillX, fillY)
			randomSleepTime(sleep1, sleep2)
			clickTarget(transmuteX, transmuteY)
			randomSleepTime(sleep1, sleep2)
			clickTarget(leftX, leftY)
			randomSleepTime(sleep1, sleep2)
			clickTarget(rightX, rightY)
			randomSleepTime(sleep1, sleep2)
			invX += nextItemX
		}
	}
}

randomSleepTime(minTime, maxTime){
	Random, rand, %minTime%, %maxTime%
	Sleep %minTime%
}

clickTarget(x, y, count = 1, button = "Left", modifier = ""){

	;Add random number to XY coordinates
	Random, rand, -3, 3
	iX := x + rand
	Random, rand, -3, 3
	iY := y + rand
	;Set delay in ms, 0 is small delay, -1 is no delay
	SetMouseDelay, 0
	;Perform clicks
	If (modifier = "Shift")
	{
		Send +{Click %button%, %iX%, %iY%, %count%}
	} 
	Else
	{
		If (modifier = "Ctrl")
		{
			Send ^{Click %button%, %iX%, %iY%, %count%}
		}
		Else
		{
			Send {Click %button%, %iX%, %iY%, %count%}
		}
	}
	Random, rTime, 75, 100
	Sleep %rTime%
}

abortScript(){
	MsgBox 0, Abort, Exiting script!, 2
	ExitApp
}

reloadScript(){
	MsgBox 0, Reload, Manual reload!, 2
	Reload
}