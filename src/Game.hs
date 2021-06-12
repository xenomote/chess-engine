{-# LANGUAGE TupleSections #-}

module Game where

import Board ( Board )
import qualified Board ( initial )

import Piece
import Position

data Chess = Chess {
    player :: Colour,
    board :: Board,
    
    -- this opposing pawn can only be taken en passant this turn
    doubleStepped :: Maybe File,

    -- the king can only castle if the pieces involved haven't moved
    canCastle :: Colour -> Castling -> Bool
}

data Castling = Kingside | Queenside

initial :: Chess
initial = Chess White Board.initial Nothing (\_ _ -> True)

inCheck, inCheckMate :: Chess -> Bool
inCheckMate = null . moves
inCheck = undefined

moves :: Chess -> [Chess]
moves = undefined 

-- list of (infinite) move sequences to be tried in order until they are blocked
movements :: Piece -> [[Move]]
movements (Piece colour kind) = movements kind
    where
        movements Pawn   = [[Move 0 $ if isWhite colour then 1 else -1]]
        movements Bishop = diagonal
        movements Rook   = orthogonal
        movements Queen  = orthogonal ||| diagonal
        movements King   = [[Move x y] |
            x <- [-1 .. 1],
            y <- [-1 .. 1],
            (x, y) /= (0, 0)]
        movements Knight = [[Move x y] |
            a <- [1, -1],
            b <- [2, -2],
            (x, y) <- [(a, b), (b, a)]]

        orthogonal = [
            steps (,0),
            steps (0,),
            steps $ \x -> (-x, 0),
            steps $ \y -> (0, -y)]

        diagonal = [
            steps $ \d -> (d, d),
            steps $ \d -> (-d, d),
            steps $ \d -> (-d, -d),
            steps $ \d -> (d, -d)]

        steps f = map (move . f) [1 ..]

        (x : xs) ||| ys = x : ys ||| xs
        []       ||| ys = ys
