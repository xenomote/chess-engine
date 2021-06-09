module Util (
    iteraten, iteratenM
) where

-- apply a function to an argument n times
iteraten :: Int -> (a -> a) -> a -> a
iteraten n f = (!! n) . iterate f

-- apply a monadic function to a pure value n times
iteratenM :: Monad m => Int -> (a -> m a) -> a -> m a
iteratenM n f = (!! n) . iterate (>>= f) . return