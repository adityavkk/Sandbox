/*
  There are N Mice and N holes are placed in a straight line.
  Each hole can accomodate only 1 mouse.
  A mouse can stay at his position, move one step right from x to x + 1, or
  move one step left from x to x − 1. Any of these moves consumes 1 minute.
  Assign mice to holes so that the time when the last mouse gets inside a hole
  is minimized.

  positions of mice are:
  4 -4 2
  positions of holes are:
  4 0 5

  Assign mouse at position x=4 to hole at position x=4 : Time taken is 0 minutes
  Assign mouse at position x=-4 to hole at position x=0 : Time taken is 4 minutes
  Assign mouse at position x=2 to hole at position x=5 : Time taken is 3 minutes
  After 4 minutes all of the mice are in the holes.

  Since, there is no combination possible where the last mouse's time is less than 4,
  answer = 4.
*/

/* Greedy heuristic:
 * Match mice with holes such that the time it takes to hole is minimized
 *
 * Sort times and sort mice positions and pair mice and holes up
 * keep track of max time
 * return max time
 */

const abs = Math.abs
const log = console.log
const f = (ms, hs) => {
  ms = ms.sort((a, b) => a - b)
  hs = hs.sort((a, b) => a - b)
  log(ms, hs)
  return hs.reduce((mx, h, i) => abs(h - ms[i]) > mx ? abs(h - ms[i]) : mx, 0)
}

log(f([4, -4, 2], [4, 0, 5])) // => 4
