const trampoline = (fn) => {
  var result,
    __slice = Function.prototype.call.bind([].slice),
    args = __slice(arguments, 1),
    arity = fn.length;

  function ret(args) {
    result = fn.apply(fn, args);
    while (result instanceof Function) {
      result = result();
    }
    return result;
  }

  function given(args) {
    return function( /* args */ ) {
      args = args.concat(__slice(arguments));
      return args.length >= arity ? ret(args) : given(args);
    };
  }

  return args.length < arity ? given([]) : ret(args);
}

const countdown = (n, fnArgs) => {
  console.log(fnArgs)
  if (!fnArgs) fnArgs = []
  return n === 0 ? fnArgs.concat([0]) : countdown(n - 1, fnArgs.concat(n))
}

console.log(trampoline(countdown, 100))
