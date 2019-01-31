-- `f :: Pattern -> NatsToUse -> LastNatUsed -> Int`
-- if the pattern is empty return 1
-- if `lastNatUsed` is `Nothing`, call `f` with every `NatToUse` and tail of the pattern and sum
-- else call `f` with every nat in `NatToUse` that satisfies the head of the pattern & `lastNatUsed` and the tail of the pattern and sum.
-- If there are no nats that satisfy the conditions return 0.
-- memoize on `pattern` and  `natsToUse`

remove x = filter (/= x)

g :: String -> [Int] -> Maybe Int -> Int
g [] [] _            = 1
g ps ns Nothing      = sum $ (\ n -> g ps (remove n ns) $ Just n) <$> ns
g (p:ps) ns (Just l) =
  sum $ (\ n -> g ps (remove n ns) $ Just n) <$> filter predicate ns
  where predicate n = p == '+' && n > l || p == '-' && n < l

f ps = g ps [0..length ps] Nothing
