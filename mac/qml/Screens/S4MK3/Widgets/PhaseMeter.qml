import QtQuick 2.5
import CSI 1.0
import '../../Defines' as Defines

Item {
    id : widget
    height: 10
	
	function colorForPhase(deckId,phaseA,phaseB,phaseC,phaseD)
	{
		switch (deckId)
		{
		  case 1: 
		  
			if (phaseA == 0) {return colors.red} 
				else if (phaseA == 1) {return colors.darkOrange} 
				else if (phaseA == 2) {return colors.lightOrange} 
				else if (phaseA == 3) {return colors.phaseColor} 
				else if (phaseA == 4) {return colors.yellow} 
				else if (phaseA == 5) {return colors.lime} 
				else if (phaseA == 6) {return colors.green} 
				else if (phaseA == 7) {return colors.mint} 
				else if (phaseA == 8) {return colors.cyan} 
				else if (phaseA == 9) {return colors.turquoise} 
				else if (phaseA == 10) {return colors.blue} 
				else if (phaseA == 11) {return colors.plum} 
				else if (phaseA == 12) {return colors.violet} 
				else if (phaseA == 13) {return colors.purple} 
				else if (phaseA == 14) {return colors.magenta} 
				else if (phaseA == 15) {return colors.fuschia}
				else if (phaseA == 16) {return colors.colorWhite}
				else {return colors.colorDeckBlueBright};		
			
		  case 2:
		  
		  if (phaseB == 0) {return colors.red} 
				else if (phaseB == 1) {return colors.darkOrange} 
				else if (phaseB == 2) {return colors.lightOrange} 
				else if (phaseB == 3) {return colors.phaseColor} 
				else if (phaseB == 4) {return colors.yellow} 
				else if (phaseB == 5) {return colors.lime} 
				else if (phaseB == 6) {return colors.green} 
				else if (phaseB == 7) {return colors.mint} 
				else if (phaseB == 8) {return colors.cyan} 
				else if (phaseB == 9) {return colors.turquoise} 
				else if (phaseB == 10) {return colors.blue} 
				else if (phaseB == 11) {return colors.plum} 
				else if (phaseB == 12) {return colors.violet} 
				else if (phaseB == 13) {return colors.purple} 
				else if (phaseB == 14) {return colors.magenta} 
				else if (phaseB == 15) {return colors.fuschia}
				else if (phaseA == 16) {return colors.colorWhite}
				else {return colors.colorDeckBlueBright};
				
		  case 3:
		  
		  if (phaseC == 0) {return colors.red} 
				else if (phaseC == 1) {return colors.darkOrange} 
				else if (phaseC == 2) {return colors.lightOrange} 
				else if (phaseC == 3) {return colors.phaseColor} 
				else if (phaseC == 4) {return colors.yellow} 
				else if (phaseC == 5) {return colors.lime} 
				else if (phaseC == 6) {return colors.green} 
				else if (phaseC == 7) {return colors.mint} 
				else if (phaseC == 8) {return colors.cyan} 
				else if (phaseC == 9) {return colors.turquoise} 
				else if (phaseC == 10) {return colors.blue} 
				else if (phaseC == 11) {return colors.plum} 
				else if (phaseC == 12) {return colors.violet} 
				else if (phaseC == 13) {return colors.purple} 
				else if (phaseC == 14) {return colors.magenta} 
				else if (phaseC == 15) {return colors.fuschia}
				else if (phaseA == 16) {return colors.colorWhite}
				else {return colors.lightOrange};
		  
		  case 4:
		  
		  if (phaseD == 0) {return colors.red} 
				else if (phaseD == 1) {return colors.darkOrange} 
				else if (phaseD == 2) {return colors.lightOrange} 
				else if (phaseD == 3) {return colors.phaseColor} 
				else if (phaseD == 4) {return colors.yellow} 
				else if (phaseD == 5) {return colors.lime} 
				else if (phaseD == 6) {return colors.green} 
				else if (phaseD == 7) {return colors.mint} 
				else if (phaseD == 8) {return colors.cyan} 
				else if (phaseD == 9) {return colors.turquoise} 
				else if (phaseD == 10) {return colors.blue} 
				else if (phaseD == 11) {return colors.plum} 
				else if (phaseD == 12) {return colors.violet} 
				else if (phaseD == 13) {return colors.purple} 
				else if (phaseD == 14) {return colors.magenta} 
				else if (phaseD == 15) {return colors.fuschia}
				else if (phaseA == 16) {return colors.colorWhite}
				else {return colors.lightOrange};

			
		}
		return colors.lightOrange;
	}

    property real phase: 0.0
	
    Defines.Settings  {id: settings}
    property int phaseAColour: settings.phaseAColour
    property int phaseBColour: settings.phaseBColour
    property int phaseCColour: settings.phaseCColour
    property int phaseDColour: settings.phaseDColour
	property int deckId:	   deckInfo.deckId
	
	


    property color phaseColor: colorForPhase(deckId, phaseAColour, phaseBColour, phaseCColour, phaseDColour)
    property color phaseHeadColor: "#FCB262"
    property color separatorColor: "#88ffffff"
    property color backgroundColor: colors.grayBackground
    property real phasePosition: parent.width * (0.5 + widget.phase)
    property real phaseBarWidth: parent.width * Math.abs(widget.phase)

    // Background
    Rectangle
    {
      anchors.fill: parent
      color: widget.backgroundColor
    }

    // Phase Bar
    Rectangle
    {
      color  : widget.phaseColor
      height : parent.height
      width  : phaseBarWidth
      x : widget.phase < 0 ? widget.phasePosition : (parent.width/2)
    }

    // Phase Head
    Rectangle
    {
      color: widget.phaseHeadColor
      height : parent.height
      width: 1
      x: widget.phase < 0 ? widget.phasePosition : (widget.phasePosition - width)
      visible: Math.round(phaseBarWidth) !== 0 // hide phase head when phase is 0
    }

    // Separator at 0.25
    Rectangle
    {
      color  : widget.separatorColor
      height : parent.height
      width  : 1
      x : parent.width * 0.25 - 1
    }

    // center Separator
    Rectangle
    {
      color  : widget.separatorColor
      height : parent.height
      width  : 1
      x : parent.width * 0.50 - 1
    }

    // Separator at 0.75
    Rectangle
    {
      color  : widget.separatorColor
      height : parent.height
      width  : 1
      x : parent.width * 0.75 - 1
    }
}
