// Given a string s, you can transform every letter individually to be lowercase or uppercase to create another string.

// Return a list of all possible strings we could create. Return the output in any order.

/*
Approach:
	if xs is empty: [[]]
	if x is a letter:
		prepend (lowercase x) to each letterCasePermutation of the rest
		+
		prepend (uppercase x) to each letterCasePermutation of the rest
	else:
		prepend x to each letterCasePermutation of the rest
*/

package main

import (
	"fmt"
	"unicode"
)

func prependToEach(c rune, permutations []string) []string {
	var result []string
	for _, s := range permutations {
		result = append(result, string(c)+s)
	}
	return result
}

func letterCasePermutation(s string) []string {
	if len(s) == 0 {
		return []string{""}
	}
	rest := s[1:]
	c := []rune(s)[0]
	permutationOfRest := letterCasePermutation(rest)
	if unicode.IsLetter(c) {
		lowerPerm := prependToEach(unicode.ToLower(c), permutationOfRest)
		upperPerm := prependToEach(unicode.ToUpper(c), permutationOfRest)
		return append(lowerPerm, upperPerm...)
	}
	return prependToEach(c, permutationOfRest)
}

// TEST
func main() {
	result := letterCasePermutation("a1z2")
	fmt.Println("A:", result)
}
