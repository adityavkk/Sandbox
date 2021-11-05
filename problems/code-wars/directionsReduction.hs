-- Approach:
--    fold over dirs with f and build the reduced dirs
--      - f d rDirs = if d is inverse of head of rDirs, then return the tail of rDirs, else: prepend d to rDirs
-- reverse the result of the fold
data Direction = North | East | West | South deriving (Eq, Show)

dirReduce :: [Direction] -> [Direction]
dirReduce dirs = reverse $ foldl f [] dirs
    where 
        f [] d = [d]
        f rDirs@(d':rest) d = if inverse d d' then rest else d:rDirs
        inverse North South = True
        inverse South North = True
        inverse East West   = True
        inverse West East   = True
        inverse _ _         = False

          
---------------- TEST CASES -----------------------

test1 = [     ]             `shouldBe` [     ]
test2 = [North]             `shouldBe` [North]
test3 = [North, West]       `shouldBe` [North,West]      
test4 = [North, West, East] `shouldBe` [North]
test5 = [North, West, South, East] `shouldBe` [North, West, South, East]
test6 = [North, South, South, East, West, North, West] `shouldBe` [West]
test7 = [North, South, South, East, West, North]       `shouldBe` []

shouldBe x y = x == y

main = putStrLn $ [test1, test2, test3, test4, test5, test6, test7]