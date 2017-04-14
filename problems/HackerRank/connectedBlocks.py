"""
Consider a matrix with n rows and m columns, where each cell contains either
a 0 or a 1 and any cell containing a 1 is called a filled cell.

If one or more filled cells are also connected, they form a region.
Note that each cell in a region is connected to at least one other cell
in the region but is not necessarily directly connected to all the other cells
in the region.

Given an n x m matrix, find and print the number of cells in the largest region
in the matrix. Note that there may be more than one region in the matrix.
"""

"""
To find largest region do we need to find all the regions?

DFS through connected filled in regions
- regions :: [Int]
- visited :: Set Coords
- for cell in matrix:
    if cell is filled in and not visited:
        add cell to visited
        count = dfs(cell, mat)
        append count regions
- return max(regions)

dfs :: StartCoord -> Matrix -> Count
- ns = neighboring coords in mat to start that are filled in and not in visited
- add ns to visited
- sum (map dfs onto ns) + 1
"""

def f(mat):
    regions = []
    visited = set()
    n = len(mat)
    m = len(mat[0])

    def inRange(c):
        (i, j) = c
        return i < n and j < m and i >= 0 and j >= 0

    def dfs(c):
        (i, j) = c
        neighbors = filter(inRange, [(i, j + 1), (i, j - 1), (i + 1, j),
                                     (i - 1, j), (i + 1, j + 1), (i + 1, j - 1),
                                     (i - 1, j - 1), (i - 1, j + 1)])
        ns = [n for n in neighbors if not n in visited and mat[n[0]][n[1]] == 1]
        for n in ns:
            visited.add(n)
        return sum([dfs(n) for n in ns]) + 1

    for i in range(0, n):
        for j in range(0, m):
            cell = mat[i][j]
            if cell == 1 and (not (i, j) in visited):
                visited.add((i, j))
                count = dfs((i, j))
                regions.append(count)
    return max(regions)


xs = [[1, 1, 0, 0],
      [0, 1, 1, 0],
      [0, 0, 1, 0],
      [1, 0, 0, 0]]
print(f(xs))
