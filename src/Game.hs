{-# LANGUAGE TupleSections #-}

module Game where

import Board

import Util
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
moves state = filter inCheck moves
    where
        moves = undefined
        
        pieces = side active . board $ state
        active = player state
        next = state {
            player = opposite active,
            doubleStepped = Nothing
        }

-- list of (infinite) move sequences to be tried in order until they are blocked
movements :: Piece -> [[Move]]
movements (Piece colour kind) = movements kind
    where
        movements Pawn   = [[Move 0 $ if isWhite colour then 1 else -1]]
        movements King   = map (take 1) cardinal
        movements Queen  = cardinal
        movements Bishop = diagonal
        movements Rook   = orthogonal
        movements Knight = [[Move x y] |
            a <- [1, -1],
            b <- [2, -2],
            (x, y) <- [(a, b), (b, a)]]

-- list of (infinite) move sequences to be tried in order until there is a capture
captures :: Piece -> [[Move]]
captures (Piece colour Pawn) = [[Move x $ if isWhite colour then 1 else -1] | x <- [1, -1]]
captures piece = movements piece

-- vertical and horizontal movements, starting right, anticlockwise
orthogonal :: [[Move]]
orthogonal = [
    steps (,0),
    steps (0,),
    steps $ \x -> (-x, 0),
    steps $ \y -> (0, -y)]

-- diagonal movements, starting up right, anticlockwise
diagonal :: [[Move]]
diagonal = [
    steps $ \d -> (d, d),
    steps $ \d -> (-d, d),
    steps $ \d -> (-d, -d),
    steps $ \d -> (d, -d)]

-- both diagonal, vetical and horizontal movements, starting right, anticlockwise
cardinal :: [[Move]]
cardinal = orthogonal ||| diagonal

-- generate an infinite sequence of moves based on a sequence nubmer
steps :: (Int  -> (Int, Int)) -> [Move]
steps f = map (Position.move . f) [1 ..]

{-

king move & take
queen move & take
bishop move $ take
knight move & take - not blocked
rook move & take

pawn move
pawn double step - only from initial position
pawn take - only when piece available
en passant - only immediately after the pawn double stepped
promotion - only when pawn reaches the rear rank

castling - only if the king and castle have not moved

-}