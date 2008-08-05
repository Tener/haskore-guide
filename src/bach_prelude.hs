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

prelude_2 = export_to "prelude" 2 $ changeTempo 2 $ prelude_start [first_period]