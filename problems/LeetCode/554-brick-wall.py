from itertools import accumulate
 
def prefixSum(lst):
    return (list(accumulate(lst))[:-1])
  
def frequencyMax(xxs):
    count = {}
    maximum = 0
    for xs in xxs:
        for x in xs:
            count[x] = count.get(x, 0) + 1
            maximum = max(count[x], maximum)
    return maximum

def leastBricks(self, wall: List[List[int]]) -> int:
    prefixSums = list(map(prefixSum, wall))
    maxCount = frequencyMax(prefixSums)
    return len(wall) - maxCount
      
"""
Insights:
    The index with the most amount of brick ends/starts across all rows will contain the line

Approach:
    compute prefix sums of each row; this will determine which at indices the slits are
    frequency of each entry in prefix sums
    keep track of max count
    return # rows - max count
"""
