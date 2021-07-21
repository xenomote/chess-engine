module Game.Manager where

import Control.Concurrent.Chan

import Game.Inputs
import Game.Outputs

manager :: Chan Input -> Chan Board -> IO ()
manager = undefined 

current :: Chan a -> IO a
current = fmap last . getChanContents