WOW 2
======

The melody from previous tutorial sounds alright, but a little bit flat. The reason is that real people don't play music exactly as in sheet music. 

We want to capture that.

staccato / legato
-------------------

from Music

	staccato, legato :: Dur -> T note -> T note
	
	staccato = articulation . Staccato
	legato   = articulation . Legato
	
These functions decorate note duration. In particular, staccato makes a note shorter, but insert a rest to fill in the gap to make total duration as the same as before. If you have the original WOW sound track, you can discover that notes of the melody played by the flute are not always in full value.

First step towards a more natural sound:

	flute_base' = [
	  cs 1 qn, staccato en . (fs 1 qn), fs 1 en, e 1 en, fs 1 hn, fs 1 en, staccato dsn . (gs 1 en)
	  ]

	flute_var_1' = [
	  a 1 qn, b 1 qn, a 1 qn, gs 1 en, fs 1 en, e 1 hn
	  ]
  
	flute_var_2' = [
	  a 1 qn, e 1 en, cs 1 en, a 1 qn, gs 1 dhn
	  ]
  
	flute_var_3' = [
	  a 1 qn, fs 1 qn, staccato en . (a 1 qn), b 1 dqn, a 1 en, staccato en . (gs 1 qn), fs 1 dwn
	  ]

Though still a bit machine like, this melody makes sure if ever played by a human, she could [breath](../midi/wow_2/wow_2_1.midi?raw=true).

Note: `legato` simply extend the duration of a note without delaying notes after it.

dynamics
---------

from Music

	accent, crescendo, diminuendo, loudness1,
	   ritardando, accelerando ::
	      Rational -> T note -> T note
    
	accent     = dynamic . Accent
	crescendo  = dynamic . Crescendo
	diminuendo = dynamic . Diminuendo
	loudness1  = dynamic . Loudness

Artist don't play in equal dynamics, they accent whenever they feel like it.

Second step:

	flute_accent_high = accent 0.2
	flute_accent_low = accent 0.1

	flute_base = [
	  flute_accent_high . (cs 1 qn), staccato en . (fs 1 qn), fs 1 en, e 1 en, fs 1 hn, fs 1 en, staccato dsn . (gs 1 en)
	  ]

	flute_var_1 = [
	  flute_accent_low . (a 1 qn), b 1 qn, a 1 qn, gs 1 en, fs 1 en, e 1 hn
	  ]

	flute_var_2 = [
	  a 1 qn, e 1 en, cs 1 en, a 1 qn, gs 1 dhn
	  ]

	flute_var_3 = [
	  flute_accent_low . (a 1 qn),  fs 1 qn, staccato en . (a 1 qn), 
	    flute_accent_high . (b 1 dqn), a 1 en, staccato en . (gs 1 qn), fs 1 dwn
	  ]

It might be hard to [spot](../midi/wow_2/wow_2_2.midi?raw=true), but we did change some dynamics in the melody.

## [Theme music from the World of Warcraft 3 ( multitrack )](wow_3.markdown)