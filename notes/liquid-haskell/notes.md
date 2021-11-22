# Liquid Haskell


## The Golden Rule of Programming
*Prefer pushing requirements upstream over pushing problems downstream*

Example:

```hs
-- Pushing the problem downstream. Deferred solving the problem
-- head :: [a] -> Maybe a

-- Pushing the requirement upstream
{-@ head :: { xs : [a] | len xs >= 1 } -> a @-}
head :: [a] -> a
head (x:_) = x

-- Compile time
example = head []
```

We can make our code safer and more robust without making any term level code.

Philosophy of LH is to push the fix upstream to make the type system more expressive

you can think of as an extension to Haskell's type system

turn runtime bounds checks into static compile time checks

## Refinement Types
Refinement types = _types_ + _predicates_

Predicates are drawn from well-behaved logics. We have completely automatic decision proceders that work very fast.

SMT Solver - black box that can answer questions in these logics. Completely decideable

### Grammar

b := Int
  | Bool
  | Int
  | ...
  | a, b, c -- type variables

t := { x:b | p } -- refined base
  | x: t -> t    -- refined function

-- predicate in decidable logic
p := e       -- atom
  | e1 == e2 -- equality
  | e1 < e2  -- ordering
  | p && p   -- and
  | p || p   -- or
  | (not p)  -- negation

e := x, y, z
  | 0, 1, 2
  | e + e
  | e - e
  | c * c
  | (f e1 .. en) -- uninterpreted function

Refinement Logic: QF-UFLIA
Quantifier-free Logic of Uninterpreted Functions and Linear Arithmetic

The logic that we're in in decideable
predicates in our logic: p, q
Very efficient algorithms that will decide whether p => q

Examples:
- Natural Numbers
    ```hs
    {-@ type Nat = { v: Int | 0 <= v }@-}

    ```

