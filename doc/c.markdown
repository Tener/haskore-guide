note C
=======

We want to output the note C.

Questions:

* For how long?
* There are many Cs, how _high_ of the C
* In what instrument?


Ignoring details
-----------------

We build a helper to ignore details we don't care. In this case, always playback in piano, and output to a midi file we specified

	module Snippet where

	import Haskore.Music.GeneralMIDI as MidiMusic
	import Haskore.Interface.MIDI.Render as Render

	render_to f m = Render.fileFromGeneralMIDIMusic f song where
	  song = MidiMusic.fromMelodyNullAttr MidiMusic.AcousticGrandPiano m

The `render_to` funciton export a melody `m` into a file `f`. That's all we need for now.


The Melody Module
------------------

	ghci
	
	:m + Haskore.Melody
	:t c
	-- c :: Haskore.Basic.Pitch.Octave -> Haskore.Basic.Duration.T -> attr -> T attr
	
Trying to guess what it does, it takes an Octave, a duration and some attributes and then produce the Melody.T type.

We want the melody type, so we tried

	:t c 1 1 ()
	-- c 1 1 () :: T ()
	
and it works.


c.midi
-------

	:l src/Snippet
	
	:t render_to
	-- render_to :: FilePath -> Haskore.Melody.T () -> IO ()
	
	render_to "c.midi" $ c 1 1 ()


Try playback `c.midi`, awesome.

c.hs
-----

You can also generate the midi file by

	runghc -isrc src/c.hs
	

Octave and Duration
--------------------

from Pitch

> type Octave = Int

from Duration

> type T = TemporalMedium.Dur

from Temporal

> type Dur = NonNeg.Rational


If we look into Duration, there are in fact some neat value-functions available to us:

	bn   = 2       -- brevis
	wn   = 1       -- whole note
	hn   = 1%+ 2    -- half note
	qn   = 1%+ 4    -- quarter note
	en   = 1%+ 8    -- eight note
	sn   = 1%+16    -- sixteenth note
	tn   = 1%+32    -- thirty-second note
	sfn  = 1%+64    -- sixty-fourth note
	
	dwn  = dotted wn    -- dotted whole note
	dhn  = dotted hn    -- dotted half note
	dqn  = dotted qn    -- dotted quarter note
	den  = dotted en    -- dotted eighth note
	dsn  = dotted sn    -- dotted sixteenth note
	dtn  = dotted tn    -- dotted thirty-second note
	
and some neat transformers and applications

	dotted, doubleDotted :: T -> T
	dotted       = ((3%+2) *)
	doubleDotted = ((7%+4) *)
	
	ddhn = doubleDotted hn  -- double-dotted half note
	ddqn = doubleDotted qn  -- double-dotted quarter note
	dden = doubleDotted en  -- double-dotted eighth note