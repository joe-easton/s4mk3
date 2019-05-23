import QtQuick 2.5

QtObject {
	//change to true to enable camelot key
	readonly property bool camelotKey:	false
	
	//0 = RGB, 1 = Default, 2 = Red, 3 = Dark Orange, 4 = Light Orange, 5 = Warm Yellow, 6 = Yellow, 7 = Lime, 8 = Green, 9 = Mint, 10 = Cyan, 11 = Turquoise, 12 = Blue, 13 = Plum, 14 = Violet, 15 = Purple, 16 = Magenta, 17 = Fuchsia
	readonly property int waveformColour:	0
	
	//change to true to show elapsed time instead of remaining time
	readonly property bool elapsedTime:	false
	
	//change to false to show the master bpm instead of the bpm difference when holding shift
	readonly property bool bpmDifference:	true
	
	//change to false to disable the waveform flashing when track end warning is enabled
	readonly property bool waveformEndFlashing: true
	
	//change to true to change the flashing to red and green when in an active loop
	readonly property bool loopActiveRedFlash: false
}