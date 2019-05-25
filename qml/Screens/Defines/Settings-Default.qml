import QtQuick 2.5

QtObject {

	//change to true to enable camelot key
	readonly property bool camelotKey:	false
	
	//0 = RGB, 1 = Default, 2 = Red, 3 = Dark Orange, 4 = Light Orange, 5 = Warm Yellow, 6 = Yellow, 7 = Lime, 8 = Green, 9 = Mint, 10 = Cyan, 11 = Turquoise, 12 = Blue, 13 = Plum, 14 = Violet, 15 = Purple, 16 = Magenta, 17 = Fuchsia
	readonly property int deckAWaveformColour:	0
	readonly property int deckBWaveformColour:	0
	readonly property int deckCWaveformColour:	0
	readonly property int deckDWaveformColour:	0
	
	property int deckId: 0
	
	//0 = Red, 1 = Dark Orange, 2 = Light Orange, 3 = White, 4 = Yellow, 5 = Lime, 6 = Green, 7 = Mint, 8 = Cyan, 9 = Turquoise, 10 = Blue, 11 = Plum, 12 = Violet, 13 = Purple, 14 = Magenta, 15 = Fuchsia
	readonly property int phaseAColour:	4
	readonly property int phaseBColour:	4
	readonly property int phaseCColour:	4
	readonly property int phaseDColour:	4
	
	
	//0 = Red, 1 = Dark Orange, 2 = Light Orange, 3 = White, 4 = Yellow, 5 = Lime, 6 = Green, 7 = Mint, 8 = Cyan, 9 = Turquoise, 10 = Blue, 11 = Plum, 12 = Violet, 13 = Purple, 14 = Magenta, 15 = Fuchsia
	readonly property int deckAColour:	10
	readonly property int deckBColour:	10
	readonly property int deckCColour:	2
	readonly property int deckDColour:	2
	
	//1 = Red, 2 = Dark Orange, 3 = Light Orange, 4 = White, 5 = Yellow, 6 = Lime, 7 = Green, 8 = Mint, 9 = Cyan, 10 = Turquoise, 11 = Blue, 12 = Plum, 13 = Violet, 14 = Purple, 15 = Magenta, 16 = Fuchsia
	readonly property int fx1Colour:	1
	readonly property int fx2Colour:	8
	readonly property int fx3Colour:	11
	readonly property int fx4Colour:	6
	readonly property int filterColour:	3
	

	
	//change to true to show elapsed time instead of remaining time
	readonly property bool elapsedTime:	false
	
	//change to false to show the master bpm instead of the bpm difference when holding shift
	readonly property bool bpmDifference:	true
	
	//change to false to disable the waveform flashing when track end warning is enabled
	readonly property bool waveformEndFlashing: true
	
	//change to true to change the flashing to red and green when in an active loop
	readonly property bool loopActiveRedFlash: false
	
	//change to false to disable tempo faders when holding shift
	readonly property bool shiftTempoFaderEnable: true
}