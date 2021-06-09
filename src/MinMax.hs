module MinMax (

) where

class MinMaxable m where
    -- expand all options from the given state
    expand :: m p -> [m p]

    -- indicate the active player of the given state
    active :: m p -> p

    -- estimate the value of the board state
    estimate :: m p -> Int

terminal :: MinMaxable m => m p -> Bool
terminal = null . expand

data Player = A | B | C 
    deriving (Eq)

data Node p = N p Int 
    deriving (Eq)

instance MinMaxable Node where
    expand (N a i) = [N a (i+1), N a (i-1)]
    active (N a i) = a
    estimate (N a i) = i
