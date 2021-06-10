module Board (
    Board, on, place, remove, move, empty, initial,
) where

import Data.List ( find )
import Data.Function ((&))
import Control.Arrow ( Arrow((&&&)), (>>>) )

import Sequence ( Sequence(values) )
import Position ( Rank(R1, R8, R7, R2), Position(Position) )
import Piece ( Colour(Black, White), Kind(Pawn, King, Queen, Bishop, Knight, Rook), Piece(Piece) )

type Board = [(Piece, Position)]

on :: Position -> Board -> Maybe Piece
position `on` board = fst <$> find ((== position) . snd) board

place :: Piece -> Position -> Board -> Board
place piece position board = (:) (piece, position) $ remove position board

remove :: Position -> Board -> Board
remove position = filter ((/= position) . snd)

move :: Position -> Position -> Board -> Board
move a b = (on a &&& remove a) >>> (\(piece, board) -> board &
    case piece of 
        Nothing -> id
        Just piece -> place piece b
    )

empty :: Board
empty = []

initial :: Board
initial =
    black back `row` R8 ++
    black front `row` R7 ++
    white front `row` R2 ++
    white back `row` R1

    where
        row pieces rank = zip pieces $ map (`Position` rank) values
        back = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
        front = 8 `replicate` Pawn
        white = map (Piece White)
        black = map (Piece Black)