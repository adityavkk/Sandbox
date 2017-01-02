-- Enumeration Types
data Thing = Shoe
           | Ship
           | SealingWax
           | Cabbage
           | King
  deriving Show

-- Shoe, Ship, SealingWax etc. are the only values of type Thing
-- deriving Show tells GHC to automatically generate default code for converting
-- Things to Strings. This is what GHC uses when printing the value of stuff

shoe :: Thing
shoe = Shoe

listO'Things :: [Thing]
listO'Things = [Shoe, SealingWax, King, Cabbage, King]

isSmall :: Thing -> Bool
isSmall Ship = False
isSmall King = False
isSmall _    = True

-- Enumerations are only special cases of algebriac data types
data FailableDouble = Failure
                    | Okay Double
  deriving Show
-- This says that FailableDouble has 2 data constructors.
-- Failure takes no arguments, so Failure by itself is a value of type FailableDouble
-- The second one, Okay takes an argument of type Double. So Okay by itself is not a
-- value of type FailableDouble; we need to give it a Double.
-- For Instance Okay 3.4 is a value of type FailableDouble

ex01 = Failure
ex02 = Okay 3.2

safeDiv :: Double -> Double -> FailableDouble
safeDiv _ 0 = Failure
safeDiv x y = Okay (x / y)

failing = safeDiv 5 0 -- Failure
pass    = safeDiv 5 2 -- OK 2.5

failureToZero :: FailableDouble -> Double
failureToZero Failure = 0
failureToZero (Okay d)  = d
-- Both Failure and Okay are data constructors so you can pattern match with them

shouldBeZero   = failureToZero failing
shouldBeDouble = failureToZero pass

-- Data constructors can have more than one argument.
data Person = Person String Int Thing
  deriving Show

aditya :: Person
aditya = Person "Aditya" 26 Cabbage

arun :: Person
arun = Person "Arun" 30 SealingWax

getAge :: Person -> Int
getAge (Person _ a _) = a

-- Notice how the type constructor and the data constructor are both named
-- Person. This is possible because they inhabit different namespaces 
-- This is a common idiom.

-- data AlgDataType = Constr1 Type11 Type12
--                  | Constr2 Type21
--                  | Constr3 Type31 Type32 Type33
--                  | Constr4

-- This implies that data dype AlgDataType can be constructed in 4 different ways
-- using different arguments for each one of the constructors
-- Note: type and data constructor names must always start with a capital letter

-- Pattern Matching
-- Fundamentally, pattern-matching is about taking apart a value by finding ou
-- which constructor it was built with. This information can then be used to decide
-- what to do in different scenarios, indeed in Haskell, this is the only way to
-- make a decision?!

-- Note that literal values like 5 and 'a' can be thought of as constructors with
-- no arguments that collectively define the types Int and Char respectively
-- i.e. you can think of Int being defined as
-- data Int = 0 | 1 | -1 | 2 | -2 etc.
-- data Char = 'a' | 'b' | 'c' etc.

-- Case Expressions
-- The fundamental construct for doing pattern-matching in Haskell is the case expression
-- In general, a case expression looks like

ex03 = case "Hello" of
          []      -> 3
          ('H':s) -> length s
          _       -> 7

-- Recursive data types
data HomeBrewedString = Empty
                      | Cons Char HomeBrewedString
  deriving Show

homebrewedString = Cons 'a' (Cons 'b' (Cons 'c' Empty))

head' :: HomeBrewedString -> Char
head' (Cons a _) = a

tail' :: HomeBrewedString -> HomeBrewedString
tail' (Cons _ Empty) = Empty
tail' (Cons a ss) = ss

data IntList = EmptyInt
             | ConsInt Int IntList
  deriving Show

myList = (ConsInt 5 (ConsInt 6 EmptyInt))
car (ConsInt a _) = a
cdr (ConsInt a b) = b

intListSum EmptyInt = 0
intListSum (ConsInt n ns) = n + intListSum ns

oneTo5 = ConsInt 1 (ConsInt 2 (ConsInt 3 (ConsInt 4 (ConsInt 5 EmptyInt))))
sumOfOneTo5 = intListSum oneTo5

data Tree = Leaf Char
          | Node Tree Char Tree
  deriving Show

aLeaf = Leaf 'a'
bLeaf = Leaf 'b'

binTree :: Tree
binTree = Node aLeaf 'c' (Node bLeaf 'd' aLeaf)

