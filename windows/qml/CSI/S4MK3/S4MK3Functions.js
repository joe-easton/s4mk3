
// Returns a color for the specified Deck index
function colorForDeck(deckId,deckA,deckB,deckC,deckD)
{
    switch (deckId)
    {
      case 1: 
	  
			if (deckA == 0) {return Color.Red} 
				else if (deckA == 1) {return Color.DarkOrange} 
				else if (deckA == 2) {return Color.LightOrange} 
				else if (deckA == 3) {return Color.White} 
				else if (deckA == 4) {return Color.Yellow} 
				else if (deckA == 5) {return Color.Lime} 
				else if (deckA == 6) {return Color.Green} 
				else if (deckA == 7) {return Color.Mint} 
				else if (deckA == 8) {return Color.Cyan} 
				else if (deckA == 9) {return Color.Turquoise} 
				else if (deckA == 10) {return Color.Blue} 
				else if (deckA == 11) {return Color.Plum} 
				else if (deckA == 12) {return Color.Violet} 
				else if (deckA == 13) {return Color.Purple} 
				else if (deckA == 14) {return Color.Magenta} 
				else if (deckA == 15) {return Color.Fuschia}
				else {return Color.Blue};
					
		
      case 2:
	  
		  if (deckB == 0) {return Color.Red} 
				else if (deckB == 1) {return Color.DarkOrange} 
				else if (deckB == 2) {return Color.LightOrange} 
				else if (deckB == 3) {return Color.White} 
				else if (deckB == 4) {return Color.Yellow} 
				else if (deckB == 5) {return Color.Lime} 
				else if (deckB == 6) {return Color.Green} 
				else if (deckB == 7) {return Color.Mint} 
				else if (deckB == 8) {return Color.Cyan} 
				else if (deckB == 9) {return Color.Turquoise} 
				else if (deckB == 10) {return Color.Blue} 
				else if (deckB == 11) {return Color.Plum} 
				else if (deckB == 12) {return Color.Violet} 
				else if (deckB == 13) {return Color.Purple} 
				else if (deckB == 14) {return Color.Magenta} 
				else if (deckB == 15) {return Color.Fuschia}
				else {return Color.Blue};
      case 3:
	  
		  if (deckC == 0) {return Color.Red} 
				else if (deckC == 1) {return Color.DarkOrange} 
				else if (deckC == 2) {return Color.LightOrange} 
				else if (deckC == 3) {return Color.White} 
				else if (deckC == 4) {return Color.Yellow} 
				else if (deckC == 5) {return Color.Lime} 
				else if (deckC == 6) {return Color.Green} 
				else if (deckC == 7) {return Color.Mint} 
				else if (deckC == 8) {return Color.Cyan} 
				else if (deckC == 9) {return Color.Turquoise} 
				else if (deckC == 10) {return Color.Blue} 
				else if (deckC == 11) {return Color.Plum} 
				else if (deckC == 12) {return Color.Violet} 
				else if (deckC == 13) {return Color.Purple} 
				else if (deckC == 14) {return Color.Magenta} 
				else if (deckC == 15) {return Color.Fuschia}
				else {return Color.LightOrange};
		  
      case 4:
	  
		  if (deckD == 0) {return Color.Red} 
				else if (deckD == 1) {return Color.DarkOrange} 
				else if (deckD == 2) {return Color.LightOrange} 
				else if (deckD == 3) {return Color.White} 
				else if (deckD == 4) {return Color.Red} 
				else if (deckD == 5) {return Color.Lime} 
				else if (deckD == 6) {return Color.Green} 
				else if (deckD == 7) {return Color.Mint} 
				else if (deckD == 8) {return Color.Cyan} 
				else if (deckD == 9) {return Color.Turquoise} 
				else if (deckD == 10) {return Color.Blue} 
				else if (deckD == 11) {return Color.Plum} 
				else if (deckD == 12) {return Color.Violet} 
				else if (deckD == 13) {return Color.Purple} 
				else if (deckD == 14) {return Color.Magenta} 
				else if (deckD == 15) {return Color.Fuschia}
				else {return Color.LightOrange};
	  
        // Deck C and D are color-coded in Orange
        
    }

    // Fall-through...
    return Color.White;
}

// primary decks defualt to track, secondary decks default to remix   
function defaultTypeForDeck(deckIdx)
{
    return (deckIdx > 2) ? DeckType.Remix : DeckType.Track
}

function deckTypeSupportsGridAdjust(deckType)
{
    return deckType == DeckType.Track || deckType == DeckType.Stem;
}

function linkedDeckIdx(deckIdx)
{
    switch (deckIdx)
    {
    // Deck A and C are linked
    case 0: return 2;
    case 2: return 0;
    // Deck B and D are linked
    case 1: return 3;
    case 3: return 1;
    }
}