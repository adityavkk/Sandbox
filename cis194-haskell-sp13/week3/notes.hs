-- Recursion Patterns
data IntList = Empty | Cons Int IntList
  deriving Show

-- Map
absAll :: IntList -> IntList
absAll Empty = Empty
absAll (Cons x xs) = Cons (abs x) (absAll xs)

mapIntList :: (Int -> Int) -> IntList -> IntList
mapIntList _ Empty = Empty
mapIntList f (Cons x xs) = Cons (f x) (mapIntList f xs)

absAll' = mapIntList abs

-- Polymorphic Data Types
data List t = E | C t (List t)

-- data List t = ... means that the List type is parametrized by a type, in
-- much the same way that a function can be parametrized by some input

lst3 :: List Bool
lst3 = C True (C False E)

-- If some condition is really guarentted, then the types ought to reflect the
-- guarantee! Then the compiler can enforce your guarantees fo you.

data NonEmptyList a = NEL a [a]
  deriving Show

nelToList :: NonEmptyList a -> [a]
nelToList (NEL x xs) = x:xs

listToNel :: [a] -> Maybe (NonEmptyList a)
listToNel [] = Nothing
listToNel (x:xs) = Just $ NEL x xs

headNEL :: NonEmptyList a -> a
headNEL (NEL a _) = a

tailNEL :: NonEmptyList a -> [a]
tailNEL (NEL _ as) = as


