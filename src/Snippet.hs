module Snippet where

import Haskore.Music.GeneralMIDI as MidiMusic
import Haskore.Interface.MIDI.Render as Render

import Haskore.Music
import Haskore.Melody
import Haskore.Basic.Pitch
import Data.List as L

render_to f m = Render.fileFromGeneralMIDIMusic f song where
  song = MidiMusic.fromMelodyNullAttr MidiMusic.AcousticGrandPiano m



arrange_melody 1 m1 m2 = [m1, m2, m2]
arrange_melody 2 m1 m2 = [m2, m1, m2]
arrange_melody 3 m1 m2 = [m2, m2, m1]
  
combine_melody         = line . L.intersperse hnr
make_test n m1 m2      = combine_melody $ arrange_melody n m1 m2


pitch_line = line . map ( \x -> x o en () ) where o = 1 :: Octave
