-- Higher Order Programming and Type Inference

-- Anonymous Functions
greaterThan100 :: [Int] -> [Int]
greaterThan100 = filter (\x -> x > 100)

greaterThan100' = filter (> 100)

-- Function Composition

-- Write down a function whose type is:
-- (b -> c) -> (a -> b) -> (a -> c)

-- We need a function which takes a function, f :: (b -> c) and another function
-- g :: (a -> b) and returns another function h :: (a -> c)

h :: (b -> c) -> (a -> b) -> (a -> c)
h f g = (\a -> f (g a))

-- h is really function composition and in Haskel we can use . to compose f and g
-- if we look at the type of (.) we find that the type is actually what we set out
-- to get 
-- (.) :: (b -> c) -> (a -> b) -> a -> c

-- But wait a minute what happened to the last set of parens around (a -> c)

-- Currying and partial application
-- All functions in Haskell take only one argument.

-- Note that function arrows associate to the right, that is:
-- W -> X -> Y -> Z is equivalent to W -> (X -> (Y -> Z))
  -- We can always add or remove parens around the rightmost top-level arrow

-- Function application, in turn, is left-associative.
-- f 3 2 is really short hand for (f 3) 2
-- We apply f to 3 which returns another function that takes 2 
-- We can abbreviate (f 3) 2 as f 3 2 giving us a nice notation for f as a
-- 'multi-argument' function.

-- The 'multi-argument' lambda abstraction
\ x y z -> x + y + z
-- Is really just syntax sugar for
\ x -> (\ y -> (\ z -> x + y + z))
-- Likewise, the function definition
f x y z = x + y + z
-- is just sugar for
f = \ x -> (\ y -> (\ z -> x + y + z))

-- The standard library defines two functions called curry and uncurry
curry :: ((a, b) -> c) -> a -> b -> c
uncurry :: (a -> b -> c) -> (a, b) -> c

-- Uncurry in particular can be useful when you have a pair and want to apply
-- a function to it. For instance:
x = uncurry (+) (2, 3)

-- Note that Haskell doesn't make it easy to partially apply to an argument other
-- than the first. With the execption of infix operators. There is an art to
-- deciding the order of arguments to a function to make partial applications of it
-- as useful as possible: the arguments shoul dbe ordered from
-- "least to greatest variation", that is, arguments which will often be the same
-- shoul dbe listed first, and arguments which will often be different should
-- come last.

-- Wholemeal programming
foobar:: [Integer] -> Integer
foobar []     = 0
foobar (x:xs)
  | x > 3     = (7 * x + 2) + foobar xs
  | otherwise = foobar xs

-- This seems straightforward enough, but it is not good Haskell style. The
-- problem is that it is:
-- Doing too much at once; and
-- working at too low of a level

-- Instead of thinking about what we want to do with each element, we can instead
-- think about making incremental transformations to the entire input, using the
-- existing recursion patterns that we know of. Here's a more idiomatic
-- implementation of foobar

foobar :: [Integer] -> Integer
foobar = sum . map ((+ 2) . (* 7)) . filter (> 3)

-- This style of coding in which we define functions without referencing its
-- arguments - in some sense saying what a function is as opposed to what it does
-- is known as point-free style.

-- Folds
sum' :: [Int] -> Int
sum' [] = 0
sum' (x:xs) = x + sum xs

product' :: [Int] -> Int
product' [] = 1
product' (x:xs) = x * product xs

length' :: [a] -> Int
length' [] = 0
length' (x:xs) 1 + length xs

fold :: b -> (a -> b -> b) -> [a] -> b
fold z f [] = z
fold z f (x:xs) = f x (fold z f xs)

-- Notice how fold essentially replaces [] with z and (:) with f, that is,
  -- fold f z [a, b, c] = a `f` (b `f` (c `f` z))

sum''     = fold 0 (+)
product'' = fold 1 (*)
length''  = fold 0 (const (1 +))

-- foldr f z [a,b,c] == a `f` (b `f` (c `f` z))
-- foldl f z [a,b,c] == ((z `f` a) `f` b) `f` c
