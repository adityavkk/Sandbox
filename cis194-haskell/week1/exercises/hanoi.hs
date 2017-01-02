-- Exercise 5
-- Towers of Hanoi
type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 a b c = []
hanoi n a b c = hanoi (n - 1) a c b ++ [(a, b)] ++ hanoi (n - 1) c b a

-- Exercise 6
-- Hanoi with 4 pegs
hanoi4 :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
hanoi4 0 _ _ _ _ = []
hanoi4 1 a b _ _ = [(a, b)]
hanoi4 n a b c d = moveFirstHalf ++ moveSecondHalf ++ finishFirstHalf
  where
    moveFirstHalf    = hanoi4 half a c b d
    moveSecondHalf   = hanoi rest a b d
    finishFirstHalf  = hanoi4 half c b a d
    half             = n `quot` 2
    rest             = n - half
-- 305 moves
