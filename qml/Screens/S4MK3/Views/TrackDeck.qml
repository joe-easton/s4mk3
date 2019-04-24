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
  property real infoBoxesWidth:   dimensions.infoBoxesWidth +4
  property real firstRowHeight:   dimensions.firstRowHeight
  property real secondRowHeight:  dimensions.secondRowHeight
  property real spacing:          dimensions.spacing-3
  property real screenTopMargin:  dimensions.screenTopMargin
  property real screenLeftMargin: dimensions.screenLeftMargin-2

  width  : 320
  height : 240

  Rectangle
  {
    id: displayBackground
    anchors.fill : parent
    color: colors.defaultBackground
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

      height: display.firstRowHeight +15
      width:  2*display.infoBoxesWidth + 5
				
    }

    // FIRST ROW //
    RowLayout {
      id: firstRow

      spacing: display.spacing

      // BPM DISPLAY //
      Rectangle {
        id: bpmBox
        height: display.firstRowHeight -3
        width:  display.infoBoxesWidth - 52

		color: (deckInfo.masterDeck == deckInfo.deckId) ? colors.loopActiveColor
				: (deckInfo.bpmOffset <= 0.05) && (deckInfo.bpmOffset >= - 0.05) ?  colors.loopActiveDimmedColor
					: colors.colorRed
        radius: display.boxesRadius

        Text {
          text: deckInfo.bpmString
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "black"
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
		
      }
	  
	  // TEMPO DISPLAY //
      Rectangle {
        id: tempoBox
        height: display.firstRowHeight -3
        width:  display.infoBoxesWidth - 53

		color: (deckInfo.tempoString < 0.05) && (deckInfo.tempoString > - 0.05) ?  colors.hotcue.hotcue
                : colors.colorBluePlaymarker
        radius: display.boxesRadius

        Text {
          text: deckInfo.tempoStringPer
          font.pixelSize: 24
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "black"
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
		
      }

      // KEY DISPLAY //
      Rectangle {
        id: keyBox
        
        height: display.firstRowHeight -3
        width:  display.infoBoxesWidth - 52
		
		
		
		color:     colors.musicalKeyColors[deckInfo.keyIndex]
                         
        radius: display.boxesRadius

        Text {
          id: keyText
          text: deckInfo.hasKey && (deckInfo.keyAdjustString != "-0") && (deckInfo.keyAdjustString != "+0") ? deckInfo.keyString + " " + deckInfo.keyAdjustString
				: deckInfo.hasKey ? deckInfo.keyString
					: "No key"
          font.pixelSize: 24	
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "black"
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
        }
		
		//keylock circle
        Text {
          visible: deckInfo.isKeyLockOn && deckInfo.hasKey
          text: "\u25CF"
          font.pixelSize: 14
          font.family: "Roboto"
          font.weight: Font.Normal
          color: "black"
          anchors.left: parent.left
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
        height: display.secondRowHeight-45

        Rectangle {
          anchors.fill: parent
          color:  trackEndBlinkTimer.blink ? colors.colorRed : colors.colorDeckGrey
          radius: display.boxesRadius
        }

        Text {
          text: deckInfo.remainingTimeString
          font.pixelSize: 28
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
        height: display.secondRowHeight-45

        Rectangle {
          anchors.fill: parent
          color: deckInfo.loopActiveLoop ? (loopActiveBlinkTimer.blink ? colors.colorRed : colors.loopActiveColor)
					: deckInfo.loopActive ? (deckInfo.shift ? colors.loopActiveDimmedColor : colors.loopActiveColor) 
						: deckInfo.shift ? colors.colorDeckDarkGrey : colors.colorDeckGrey 
          radius: display.boxesRadius
          }

        Text {
          text: deckInfo.loopSizeString
          font.pixelSize: 28
          font.family: "Roboto"
          font.weight: Font.Medium
          color: deckInfo.loopActive ? "black" : ( deckInfo.shift ? colors.colorDeckGrey : colors.defaultTextColor )
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }
		
		Timer {
          id: loopActiveBlinkTimer
          property bool  blink: false
	
          interval: 120
          repeat:   true
          running:  deckInfo.loopActiveLoop

          onTriggered: {
            blink = !blink;
          }

          onRunningChanged: {
            blink = running;
          }
        }
      }

      

    } // second row
	
	// STRIPE //
	Widgets.PhaseMeter
    {
      height: 18
      width:  2*display.infoBoxesWidth + display.spacing
      anchors.left: parent.left
	  
	  phase:  deckInfo.phase
    }

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
      width:  2*display.infoBoxesWidth + display.spacing
      anchors.left: parent.left


      hotcuesModel: deckInfo.hotcues
      trackLength:  deckInfo.trackLength
      elapsedTime:  deckInfo.elapsedTime
      audioStreamKey: ["PrimaryKey", deckInfo.primaryKey]
    }

  }




}
