module Wow2 where

import Haskore.Melody
import Haskore.Music as M
import Haskore.Basic.Duration as D
import Haskore.Basic.Duration
import Snippet
import Prelude as P
import Haskore.Music.GeneralMIDI
import Haskore.Basic.Interval

-- version 1

flute_base' = [
  cs 1 qn, staccato en . (fs 1 qn), fs 1 en, e 1 en, fs 1 hn, fs 1 en, staccato dsn . (gs 1 en)
  ]

flute_var_1' = [
  a 1 qn, b 1 qn, a 1 qn, gs 1 en, fs 1 en, e 1 hn
  ]
  
flute_var_2' = [
  a 1 qn, e 1 en, cs 1 en, a 1 qn, gs 1 dhn
  ]
  
flute_var_3' = [
  a 1 qn, fs 1 qn, staccato en . (a 1 qn), b 1 dqn, a 1 en, staccato en . (gs 1 qn), fs 1 dwn
  ]

flute' = map (\x -> x ()) $ 
  concat [
    flute_base',
    flute_var_1',
    flute_base',
    flute_var_2',
    flute_base',
    flute_var_1',
    flute_var_3'
    ]

t1' = play_with PanFlute $ line flute'
wow_2_1 = export_to' "wow_2" 1 $ changeTempo 3 $ transpose octave $ t1'



-- version 2

flute_accent_high = accent 0.2
flute_accent_low  = accent 0.1

flute_base = [
  flute_accent_high . (cs 1 qn), staccato en . (fs 1 qn), fs 1 en, e 1 en, fs 1 hn, fs 1 en, staccato dsn . (gs 1 en)
  ]

flute_var_1 = [
  flute_accent_low . (a 1 qn), b 1 qn, a 1 qn, gs 1 en, fs 1 en, e 1 hn
  ]

flute_var_2 = [
  a 1 qn, e 1 en, cs 1 en, a 1 qn, gs 1 dhn
  ]

flute_var_3 = [
  flute_accent_low . (a 1 qn),  fs 1 qn, staccato en . (a 1 qn), 
    flute_accent_high . (b 1 dqn), a 1 en, staccato en . (gs 1 qn), fs 1 dwn
  ]

flute = map (\x -> x ()) $ 
  concat [
    flute_base,
    flute_var_1,
    flute_base,
    flute_var_2,
    flute_base,
    flute_var_1,
    flute_var_3
    ]

t1 = play_with PanFlute $ line flute
wow_2_2 = export_to' "wow_2" 2 $ changeTempo 3 $ transpose octave $ t1





main = do
  wow_2_1
  wow_2_2