module CMajor where

import Haskore.Melody
import Haskore.Music
import Haskore.Basic.Duration
import Snippet

c_major = map (\x -> x 1 qn () ) [c, e, g]

c_serial = foldl1 (+:+) c_major
c_parallel = chord c_major

main = do
  render_to "c_major_serial.midi" c_serial
  render_to "c_major_parallel.midi" c_parallel