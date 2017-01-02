-- More Polymorphism and Type Classes
-- Haskell’s particular brand of polymorphism is known as parametric 
-- polymorphism. Essentially, this means that polymorphic functions must work 
-- uniformly for any input type.

-- Haskell does not have anything like Java's instanceof operator: it is not possible
-- to ask what type something is and decide ehat to do based on the answer.
-- One reason for this ist htat Haskell types are reased by the compiler after being
-- checked: at runtime, there is no type information around to query!

-- Sometimes it can be really useful to be able to decide what to do based on types!
-- For instance, what about addition? We've already seen that addition is polymorphic
-- It works on Int, Integer, and Double, but clearly it has to know what type of
-- numbers it is adding. How does it do this?

-- Type Classes
-- Num, Eq, Ord and Show are type classes, and we say that the following:
-- (==), (<), (+)
-- Are all type class polymorphic.

-- Lets have a closer look at the Eq type class
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
-- We can read this as follows: Eq is declared to be a type class with a single
-- parameter, a. Any type a which wants to be an instance of Eq must define two
-- function (==) and (/=), with the indicated type signatures.

-- Let's make our own type and declare an instance of Eq for it.

data Foo = F Int | G Char

instance Eq Foo where
  (F i1) == (F i2) = i1 == i2
  (G c1) == (G c2) = c1 == c2
  _ == _           = False

  foo1 /= foo2 = not (foo1 == foo2)

-- As it turns out, Eq (along with a few other standard type classes) is special:
-- GHC is able to automatically generate instances of Eq for us. Like so:
data Foo' = F' Int | G' Char
  deriving (Eq, Ord, Show)

-- A type class example
class Listable a where
  toList :: a -> [Int]

-- Let's make some instnaces of the type class Listable.
instance Listable Int where
  toList x = [x]

instance Listable Bool where
  toList True  = [1]
  toList False = [0]

instance Listable [Int] where
  toList = id

data Tree a = Empty | Node a (Tree a) (Tree a)

instance Listable (Tree Int) where
  toList Empty        = []
  toList (Node x l r) = toList l ++ [x] ++ toList r

instance (Listable a, Listable b) => Listable (a, b) where
  toList (x, y) = toList x ++ toList y

-- Notice how we can put type class constraints on an instance as well as on a
-- function type. This says that a pair type (a, b) is an instance of Listable
-- as long as a and b both are. Then we get to use toList on values of types a
-- and b in ourdefinition of toList for a pair.
-- Notice, however, that this is not necessarily a recursive definition of toList
-- because toList can call other implementations of toList on each tuple value
