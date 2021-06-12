module Position (
    File(..),
    Rank(..),
    Position(..),
    Move(..), move, to, from,
) where

import Sequence ( Sequence, step )

data File = A | B | C | D | E | F | G | H
    deriving (Eq, Ord, Bounded, Enum,  Show, Read)

data Rank = R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8
    deriving (Eq, Ord, Bounded, Enum, Show, Read)

instance Sequence File
instance Sequence Rank

data Position = Position {
    file :: File,
    rank :: Rank
}
    deriving (Eq, Show, Read)

data Move = Move {
    filediff :: Int,
    rankdiff :: Int
}
    deriving (Eq, Show, Read)

move :: (Int, Int) -> Move
move (x, y) = Move x y

to :: Position -> Position -> Move
Position f1 r1 `to` Position f2 r2 = Move (f2 - f1) (r2 - r1)
    where a - b = fromEnum a Prelude.- fromEnum b

from :: Move -> Position -> Maybe Position
Move x y `from` Position f r = do 
    f <- step x f
    r <- step y r
    return $ Position f r