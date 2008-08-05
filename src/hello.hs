module GeneratedTest where
import Haskore.Basic.Duration((%+))
import Haskore.Music
import Haskore.Melody.Standard
import Haskore.Music.GeneralMIDI as MidiMusic
import Haskore.Interface.MIDI.Render as Render

main = Render.fileFromGeneralMIDIMusic "hello.midi" song
song = MidiMusic.fromStdMelody MidiMusic.AcousticGrandPiano $ chord
  [changeTempo (2 %+ 3) (line [c 1 (1 %+ 23) na, rest (1 %+ 23)]),
   transpose 3 (line [c 1 qn na, qnr]),
   changeTempo (2 %+ 3) (c 1 (1 %+ 23) na),
   transpose (- 3) (c 1 qn na), changeTempo (7 %+ 1) (rest (1 %+ 23)),
   transpose 4 qnr]
