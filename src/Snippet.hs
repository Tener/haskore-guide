module Snippet where

import Haskore.Music.GeneralMIDI as MidiMusic
import Haskore.Interface.MIDI.Render as Render

-- c_major
render_to f m = Render.fileFromGeneralMIDIMusic f song where
  song = MidiMusic.fromMelodyNullAttr MidiMusic.AcousticGrandPiano m

-- bach's prelude
export_to f v = render_to $ concat ["midi/", f, "/", f, "_", show v, ".midi"]

in_group_of n []       = []
in_group_of n xs       = h : in_group_of n t where (h, t) = splitAt n xs
