C major
========

There is a class of functions in Haskore that deal with chords, but we won't touch them yet.

Basic note combinators
----------------------

A naive approach is just some how make `[c, e, g]` sort of a melody, since that's what C major is. Duck typing would rock here :)

Questions:

* Do we play all the notes together or one by one?


from Music

	(+:+), (=:=) :: T note -> T note -> T note
	infixr 7 +:+  {- like multiplication -}
	infixr 6 =:=  {- like addition -}

This vaguely seems to be what we are looking for.

	ghci src/Snippet.hs
	
	:m + Haskore.Music Haskore.Melody
	
	c_major = map (\x - > x 1 qn () ) [c, e, g]
	c_serial = foldl1 (+:+) c_major
	c_parallel = foldl1 (=:=) c_major
	
	render_to "c_major_serial.midi" c_serial
	render_to "c_major_parallel.midi" c_parallel
	
You can verify that this works as expected.

Higher level helpers
----------------------

from Music

	line, chord :: [T note] -> T note
	line  = serial
	chord = parallel

Can this be the helper that does what we just did? The answer is yes. In c_major.hs we have 

	c_major = map (\x -> x 1 qn () ) [c, e, g]
	c_parallel = chord c_major
	
It works exactly the same as folding on `(=:=)`.

Neat :)