import CSI 1.0
import "../../Defines"
import "S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines2

/*
  This file represents a hardware module on the S4MK3
*/
Module
{
  id: module
  
  Defines2.Settings  {id: settings}
  property int deckA: settings.deckAColour
  property int deckB: settings.deckBColour
  property int deckC: settings.deckCColour
  property int deckD: settings.deckDColour
  
  property string surface: ""
  property string propertiesPath: ""
  property int topDeckIdx: 0 
  property int bottomDeckIdx: 0 
  property alias shift: shiftProp
  property int focusedDeckIdx: topDeckFocus.value ? topDeckIdx : bottomDeckIdx
  property bool hapticHotcuesEnabled: true

  //--------------------------HelperFunctions-----------------------------

  function updatePads() 
  {
    if(PadsMode.isPadsModeSupported(focusedDeck().padsMode, focusedDeck().deckType))
    {
      focusedDeck().enablePads = true;
      nonFocusedDeck().enablePads = false;
    }
    else if(focusedDeck().padsMode == PadsMode.remix && nonFocusedDeck().deckType === DeckType.Remix)
    {
      focusedDeck().enablePads = false;
      nonFocusedDeck().enablePads = true
      nonFocusedDeck().padsMode = PadsMode.remix;
    }
    else
    {
      focusedDeck().padsMode = PadsMode.defaultPadsModeForDeck(focusedDeck().deckType);
    }

    // Keep pads state in sync with focused deck, will only trigger callbacks if value has changed
    globalPadsMode.value = focusedDeck().padsMode;
  }

  function nonFocusedDeck()
  {
    return topDeckFocus.value ? bottomDeck : topDeck;
  }

  function focusedDeck()
  {
    return topDeckFocus.value ? topDeck : bottomDeck;
  }

  //--------------------------MAPPING-----------------------------

  // Deck focus //

  MappingPropertyDescriptor
  {
    id: topDeckFocus;
    path: propertiesPath + ".top_deck_focus";
    type: MappingPropertyDescriptor.Boolean;
    value: true;
    onValueChanged:
    {
      updatePads();
    }  
  }

  Wire
  {
    from: "%surface%.top_deck";
    to: SetPropertyAdapter  { path: propertiesPath + ".top_deck_focus"; value: true; color: S4MK3Functions.colorForDeck(module.topDeckIdx,deckA,deckB,deckC,deckD) }
  } 

  Wire
  {
    from: "%surface%.bottom_deck";
    to: SetPropertyAdapter  { path: propertiesPath + ".top_deck_focus"; value: false; color: S4MK3Functions.colorForDeck(module.bottomDeckIdx,deckA,deckB,deckC,deckD) }
  } 

  // Performace pads mode  //

  MappingPropertyDescriptor
  {
    id: globalPadsMode;
    path: propertiesPath + ".pads_mode";
    type: MappingPropertyDescriptor.Integer;
    value: PadsMode.disabled;
    onValueChanged:
    {
      focusedDeck().padsMode = globalPadsMode.value;
    }  
  }

  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.stems , focusedDeck().deckType);
    from: "%surface%.stems";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.stems; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD)   }
  } 

  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.hotcues, focusedDeck().deckType);
    from: "%surface%.hotcues";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.hotcues; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }

  Wire
  {
    enabled: PadsMode.isPadsModeSupported(PadsMode.remix, bottomDeck.deckType) || PadsMode.isPadsModeSupported(PadsMode.remix, topDeck.deckType);
    from: "%surface%.samples";
    to: SetPropertyAdapter  { path: propertiesPath + ".pads_mode"; value: PadsMode.remix; color: S4MK3Functions.colorForDeck(focusedDeckIdx,deckA,deckB,deckC,deckD) }
  }

  // Shift //
  MappingPropertyDescriptor { id: shiftProp; path: propertiesPath + ".shift"; type: MappingPropertyDescriptor.Boolean; value: false }
  Wire { from: "%surface%.shift";  to: DirectPropertyAdapter { path: propertiesPath + ".shift"  } }

  //------------------------------------SUBMODULES---------------------------------------------//

  KontrolScreen { name: "screen"; side: topDeckIdx==1 ? ScreenSide.Left : ScreenSide.Right; propertiesPath: module.propertiesPath; flavor: ScreenFlavor.S4MK3 }
  Wire { from: "screen.output";   to: "%surface%.display" }

  S4MK3Deck
  {
    id: topDeck
    name: "topDeck"
    surface: module.surface
    deckPropertiesPath: propertiesPath + "." + topDeckIdx
    isLinkedDeckEncoderInUse: bottomDeck.isEncoderInUse
    shift: shiftProp.value
    deckIdx: topDeckIdx
    active: topDeckFocus.value
    hapticHotcuesEnabled: module.hapticHotcuesEnabled
    onDeckTypeChanged:
    {
      updatePads();
    }
    onPadsModeChanged:
    {
      updatePads();
    }
  }

  S4MK3Deck
  {
    id: bottomDeck
    name: "bottomDeck"
    surface: module.surface
    isLinkedDeckEncoderInUse: topDeck.isEncoderInUse
    deckPropertiesPath: propertiesPath + "." + bottomDeckIdx
    shift: shiftProp.value
    deckIdx: bottomDeckIdx
    active: !topDeckFocus.value
    hapticHotcuesEnabled: module.hapticHotcuesEnabled
    onDeckTypeChanged:
    { 
      updatePads();
    }
    onPadsModeChanged:
    {
      updatePads();
    }
  }

//#ifdef DEVELOPMENT_MODE
  Wire { from: "%surface%.record";  to: TriggerPropertyAdapter { path:"app.traktor.debug.take_screenshot"; output: false } enabled: topDeck.shift }
//#endif

}
            
 
