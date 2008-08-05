Goal
=====

From now on, I'll be building music pieces used for some music-potential test targeted at small children. Each piece consists of 3 parts, and only one part is different from the rest.

As usual, we build a helper that makes two different parts into a single test case

	module Snippet where

	import Haskore.Music
	import Haskore.Melody
	import Haskore.Basic.Pitch
	import Data.List as L

	arrange_melody 1 m1 m2 = [m1, m2, m2]
	arrange_melody 2 m1 m2 = [m2, m1, m2]
	arrange_melody 3 m1 m2 = [m2, m2, m1]

	combine_melody         = line . L.intersperse hnr
	make_test n m1 m2      = combine_melody $ arrange_melody n m1 m2
	
And a helper to combine pitches

	pitch_line = map ( \x -> x o qn () ) where o = 1 :: Octave
	
Let's play with it

	ghci src/Snippet.hs
	
	render_to "test.midi" $ make_test 2 (pitch_line [c,d,c]) (pitch_line [c,d,e])

Now we have a one liner to generate simple music test :)