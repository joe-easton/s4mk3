import QtQuick 2.5
import QtQuick.Layouts 1.1
import CSI 1.0
import QtGraphicalEffects 1.0
import Traktor.Gui 1.0 as T
import '../Waveform' as WF


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

      height: display.firstRowHeight-6
      width:  2*display.infoBoxesWidth + 4
				
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
				: deckInfo.shift && (deckInfo.bpmOffset <= 0.05) && (deckInfo.bpmOffset >= - 0.05) ? colors.loopActiveColor
					: (deckInfo.bpmOffset <= 0.05) && (deckInfo.bpmOffset >= - 0.05) ?  colors.loopActiveDimmedColor
						: colors.colorRed
        radius: display.boxesRadius

        Text {
          text: settings.showMasterBpm ? ((settings.bpmSwap && (deckInfo.masterDeck == deckInfo.deckId)) ? deckInfo.bpmString : (deckInfo.shift ? deckInfo.bpmString : (settings.bpmDifference ? deckInfo.bpmOffset : deckInfo.masterBPM))) : (settings.bpmSwap ? (deckInfo.shift ? deckInfo.bpmString : (settings.bpmDifference ? deckInfo.bpmOffset : deckInfo.masterBPM)) : (deckInfo.shift ? (settings.bpmDifference ? deckInfo.bpmOffset : deckInfo.masterBPM) : deckInfo.bpmString))
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
          text: deckInfo.shift ? (settings.shiftExtraPitchDisplay ? (settings.desiredPitch ? deckInfo.tempoNeededString : deckInfo.tempoRange) : deckInfo.tempoStringPer) : deckInfo.tempoStringPer
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
          text: deckInfo.hasKey && (deckInfo.keyAdjustString != "-0") && (deckInfo.keyAdjustString != "+0") ? (settings.camelotKey ? utils.camelotConvert(deckInfo.keyString) : deckInfo.keyString) + " " + deckInfo.keyAdjustString
				: deckInfo.hasKey ? (settings.camelotKey ? utils.camelotConvert(deckInfo.keyString) : deckInfo.keyString)
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
        width : settings.enableBeatsBox ? display.infoBoxesWidth - 52 : display.infoBoxesWidth
        height: display.secondRowHeight-40

        Rectangle {
          anchors.fill: parent
          color:  trackEndBlinkTimer.blink ? colors.colorRed : colors.colorDeckGrey
          radius: display.boxesRadius
        }

        Text {
          text: deckInfo.shift ? (settings.elapsedTime ? deckInfo.remainingTimeString : deckInfo.elapsedTimeString) : (settings.elapsedTime ? deckInfo.elapsedTimeString : deckInfo.remainingTimeString)
          font.pixelSize: settings.enableBeatsBox ? 26 : 28
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
	  
	  //BEATS DISPLAY
	  Item {
        id: beatsBox
        width : display.infoBoxesWidth - 52
		visible: settings.enableBeatsBox
        height: display.secondRowHeight-40

        Rectangle {
          anchors.fill: parent
          color: colors.colorDeckGrey 
          radius: display.boxesRadius
        }

        Text {
          text: deckInfo.beats
          font.pixelSize: 26
          font.family: "Roboto"
          font.weight: Font.Medium
          color: colors.defaultTextColor
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
		  visible: settings.showBeatsToCue ? deckInfo.shift : !deckInfo.shift
        }
		
		Text {
          text: deckInfo.beatsToCue
          font.pixelSize: 26
          font.family: "Roboto"
          font.weight: Font.Medium
          color: colors.defaultTextColor
          anchors.fill: parent
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
		  visible: settings.showBeatsToCue ? !deckInfo.shift : deckInfo.shift
        }
	  }

      // LOOP DISPLAY //
      Item {
        id: loopBox
        width : settings.enableBeatsBox ? display.infoBoxesWidth - 52 : display.infoBoxesWidth
        height: display.secondRowHeight-40

        Rectangle {
          anchors.fill: parent
          color: deckInfo.loopActiveLoop ? (loopActiveBlinkTimer.blink ? (settings.loopActiveRedFlash ? colors.colorRed : colors.loopActiveDimmedColor) : colors.loopActiveColor)
					: deckInfo.loopActive ? (deckInfo.shift ? colors.loopActiveDimmedColor : colors.loopActiveColor) 
						: deckInfo.shift ? colors.colorDeckDarkGrey : colors.colorDeckGrey 
          radius: display.boxesRadius
          }

        Text {
          text: deckInfo.loopSizeString
          font.pixelSize: settings.enableBeatsBox ? 26 : 28
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
	
          interval: 333
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
	
	//WAVEFORM

	  property string deckSizeState:   "large"
	  property color  deckColor:       colors.colorRed
	  
	  readonly property int waveformHeight: (deckSizeState == "small") ? 0 : ( parent ? ( (deckSizeState == "medium") ? (parent.height-43) : (parent.height-53) ) : 0 )

	  property bool showLoopSize: false
	  property int  zoomLevel:    1
	  property bool isInEditMode: false
	  property string propertiesPath: ""

	  readonly property int minSampleWidth: 0x800
	  readonly property int sampleWidth: minSampleWidth << zoomLevel
	  
	
	
	// PHASE METER //
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
      height: display.secondRowHeight+35
      width:  2*display.infoBoxesWidth + display.spacing
      anchors.left: parent.left


      hotcuesModel: deckInfo.hotcues
      trackLength:  deckInfo.trackLength
      elapsedTime:  deckInfo.elapsedTime
      audioStreamKey: ["PrimaryKey", deckInfo.primaryKey]
    }
	
	

  }




}
