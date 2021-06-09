module Rules (
    moves, inCheck, inCheckMate
) where

import Board
import Piece

moves :: Board -> Colour -> [Board]
moves board activePlayer
  | inCheckMate board activePlayer  = []        -- cannot move
  | inCheck board activePlayer      = undefined -- defend the check
  | otherwise                       = undefined -- normal moves

inCheck, inCheckMate :: Board -> Colour -> Bool
inCheck = undefined
inCheckMate = undefined