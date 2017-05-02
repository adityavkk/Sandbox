-- Given two squares on a two-dimensional plane, find a line that would cut these two
-- squares in half. Assume that the top and the bottom sides of the square run
-- parallel to the x-axis

-- Any line that goes through the center of a square cuts it in half
-- compute the y-intercept and slope of line that goes through the center of a and b

-- f :: (Square, Square) -> (Slope, Y-Intercept)
  -- line (center a) (center b)

-- center :: Square -> (x, y)
  -- (x0 + (w / 2), y0 + (w / 2))

-- line :: (x0, y0) -> (x1, y1) -> (Slope, Y-Intercept)
  -- m = (x1 - x0) / (y1 - y0)
  -- b = y1 / (m * x1)

type Square = ((Float, Float), Float)

f :: Square -> Square -> (Float, Float)
f a b = line (center a) (center b)

line (x0, y0) (x1, y1) = (m, b)
  where m = (x1 - x0) / (y1 - y0)
        b = y1 / (m * x1)

center ((x0, y0), w) = (x0 + (w / 2), y0 + (w / 2))
