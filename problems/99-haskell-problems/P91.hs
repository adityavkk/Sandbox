-- Knight's tour
-- How can a knight jump on an NxN chessboard in shuch a way that it visits
-- every square exactly once?

-- Hints: Represent the squares by pairs of their coordinates of the form X/Y, where
-- both X and Y are integers between 1 and N. (Note that '/' is just a convenient
-- functor, not division!) Define the relation jump(N, X/Y, U/V) to express
-- the fact that a knight can jump from X/Y to U/V on a NxN chessboard. And finally
-- represent the solution of our problem as a list of N*N knight positions
-- (the knight's tour)

-- There are two variants of this problem:
-- 1. find a tour ending at a particular square
-- 2. find a circular tour, ending a knight's jump from the start (clearly it doesn't
    -- matter where you start, so choose (1, 1))
