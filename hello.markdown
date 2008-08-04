Hello World
============

The first thing is to output something, anything. So here is the demo file from Haskore, we simply run it.

	module GeneratedTest where
	import Haskore.Basic.Duration((%+))
	import Haskore.Music
	import Haskore.Melody.Standard
	import Haskore.Music.GeneralMIDI as MidiMusic
	import Haskore.Interface.MIDI.Render as Render
	main = Render.fileFromGeneralMIDIMusic "test.mid" song
	song = MidiMusic.fromStdMelody MidiMusic.AcousticGrandPiano $ chord
	  [changeTempo (2 %+ 3) (line [c 1 (1 %+ 23) na, rest (1 %+ 23)]),
	   transpose 3 (line [c 1 qn na, qnr]),
	   changeTempo (2 %+ 3) (c 1 (1 %+ 23) na),
	   transpose (- 3) (c 1 qn na), changeTempo (7 %+ 1) (rest (1 %+ 23)),
	   transpose 4 qnr]

If we ignore all the imports, the meaning is pretty clear. 

main: It output a `test.mid` file form a song. 

song: The song is ( reading from right to left ) a chord, played by a piano, and exported in midi format.

Why not trying to playback the generated `test.mid` now?