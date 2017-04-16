/*
   The gray code is a binary numeral system where two successive values differ in
   only one bit.

   Given a non-negative integer n representing the total number of bits in the code,
   print the sequence of gray code. A gray code sequence must begin with 0.

  For example, given n = 2, return [0,1,3,2]. Its gray code sequence is:
  00 - 0
  01 - 1
  11 - 3
  10 - 2

  There might be multiple gray code sequences possible for a given n
*/

/* 000
 * 010
 * 011
 * 111
 * 110
 * 100
 * 101
 * 001
 *
 * Brute Force:
 * Not every path with (1 edit) leads to a complete enumeration of all the
 * numbers that can be represented by n bits
 *
 * We need a path from 0000.. of length 2^n - 1
 *
 * f -> BinaryNumber -> [Int]
 * Keep global seen set
 * map f (change 1 bit ns)
 *
 * Optimized Approach:
 * G(n) is the gray code for n
 * R(n) is reverse(G(n)) -> also a valid gray code
 * Note that G(n + 1) = map (0:) G(n) ++ map (1:) R(n)
 * Constructing G(3) from G(2):
 * 0 00
 * 0 01
 * 0 11
 * 0 10
 * 1 10
 * 1 11
 * 1 01
 * 1 00
 */
