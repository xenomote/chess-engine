module Search where

class Search m where
    expand :: m -> [m]

terminal :: Search m => m -> Bool
terminal = null . expand

