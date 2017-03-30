const log = console.log

// zipAll :: Iterables -> [(a, b)]
function zipAll(iters, v) {
  const ls = iters.map(x => x.length)
  const maxLength = Math.max(...ls)
  return range(0, maxLength).map(i => zipIndex(v, i, iters, ls))
}

// zipIndex :: Int -> Iterables a -> [a]
function zipIndex(v, i, iters, ls) {
  return iters.map((iter, k) => {
    if (i >= ls[k]) return v
    return iter[i]
  })
}

function range(start, end) {
  return Array.from(new Array(end - start), (_,i) => start + i)
}

log(zipAll([range(1, 5), range(6, 9), range(10, 20)], 'cheese'))

zipSequence.__iteratorUncached = function(type, reverse) {
    var iterators = iters.map(i =>
      (i = Iterable(i), getIterator(reverse ? i.reverse() : i))
    );
    var iterations = 0;
    var isDone = false;
    return new Iterator(() => {
      var steps;
      if (!isDone) {
        steps = iterators.map(i => i.next());
        if (zipAll) isDone = steps.every(s => s.done);
        else isDone = steps.some(s => s.done);
      }

      if (isDone) {
        return iteratorDone();
      }

      return iteratorValue(
        type,
        iterations++,
        zipper.apply(null, steps.map(s => s.done ? undefined : s.value))
      );
    });
  };

