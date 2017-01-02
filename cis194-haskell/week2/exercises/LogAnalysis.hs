{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log
import Data.Typeable

parseMessage :: String -> LogMessage
parseMessage cs
  | isValid ss = LogMessage (getMessageType ss) (getTimestamp ss) (getString ss)
  | otherwise  = Unknown cs
  where
    ss = words cs

isValid :: [String] -> Bool
isValid ss = hasType && hasTimestamp && hasString
  where
    h            = head ss
    hasType      = or [f h | f <- [(== "I"), (== "E"), (== "W")]]
    hasTimestamp = (h == "E" && isInt (ss !! 2)) || isInt (ss !! 1)
    hasString    = length ss > 2

getTimestamp ss
  | isError ss = toInt (ss !! 2)
  | otherwise  = toInt (ss !! 1)

getMessageType ss
  | t == "I" = Info
  | t == "E" = Error e
  | t == "W" = Warning
    where
      t = head ss
      e = toInt (ss !! 1)

getString ss
  | isError ss = unwords (drop 3 ss)
  | otherwise  = unwords (drop 2 ss)

isError ss = head ss == "E"
isInt n    = and [isDigit x | x <- n]
  where
    isDigit x = x `elem` ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
toInt ss
  | isInt ss = read ss :: Int
  | otherwise = 9999

parse :: String -> [LogMessage]
parse ss = [parseMessage s | s <- lines ss]

-- Exercise 2
insert :: LogMessage -> MessageTree -> MessageTree
insert log Leaf         = Node Leaf log Leaf
insert (Unknown _) tree = tree
insert log mTree
  | logT > mT = insert log r
  | otherwise = insert log l
  where
    logT = timestamp log
    mT =  timestamp $ getNode mTree
    l = getLeft mTree
    r = getRight mTree

getNode (Node _ n _)  = n
getLeft (Node l _ _)  = l
getRight (Node _ _ r) = r

timestamp (LogMessage _ ts _) = ts

-- Exercise 3
build :: [LogMessage] -> MessageTree
build = foldr insert Leaf

-- Exercise 4
inOrder :: MessageTree -> [LogMessage]
inOrder Leaf               = []
inOrder (Node l message r) = inOrder l ++ [message] ++ inOrder r

-- Exercise 5
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong [] = []
whatWentWrong (m:ms)
  | severity >= 50 = getString m : whatWentWrong ms
  | otherwise      = whatWentWrong ms
  where
    severity = getSeverity m
    getSeverity (LogMessage (Error s) _ _) = s
    getSeverity _ = 0
    getString (LogMessage _ _ s) = s
