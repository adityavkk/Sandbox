#Given a 2D board and a list of words from the dictionary, find all words in the board.

#Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those 
#horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

# Approach
# BF: 
# Start at each i, traverse all possible paths from i. For each new letter check if the word thusfar is in the dictionary
# 
# Optimal:
# Insert all words in dict into trie
# start at each i in board, traverse all directions as long as the letter matches (4 x max)
    # if match: add to list of words
    # else: stop traversal
# 
# Runtime: O(SL) + O(4 XY L) X = width, Y = height, L = longest word in dict, S = size of dict

def f():
