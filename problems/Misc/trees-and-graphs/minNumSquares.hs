{-# LANGUAGE FlexibleContexts #-}
import qualified Data.HashMap.Lazy as H
import           Data.Hashable
import           Control.Monad.State

-- DP Approach
f x
  | perfSq x  = Left 1
  | otherwise = Right ([x - z^2 | z <- [1..intY]], minimum . map (+1))
  where y        = sqrt (fromIntegral x)
        intY     = floor y :: Int

        perfSq :: Int -> Bool
        perfSq x = intY^2 == x

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
