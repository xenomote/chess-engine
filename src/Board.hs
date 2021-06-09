module Board (
    Board, at, start
) where

import Data.List ( find )

import Sequence

import Piece

import Position

type Board = [(Piece, Position)]

at :: Board -> Position -> Maybe Piece
board `at` position = fst <$> find ((== position) . snd) board

start :: Board
start = 
    black back `row` R8 ++ 
    black front `row` R7 ++ 
    white front `row` R2 ++
    white back `row` R1

    where
        row pieces rank = zip pieces $ map (`Position` rank) (values :: [File])
        back = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
        front = 8 `replicate` Pawn
        white = map (Piece White)
        black = map (Piece Black)