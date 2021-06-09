module Sequence (
    Sequence, next, prev, step, values
) where

import Data.Maybe ()
import Data.List ( find )
import Util ( iteratenM )

class (Ord a, Bounded a, Enum a) => Sequence a where
    next, prev :: a -> Maybe a
    next x = find (> x) values
    prev x = find (< x) $ reverse values

    step :: Int -> a -> Maybe a
    step n
        | n < 0     = iteratenM (-n) prev
        | n > 0     = iteratenM n next
        | otherwise = return

    values :: [a]
    values = [minBound ..]
