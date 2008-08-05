module Export where

import Snippet

export_to f = render_to ("midi/" ++ f ++ ".midi")