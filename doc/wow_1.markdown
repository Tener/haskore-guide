WOW 1
=====

There will probably be a series of tutorials which lead us to _functionally_ produce various theme music from the world of warcraft.

What is the Music type?
----------------------

We haven't made clear distinctions between the Melody type and Music type:

from Melody

	data Note attr = Note {noteAttrs_ :: attr, notePitch_ :: Pitch.T}
	    deriving (Show, Eq, Ord)

	type T attr = Music.T (Note attr)

Now everything is about the Music type, what is it then? Suppose we are the designer, what should this type do?

It should:

* capture the pitch value, duration, and some note specific attributes ( not used yet )
* be composable both as in line and as in chord, the result is preferably of the same type
* can be apply with effects ( controls ), result of which is preferably of the same type

I'm sure you already have a feeling of what this data type would look like, the definition is well hidden

in Medium.Controlled.List

	data T control content =
	      Primitive content                    -- ^ primitive content
	    | Serial   [T control content]         -- ^ sequential composition
	    | Parallel [T control content]         -- ^ parallel composition
	    | Control  control (T control content) -- ^ controller
	   deriving (Show, Eq, Ord {- for use in FiniteMap -})

everything else just beautifully follows

in Music

	type T note = CtrlMediumList.T Control (Primitive note)
	
	data Control =
	         Tempo      DurRatio        -- scale the tempo
	       | Transpose  Pitch.Relative  -- transposition
	       | Player     PlayerName      -- player label
	       | Phrase     PhraseAttribute -- phrase attribute
	    deriving (Show, Eq, Ord)

back to Medium.Controlled.List

	instance Medium.Construct (T control) where
	   prim = Primitive

	   (+:+) x y = serial   (serialToList   x ++ serialToList   y)
	   (=:=) x y = parallel (parallelToList x ++ parallelToList y)


	   serial   = serial
	   parallel = parallel

	   serial1   = serial
	   parallel1 = parallel

	prim :: a -> T control a
	prim = Primitive

	serialToList, parallelToList :: T control a -> [T control a]

	serialToList (Serial ns) = ns
	serialToList n           = [n]

	parallelToList (Parallel ns) = ns
	parallelToList n             = [n]

	serial, parallel :: [T control a] -> T control a
	serial   = Serial
	parallel = Parallel

in Medium

	class Construct medium where
	   prim :: a -> medium a

	   {- for easy compatibility with Haskore 2000 songs
	      replace :+: by +:+ and :=: by =:= -}
	   (+:+), (=:=) :: medium a -> medium a -> medium a

	   serial, parallel :: Temporal.C a => [medium a] -> medium a
	   serial1, parallel1 :: [medium a] -> medium a

Remember in Melody, there's a `prim` function that construct Music.T note ?

in Melody

	note :: Pitch.T -> Duration.T -> attr -> T attr
	note p d' nas = Medium.prim (Music.Atom d' (Just (Note nas p)))

`note` raises the `Music.Primitive` type constructed from `Music.Atom` to `the Music.T` type, since `Music.T` _transforms to_ (need a better word) `CtrlMediumList.T` which is an instance of Medium. `prim` instantiated in `Medium.Controllel.List` simply put the `Medium.Controllel.List.Primitive` constructor on top of it's parameter, and the circle of type transformation is complete.


What is Midi?
--------------

Instead of reading the specifications, Midi can be think of as those World of Warcraft ( or your favorite RPG here ) 's action bars. You have several action bars ( called channels ) available to you at all time, and different buttons can be placed arbitrarily in each bar ( defining instruments inside a channel ). You then invoke your actions by pressing on the icon ( midi events are send to channels then mapped to instruments and played ).

I could be seriously wrong here, it is a model of thinking works for me.


Changing instruments
---------------------

Recalling that in `render_to` helper, we used `fromMelodyNullAttr` to render melody in piano.

from Snippet
	
	render_to f m = Render.fileFromGeneralMIDIMusic f song where
	  song = MidiMusic.fromMelodyNullAttr MidiMusic.AcousticGrandPiano m

from Music.GeneralMIDI

	import qualified Sound.MIDI.General as GM
	
	type Instr = GM.Instrument

	fromMelodyNullAttr :: Instr -> Melody.T () -> T
	fromMelodyNullAttr = RhyMusic.fromMelodyNullAttr


from Sound.MIDI.General ( this is a cabal package, outside of Haskore )

	data Instrument =
	     AcousticGrandPiano              | BrightAcousticPiano
	   | ElectricGrandPiano              | HonkyTonk
	   | ElectricPiano1                  | ElectricPiano2
	   | Harpsichord                     | Clavinet
	   | Celesta                         | Glockenspiel
	   | MusicBox                        | Vibraphone
	   | Marimba                         | Xylophone
		...
	     deriving (Show, Eq, Ord, Ix, Enum, Bounded)

It now seems too easy to set up an instrument, isn't it.

Tavern Melody
--------------

Let's conclude this tutorial with this little teaser.

some helpers

	play_with = MidiMusic.fromMelodyNullAttr
	render_to' f = Render.fileFromGeneralMIDIMusic f
	export_to' f v = render_to' $ concat ["midi/", f, "/", f, "_", show v, ".midi"]

We want to be able to playback in a higher octave.

in Music

	transpose :: Pitch.Relative -> T note -> T note
	transpose = mkControl Transpose

in Pitch
	
	type Relative = Int
	
in Interval

	unison       =  0
	minorSecond  =  1
	majorSecond  =  2
	minorThird   =  3
	majorThird   =  4
	fourth       =  5
	fifth        =  7
	minorSixth   =  8
	majorSixth   =  9
	minorSeventh = 10
	majorSeventh = 11
	octave       = 12 

Now we have everything we need, let's see the code:

	flute_base = [
	  cs 1 qn, fs 1 qn, fs 1 en, e 1 en, fs 1 hn, gs 1 qn
	  ]

	flute_var_1 = [
	  a 1 qn, b 1 qn, a 1 qn, gs 1 en, fs 1 en, e 1 hn
	  ]

	flute_var_2 = [
	  a 1 qn, e 1 en, cs 1 en, a 1 qn, gs 1 dhn
	  ]

	flute_var_3 = [
	  a 1 qn, fs 1 qn, a 1 qn, b 1 dqn, a 1 en, gs 1 qn, fs 1 dwn
	  ]

	t1 = play_with PanFlute . line $ map (\x -> x ()) $ 
	  concat [
	    flute_base,
	    flute_var_1,
	    flute_base,
	    flute_var_2,
	    flute_base,
	    flute_var_1,
	    flute_var_3
	    ]

	wow_1 = export_to' "wow_1" 1 $ changeTempo 3 $ transpose octave $ t1

Please relax and enjoy this wonderful [melody](../midi/wow_1/wow_1_1.midi?raw=true) :)