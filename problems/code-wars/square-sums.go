// Write function square_sums_row ( or squareSumsRow or SquareSumsRow ) that, given integer number N (in range 2..43), returns array of integers 1..N arranged in a way, so sum of each 2 consecutive numbers is a square.

// Solution is valid if and only if following two criterias are met:

// Each number in range 1..N is used once and only once.
// Sum of each 2 consecutive numbers is a perfect square.

// N = 15; Output = [ 9, 7, 2, 14, 11, 5, 4, 12, 13, 3, 6, 10, 15, 1, 8 ]

// Approach:
/*
	SumSquaresRow (N: int):
		for n in range N:
			if go n (remove n range N):
				return result

	go (head: int) (rest: [] int) -> tries to find square sums with the specified head or returns false
		if isEmpty rest: return [head]
		foundSqs = find (head: int) (rest: [] int) -> tries to find the numbers in rest that when summed w head is a sq, or false
		for found in foundSqs:
			recursiveResult = go found (remove found rest)
			if recursiveResult:
				return [head, found] ++ recursiveResult
*/

package main

import (
	"fmt"
	"math"
)

func remove(s []int, r int) []int {
	for i, v := range s {
		if v == r {
			return append(s[:i], s[i+1:]...)
		}
	}
	return s
}

func makeRange(min, max int) []int {
	a := make([]int, max-min+1)
	for i := range a {
		a[i] = min + i
	}
	return a
}

func isSquare(x int) bool {
	var int_root int = int(math.Sqrt(float64(x)))
	return (int_root * int_root) == x
}
func filter(ss []int, test func(int) bool) (ret []int) {
	for _, s := range ss {
		if test(s) {
			ret = append(ret, s)
		}
	}
	return
}

func findSquareSums(y int, xs []int) []int {
	predicate := func(x int) bool {
		return isSquare(x + y)
	}
	return filter(xs, predicate)
}

func do(head int, rest []int) []int {
	if len(rest) == 0 {
		return []int{head}
	}
	foundSquares := findSquareSums(head, rest)
	if len(foundSquares) == 0 {
		return nil
	} else {
		for _, found := range foundSquares {
			var recursiveResult = do(found, remove(rest, found))
			if recursiveResult != nil {
				return append([]int{head, found}, recursiveResult...)
			}
		}
	}
	return nil
}

func SquareSumsRow(N int) []int {
	var intRange = makeRange(1, N)
	for _, n := range intRange {
		var result = do(n, remove(intRange, n))
		if result != nil {
			return result
		}
	}
	return nil
}

func main() {
	fmt.Print(SquareSumsRow(15))
}
