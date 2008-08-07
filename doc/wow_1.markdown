WOW 1
=====

This will probably be a series of tutorials which leads us to _functional_ produce the some theme music from the world of warcraft.

What is Music.T type?
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
	* can be apply to effects ( controls ), result of which is preferably of the same type

I'm sure you already have a feeling of what this data type would look like, the definition is actually well hidden

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
	
	control :: Control -> T note -> T note
	control ctrl = CtrlMedium.control ctrl
	
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
	
and the Construct class

in Medium

	class Construct medium where
	   prim :: a -> medium a

	   {- for easy compatibility with Haskore 2000 songs
	      replace :+: by +:+ and :=: by =:= -}
	   (+:+), (=:=) :: medium a -> medium a -> medium a

	   serial, parallel :: Temporal.C a => [medium a] -> medium a
	   serial1, parallel1 :: [medium a] -> medium a
	

What is Midi?
--------------

Instead of reading the specifications, Midi can be think of World of Warcraft ( or your favorite RPG here ) 's action bars. You have several action bars ( called channels ) available to you at all time, and different action buttons can be placed arbitrarily in each action bar ( defining instruments inside a channel ). You then invoke your action bar by pressing it ( midi events are send to channels then mapped to instruments and played ).

I could be seriously wrong here, but it's a model to think that works for me.


Changing instruments
---------------------

Recalling that in `render_to` helper, we used `fromMelodyNullAttr` to render melody in an instrument

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

It seems to be too easy now to change an instrument, isn't it.

Let's conclude this tutorial with this little teaser.