module Wow2 where

import Haskore.Melody
import Haskore.Music as M
import Haskore.Basic.Duration as D
import Haskore.Basic.Duration
import Snippet
import Prelude as P
import Haskore.Music.GeneralMIDI hiding (drum)
import Haskore.Basic.Interval
import Haskore.Composition.Drum  as Drum
import Sound.MIDI.General as MIDI

-- flute
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
    b 1 dqn, a 1 en, staccato en . (gs 1 qn), fs 1 dwn
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

flute_track = transpose octave $ play_with PanFlute $ line flute

-- drums
drum_enum = export_to' "wow_3" 1 $ M.line $ map (\d ->  Drum.toMusicDefaultAttr d en) MIDI.drums

drum = Drum.toMusicDefaultAttr

drum_1 = M.replicate 8 $ M.line [
  drum OpenHiConga qn,
  drum LowConga hn,
  accent (- 0.3) $ drum LowFloorTom qn,
  drum LowConga hn
  ]

drum_2_var_1 = [
  drum LowBongo dqn,
  drum LowBongo dqn,
  drum LowBongo hn,
  enr,
  drum LowConga en
  ]
  
drum_2_var_2 = [
  drum LowBongo en
  ] ++ P.replicate 5 (drum LowConga en) ++ [
  drum LowBongo hn,
  rest (1 %+ 12),
  drum LowConga (2 %+ 12)
  ]

drum_2 =  (+:+) sfnr $ accent (- 0.2) $ M.replicate 2 $ M.line . concat $
  [drum_2_var_1, drum_2_var_1, drum_2_var_2, drum_2_var_1] 

drum_track = accent (- 0.1) $ drum_1 =:= drum_2

wow_2 = export_to' "wow_3" 2 $ changeTempo 3 $ flute_track =:= drum_track


-- base
base = M.replicate 16 $ play_with Cello $ fs (-2) 3 ()
base_track = accent (- 0.2) base

wow_3 = export_to' "wow_3" 3 $ changeTempo 3 $ chord [flute_track, drum_track, base_track] 

-- helper
drum_test = export_to' "wow_3" 9 $ changeTempo 3 base
main = do
  drum_enum
  wow_2
  wow_3
  drum_test

