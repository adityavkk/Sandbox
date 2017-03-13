-- Functors
-- Kinds
-- Just as every expression has a type, types themselves have "types", called kinds.
-- Every type which can serve as a type has a kind of *
-- Int has kind *
-- Char has kind *
-- Bool has kind *
-- Maybe Bool has kind *

-- Maybe itself is, in a sense, a function on types - we call it a type constructor
-- which takes one type and returns another type
-- Maybe has kind * -> *
-- For instance, Maybe can take as Input Int :: * and produce Maybe Int :: *

-- Tree, or the list type constructor, written [] have kind * -> *
-- for instance, if we were to ask ghci :k [] Int we get
-- [] Int :: *
-- [Int] is special syntax for [] Int

-- What about type constructors with other kinds? How about JoinList from Homework 7?

data JoinList m a = Empty
                  | Single m a
                  | Append m (JoinList m a) (JoinList m a)
-- Prelude> :k JoinList
-- JoinList :: * -> * -> *

-- Here's another one:
-- :k (->)
-- (->) :: * -> * -> *
-- This tells us that the function type constructor takes two type arguments and
-- returns another type and as any operator, we use it infix

-- Higher-order type constructors
data Funny f a = Funny a (f a)

-- Funny takes a f which takes a type and returns another type and a type, a,
-- :k Funny
-- Funny :: (* -> *) -> * -> *

-- Functor
-- The essence of the mapping pattern we saw was a higher-order function with a
-- type like
thingMap :: (a -> b) -> f a -> f b
-- where f is a type variable standing in for some type of kind * -> *

-- since thingMap has to work differently under the hood for each type f we define
-- a type class traditionally called a Functor

class Functor f where
  fmap :: (a -> b) -> f a -> f b

-- Nore that the Functor class abstracts over types of kind * -> *, so it would make
-- no sense to for type Int to be a Functor

-- instance Functor Int where
  -- fmap = ...
-- the above would throw a kind-mismatch error

-- However, we can make Maybe an instance of Functor and on lists
instance Functor Maybe where
  fmap _ Nothing  = Nothing
  fmap g (Just a) = Just (g a)

instance Functor [] where
  fmap _ [] = []
  fmap g (x:xs) = g x : fmap xs
  -- or just map :)

-- Would IO make sense as an instance of functor? sure, IO is a type constructor
-- with kind * -> *
-- So, what would fmap over IO a do?
-- fmap :: (a -> b) -> IO a -> IO b
-- It would run IO a then apply (a -> b) to its result and wraps it back up in an IO

instance Functor IO where
  fmap f ioa = ioa >>= (\ a -> return (f a))

-- or
instance Functor IO where
  fmap f ioa = ioa >>= (return . f)


