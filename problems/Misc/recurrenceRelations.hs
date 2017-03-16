{-# LANGUAGE FlexibleContexts #-}

import qualified Data.HashMap.Lazy as H
import Data.Either
import Data.Hashable
import Control.Monad
import Control.Monad.State

f :: Ord a => a -> Either b ([a], [b] -> b)
f = undefined

fromLeft (Left x)   = x
fromRight (Right x) = x

factorial i | i == 0    = Left 1
            | otherwise = Right ([i - 1], (*i) . head)

fibonacci i | i < 2     = Left i
            | otherwise = Right ([i - 1, i - 2], sum)

coinchange (a, i)   | a == 0          = Left 1
                    | a < 0 || i == 0 = Left 0
                    | otherwise       = Right ([(a, i-1), (a-coinlist!!(i-1), i)], sum)
coinlist = [1, 3, 5, 10]

evaluateFunction :: (Ord a, Hashable a) =>
  (a -> Either b ([a], [b] -> b))
  -> a -> b
evaluateFunction f n = evalState (cache f' n) H.empty
  where
    f' a = case f a of
             Left v           -> return v
             Right (xs, oper) -> oper <$> sequence (cache f' <$> xs)

cache :: (MonadState (H.HashMap k v) m, Ord k, Hashable k) => 
  (k -> m v) ->
  k ->
  m v
cache g n = do
  memo <- H.lookup n <$> get
  case memo of
    Just v -> return v
    _      -> do
                r <- g n
                modify (H.insert n r)
                return r


-- Check state for key, n, if found return it in state monad
-- Otherwise, call evalInner with key, n, which then calls f n
-- If f n is Left val -> return val in state monad
  -- else combine mapping (memoized evalInner) onto the list from Right
-- Modify state with the result stored with key
