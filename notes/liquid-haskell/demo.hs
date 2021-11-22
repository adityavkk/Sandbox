{-# LANGUAGE ScopedTypeVariables #-}
import Prelude hiding (head, abs, take, tail)

-- A Golden Rule Of Programming

-- Push requirements upstream over pushing problems downstream

-- Implement head :: [a] -> a
head :: [a] -> a
head []    = error "can't the the head of an empty list"
head (x:_) = x

tryHead :: [a] -> Maybe a
tryHead [] = Nothing
tryHead (x:_) = Just x

-- head :: [a] -> a
-- head []    = error "Cannot take head of an empty list"
-- head (x:_) = x

-- tryHead :: [a] -> Maybe a
-- tryHead []    = Nothing
-- tryHead (x:_) = Just x

-- x  = head []
-- x' = tryHead []


-- What if we can make our code safer without any term level code changes by making our type system more expressive


y  = head []
y' = head [12, 13]

{-@ head :: { xs: [a] | 1 <= len xs } -> a @-}

-- deserialize list = if length list == 0 then error "Junk data found" else list
-- head junkListFromJson


-- Refinement Types
-- Refinement types = types + predicates

-- Predicates are drawn from well-behaved logics.
-- We have completely automatic decision procedures that work very fast.

-- SMT Solver - black box that can answer questions in these logics.
-- Completely decideable

-- Grammar

-- b = Int
--   | Bool
--   | Int
--   | ...
--   | a, b, c -- type variables

-- t := { x:b | p } -- refined base
--   | x: t -> t    -- refined function

-- -- predicate in decidable logic
-- p := e       -- atom
--   | e1 == e2 -- equality
--   | e1 < e2  -- ordering
--   | p && p   -- and
--   | p || p   -- or
--   | (not p)  -- negation

-- e := x, y, z
--   | 0, 1, 2
--   | e + e
--   | e - e
--   | c * c
--   | (f e1 .. en) -- uninterpreted function

-- Refinement Logic: QF-UFLIA
-- Quantifier-free Logic of Uninterpreted Functions and Linear Arithmetic

-- The logic that we're in in decideable
-- predicates in our logic: p, q
-- Very efficient algorithms that will decide whether p => q


























-- Why this is even better?

-- Static Vs. Runtime Checks

-- Efficiency vs. Safety

-- No Checks are efficient but not safe

-- Runtime checks can be safe (not really) but aren't efficient and difficult to manage

-- Static Checks are both safe and efficient

{-@ type Nat = { v: Int | 0 <= v } @-}

{-@ nats :: [Nat] @-}
nats :: [Int]
nats = [0, 1, 2, 3, 5, 6, 7, 8, 8, 9, 10, 11, 12, -1]




-- Postconditions

{-@ abs :: Int -> { n : Int | 0 <= n } @-}
abs :: Int -> Int
abs x = if x < 0 then negate x else x



{-@ assume foo :: OrdList a @-}
foo = 1 ::: 5 ::: 2 ::: Empty

{-@ take :: { v: Int | v >= 0 } -> { xs:[a] | v <= len xs } -> { ys: [a] | v == len ys } @-}
take :: Int -> [a] -> [a]
take 0 _  = []
take n xs = head xs : take (n - 1) (tail xs)

{-@ tail :: { xs : [a] | 1 <= len xs } -> { ys: [a] | len xs - 1 == len ys } @-}
tail :: [a] -> [a]
tail (_:xs) = xs

-- Ordered Lists
data OrdList a = Empty | a ::: OrdList a

infixr 9 :::


good = 1 ::: 2 ::: 3 ::: Empty
bad  = 10 ::: 15 ::: 12 ::: Empty

{-@ data OrdList a = Empty | (:::) { hd :: a, tl :: OrdList {v:a | hd <= v}}  @-}

-- Implement Quicksort
quickSort :: (Ord a) => [a] -> OrdList a
quickSort (x:xs) = append lesser x greater
  where
    lesser  = quickSort [y | y <- xs , y < x]
    greater = quickSort [y | y <- xs, y >= x]

{-@ append :: OrdList {v: a | v < x }
              -> x:a
              -> OrdList {v: a | v >= x }
              -> OrdList a
 @-}
append :: Ord a => OrdList a -> a -> OrdList a -> OrdList a
append Empty      z ys = z ::: ys
append (x ::: xs) z ys = x ::: append z xs ys

-- [1, 2, 3] [2, 5, 7] == [1, 2, 3, 2, 5, 7]

-- quickSort           :: (Ord a) => [a] -> OrdList a
-- quickSort []        = Empty
-- quickSort (x:xs)    = append x lessers greaters
--   where
--     lessers         = quickSort [y | y <- xs, y < x ]
--     greaters        = quickSort [z | z <- xs, z >= x]

main = print "done"
