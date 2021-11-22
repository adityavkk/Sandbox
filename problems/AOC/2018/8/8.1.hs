import System.Environment

tryHead []     = Nothing
tryHead (x:xs) = Just x

tryGet i = tryHead . drop (i - 1)

splitBy a xs = y:ys
    where (y, ys) = foldr (\ x (ys, xxs) -> if x == a then ([], ys:xxs) else (x:ys, xxs)) ([], []) xs

toInts :: String -> [Int]
toInts = map read . splitBy ' '

mapFst f (a, b) = (f a, b)
mapSnd f (a, b) = (a, f b)

data Tree a = Empty | Node [Tree a] [a] 
    deriving Show

parse :: [Int] -> Tree Int
parse [] = Empty
parse (c:d:xs) = let (children, rest) = parseChildren c d xs in Node children $ take d rest

parseChildren :: Int -> Int -> [Int] -> ([Tree Int], [Int])
parseChildren _ _ []  = ([Empty], [])
parseChildren n d [md] = ([Node [] [md]], [])
parseChildren n d rest@(c:d':xs)
    | n == 0    = ([], rest) 
    | otherwise = (Node firstsChildren firstsMetadata:restChildren, rest''')
        where 
            (firstsChildren, rest') = parseChildren c d' xs
            (firstsMetadata, rest'') = splitAt d' rest'
            (restChildren, rest''') = parseChildren (n - 1) d rest''
    
dfs :: Maybe (Tree Int) -> Int
dfs Nothing  = 0
dfs (Just Empty) = 0
dfs (Just (Node [] mds)) = sum mds
dfs (Just (Node cs mds)) = sum $ map (dfs . (flip tryGet cs)) mds

isNothing (Nothing) = true
isNothing _ = false

getTail :: [Int] -> [Int]
getTail = let maybeHead = tryHead xs in if isNothing maybeHead then xs else tail xs

getToken :: [Int] -> (Maybe Int, [Int])
getToken xs = (tryHead xs, getTail xs)

repeat :: Int -> ([Int] -> (Maybe Int, [Int])) -> ([Int] -> [Maybe Int], [Int])
repeat n parser x = go x n 
    where
        go x 0 = ([], x)
        go x n = let (x', xs) = getToken x in mapFst (x':) $ go xs (n - 1)

main = do
    i <- readFile "./input"
    print $ dfs $ Just $ parse $ toInts i