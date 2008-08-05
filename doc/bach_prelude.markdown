Bach's Prelude 1 in C Major
===========================

Believe it or not, we have everything we need to generate Bach's Prelude. The reason to choose it is because there's is no change of dynamic or rhythm inside the song, which is perfect for this demonstration.

Output to Web
--------------

We first create a helper to generate midi files accessible from the web.

	export_to f v = render_to $ concat ["midi/", f, "/", f, "_", show v, ".midi"]


Prelude Helper
---------------

Prelude has repetitions and we want to take advantage of this pattern.

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

	prelude_1 = export_to "prelude" 1 $ prelude_start [first_period]


[prelude_1](../midi/prelude/prelude_1.midi?raw=true) seems to be too slow.


Fix tempo
----------

from Music

> changeTempo :: DurRatio -> T note -> T note

> changeTempo = mkControl Tempo

It seems to do what we want, but does it increase the tempo or decrease it?

Let's try it out

	prelude_2 = export_to "prelude" 2 $ changeTempo 2 $ prelude_start [first_period]

[prelude_2](../midi/prelude/prelude_2.midi?raw=true) now has a faster tempo, which tells us that the DurRatio parameter increases the tempo.


The Complete Prelude
---------------------

I save you the effort of translating Prelude from the sheet to the DSL we are using.

some helpers as usual

	in_group_of n []       = []
	in_group_of n xs       = h : in_group_of n t where (h, t) = splitAt n xs
	
	repeat_last_3 xs = xs ++ ( P.reverse $ P.take 3 $ P.reverse xs )

whole music

	rest_period = map eight_bars $ map repeat_last_3 $ in_group_of 5 [
	  c 1,    d 1,    a 1,    d 2,    f 2,
	  b 0,    d 1,    g 1,    d 2,    f 2,
	  c 1,    e 1,    g 1,    c 2,    e 2, 
	  c 1,    e 1,    a 1,    e 2,    a 2,
	  c 1,    d 1,    fs 1,   a 1,    d 2, 
	  b 0,    d 1,    g 1,    d 2,    g 2,
	  b 0,    c 1,    e 1,    g 1,    c 2,
	  a 0,    c 1,    e 1,    g 1,    c 2,
	  d 0,    a 0,    d 1,    fs 1,   c 2,
	  g 0,    b 0,    d 1,    g 1,    b 1,
	  g 0,    bf 0,   e 1,    g 1,    cs 2,
	  f 0,    a 0,    d 1,    a 1,    d 2,
	  f 0,    af 0,   d 1,    f 1,    b 1,
	  e 0,    g 0,    c 1,    g 1,    c 2,
	  e 0,    f 0,    a 0,    c 1,    f 1,
	  d 0,    f 0,    a 0,    c 1,    f 1,
	  g (-1), d 0,    g 0,    b 0,    f 1,
	  c 0,    e 0,    g 0,    c 1,    e 1,
	  c 0,    g 0,    bf 0,   c 1,    e 1,  

	  f (-1), f 0,    a 0,    c 1,    e 1,
	  f (-1), c 0,    a 0,    c 1,    ef 1,
	  af (-1),f 0,    b 0,    c 1,    d 1,
	  g (-1), f 0,    g 0,    b 0,    d 1,
	  g (-1), e 0,    g 0,    c 1,    e 1,
	  g (-1), d 0,    g 0,    c 1,    f 1,
	  g (-1), d 0,    g 0,    b 0,    f 1,
	  g (-1), ef 0,   a 0,    c 1,    f 1,
	  g (-1), e 0,    g 0,    c 1,    g 1,
	  g (-1), d 0,    g 0,    c 1,    f 1,
	  g (-1), d 0,    g 0,    b 0,    f 1,
	  c (-1), c 0,    g 0,    bf 0,   e 1
	  ]

	prelude_end = eight_bars [
	  c (-1), c 0,    f 0,    a 0,    c 1,    f 1,    c 1,    a 0,
	  c 1,    a 0,    f 0,    a 0,    f 0,    d 0,    f 0,    d 0,
	  c (-1), b (-1), g 0,    b 0,    d 1,    f 1,    d 1,    b 0,
	  d 1,    b 0,    g 0,    b 0,    d 0,    f 0,    e 0,    d 0
	  ]

	prelude_conclude = chord $ map (\n -> n wn ()) [c (-1), c 0, e 1, g 1, c 2]
	prelude_full     = line [ prelude_start (first_period : rest_period), prelude_end, prelude_conclude ]
	prelude_3        = export_to "prelude" 3 $ changeTempo 2 $ prelude_full

Please relax and [enjoy](../midi/prelude/prelude_3.midi?raw=true)