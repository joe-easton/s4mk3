import QtQuick 2.5


//here we assume that `colors` and `dimensions` already exists in the object hierarchy
Item {
  id: widget
  property string title: ''
  property string artist: ''
  property color  backgroundColor: colors.defaultBackground
  height:         dimensions.firstRowHeight +18

  
  

  Rectangle {
    id           : headerBg
    color        : (deckId == 1 || deckId == 2) ? colors.colorDeckBlueBright
					: (deckId == 3 || deckId == 4) ? colors.colorDeckOrangeBright
					 :  colors.white
    anchors.fill : parent
    radius: dimensions.cornerRadius

    
    // TRACK NAME // 
    Text
    {
      anchors.fill : parent
      anchors.leftMargin:   dimensions.titleTextMargin
      anchors.rightMargin:  dimensions.titleTextMargin
      font.family: "Roboto"
      font.weight: Font.Normal

      font.pixelSize: 22
      color: colors.black
      elide: Text.ElideRight
	  
      text: widget.title
    }
	
	// ARTIST NAME // 
    Text
    {
      anchors.fill : parent
      anchors.leftMargin:   dimensions.titleTextMargin
      anchors.rightMargin:  dimensions.titleTextMargin
	  anchors.topMargin: 23
      font.family: "Roboto"
      font.weight: Font.Normal
	  
	  elide: Text.ElideRight
      font.pixelSize: 20
      color: colors.black
	  
      text: widget.artist
    }
    
	
  }
}
