module Game.Outputs where

import Game.Position

data Board = Board {
    white :: [(Piece, Position)],
    black :: [(Piece, Position)]
}

data Piece
    = King
    | Queen
    | Bishop
    | Knight
    | Rook
    | Pawn