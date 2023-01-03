/*
Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

You must write an algorithm that runs in O(n) time.

Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

https://leetcode.com/problems/longest-consecutive-sequence/
*/

/*
Approach:
iterate through array
keep track of head, tail, length of chain in a map

	head of chain with x is the head of the chain to the left
	tail of chain with x is the tail of the chain to the right
	length of chain with x is the lengh of left chain + right chain + 1
	update the head and length of the right chain at the last element
	update the tail and length of the left chain at the first element
*/
func intMax(x int, y int) int {
	if x > y {
		return x
	}
	return y
}

type Metadata struct {
	head        int
	tail        int
	chainLength int
}

func longestConsecutive(nums []int) int {
	var longestChains = make(map[int]Metadata)
	longestSoFar := 0
	for _, x := range nums {
		beforeX, foundBefore := longestChains[x-1]
		afterX, foundAfter := longestChains[x+1]
		xMetadata := Metadata{x, x, 1}
		if foundBefore {
			xMetadata.head = beforeX.head
			xMetadata.chainLength = beforeX.chainLength + 1
		}
		if foundAfter {
			xMetadata.tail = afterX.tail
			xMetadata.chainLength = xMetadata.chainLength + afterX.chainLength
		}
		if foundBefore {
			chainhead := longestChains[beforeX.head]
			chainhead.tail = xMetadata.tail
			chainhead.chainLength = xMetadata.chainLength
			longestChains[beforeX.head] = chainhead
		}
		if foundAfter {
			chainTail := longestChains[afterX.tail]
			chainTail.head = xMetadata.head
			chainTail.chainLength = xMetadata.chainLength
			longestChains[afterX.tail] = chainTail
		}
		longestChains[x] = xMetadata
		longestSoFar = intMax(longestSoFar, xMetadata.chainLength)

	}
	return longestSoFar
}