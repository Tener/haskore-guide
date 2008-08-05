Bach's Prelude 1 in C Major
===========================

Believe it or not, we have everything we need to generate Bach's Prelude. The reason to choose it is because there's is no change of dynamic or rhythm inside the song, which is perfect for this demonstration.

Output to Web
--------------

We first create a helper to generate midi file accessible from the web.

	export_to f v = render_to $ concat ["midi/", f, "/", f, "_", show v, ".midi"]


Prelude Helper
---------------

Prelude has periodic repetition, we want to take advantage of this pattern

in Music

> replicate :: Int -> T note -> T note

> replicate n m = line (List.replicate n m)


First try
----------

	module BachPrelude where

	import Haskore.Melody
	import Haskore.Music as M
	import Haskore.Basic.Duration
	import Snippet
	
	
	eight_bar n = n en ()
	eight_bars = line . map eight_bar

	first_period = eight_bars [c 1, e 1, g 1, c 2, e 2, g 1, c 2, e 2]

	prelude_start = line . map (M.replicate 2)

	prelude_1 = export_to "prelude" "prelude_1" $ prelude_start [first_period]


[prelude_1](../midi/prelude/prelude_1.midi?raw=true) seems to be too slow.


Fix tempo
----------


from Music

> changeTempo :: DurRatio -> T note -> T note

> changeTempo = mkControl Tempo

It seems to do what we want, but does it increase the tempo or decrease it?

Let's try it out

	prelude_2 = export_to "prelude" 2 $ changeTempo 2 $ prelude_start [first_period]

[prelude_2](../midi/prelude/prelude_2.midi?raw=true) now has a faster tempo, which tells us that tempo ratio and tempo rate are proportional.



