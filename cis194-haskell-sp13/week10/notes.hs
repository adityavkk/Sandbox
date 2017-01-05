-- From LYAH - Applicative functors

-- What happens if we do:
x :: Num a => Maybe (a -> a)
x = fmap (*) (Just 3)
-- We get a Maybe functor with a function inside of it 

-- So, now what can we do with this functor? We can fmap functions that use these
-- internal functions as parameters
x' :: Num a => Maybe a
x' = fmap (\ f -> f 9) x

-- What if we have a functor value of Just (3 *) and one of Just 4, how do we
-- take the fn inside of the first functor and fmap it over the second one?
-- We could mattern match on the first one extract what's inside and fmap it,
  -- but we can generalize this behavior using a typeclass which we call
  -- Applicative

class (Functor f) => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b

-- The class def. tells us that for something to be an applicative it has to first
-- be a functor, then it has to have a pure method and an <*>, apply, method

-- The pure method, should take a vlue of any type and return an applicative functor
-- with that value inside it.

-- The <*> function is sort of a beefed up fmap. It takes a functor with a fn inside of it
-- and another functor and applies that function from the first functor onto
-- the second functor

instance Applicative Maybe where
  pure           = Just
  Nothing <*> _  = Nothing
  (Just f) <*> g = fmap f g

-- Note that the f that plays the role of the applicative functor takes one
-- concrete type as a parameter, that's why we write 
-- instance Applicative Maybe where ... instead of writing 
-- instance Applicative (Maybe a) where

-- ghci> Just (+3) <*> Just 9
-- Just 12 

-- ghci> pure (+3) <*> Just 10
-- Just 13

-- ghci> pure (+) <*> Just 3 <*> Just 5 
-- Just 8
-- ghci> pure (+) <*> Just 3 <*> Nothing
-- Nothing
-- ghci> pure (+) <*> Nothing <*> Just 5
-- Nothing

-- Applicative functors and the applicative style of doing pure f <*> x <*> y ...
-- allow us to take a function that expects parameters that aren't necessarily
-- wrapped in functors and use that function to operate on several values that
-- in functor contexts.

-- The function can take as many parameters as we want, because it's always partially
-- applied step by step between occurences of <*>

-- This becomes even more handy and apparent if we consider the fact that
-- pure f <*> x equals fmap f x, this is one of the applicative laws

-- because of this Control.Applicative exports a function called <$>, which is
-- just fmap as an infix operator. Here is how it's defined
(<$>) :: (Functor f) => (a -> b) -> f a -> f b
f <$> x = fmap f x

-- <$> makes the applicative style really shine, because now if we want to apply
-- a function f between three applicative functors, we can write
-- f <$> x <*> y <*> z, if the parameters weren't applicative functors, but normal
-- values, we'd write f x y z

-- Let's take a look at how lists can be made into applicatives
instance Applicative [] where
  pure f = [f]
  fs <*> xs = [f x | f <- fs, x <- xs]

-- <*> will apply every function in the left list to every value in the right list

-- Let's see how we can make IO an applicative
instance Applicative IO where
  pure = return
  a <*> b = do
    f <- a
    x <- b
    return (f x)

myAction :: IO String
myAction = do
  a <- getLine
  b <- getLine
  return $ a ++ b

myAction' :: IO String
myAction' = (++) <$> getLine <*> getLine

myAction'' :: IO String
myAction'' = pure (++) <*> getLine <*> getLine

-- Another instance of Applicative is (-> ) r, so functions.
instance Applicative ((->) r) where
  pure = const
  f <*> g = \ x -> f x (g x)

-- Applicative Functors from CIS194
type Name = String
data Employee = Employee { name  :: Name
                         , phone :: String }
  deriving Show

-- The Employee constructor has the type
-- Employee :: Name -> String -> Employee

-- Suppose we only have a Maybe Name and a Maybe String and we want a Maybe Employee
-- i.e. a function :
-- (Name -> String -> Employee) -> (Maybe Name -> Maybe String -> Maybe Employee)


