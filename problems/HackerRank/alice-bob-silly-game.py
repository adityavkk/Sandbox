"""
Alice and Bob play a game where:
    - The game starts with an integer, n, that's used to build a set of n
    distinct integers in the inclusive range from 1 to n
    - Alice always plays first, and the two players move in alternating turns
    - During each move, the current player chooses a prime number, p, from set.
    The player then removes p and all of its multiples from the set
    - The first player unable to make a move loses the game.

Alice and Bob play g games. Given the value of n for each game, print the name
of the game's winner on a new line. If Alice wins, print Alice; otherwise, Bob

Each player plays optimally
"""

"""
Approach:
    f :: [Int] -> [PrimeSoFar] -> [Prime]
    p = head xs
    f (filter ( /= 0 . `mod` p) xs) (p:ps)
"""

from math import log
import bisect

def num_primes(n):

    def f(xs, p_count = 0):
        ps = set()
        while True:
            if len(xs) > 0:
                p = xs[0]
            else:
                return p_count
            ps.add(p)
            p_count += 1
            xs = [x for x in xs if not x % p == 0]

    return f(range(2, n + 1))

def g(n):
    return (n - 3) / log(3)
