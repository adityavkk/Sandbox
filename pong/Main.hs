module Main(main) where

import Graphics.Gloss

window :: Display
window = InWindow "Pong" (width, width) (offset, offset)

width = 300
offset = 100

background :: Color
background = black

data PongGame = Game { ballLoc :: (Float, Float)
                     , ballVel :: (Float, Float)
                     , player1 :: Float
                     , player2 :: Float
                     } deriving Show

initialState :: PongGame
initialState = Game { ballLoc = (-10, 30)
                    , ballVel = (-20, 0)
                    , player1 = 40
                    , player2 = -80
                    }

render :: PongGame -> Picture
render game = pictures [ball, walls, ball',
                        mkPaddle rose 120 $ player1 game,
                        mkPaddle orange (-120) $ player2 game]
  where
    ball      = uncurry translate (ballLoc game) $ color ballColor $ circleSolid 10
    ballColor = dark red

    ball'     = translate (-155) 10 $ color red $ circleSolid 10

    wall :: Float -> Picture
    wall offset =
      translate 0 offset $
        color wallColor $
          rectangleSolid 270 10

    wallColor = greyN 0.5
    walls = pictures [wall 150, wall (-150)]

    mkPaddle :: Color -> Float -> Float -> Picture
    mkPaddle col x y = pictures
      [ translate x y $ color col $ rectangleSolid 26 86
      , translate x y $ color paddleColor $ rectangleSolid 20 80
      ]

    paddleColor = light (light blue)

moveBall :: Float -> PongGame -> PongGame
moveBall secs game = game { ballLoc = (x', y') }
  where
    (x, y)   = ballLoc game
    (vx, vy) = ballVel game
    x'       = x + vx * secs
    y'       = y + vy * secs

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

paddleCollision :: Position -> Radius -> Bool
paddleCollision (x, y) rad = leftCollision || rightCollision
  where
    leftCollision  = (x + rad) <= -140
    rightCollision = x + rad >= 10

paddleBounce :: PongGame -> PongGame
paddleBounce game
  | paddleCollision (ballLoc game) rad = game { ballVel = (vx', vy') }
  | otherwise = game
    where
      rad        = 10
      (vx, vy)   = ballVel game
      (vx', vy') = (vx, -vy)

fps :: Int
fps = 60

main :: IO ()
main = simulate window background fps initialState render update

update _ secs = paddleBounce . moveBall secs
