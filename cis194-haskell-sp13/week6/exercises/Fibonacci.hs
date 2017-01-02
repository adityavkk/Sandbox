{-# LANGUAGE FlexibleInstances, FlexibleContexts #-}
import Data.List

-- Exercise 1
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibs1 :: [Integer]
fibs1 = map fib [0..]

-- Exercise 2
fibs2 = scanl (+) 0 (1:fibs2)

fib2 :: [Integer]
fib2 = f 0 1
  where
    f a b = (b + a) : f b (b + a)

-- Exercise 3
data Stream a = Cons a (Stream a)
instance Show a => Show (Stream a) where
  show = show . take 20 . streamToList

-- f = map snd . filter g . zip [1..]
  -- where
    -- g (x, _) = x `mod` 1 == 0

streamToList :: Stream a -> [a]
streamToList (Cons x y) = x : streamToList y

-- Exercise 4
s = streamRepeat 4

streamRepeat :: a -> Stream a
streamRepeat a = Cons a (streamRepeat a)

streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Cons a b) = Cons (f a) (streamMap f b)

streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f z = Cons z (streamFromSeed f nz)
  where
    nz = f z

-- Exercise 5
nats :: Stream Integer
nats = streamFromSeed (+ 1) 0

pis = streamFromSeed (+ 1) 1

-- w/o interleave streams
ruler' :: Stream Integer
ruler' = streamMap f pis
  where
    f n
      | even n    = foldl (\ r m -> if n `mod` 2^m == 0 then m else r) 1 [2..iroot n + 1]
      | otherwise = 0

iroot = floor . sqrt . fromIntegral

-- with interleave streams
interleaveStreams :: Stream a -> Stream a -> Stream a
interleaveStreams (Cons a a') b = Cons a $ interleaveStreams b a'

g n = interleaveStreams (streamRepeat n) (g (n + 1))
ruler = g 0

-- Exercise 6
x :: Stream Integer
x = Cons 0 $ Cons 1 $ streamRepeat 0

streamZip (Cons a a') (Cons b b') = Cons (a, b) $ streamZip a' b'

instance Num (Stream Integer) where
  fromInteger                       = flip Cons $ streamRepeat 0
  negate                            = streamMap negate
  (+) a b                           = streamMap (uncurry (+)) $ streamZip a b
  (*) a@(Cons a0 a') b@(Cons b0 b') = Cons (a0 * b0) $ streamMap (* a0) b' + (a' * b)

instance Fractional (Stream Integer) where
  (/) a@(Cons a0 a') b@(Cons b0 b') = Cons (a0 `div` b0) $ streamMap (`div` b0) (a' - qb')
    where qb' = (a / b) * b'

fibs3 :: Stream Integer
fibs3 = x / (1 - x - x^2)

-- Exercise 7
data Matrix a = Mat a a a a
  deriving Show

instance (Num a) => Num (Matrix a) where
  (*) (Mat m1 m2 m3 m4) (Mat n1 n2 n3 n4) = Mat (m1 * n1 + m2 * n3)
                                                (m1 * n2 + m2 * n4)
                                                (m3 * n1 + m4 * n3)
                                                (m3 * n2 + m4 * n4)

fib4 :: Integer -> Integer
fib4 0 = 0
fib4 n = fibn
  where fibn = case m^n of
                 (Mat _ _ x _) -> x
        m :: Matrix Integer
        m = Mat 1 1 1 0


