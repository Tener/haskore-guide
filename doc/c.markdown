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
	
Trying to guess what it does, it takes an octave, a duration and some attributes and then produces the Melody.T type.

We want the melody type, so we try

	:t c 1 1 ()
	-- c 1 1 () :: T ()
	
and it works.


generate c.midi
----------------

	:l src/Snippet
	
	:t render_to
	-- render_to :: FilePath -> Haskore.Melody.T () -> IO ()
	
	render_to "c.midi" $ c 1 1 ()


Warning:

Don't click on the midi file linked below, or any midi links in this guide if you are

1. on windows
2. using firefox
3. installed iTunes / QuickTime

Since, you'll then probably have quicktime as your default player for online midi files, and you are risking yourself being exposed of a crack sound played in highest volume. ( I have this issue on 2 machines with this kind of set up ). A work around is to right click, save as, then play back in a local media player.

Mac is safe and Linux untested.

Try to playback [c.midi](../midi/c/c.midi?raw=true), awesome.

using c.hs
-----------

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
	
and some neat transformers and applications

	dotted, doubleDotted :: T -> T
	dotted       = ((3%+2) *)
	doubleDotted = ((7%+4) *)

	dwn  = dotted wn    -- dotted whole note
	dhn  = dotted hn    -- dotted half note
	dqn  = dotted qn    -- dotted quarter note
	den  = dotted en    -- dotted eighth note
	dsn  = dotted sn    -- dotted sixteenth note
	dtn  = dotted tn    -- dotted thirty-second note
		
	ddhn = doubleDotted hn  -- double-dotted half note
	ddqn = doubleDotted qn  -- double-dotted quarter note
	dden = doubleDotted en  -- double-dotted eighth note
	
Notes other then C
-------------------

from Melody

	note :: Pitch.T -> Duration.T -> attr -> T attr
	note p d' nas = Medium.prim (Music.Atom d' (Just (Note nas p)))
	
	note' :: Pitch.Class -> Pitch.Octave ->
	           Duration.T -> attr -> T attr
	note' = flip (curry note)
	
	cf,c,cs,df,d,ds,ef,e,es,ff,f,fs,gf,g,gs,af,a,as,bf,b,bs ::
	   Pitch.Octave -> Duration.T -> attr -> T attr
	
	cf = note' Cf;  c = note' C;  cs = note' Cs
	df = note' Df;  d = note' D;  ds = note' Ds
	ef = note' Ef;  e = note' E;  es = note' Es
	ff = note' Ff;  f = note' F;  fs = note' Fs
	gf = note' Gf;  g = note' G;  gs = note' Gs
	af = note' Af;  a = note' A;  as = note' As
	bf = note' Bf;  b = note' B;  bs = note' Bs

It's clear we can create any note using these generators.
	
## [C Major](c_major.markdown)