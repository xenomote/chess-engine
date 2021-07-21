module Game.Position where

newtype Source = Source Position
newtype Destination = Destination Position
newtype Position = Position (File, Rank)

data File = A | B | C | D | E | F | G | H
data Rank = R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8