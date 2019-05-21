import QtQuick 2.5


//here we assume that `colors` and `dimensions` already exists in the object hierarchy
Item {
  id: widget
  property string title: ''
  property string artist: ''
  property color  backgroundColor: colors.defaultBackground
  height:         dimensions.firstRowHeight

  
  

  Rectangle {
    id           : headerBg
    color        : (deckId == 1 || deckId == 2) ? colors.colorDeckBlueBright
					: (deckId == 3 || deckId == 4) ? colors.colorDeckOrangeBright
					 :  colors.white
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
