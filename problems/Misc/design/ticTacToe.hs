-- Tic Tac Toe

-- data Game = { state, board, toMove, move }
-- data Board = { pieces }

-- pieces :: [[Char]
-- move :: Game -> Pos -> Either Error Game
-- state :: Bool
-- toMove :: Char
import Data.List (transpose)

data Game = G { state  :: Bool
              , board  :: Board
              , toMove :: Char
              , err  :: String
              }

data Board = B { pieces :: [[Char]] }
  deriving (Show, Eq)

type Pos = (Int, Int)

instance Show Game where
  show g@(G _ _ _ e)
    | e /= "" = show g { err = "" } ++ "\n" ++ e ++ "\n"
  show g@(G True _ c _) = show (g { state = False }) ++ "\n" ++ nc
                      : " has won the game!"
    where nc = next c
  show (G _ b c _)    = "\n  " ++ [ps !! 0 !! 0] ++ " | " ++ [ps !! 0 !! 1] ++
                      " | " ++ [ps !! 0 !! 2] ++ " \n"
                       ++ divider ++
                       "  " ++ [ps !! 1 !! 0] ++ " | " ++ [ps !! 1 !! 1] ++
                       " | " ++ [ps !! 1 !! 2] ++ " \n"
                       ++ divider ++
                       "  " ++ [ps !! 2 !! 0] ++ " | " ++ [ps !! 2 !! 1] ++
                       " | " ++ [ps !! 2 !! 2] ++ " \n"
    where
      divider = "-------------\n"
      ps = pieces b

emptyBoard :: Board
emptyBoard = B [[' ' | _ <- [0..2]] | _ <- [0..2]]

emptyGame :: Game
emptyGame = G False emptyBoard 'O' ""

next :: Char -> Char
next 'O' = 'X'
next 'X' = 'O'
next _   = ' '

insert :: Char -> Pos -> Board -> Board
insert c (i, j) b@(B ps)
  | ps !! i !! j == ' ' = B ps'
  | otherwise           = b
  where ps'  = take i ps
               ++ [ take j ps'' ++ [c] ++ drop (j + 1) ps'' ]
               ++ drop (i + 1) ps
        ps'' = ps !! i

move :: Pos -> Game -> Game
move p g@(G s b c e)
  | not s && isValid   = updateState $ g' { board = insert c p b
                                          , toMove = next c }
  | otherwise          = g'
  where (isValid, g') = valid p g

valid :: Pos -> Game -> (Bool, Game)
valid (i, j) g = if i < 3 && j < 3 && pieces (board g) !! i !! j == ' '
                 then (True, g { err = "" })
                 else (False, g { err = "invalid move" })

updateState :: Game -> Game
updateState g
  | state g   = g
  | otherwise = g { state = win $ board g }

win :: Board -> Bool
win (B ps) = any same ps || any same (transpose ps) || any same (diags ps)
  where same []     = True
        same (x:xs) = all (\ y -> y == x && y /= ' ') xs

diags xxs = [xxs !! i !! i | i <- [0..l]] :
            [[xxs !! (l - j) !! j | j <- [l, l - 1..0]]]
  where l = length xxs - 1

main = do
  putStrLn "Hi! Let's play a game of Tic-Tac-Toe"
  play emptyGame

play :: Game -> IO ()
play g = do
  print g
  if state g
  then putStrLn "Cya!"
  else do
         putStrLn (toMove g : " to move. Where do you want to play (i, j)?")
         pos <- getLine
         play (move (read pos) g)
