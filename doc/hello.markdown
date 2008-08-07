Hello World
============

The first thing is to output something, anything. So here is the demo file from Haskore, we simply run it.

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

If we ignore all the imports, the meaning is pretty clear. 

* main: It output a `hello.midi` file from a song. 
* song: The song is ( reading from right to left ) a chord, played by a piano, and exported in midi format.

All the source code in each tutorial is inside the src folder, so get this git repo
	
	git clone git://github.com/nfjinjing/haskore-guide.git

and run it.

	cd haskore-guide
	runghc src/hello.hs

This will output `hello.midi` inside current path.

Play [hello.midi](../midi/hello/hello.midi?raw=true)

## [Note C](c.markdown)