module Util where

import Control.Monad


-- apply a function to an argument n times
iteraten :: Int -> (a -> a) -> a -> a
iteraten n f = (!! n) . iterate f

-- apply a monadic function to a pure value n times
iteratenM :: Monad m => Int -> (a -> m a) -> a -> m a
iteratenM n f = (!! n) . iterate (>>= f) . return

-- interleave two lists item by item
(|||) :: [a] -> [a] -> [a]
(x : xs) ||| ys = x : ys ||| xs
[]       ||| ys = ys

-- take elements from a list of maybes while they are non-nothing
takeWhileJust :: [Maybe a] -> [a]
takeWhileJust (Just x : xs) = x : takeWhileJust xs
takeWhileJust xs = []

-- get the first non-nothing element of a list of maybes
firstJust :: [Maybe a] -> Maybe a
firstJust = msum

takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive p [] = []
takeWhileInclusive p (x : xs) = x : if p x 
    then takeWhileInclusive p xs 
    else []

whenJust :: a -> Maybe b -> Maybe a
x `whenJust` (Just _) = Just x
x `whenJust` Nothing = Nothing

invert :: Maybe a -> Maybe ()
invert (Just _) = Nothing
invert Nothing = Just ()