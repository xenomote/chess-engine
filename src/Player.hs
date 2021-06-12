module Player where

import Game

class Monad p => Player p where
    choose :: [g] -> p g