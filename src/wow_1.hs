module Wow1 where

import Haskore.Melody
import Haskore.Music as M
import Haskore.Basic.Duration as D
import Haskore.Basic.Duration
import Snippet
import Prelude as P
import Haskore.Music.GeneralMIDI
import Haskore.Basic.Interval

flute_base = [
  cs 1 qn, fs 1 qn, fs 1 en, e 1 en, fs 1 hn, fs 1 en, gs 1 en
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

main = wow_1