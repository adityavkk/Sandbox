-- We've already seen how to define a folding function for lists, but we can
-- generalize the idea to other data types as well!

data Tree a = Empty
            | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

-- Lets look at the following patterns of operations on trees

treeDepth :: Tree a -> Integer
treeDepth Empty        = 0
treeDepth (Node l _ r) = 1 + max (treeDepth l) (treeDepth r)

-- Or flattening the elements of the tree into a list?

flatten :: Tree a -> [a]
flatten Empty        = []
flatten (Node l x r) = flatten l ++ [x] ++ flatten r

-- We can abstract away the pattern of doing something when tree is empty
-- and combining the result of recursively calling the function on the left
-- and right sub trees and combining the results with the value of the current
-- node based on some combining function f

treeFold :: b -> (b -> a -> b -> b) -> Tree a -> b
treeFold e _ Empty = e
treeFold e f (Node l x r) = f (treeFold e f l) x (treeFold e f r)

-- Lets see how we can define the above functions in terms of the tree fold

treeDepth' :: Tree a -> Integer
treeDepth' = treeFold 0 f
  where f ld _ rd = 1 + max ld rd

flatten' :: Tree a -> [a]
flatten' = treeFold [] (\ l v r -> concat [l, [v], r])

-- We can write new tree-folding functions easily as well
treeMax :: (Ord a, Bounded a) => Tree a -> a
treeMax = treeFold minBound (\l v r -> l `max` v `max` r)

-- Folding Expressions
-- We can write folds over other data types

data ExprT = Lit Integer
           | Add ExprT ExprT
           | Mul ExprT ExprT

eval :: ExprT -> Integer
eval (Lit i)     = i
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2

exprTFold :: (Integer -> b) -> (b -> b -> b) -> (b -> b -> b) -> ExprT -> b
exprTFold f _ _ (Lit i)     = f i
exprTFold f g h (Add e1 e2) = g (exprTFold f g h e1) (exprTFold f g h e2)
exprTFold f g h (Mul e1 e2) = h (exprTFold f g h e1) (exprTFold f g h e2)

eval2 :: ExprT -> Integer
eval2 = exprTFold id (+) (*)

-- because we've defined a fold over ExprT, we can do other things with the
-- ExprT aside from just evaluate them

numLiterals :: ExprT -> Integer
numLiterals = exprTFold (const 1) (+) (+)

-- The fold for data type T will take one (higher-order) argument for each of T's
-- constructors, encoding how to turn the values stored by that constructor into
-- a value of the result type.
-- Many of the functions we might want to write on T will end up being expressible
-- as simple folds.

-- Monoids
class Monoid m where
  mempty  :: m
  mappend :: m -> m -> m

  mconcat :: [m] -> m
  mconcat = foldr mappend mempty

(<>) :: Monoid m => m -> m -> m
(<>) = mappend

-- (<>) is defined as a synomym for mappend

-- TYpes which are instances of Monoid have a special element called mempty, and
-- a binary operation mappend which takes two values of the type and produces
-- another one. The intention is that mempty is an identity for <>

-- Monoids show up everywhere.

-- Lists form a monoid under concatenation:
instance Monoid [a] where
  mempty  = []
  mappend = (++)

-- Integers, in fact, all numbers form a monoid under addition, but also 
-- under multiplication.
-- However, since we can't define 2 different instances of the same type class
-- to the same type, we create two newtypes, one for each instance:

newtype Sum a = Sum a
  deriving (Show, Eq, Ord, Num)

getSum :: Sum a -> a
getSum (Sum a) = a

newtype Product a = Product a
  deriving (Show, Eq, Ord, Num)

getProduct :: Product a -> a
getProduct (Product a) = a

instance Num a => Monoid (Sum a) where
  mempty  = Sum 0
  mappend = (+)

instance Num a => Monoid (Product a) where
  mempty  = Product 0
  mappend = (*)

-- Pairs form a monoid as long as the individual components do:
instance (Monoid a, Monoid b) => Monoid (a, b) where
  mempty                  = (mempty, mempty)
  (a, b) `mappend` (c, d) = (a `mappend` c, b `mappend` d)

-- Bool forms a monoid under (||), (&&), (==) and (\=)
newtype All a = All a
  deriving (Show, Bool)

newtype Any a = Any a
  deriving (Show, Bool)

instance (Bool a) => Monoid (Any a) where
  mempty  = Any False
  mappend (Any a) (Any b)= Any (a || b)

instance (Bool a) => Monoic (All a) where
  mempty  = All True
  mappend (All a) (All b)= All (a && b)


