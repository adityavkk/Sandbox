-- Given an array arr[] of n integers, construct a Product Array prod[] 
-- (of same size) such that prod[i] is equal to the product of all the elements 
-- of arr[] except arr[i]. Solve it without division operator and in O(n).

f :: [Int] -> [Int]
f xs = [pre !! i * post !! i | i <- [0..length xs - 1]]
  where
    pre = prefixProd xs
    post = postfixProd xs

prefixProd :: [Int] -> [Int]
prefixProd = reverse . fst .
                foldl (\ (pres, last) x -> (last : pres, last * x))
                      ([], 1)

postfixProd :: [Int] -> [Int]
postfixProd = fst .
                foldr (\ x (posts, last) -> (last : posts, last * x))
                      ([], 1) 

