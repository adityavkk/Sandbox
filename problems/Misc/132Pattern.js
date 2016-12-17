function ottPattern(xs) {
  if (xs.length < 3) return false;
  for (let i = xs.length - 1; i > 1; i--) {
    const xi = xs[i];
    if (largeThenSmall(xs.slice(0, i), xi)) return true;
  }
  return false;
}
function largeThenSmall(ns, x) {
  let lastN = ns[ns.length - 1], withoutLast = ns.slice(0, ns.length - 1);
  if (ns.length < 2) return false;
  if (lastN > x) {
    return smaller(withoutLast, x)
  }
  return largeThenSmall(withoutLast, x)
}

function smaller (ns, x) {
  return Math.min(...ns) < x
}

function canAccommodate (memo, ns, x) {

}

console.log(ottPattern([7, 9, 3, 4, 8, 12]))
