Goal
=====

Suppose we want to build music pieces for some music-potential test. Each piece will consist 3 parts, and only one part is different from the rest.

As usual, we build a helper that makes two different parts into a single test case

	module Goal where

	import Haskore.Music
	import Haskore.Melody
	import Haskore.Basic.Pitch
	import Haskore.Basic.Duration
	import Data.List as L

	import Snippet

	-- goal
	arrange_melody 1 m1 m2 = [m1, m2, m2]
	arrange_melody 2 m1 m2 = [m2, m1, m2]
	arrange_melody 3 m1 m2 = [m2, m2, m1]
  
	combine_melody         = line . L.intersperse hnr
	make_test n m1 m2      = combine_melody $ arrange_melody n m1 m2

And a helper to combine pitches

	pitch_line = line . map ( \x -> x o en () ) where o = 1 :: Octave
	
Let's play with it

	ghci -isrc src/goal.hs
	
	render_to "test.midi" $ make_test 2 (pitch_line [c,d,c]) (pitch_line [c,d,e])

Now we have a one liner to generate [simple music test](../midi/goal/goal.midi?raw=true) :)


Rest
-----

You may have noticed the usage of `hnr`.

from Music

	rest :: Dur -> T note
	rest d' = prim (Atom d' Nothing)
	
	bnr, wnr, hnr, qnr, enr, snr, tnr, sfnr :: T note
	dwnr, dhnr, dqnr, denr, dsnr, dtnr      :: T note
	ddhnr, ddqnr, ddenr                     :: T note
	
	bnr   = rest Duration.bn     -- brevis rest
	wnr   = rest Duration.wn     -- whole note rest
	hnr   = rest Duration.hn     -- half note rest
	qnr   = rest Duration.qn     -- quarter note rest
	enr   = rest Duration.en     -- eight note rest
	snr   = rest Duration.sn     -- sixteenth note rest
	tnr   = rest Duration.tn     -- thirty-second note rest
	sfnr  = rest Duration.sfn    -- sixty-fourth note rest
	
	dwnr  = rest Duration.dwn    -- dotted whole note rest
	dhnr  = rest Duration.dhn    -- dotted half note rest
	dqnr  = rest Duration.dqn    -- dotted quarter note rest
	denr  = rest Duration.den    -- dotted eighth note rest
	dsnr  = rest Duration.dsn    -- dotted sixteenth note rest
	dtnr  = rest Duration.dtn    -- dotted thirty-second note rest
	
	ddhnr = rest Duration.ddhn  -- double-dotted half note rest
	ddqnr = rest Duration.ddqn  -- double-dotted quarter note rest
	ddenr = rest Duration.dden  -- double-dotted eighth note rest

The meaning is clear, a note can be silenced and it becomes a rest note.

	rest d' = prim (Atom d' Nothing)

This tells us that a rest note is applying `prim` on a result of the `Atom` constructor.

	data Primitive note =
          	Atom Dur (Atom note) -- a note or a rest
     	deriving (Show, Eq, Ord)

So the Atom constructor creates a Primitive note. However, this constructor is extremely confusing, since `Atom` is not only used as a data type constructor ( as in former ), but also a type alias ( as in latter ).

	type Atom note = Maybe note
	
Finally `prim` is defined in 
	
	class Construct medium where
	   prim :: a -> medium a


FIXME: How `prim` converts a Primitive note into a Music.T note ?

## [Bach's Prelude 1 in C Major](bach_prelude.markdown)