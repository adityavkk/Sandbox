{-# LANGUAGE FlexibleContexts #-}
import qualified Data.HashMap.Lazy as H
import Data.Either
import Data.Hashable
import qualified Data.Map as M
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

{- evaluateFunction :: (Num a, Eq a, Enum a, Hashable a) => (a -> Either b ([a], [b] -> b)) -> a -> b -}
{- evaluateFunction f n = f' n -}
  {- where -}
    {- memo    = H.fromList [(n', g $ f' <$> xs) | n' <- [0..]] -}
    {- (xs, g) = fromRight $ f n -}
    {- -- table n = H.insert n (g <$> f' <$> xs) memo -}
    {- f' n -}
      {- | isLeft $ f n = fromLeft $ f n -}
      {- | otherwise    = memo H.! n -}

{- evaluateFunction' :: Ord a => (a -> Either b ([a], [b] -> b)) -> a -> b -}
{- evaluateFunction' f n = case f n of -}
                         {- (Left x)        -> x -}
                         {- (Right (xs, g)) -> g $ evaluateFunction' f <$> xs -}
fib = f'
  where
    memo = map f' [0..]
    f n = memo !! n
    f' n | n < 2 = 2
         | otherwise = f (n - 1) + f (n - 2)

memoized f n = do maybeCached <- liftM (M.lookup n) get
                  case maybeCached of
                    Just value -> return value
                    Nothing    -> do result <- f n
                                     modify (M.insert n result)
                                     return result

evaluateFunction f n =
    evalState (memoized evalInner n) M.empty
    where evalInner n = case f n of
                            Left value            -> return value
                            Right (list, combine) -> liftM combine (mapM (memoized evalInner) list)
