{-# OPTIONS_GHC -fno-warn-orphans #-}
module Party where
import Employee
import Data.Monoid
import Data.Tree

-- Exercise 1
glCons :: Employee -> GuestList -> GuestList
glCons e@(Emp _ ef) (GL es f) = GL (e:es) (f + ef)

instance Monoid GuestList where
  mempty                        = GL [] 0
  mappend (GL as af) (GL bs bf) = GL (as ++ bs) (af + bf)

moreFun :: GuestList -> GuestList -> GuestList
moreFun a b
  | a > b     = a
  | otherwise = b

-- Exercise 2
treeFold :: b -> (a -> [b] -> b) -> Tree a -> b
treeFold e f (Node x []) = f x [e]
treeFold e f (Node x xs) = f x [treeFold e f y | y <- xs]

-- Exercise 3
nextLevel :: Employee -> [(GuestList, GuestList)] -> (GuestList, GuestList)
nextLevel b [] = (glCons b mtGL, mtGL)
  where mtGL = GL [] 0
nextLevel b cs = (maxWith, maxWithout)
  where
    maxWithout = mconcat $ map (uncurry max) cs
    maxWith    = glCons b $ mconcat $ map snd cs

-- Exercise 4
maxFun :: Tree Employee -> GuestList
maxFun t = uncurry max $ treeFold (mtGL, mtGL) nextLevel t
  where mtGL = GL [] 0

-- Exercise 5
ppGl :: GuestList -> String
ppGl (GL es f) = "Total fun: " ++ show f ++ "\n" ++ ppEs es
  where ppEs = foldr (\ e cs -> cs ++ empName e ++ "\n") ""

main :: IO ()
main = do
  company <- readFile "company.txt"
  putStr $ ppGl $ maxFun $ read company

