import Control.Applicative 

-- The Applicative law pure f <*> xs === f <$> xs has to hold for it to be an applicative

(.+) = liftA2 (+)
(.*) = liftA2 (*)

n = ([4,5] .* pure 2) .+ [6,1]

-- newtype ZipList' a = ZipList' { getZipList' :: [a] }
  -- deriving (Eq, Show)

-- instance Applicative ZipList' where
  -- pure = ZipList' . repeat
  -- ZipList' fs <*> ZipList' xs = ZipList' (zipWith ($) fs xs)

-- Reader or environment applicative
--instance Functor ((->) e) where
 -- fmap = (.)

-- instance Applicative ((->) e) where
  -- pure = const
  -- f <*> x = \ e -> (f e) (x e)

-- The Applicative API
-- One of the benefits of having a unified interface, like Applicative is that we can
-- write generic tools and control structures that work with any type which is an
-- instance of APplicative.

pair :: Applicative f => f a -> f b -> f (a, b)
-- pair fa fb = (\x y -> (x, y)) <$> fa <*> fb
-- pair' fa fb = (,) <$> fa <*> fb
-- pair'' fa fb = liftA2 (,) fa fb
pair = liftA2 (,)

-- Now, let's think about what this function actually does with different Applicative
-- instances

-- Maybe
-- Nothing, if either of the args is. Otherwise, it's the pair of the two Just values
maybePair = pair (Just [1,2]) (Just False)
-- Just ([1,2], False)

-- []
-- The cartesian product
listPair = pair [1,2,3] [4,5,6]

-- zipList
-- pair is the same as the zip function

-- IO
-- pair runs two IO actions in sequence, returning a pair of their results
ioPair = pair (putStrLn "What is your name?") getLine
-- ((), "Aditya")

-- Parser
-- pair runs two parsers in sequence (the parsers consume consecutive sections 
-- of the input), returning their results as a pair. If either parser fails, 
-- the whole thing fails.

(*>>) :: Applicative f => f a -> f b -> f b
(*>>) fa fb = const id <$> fa <*> fb

-- Maybe
-- if fa is nothing then nothing, otherwise it will be fb
maybe' = Nothing *> Just 5 -- Nothing
maybe'' = Just (* 4) *> Just [1,2,3] -- Just [1,2,3]

-- []
-- For each element of fa elements of fb will be replicated
list' = [False, True, False] *>> [([1], 0), ([4], 3)]

-- IO
-- both io actions will be run but only the second one will be returned
io' = getLine *>> getLine
