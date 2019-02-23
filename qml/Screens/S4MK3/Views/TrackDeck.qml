import QtQuick 2.5
import QtQuick.Layouts 1.1

import '../Widgets' as Widgets


//----------------------------------------------------------------------------------------------------------------------
//  Track Screen View - UI of the screen for track
//----------------------------------------------------------------------------------------------------------------------

Item {
  id: display
  Dimensions {id: dimensions}

  // MODEL PROPERTIES //
  property var deckInfo: ({})
  property real boxesRadius:      dimensions.cornerRadius
  property real infoBoxesWidth:   dimensions.infoBoxesWidth
  property real firstRowHeight:   dimensions.firstRowHeight
  property real secondRowHeight:  dimensions.secondRowHeight
  property real spacing:          dimensions.spacing
  property real screenTopMargin:  dimensions.screenTopMargin
  property real screenLeftMargin: dimensions.screenLeftMargin

  width  : 320
  height : 240

  Rectangle
  {
    id: displayBackground
    anchors.fill : parent
    color: (deckId == 1 || deckId == 2) ? colors.colorDeckBlueBright
			: (deckId == 3 || deckId == 4) ? colors.colorDeckOrangeBright
			 :  colors.defaultBackground
  }

  ColumnLayout
  {
    id: content
    spacing: display.spacing
    
    anchors.left:       parent.left
    anchors.top:        parent.top
    anchors.topMargin:  display.screenTopMargin
    anchors.leftMargin: display.screenLeftMargin

    // DECK HEADER //
    Widgets.DeckHeader
    {
      id: deckHeader

      title:  deckInfo.titleString
	  artist: deckInfo.artistString	

      height: display.firstRowHeight +18
      width:  2*display.infoBoxesWidth + 5
				
    }

    // FIRST ROW //
    RowLayout {
      id: firstRow

      spacing: display.spacing

      // BPM DISPLAY //
      Rectangle {
        id: bpmBox
        height: display.firstRowHeight
        width:  display.infoBoxesWidth - 52

		color: (deckInfo.isSyncOn) ?  colors.loopActiveDimmedColor
                : colors.defaultBackground
        radius: display.boxesRadius

        Text {
          text: deckInfo.bpmString
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "white"
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
		
      }
	  
	  // TEMPO DISPLAY //
      Rectangle {
        id: tempoBox
        height: display.firstRowHeight
        width:  display.infoBoxesWidth - 53

		color: (deckInfo.tempoString < 0.05) && (deckInfo.tempoString > - 0.05) ?  colors.hotcue.hotcue
                : colors.defaultBackground
        radius: display.boxesRadius

        Text {
          text: deckInfo.tempoStringPer
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "white"
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
		
      }

      // KEY DISPLAY //
      Rectangle {
        id: keyBox
        
        height: display.firstRowHeight
        width:  display.infoBoxesWidth - 52
		
		
		
		color:     colors.musicalKeyColors[deckInfo.keyIndex]
                         
        radius: display.boxesRadius

        Text {
          id: keyText
          text: deckInfo.hasKey ? deckInfo.keyString : "No key"
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: colors.colorWhite
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
        }
		
		//keylock circle
        Text {
          visible: deckInfo.isKeyLockOn && deckInfo.hasKey
          text: "\u25CF"
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: colors.loopActiveColor
          anchors.left: keyText.right
          anchors.leftMargin: 3
          anchors.verticalCenter: parent.verticalCenter
        }

        
      }
    } // first row

    
    // SECOND ROW //
    RowLayout {
      id: secondRow
      spacing: display.spacing

      // TIME DISPLAY //
      Item {
        id: timeBox
        width : display.infoBoxesWidth
        height: display.secondRowHeight-35

        Rectangle {
          anchors.fill: parent
          color:  trackEndBlinkTimer.blink ? colors.colorRed : colors.colorDeckGrey
          radius: display.boxesRadius
        }

        Text {
          text: deckInfo.remainingTimeString
          font.pixelSize: 35
          font.family: "Roboto"
          font.weight: Font.Medium
          color: trackEndBlinkTimer.blink ? "black": "white"
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        Timer {
          id: trackEndBlinkTimer
          property bool  blink: false

          interval: 500
          repeat:   true
          running:  deckInfo.trackEndWarning

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
        }
      }

      // LOOP DISPLAY //
      Item {
        id: loopBox
        width : display.infoBoxesWidth
        height: display.secondRowHeight-35

        Rectangle {
          anchors.fill: parent
          color: deckInfo.loopActive ? (deckInfo.shift ? colors.loopActiveDimmedColor : colors.loopActiveColor) : (deckInfo.shift ? colors.colorDeckDarkGrey : colors.colorDeckGrey ) 
          radius: display.boxesRadius
          }

        Text {
          text: deckInfo.loopSizeString
          font.pixelSize: 35
          font.family: "Roboto"
          font.weight: Font.Medium
          color: deckInfo.loopActive ? "black" : ( deckInfo.shift ? colors.colorDeckGrey : colors.defaultTextColor )
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
      }

      

    } // second row

    // STRIPE //
    Widgets.Stripe
    {
      deckId:  deckInfo.deckId - 1 // stripe uses zero based indices.
      visible: deckInfo.isLoaded

      // we apply -3 on the height and +3 on the topMargin,
      //because Widgets.Stripes has elements (the cues) that are
      //not taken into the height of the Stripe. They are 3pix outside
      //of the stripe.
      height: display.secondRowHeight+23
      width:  2*display.infoBoxesWidth + display.spacing - 6
      anchors.left: parent.left
      anchors.leftMargin: 6


      hotcuesModel: deckInfo.hotcues
      trackLength:  deckInfo.trackLength
      elapsedTime:  deckInfo.elapsedTime
      audioStreamKey: ["PrimaryKey", deckInfo.primaryKey]
    }

  }




}
