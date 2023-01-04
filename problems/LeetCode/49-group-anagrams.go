/*
Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

Input: strs = [""]
Output: [[""]]

Input: strs = ["a"]
Output: [["a"]]

Approach 1:
groups = []
for w in ws:

	group = [w]
	for w' in rest of ws:
		if w' is anagram of w:
			group + w'
	groups + group

Runtime: O(N^2)

Approach 2:
construct a set of sorted versions of each word O(N * W Log W)
for w in ws: check if sort(w) is in set and and add to group O(N * W Log W)
Runtime: O(N * W Log W)

Pseudo-code:
sortedWords: Map<string, string[]> = {}
for w in ws:

	if sort(w) in sortedWords: sortedWords[sort(w)] + w
	else: sortedWords[sort(w)] = [w]

return values(sortedWords)
*/
import (
	"sort"
	"strings"
)

func sortString(s string) string {
	runes := strings.Split(s, "")
	sort.Strings(runes)
	sorted := strings.Join(runes, "")
	return sorted
}

func groupAnagrams(strs []string) [][]string {
	var anagramGroups = make(map[string][]string)
	for _, w := range strs {
		sortedW := sortString(w)
		anagramGroup := anagramGroups[sortedW]
		anagramGroups[sortedW] = append(anagramGroup, w)
	}
	values := make([][]string, 0, len(anagramGroups))
	for _, v := range anagramGroups {
		values = append(values, v)
	}
	return values
}