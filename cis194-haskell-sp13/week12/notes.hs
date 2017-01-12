-- Lecture Notes
-- Motivation
-- We've seen how the Applicative class allows us to idiomatically handle 
-- computations which take place in some sort of "special context"
-- For instance, taking into account possible failure with Maybe, multiple
-- possible outputs with [], consulting some sort of environment using ((->) e)

-- However, so far we've only seen computations with a fixed structure, such as
-- applying a data constructor to a fixed set of arguments. What if we don't know
-- the structure of the computation in advance, - that is, we want to be able to
-- decide what to do based on some intermediate results

-- Supose we are trying to parse a file containing a sequence of numbers,
-- like this: 4 78 19 3 44 3 1 7 5 2 3 2
-- The catch is that the first number in the file tells us the length of a
-- following "group" of numbers; the next number after the group is the length
-- of the next group, and so on.

-- We need to write a parser for this file format of type
parseFile :: Parser [[Int]]
parseFile = undefined

-- This is not possible using only the Applicative interface. The problem is
-- that the Applicative gives us no way to decide what to do next based on
-- previous results; we must decide in advance what parsing operations we are
-- going to run, before we see the results.

-- The Parser type can support this sort of pattern, which is abstracted into
-- the Monad type classs.

class Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  m1 >> m2 = m1 >>= \_ -> m2

-- return looks familiar because it has the same type as pure.
-- In fact, every Monad sould also be an Applicative, with pure = return
-- The reason we have both is that the Applicative was invented after Monad
-- had already been around for a while

-- (>>) is just a specialized version of (>>=)

-- (>>=) :: m a -> (a -> m b) -> m b
-- is pronounced "bind" and its where all the action is
-- It takes two arguments. The first one is a value of type m a (a monadic value)
  -- they are not monads, m, the type constructor is a monad.

-- The idea is that a mobit, or monadic value, of type m a represents a computation
-- which results in a value (or several values, or no values) of type a, and may
-- also have some sort of effect:
  -- c1 :: Maybe a is a computation which might fail but results in an a if it passes
  -- c2 :: [a] is a computation which results in (multiple) as
  -- c3 :: Parser a is a computation which implicitly consumes part of a String and
    -- (possibly) produces an a
  -- c4 :: IO a is a computation which potentially has some I/O effects and
    -- then produces an a

-- The second argument to (>>=) is a function of type (a -> m b).
-- It's a function which will choose the next computation to run based on the result(s)
-- of the first computation. This is precisely what embodies the promised power of Monad
-- to encapusulate computations which can choose what to do next based on the results
-- of previous computations.

-- (>>=) puts together two mobits to produce a larger one, which first runs one and then
-- the other, reaturning the result of the second one.
-- The all-important twist is that we get to decide which mobit to run second 
-- based on the output from the first

-- Examples
instance Monad Maybe where
  return          = Just
  Nothing >>= _  = Nothing
  (Just x) >>= k = k x

-- return, of course, is Just. If the first argument of (>>=) is Nothing, 
-- then the whole computation fails; otherwise, if it is Just x, we apply the 
-- second argument to x to decide what to do next.

check :: Int -> Maybe Int
check n | n < 10    = Just n
        | otherwise = Nothing

halve :: Int -> Maybe Int
halve n | even n    = Just $ n `div` 2
        | otherwise = Nothing

ex01 = return 7 >>= check >>= halve
ex02 = return 12 >>= check >>= halve
ex02 = return 12 >>= halve >>= check

instance Monad [] where
  return x = [x]
  xs >>= k = concatMap k xs

addOneOrTwo :: Int -> [Int]
addOneOrTwo x = [x+1, x+2]

ex04 = [10, 20, 30] >>= addOneOrTwo

-- Monad combinators
-- Onlyusing return and (>>=) we can build up nice general combinators
-- for programming with monads

-- Sequence
-- sequence takes a list of monadic values and produces a single monadic value
-- which collects the results. What this means depends on the particular monad.
-- Int he case of Maybe, it means that the entire computation succeeds only if
-- all the individual ones do; in the case of IO it means to run all the computations
-- in sequence; in the case of Parser it means to run all the parsers on sequential
-- parts of the input (and succeed only if they all do)

sequence :: Monad m => [m a] -> m [a]
sequence [] = return []
sequence (ma:mas) = ma >>= \ a ->
  sequence mas >>= \ as -> return (a:as)

replicateM :: Monad m => Int -> m a -> m [a]
replicateM n m = sequence (replicate n m)

-- Now, we can do what we wanted to do in the begining
parseFile :: Parser [[Int]]
parseFile = zeroOrMore parseLine

parseLine :: Parser [Int]
parseLine = parseInt >>= \i -> replicateM i parseInt
