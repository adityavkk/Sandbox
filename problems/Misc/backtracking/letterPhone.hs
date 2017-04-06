combine :: [String] -> [String]
combine [] = [[]]
combine (xs:xxs)
  | null xxs  = map pure xs
  | otherwise = concatMap (\ x -> (map (x:) (combine xxs))) xs
