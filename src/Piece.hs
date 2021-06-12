module Piece (
    Colour(..), opposite, isWhite, isBlack,
    Kind(..), isKing, isQueen, isPawn, isRook, isKnight, isBishop,
    Piece(..), sameColour, sameKind,
) where

data Colour = White | Black
    deriving (Eq, Read, Show)

isWhite, isBlack :: Colour -> Bool
isWhite = (==) White
isBlack = (==) Black

opposite :: Colour -> Colour
opposite White = Black
opposite Black = White

data Kind = King | Queen | Bishop | Knight | Rook | Pawn 
    deriving (Eq, Read, Show)

isKing, isQueen, isPawn, isRook, isKnight, isBishop :: Kind -> Bool
isKing = (==) King
isQueen = (==) Queen
isBishop = (==) Bishop
isKnight = (==) Knight
isRook = (==) Rook
isPawn = (==) Pawn

data Piece = Piece {
    colour::Colour,
    kind::Kind
}
    deriving (Eq, Read, Show)

sameColour, sameKind :: Piece -> Piece -> Bool
sameColour x y = colour x == colour y 
sameKind x y = kind x == kind y