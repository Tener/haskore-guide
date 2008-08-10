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
drum = Drum.toMusicDefaultAttr

drum_1 = M.replicate 8 $ M.line [
  drum OpenHiConga qn,
  drum LowConga hn,
  loudness1 0.5 $ drum LowFloorTom qn,
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

drum_2 =  (+:+) sfnr $ loudness1 0.6 $ M.replicate 2 $ M.line . concat $
  [drum_2_var_1, drum_2_var_1, drum_2_var_2, drum_2_var_1] 

drum_track = loudness1 1.5 $ drum_1 =:= drum_2

-- base
base = fs (-2) 12 ()
base_track = loudness1 0.6 $ play_with Cello base

-- guitar_base
guitar_base = M.line $ map (\n -> n 1 (wn + dqn) () +:+ enr) [
  cs, cs, cs, cs, cs, cs, d, cs
  ]

guitar_base_track = accent 0.6 $ play_with AcousticGuitarNylon guitar_base

-- guitar fill
guitar_fill_common = M.line [
  qnr, fs 1 en (), fs 1 en (), enr, fs 1 en (), fs 1 qn (), fs 1 qn ()
  ]

guitar_fill_var_1 = gs 1 qn ()
guitar_fill_var_2 = e 1 qn ()

guitar_fill = M.line $ [
  guitar_fill_common, accent 0.4 guitar_fill_var_1,
  guitar_fill_common, guitar_fill_var_2,
  guitar_fill_common, accent 0.3 guitar_fill_var_1,
  guitar_fill_common, guitar_fill_var_2,
  guitar_fill_common, accent 0.4 guitar_fill_var_1,
  guitar_fill_common, guitar_fill_var_2
  ] ++ P.concat (P.replicate 2 [guitar_fill_common, guitar_fill_var_2])
  
guitar_fill_track = loudness1 0.9 $ play_with AcousticGuitarNylon guitar_fill
  
-- helper
drum_enum = export_to' "wow_3" 1 $ M.line $ map (\d ->  Drum.toMusicDefaultAttr d en) MIDI.drums
wow_2 = export_to' "wow_3" 2 $ changeTempo 3 $ flute_track =:= drum_track
wow_3 = export_to' "wow_3" 3 $ changeTempo 3 $ chord [flute_track, drum_track, base_track] 
wow_4 = export_to' "wow_3" 4 $ changeTempo 3 $ chord [flute_track, drum_track, base_track, guitar_base_track] 
wow_5 = export_to' "wow_3" 5 $ changeTempo 3 $ chord
  [flute_track, drum_track, base_track, guitar_base_track, guitar_fill_track]

drum_test = export_to' "wow_3" 9 $ changeTempo 3 $ guitar_fill_track

main = do
  drum_enum
  wow_2
  wow_3
  wow_4
  wow_5
  drum_test

