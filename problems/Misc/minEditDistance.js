/* Minimum Edit Distance
 *
 * Given two strings (s1, s2),
 * What is the minimum number of operations you have to perform to transform one
 * into the other if you had access to the following operations:
 * 1. Insert a character
 * 2. Remove a character
 * 3. Replace a character
 */

const withoutLast = s => s.slice(0, s.length - 1),
  withoutFirst = s => s.slice(1);

const minEdit = (s1, s2) => {
  const n = s1.length,
    m = s2.length,
    f1 = s1[0],
    f2 = s2[0],
    l1 = s1[n - 1],
    l2 = s2[m - 1];
  if (n === 0) return m;
  if (m === 0) return n;
  if (f1 === f2) return minEdit(withoutFirst(s1), withoutFirst(s2))
  if (l1 === l2) return minEdit(withoutLast(s1), withoutLast(s2));
  const ifInsert = minEdit(s1, withoutLast(s2)),
    ifRemove = minEdit(withoutLast(s1), s2),
    ifReplace = minEdit(withoutLast(s1), withoutLast(s2));
  return 1 + Math.min(ifInsert, ifRemove, ifReplace);
}
