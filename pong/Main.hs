module Main(main) where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

window :: Display
window = InWindow "Pong" (width, width) (offset, offset)

width        = 600
offset       = 200
tenOffset    = 0.9 * fromIntegral width / 2
twentyOffset = 0.8 * fromIntegral width / 2
paddleW      = 20
paddleH      = 80

background :: Color
background = black

data PongGame = Game { ballLoc :: (Float, Float)
                     , ballVel :: (Float, Float)
                     , player1 :: Float
                     , player2 :: Float
                     , paused  :: Bool
                     , p1Up    :: Bool
                     , p1Down  :: Bool
                     , p2Up    :: Bool
                     , p2Down  :: Bool
                     } deriving Show

initialState :: PongGame
initialState = Game { ballLoc = (-10, 60)
                    , ballVel = (150, 0)
                    , player1 = 40
                    , player2 = (-200)
                    , paused  = True
                    , p1Up    = False
                    , p1Down  = False
                    , p2Up    = False
                    , p2Down  = False
                    }

render :: PongGame -> Picture
render game = pictures [centerLine, ball, walls,
                        mkPaddle offWhite tenOffset $ player1 game,
                        mkPaddle offWhite (-tenOffset) $ player2 game]
  where
    centerLine = color offWhite $ rectangleSolid 2 (fromIntegral width)

    ball      = uncurry translate (ballLoc game) $ color offWhite $ rectangleSolid 10 10
    ballColor = dark red

    offWhite = dim white

    wall :: Float -> Picture
    wall offset =
      translate 0 offset $
        color wallColor $
          rectangleSolid (0.9 * fromIntegral width) (0.04 * fromIntegral width)

    wallColor = greyN 0.5
    walls = pictures [wall (fromIntegral width / 2), wall (fromIntegral width / (-2))]

    mkPaddle :: Color -> Float -> Float -> Picture
    mkPaddle col x y =
      translate x y $ color offWhite (rectangleSolid paddleW paddleH)


moveStuff :: Float -> PongGame -> PongGame
moveStuff secs game
  | p1u && player1 game <= (tenOffset - 5 - paddleH / 2) =
      ng { player1 = player1 game + 10 }
  | p1d && player1 game >= (-tenOffset) + 5 + paddleH / 2 =
      ng { player1 = player1 game - 10 }
  | p2u && player2 game <= (tenOffset - 5 - paddleH / 2) =
      ng { player2 = player2 game + 10 }
  | p2d && player2 game >= (-tenOffset) + 5 + paddleH / 2 =
      ng { player2 = player2 game - 10 }
  | otherwise = ng
    where
      (x, y)   = ballLoc game
      (vx, vy) = ballVel game
      x'       = x + vx * secs
      y'       = y + vy * secs
      p1u      = p1Up game
      p1d      = p1Down game
      p2u      = p2Up game
      p2d      = p2Down game
      ng       = game { ballLoc = (x', y') }

type Radius = Float
type Position = (Float, Float)

wallCollision :: Position -> Radius -> Bool
wallCollision (_, y) rad = topCollision || bottomCollision
  where
    topCollision    = y - rad <= -fromIntegral width / 2
    bottomCollision = y + rad >= fromIntegral width / 2

wallBounce :: PongGame -> PongGame
wallBounce game = game { ballVel = (vx, vy') }
  where
    rad      = 10
    (vx, vy) = ballVel game
    vy'      = if wallCollision (ballLoc game) rad
               then
                 (-vy)
               else
                 vy

paddleCollision :: Position -> Float -> Float -> Radius -> (Bool, String)
paddleCollision (x, y) p1 p2 rad
    | leftCollision  = (True, "Left")
    | rightCollision = (True, "Right")
    | otherwise      = (False, "False")
  where
    leftCollision  =
      (x - rad) <= -(fromIntegral width / 2 - 36) &&
      y >= p2 - 36 && y <= p2 + 36
    rightCollision =
      x + rad >= (fromIntegral width / 2 - 36) &&
      y >= p1 - 36 && y <= p1 + 36

paddleBounce :: PongGame -> PongGame
paddleBounce game
  | col =
      if (xb > p1 && side == "Right") || (xb < p2 && side == "Left")
      then game { ballVel = (vx', vy') }
      else game { ballVel = (vx', 0) }
  | otherwise = game
    where
      rad         = 10
      (vx, vy)    = ballVel game
      (vx', vy')  = (1.1 * (-vx), 1.1 * vx)
      p1          = player1 game
      p2          = player2 game
      bLoc        = ballLoc game
      (xb, yb)    = bLoc
      (col, side) = paddleCollision bLoc p1 p2 rad

fps :: Int
fps = 60

handleKeys :: Event -> PongGame -> PongGame
handleKeys (EventKey (Char 'r') Down _ _) game =
  game { ballLoc = (0, 0), ballVel = (-90, 0) }
handleKeys (EventKey (Char 'p') Down _ _) game =
  game { paused = not $ paused game }
handleKeys (EventKey (Char 'w') s _ _) game
  | s == Down && player2 game <= (tenOffset - 5 - paddleH / 2) =
      game { p2Up = True, player2 = player2 game + 30 }
  | s == Up = game { p2Up = False }
handleKeys (EventKey (Char 's') s _ _) game
  | s == Down && player2 game >= (-tenOffset) + 5 + paddleH / 2 =
      game { p2Down = True, player2 = player2 game - 30 }
  | s == Up = game { p2Down = False }
handleKeys (EventKey (SpecialKey KeyUp) s _ _) game
  | s == Down && player1 game <= (tenOffset - 5 - paddleH / 2)=
      game { p1Up = True, player1 = player1 game + 30 }
  | s == Up = game { p1Up = False }
handleKeys (EventKey (SpecialKey KeyDown) s _ _) game
  | s == Down && player1 game >= (-tenOffset) + 5 + paddleH / 2 =
      game { p1Down = True, player1 = player1 game - 30 }
  | s == Up = game { p1Down = False }
handleKeys _ game                           = game

update :: Float -> PongGame -> PongGame
update secs game
  | paused game = game
  | otherwise   = wallBounce $ paddleBounce $ moveStuff secs game

main :: IO ()
main = play window background fps initialState render handleKeys update
