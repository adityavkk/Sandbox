{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}
import ExprT
import Parser
import StackVM

-- Exercise 1
eval :: ExprT -> Integer
eval (ExprT.Mul a b) = eval a * eval b
eval (ExprT.Add a b) = eval a + eval b
eval (Lit a)   = a


-- Exercise 2
isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing _       = False

evalStr :: String -> Maybe Integer
evalStr cs
  | isNothing p = Nothing
  | otherwise = fmap eval p
  where
    p = parseExp Lit ExprT.Add ExprT.Mul cs

-- Exercise 3
class Expr a where
  lit :: Integer -> a
  add :: a -> a -> a
  mul :: a -> a -> a

instance Expr ExprT where
  lit = Lit
  add = ExprT.Add
  mul = ExprT.Mul

-- Exercise 4
instance Expr Integer where
  lit = id
  add = (+)
  mul = (*)

instance Expr Bool where
  lit = (\ n -> not (n <= 0))
  add = (||)
  mul = (&&)

instance Expr MinMax where
  lit                       = MinMax
  add (MinMax a) (MinMax b) = lit $ max a b
  mul (MinMax a) (MinMax b) = lit $ min a b

instance Expr Mod7 where
  lit                   = Mod7 . (`mod` 7)
  add (Mod7 a) (Mod7 b) = lit (a + b)
  mul (Mod7 a) (Mod7 b) = lit (a * b)

newtype MinMax = MinMax Integer deriving (Eq, Show)
newtype Mod7   = Mod7 Integer deriving (Eq, Show)

testExp :: Expr a => Maybe a
testExp = parseExp lit add mul "(3 * -4) + 5"

testInteger = testExp :: Maybe Integer
testBool    = testExp :: Maybe Bool
testMM      = testExp :: Maybe MinMax
testSat     = testExp :: Maybe Mod7

-- Exercise 5
instance Expr Program where
  lit a   = [PushI a]
  add a b = a ++ b ++ [StackVM.Add]
  mul a b = a ++ b ++ [StackVM.Mul]

compile :: String -> Maybe Program
compile cs = parseExp lit add mul cs :: Maybe Program

-- Exercise 6
class HasVars a
