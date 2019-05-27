import CSI 1.0
import "S4MK3Functions.js" as S4MK3Functions
import '../../Screens/Defines' as Defines

Module
{
  id: module
  
  Defines.Settings  {id: settings}
  property int fx1: settings.fx1Colour
  property int fx2: settings.fx2Colour
  property int fx3: settings.fx3Colour
  property int fx4: settings.fx4Colour
  property int filterColour: settings.filterColour
  
  function colorForDeck(mixerColour)
	{

			if (mixerColour == null) {return Color.Red} 
				else if (mixerColour == 1) {return Color.Red} 
				else if (mixerColour == 2) {return Color.DarkOrange} 
				else if (mixerColour == 3) {return Color.LightOrange} 
				else if (mixerColour == 4) {return Color.White} 
				else if (mixerColour == 5) {return Color.Yellow} 
				else if (mixerColour == 6) {return Color.Lime} 
				else if (mixerColour == 7) {return Color.Green} 
				else if (mixerColour == 8) {return Color.Mint} 
				else if (mixerColour == 9) {return Color.Cyan} 
				else if (mixerColour == 10) {return Color.Turquoise} 
				else if (mixerColour == 11) {return Color.Blue} 
				else if (mixerColour == 12) {return Color.Plum} 
				else if (mixerColour == 13) {return Color.Violet} 
				else if (mixerColour == 14) {return Color.Purple} 
				else if (mixerColour == 15) {return Color.Magenta} 
				else if (mixerColour == 16) {return Color.Fuschia}
				else {return Color.Blue};
	}
  property bool cancelMultiSelection: false
  property int currentlySelectedFx: -1

  // Mixer Effects Color Scheme
  readonly property variant colorScheme: [
    settings.filterColour,  // Filter
    settings.fx1Colour,          // FX1
    settings.fx2Colour,        // FX2
    settings.fx3Colour,         // FX3
    settings.fx4Colour        // FX4
  ]

   // Channel Fx  
  S4MK3ChannelFX
  {
    id: channel1
    name: "channel1"
    index: 1
    onFxChanged : { module.cancelMultiSelection = true; }
    channelFxSelectorVal: module.currentlySelectedFx
  }

  S4MK3ChannelFX
  {
    id: channel2
    name: "channel2"
    index: 2
    onFxChanged : { module.cancelMultiSelection = true; }
    channelFxSelectorVal: module.currentlySelectedFx
  }

  S4MK3ChannelFX
  {
    id: channel3
    name: "channel3"
    index: 3
    onFxChanged : { module.cancelMultiSelection = true; }
    channelFxSelectorVal: module.currentlySelectedFx
  }

  S4MK3ChannelFX
  {
    id: channel4
    name: "channel4"
    index: 4
    onFxChanged : { module.cancelMultiSelection = true; }
    channelFxSelectorVal: module.currentlySelectedFx
  }

  function onFxSelectReleased(fxSelection)
  {
    if (!module.cancelMultiSelection)
    {
      channel1.selectedFx.value = fxSelection;
      channel2.selectedFx.value = fxSelection;
      channel3.selectedFx.value = fxSelection;
      channel4.selectedFx.value = fxSelection; 
    }
    if (module.currentlySelectedFx == fxSelection)
      module.currentlySelectedFx = -1;
  }

  function onFxSelectPressed(fxSelection)
  {
    module.cancelMultiSelection = (module.currentlySelectedFx != -1);
    module.currentlySelectedFx = fxSelection;
  }
    
  function isFxUsed(index)
  {
    return channel1.selectedFx.value == index ||
           channel2.selectedFx.value == index ||
           channel3.selectedFx.value == index ||
           channel4.selectedFx.value == index;
  }

  function ledBrightness(on)
  {
    return on ? 1.0 : 0.0;
  }

  Wire 
  { 
    from: "s4mk3.mixer.channel_fx.filter"; 
    to: ButtonScriptAdapter
    {
      onPress :
      {
        onFxSelectPressed(0)
      }
      onRelease :
      {
        onFxSelectReleased(0);
      }
      color: module.colorScheme[0]  
      brightness: ledBrightness(isFxUsed(0))
    }
  }
  Wire 
  { 
    from: "s4mk3.mixer.channel_fx.fx1"; 
    to: ButtonScriptAdapter
    {
      onPress :
      {
        onFxSelectPressed(1)
      }
      onRelease :
      {
        onFxSelectReleased(1);
      }
      color: module.colorScheme[1]  
      brightness: ledBrightness(isFxUsed(1))
    }
  }
  Wire 
  { 
    from: "s4mk3.mixer.channel_fx.fx2"; 
    to: ButtonScriptAdapter
    {
      onPress :
      {
        onFxSelectPressed(2)
      }
      onRelease :
      {
        onFxSelectReleased(2);
      }
      color: module.colorScheme[2]   
      brightness: ledBrightness(isFxUsed(2))  
    }
  }
  Wire 
  { 
    from: "s4mk3.mixer.channel_fx.fx3"; 
    to: ButtonScriptAdapter
    {
      onPress :
      {
        onFxSelectPressed(3)
      }
      onRelease :
      {
        onFxSelectReleased(3);
      }
      color: module.colorScheme[3] 
      brightness: ledBrightness(isFxUsed(3))  
    }
  }
  Wire 
  { 
    from: "s4mk3.mixer.channel_fx.fx4"; 
    to: ButtonScriptAdapter
    {
      onPress :
      {
        onFxSelectPressed(4)
      }
      onRelease :
      {
        onFxSelectReleased(4);
      }
      color: module.colorScheme[4]    
      brightness: ledBrightness(isFxUsed(4))
    }
  }
}