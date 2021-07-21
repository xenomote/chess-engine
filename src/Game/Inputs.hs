module Game.Inputs where

import Game.Position

data Input
    = Choose Move
    | Undo
    | Resign

data Move
    = Move Source Destination
    | Promote Source Destination Promotion
    | Castle Side

data Promotion
    = Queen
    | Rook
    | Knight
    | Bishop

data Side
    = Kingside
    | Queenside