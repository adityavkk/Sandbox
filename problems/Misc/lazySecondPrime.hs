-- Calculate the second prime between 10,000,000 and 100,000,000
import IsPrime

second = head . tail

-- Because of the laziness of Haskell, f will not actually enumerate all the
-- numbers from i to j and filter all of them for isPrime, but will only go until
-- the second one is needed
f i j = second $ filter isPrime [i..j]
secondPrime = f 10000000 100000000

-- However, ps is asking for the number of all the primes between 10M and 100M
-- so all the primes need to be enumerated, filtered and counted, this will not
-- complete
ps = length $ filter isPrime [10000000..100000000]
