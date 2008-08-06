module BachPrelude where

import Haskore.Melody
import Haskore.Music as M
import Haskore.Basic.Duration
import Snippet
import Prelude as P


eight_bar n      = n en ()
eight_bars       = line . map eight_bar

first_period     = eight_bars [c 1, e 1, g 1, c 2, e 2, g 1, c 2, e 2]
prelude_start    = line . map (M.replicate 2)
  
prelude_1        = export_to "prelude" 1 $ prelude_start [first_period]
prelude_2        = export_to "prelude" 2 $ changeTempo 2 $ prelude_start [first_period]

repeat_last_3 xs = xs ++ ( P.reverse $ P.take 3 $ P.reverse xs )

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
  fs(-1), c 0,    a 0,    c 1,    ef 1,
  af (-1),f 0,    b 0,    c 1,    d 1,
  g (-1), f 0,    g 0,    b 0,    d 1,
  g (-1), e 0,    g 0,    c 1,    e 1,
  g (-1), d 0,    g 0,    c 1,    f 1,
  g (-1), d 0,    g 0,    b 0,    f 1,
  g (-1), ef 0,   a 0,    c 1,    fs 1,
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

main = do
  prelude_1
  prelude_2
  prelude_3