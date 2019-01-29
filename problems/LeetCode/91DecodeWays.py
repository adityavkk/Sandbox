#  A message containing letters from A-Z is being encoded to numbers using the following mapping:
#      A -> 1
#      B -> 2
#      ...
#      Z -> 26
#
#  Given a non-empty string containing only digits, determine the total number of ways to decode it
#
#  Example 1:
#      Input 12
#      Output 2
#      Explanation: It could be decoded as AB or L
#

#  Approach:
#      f :: String -> Int
#      base case:
#          if s is '0' return 0
#          if s is '' return 1
#      recurrence:
#          T(n) = T(n - 1) + T(n - 2)
#          x = f(n[1:])
#          elif first 2 digits < 26:
#              y = f(n[2:])
#              else y + x
#          else:
#              x
#      runtime: if memoised O(n) else fibonacci
from functools import lru_cache

def main(s):
    l = len(s)
    @lru_cache(maxsize=None)
    def f(i):
        if i == l: return 1
        c = s[i]
        if c == '0': return 0
        x = f(i + 1)
        if i < l - 1:
            d = s[i + 1]
            if int(c + d) < 27:
                y = f(i + 2)
                return y + x
        return x
    return f(0)
