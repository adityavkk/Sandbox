# input = ['abcd',
#          'efgh',
#          'hjkl',
#          'mnop']
#
# dict :: Set String

dictionary = set(open('../../../hidden/dict.txt').read().strip().split('\n'))

words = set()
def f(board):
    for i in range(0, len(board)):
        for j in range(0, len(board[0])):
            search(board, (i, j))
    return words

def search(board, pos, word = ''):
    (i, j) = pos
    c = board[i][j]
    if len(word) > 7:
        return
    if inDict(word):
        words.add(word)
    for p in neighbors(board, i, j):
        search(board, p, word + c)

def inDict(w):
    return w in dictionary

def neighbors(board, i, j):
    ns = [(i + 1, j + 1), (i + 1, j), (i + 1, j - 1), (i - 1, j), (i - 1, j - 1), \
          (i - 1, j + 1), (i, j + 1), (i, j - 1)]
    return [(i, j) for (i, j) in ns if i < len(board) and \
            i >= 0 and j >= 0 and j < len(board[0])]

board = ['aihur', 'ntcir', 'opeto', 'biakl']
