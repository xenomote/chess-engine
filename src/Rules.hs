module Rules (
    validMoves, inCheck, inCheckMate
) where

import Data.Maybe

import Board
import Piece
import Position

validMoves :: Board -> Colour -> [Board]
validMoves board activePlayer
  | inCheckMate board activePlayer  = []        -- cannot move
  | inCheck board activePlayer      = undefined -- must defend the check
  | otherwise                       = undefined

{-
king
queen
bishop
knight - not blocked by other pieces
rook
pawn step
pawn double step - only on first move
pawn take
promotion - choose which piece to promote to
en passant - only on the move after a double move
castling - only if the rook and king havent moved, cannot castle through check, can castle with rook under attack
-}

defendingMoves :: Board -> Colour -> [Board]
defendingMoves = undefined

inCheck, inCheckMate :: Board -> Colour -> Bool
inCheck = undefined
inCheckMate board colour = inCheck board colour && null (defendingMoves board colour)