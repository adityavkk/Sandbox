#r "System"

let memoize (f: 'a -> 'b) = let c = Collections.Concurrent.ConcurrentDictionary<'a, 'b>() in fun x -> c.GetOrAdd(x, f)