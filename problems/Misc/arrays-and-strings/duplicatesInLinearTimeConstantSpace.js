/* Given an array of n elements which contains elements from 0 to n - 1, with
 * any of these number appearing any number of times. Find these repeating
 * numbers in O(n) time using only constant space
 *
 * n = 7
 * xs = [1, 2, 3, 1, 3, 6, 6]
 * return [1, 3, 6]
 */

/* Since we know that the array contains elements from 0 to n - 1 of length at least
 * n - 1, we can use that information to change the element at index xs[abs(xs[i])]
 * into a negative number if it isn't already negative, if it is negative then we know
 * that we've seen that particular element at index xs[i] before since we must've
 * indexed into that same position before.
 */

const log = console.log
const f = (n, xs) => {
  return xs.reduce((ds, x, i) => {
    const absX = Math.abs(x)
    if (xs[absX] < 0) return ds.concat(absX)
    xs[absX] = -xs[absX]
    return ds
  }, [])
}

log(f(7, [1, 4, 2, 3, 1, 3, 6, 6, 5, 4]))
