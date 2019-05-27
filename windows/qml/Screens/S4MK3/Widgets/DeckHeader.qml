import QtQuick 2.5
import CSI 1.0
import '../../Defines' as Defines


//here we assume that `colors` and `dimensions` already exists in the object hierarchy
Item {
  id: widget
  property string title: ''
  property string artist: ''
  property color  backgroundColor: colors.defaultBackground
  height:         dimensions.firstRowHeight

  Defines.Settings  {id: settings}
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  
  function colorForDeck(deckId,deckA,deckB,deckC,deckD)
	{
		switch (deckId)
		{
		  case 1: 
		  
			if (deckA == 0) {return colors.red} 
				else if (deckA == 1) {return colors.darkOrange} 
				else if (deckA == 2) {return colors.lightOrange} 
				else if (deckA == 3) {return colors.colorWhite} 
				else if (deckA == 4) {return colors.yellow} 
				else if (deckA == 5) {return colors.lime} 
				else if (deckA == 6) {return colors.green} 
				else if (deckA == 7) {return colors.mint} 
				else if (deckA == 8) {return colors.cyan} 
				else if (deckA == 9) {return colors.turquoise} 
				else if (deckA == 10) {return colors.colorDeckBlueBright} 
				else if (deckA == 11) {return colors.plum} 
				else if (deckA == 12) {return colors.violet} 
				else if (deckA == 13) {return colors.purple} 
				else if (deckA == 14) {return colors.magenta} 
				else if (deckA == 15) {return colors.fuschia}
				else {return colors.colorDeckBlueBright};		
			
		  case 2:
		  
		  if (deckB == 0) {return colors.red} 
				else if (deckB == 1) {return colors.darkOrange} 
				else if (deckB == 2) {return colors.lightOrange} 
				else if (deckB == 3) {return colors.colorWhite} 
				else if (deckB == 4) {return colors.yellow} 
				else if (deckB == 5) {return colors.lime} 
				else if (deckB == 6) {return colors.green} 
				else if (deckB == 7) {return colors.mint} 
				else if (deckB == 8) {return colors.cyan} 
				else if (deckB == 9) {return colors.turquoise} 
				else if (deckB == 10) {return colors.colorDeckBlueBright} 
				else if (deckB == 11) {return colors.plum} 
				else if (deckB == 12) {return colors.violet} 
				else if (deckB == 13) {return colors.purple} 
				else if (deckB == 14) {return colors.magenta} 
				else if (deckB == 15) {return colors.fuschia}
				else {return colors.colorDeckBlueBright};
				
		  case 3:
		  
		  if (deckC == 0) {return colors.red} 
				else if (deckC == 1) {return colors.darkOrange} 
				else if (deckC == 2) {return colors.lightOrange} 
				else if (deckC == 3) {return colors.colorWhite} 
				else if (deckC == 4) {return colors.yellow} 
				else if (deckC == 5) {return colors.lime} 
				else if (deckC == 6) {return colors.green} 
				else if (deckC == 7) {return colors.mint} 
				else if (deckC == 8) {return colors.cyan} 
				else if (deckC == 9) {return colors.turquoise} 
				else if (deckC == 10) {return colors.colorDeckBlueBright} 
				else if (deckC == 11) {return colors.plum} 
				else if (deckC == 12) {return colors.violet} 
				else if (deckC == 13) {return colors.purple} 
				else if (deckC == 14) {return colors.magenta} 
				else if (deckC == 15) {return colors.fuschia}
				else {return colors.lightOrange};
		  
		  case 4:
		  
		  if (deckD == 0) {return colors.red} 
				else if (deckD == 1) {return colors.darkOrange} 
				else if (deckD == 2) {return colors.lightOrange} 
				else if (deckD == 3) {return colors.colorWhite} 
				else if (deckD == 4) {return colors.yellow} 
				else if (deckD == 5) {return colors.lime} 
				else if (deckD == 6) {return colors.green} 
				else if (deckD == 7) {return colors.mint} 
				else if (deckD == 8) {return colors.cyan} 
				else if (deckD == 9) {return colors.turquoise} 
				else if (deckD == 10) {return colors.colorDeckBlueBright} 
				else if (deckD == 11) {return colors.plum} 
				else if (deckD == 12) {return colors.violet} 
				else if (deckD == 13) {return colors.purple} 
				else if (deckD == 14) {return colors.magenta} 
				else if (deckD == 15) {return colors.fuschia}
				else {return colors.lightOrange};

			
		}

		// Fall-through...
		return colors.colorWhite;
	}
  

  Rectangle {
    id           : headerBg
    color        : colorForDeck(deckId,deckA,deckB,deckC,deckD)
    anchors.fill : parent
    radius: dimensions.cornerRadius	
	
	Text {
			  anchors.fill : parent
			  anchors.leftMargin:   4
			  anchors.rightMargin:  2
			  font.family: "Roboto"
			  font.weight: Font.Normal
			  font.pixelSize: 22
			  color: colors.black  
			  text: widget.title
			  elide: Text.ElideRight			
			  visible: deckInfo.shift ? false : true
	}	
	
	Text {
			  anchors.fill : parent
			  anchors.leftMargin:   4
			  anchors.rightMargin:  2
			  font.family: "Roboto"
			  font.weight: Font.Normal
			  font.pixelSize: 22
			  color: colors.black  
			  text: widget.artist
			  elide: Text.ElideRight			
			  visible: deckInfo.shift ? true : false
	}	
  }
}