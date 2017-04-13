"""
Consider a staircase of size :

   #
  ##
 ###
####

Observe that its base and height are both equal to n, and the image is drawn
using # symbols and spaces. The last line is not preceded by any spaces.

Write a program that prints a staircase of size n.
"""

"""
f :: Int -> String
1st line is (n - 1) spaces and 1 #
nth line is (n - n) spaces and n #

for i in range(1, n + 1):
    str += (n - i) spaces + i #s + '\n'
"""

def f(n):
    ss = ''
    for i in range(1, n + 1):
        ss += (n - i) * ' ' + i * '#' + '\n'
    print(ss.strip('\n'))
