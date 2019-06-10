import CSI 1.0
import QtQuick 2.0
import QtGraphicalEffects 1.0
import Traktor.Gui 1.0 as T

import '../../../Defines'
import '../../Defines'


Item {
  id: view
  property int    deckId:        deckInfo.deckId
  property string deckSizeState: "large"
  property int    sampleWidth:   0
  property bool   showLoopSize: false
  property bool   isInEditMode: false
  property string propertiesPath: ""

  readonly property bool trackIsLoaded: (primaryKey.value > 0)

  //--------------------------------------------------------------------------------------------------------------------

  AppProperty     { id: primaryKey;        path: "app.traktor.decks."   + deckId + ".track.content.primary_key"  }
  AppProperty     { id: sampleRate;        path: "app.traktor.decks."   + deckId + ".track.content.sample_rate"; onValueChanged: { updateLooping(); } }
  AppProperty     { id: propFluxState;     path: "app.traktor.decks."   + deckId + ".flux.state"                 }
  AppProperty     { id: propFluxPosition;  path: "app.traktor.decks."   + deckId + ".track.player.flux_position" }
  
  // If the playhead is in a loop, propIsLooping is TRUE and the loop becomes the active cue.
  AppProperty   { id: propIsLooping;     path: "app.traktor.decks." + deckId + ".loop.is_in_active_loop";        onValueChanged: { updateLooping(); } }
  AppProperty   { id: propLoopStart;     path: "app.traktor.decks." + deckId + ".track.cue.active.start_pos";    onValueChanged: { updateLooping(); } }
  AppProperty   { id: propLoopLength;    path: "app.traktor.decks." + deckId + ".track.cue.active.length";       onValueChanged: { updateLooping(); } }


  //--------------------------------------------------------------------------------------------------------------------
  // WAVEFORM Position
  //------------------------------------------------------------------------------------------------------------------
  
  function slicer_zoom_width()          { return  slicer.slice_width * slicer.slice_count / slicer.zoom_factor * sampleRate.value;          }
  function slicer_pos_to_waveform_pos() { return (slicer.slice_start - (0.5 * slicer.slice_width * slicer.zoom_factor)) * sampleRate.value; }

  function updateLooping()
  {
    if (propIsLooping.value) {
      var loopStart  = propLoopStart.value  * sampleRate.value;
      var loopLength = propLoopLength.value * sampleRate.value;
      wfPosition.clampPlayheadPos(loopStart, loopLength);
    }
    else wfPosition.unclampPlayheadPos();
  }

  T.WaveformPosition {
    id: wfPosition
    deckId: deckInfo.deckId
    followsPlayhead: !slicer.enabled && !beatgrid.editEnabled
    waveformPos:     beatgrid.editEnabled ? beatgrid.posOnEdit   : (slicer.enabled ? slicer_pos_to_waveform_pos() : (playheadPos -  0.5 * view.sampleWidth ))
    sampleWidth:     beatgrid.editEnabled ? beatgrid.widthOnEdit : (slicer.enabled ? slicer_zoom_width()          : view.sampleWidth)
    viewWidth:       singleWaveform.width

    Behavior on sampleWidth { PropertyAnimation { duration: 150; easing.type: Easing.OutCubic } }
    Behavior on waveformPos { PropertyAnimation { duration: 150; easing.type: Easing.OutCubic }  enabled: (slicer.enabled || beatgrid.editEnabled) }
  }


  //--------------------------------------------------------------------------------------------------------------------
  // Single/DAW WAVEFORM
  //------------------------------------------------------------------------------------------------------------------

  SingleWaveform {
    id: singleWaveform
    deckId:        view.deckId
    sampleWidth:   view.sampleWidth

    waveformPosition: wfPosition

    anchors.top:   view.top
    anchors.left:  view.left
    anchors.right: view.right

    anchors.leftMargin:   3
    anchors.rightMargin:  3
    anchors.bottomMargin: (slicer.enabled) ? 11 : 0

    clip:    true
    visible: true        // changed in state
    height:  view.height // changed in state

    Behavior on anchors.bottomMargin { PropertyAnimation {  duration: durations.deckTransition } }
  }

  //--------------------------------------------------------------------------------------------------------------------
  //  Beatgrid
  //--------------------------------------------------------------------------------------------------------------------

  BeatgridView {
    id: beatgrid
    anchors.fill:  parent
    anchors.leftMargin:  3
    anchors.rightMargin: 3

    waveformPosition: wfPosition
    propertiesPath:   view.propertiesPath
    trackId:          primaryKey.value
    deckId:           parent.deckId  
    visible:          (!slicer.enabled || beatgrid.editEnabled)
    editEnabled:      view.isInEditMode && (deckSizeState != "small")
    clip: true
  }

  //--------------------------------------------------------------------------------------------------------------------
  //  CuePoints
  //--------------------------------------------------------------------------------------------------------------------

  WaveformCues {
    id: waveformCues
    anchors.fill: parent
    anchors.leftMargin:  3
    anchors.rightMargin: 3

    deckId:            view.deckId
    waveformPosition:  wfPosition
    forceHideLoop:     slicer.enabled || !trackIsLoaded
  }


  //--------------------------------------------------------------------------------------------------------------------
  // Freeze/Slicer
  //--------------------------------------------------------------------------------------------------------------------

  Slicer {
    id: slicer
    anchors.fill:      parent
    anchors.leftMargin: 3
    anchors.rightMargin: 3
    anchors.topMargin: 1
    deckId:            view.deckId
    opacity:           (beatgrid.editEnabled) ? 0 : 1
  }

  T.WaveformTranslator {
    Rectangle {
      id: flux_marker
      x:     0; y:      -4
      width: 3; height: view.height
      color:        colors.colorBluePlaymarker
      border.color: colors.colorBlack31
      border.width: 1
      visible:      (propFluxState.value == 2) // flux mode enabled & fluxing)
    }

    followFluxPosition: true
    relativeToPlayhead: true
    pos:                0
    followTarget:       wfPosition
  }

  //--------------------------------------------------------------------------------------------------------------------
  //  PlayMarker
  //--------------------------------------------------------------------------------------------------------------------

  T.WaveformTranslator {
    id: play_marker
    followTarget:       wfPosition
    pos:                0
    relativeToPlayhead: true
    visible:            view.trackIsLoaded

    Rectangle {
      property int sliceModeHeight: waveformContainer.height - 10
      
      y:     -1
      width:  3
      height: (slicer.enabled && !beatgrid.editEnabled ) ? sliceModeHeight : waveformContainer.height + 2
      color:        colors.colorRedPlaymarker
      border.color: colors.colorBlack31
      border.width: 1
    }
  }


  //--------------------------------------------------------------------------------------------------------------------
  // States
  //------------------------------------------------------------------------------------------------------------------ 
  state: "single"
  states: [
    State {
      name: "single";
      PropertyChanges { target: singleWaveform; height: view.height; }
    }
  ]

}
