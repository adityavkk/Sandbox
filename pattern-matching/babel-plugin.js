module.exports = function(babel) {
  const t = babel.types;

  const isIdent = n => t.isIdentifier(n),
        isWC = n => isIdent(n) && n.name === '_',
        isCaps = s => s.toUpperCase() === s,
        isVar = n => isIdent(n) && !isCaps(n.name[0]),
        isArr = n => t.isArrayExpression(n),
        isOr = n => t.isLogicalExpression(n) && n.operator === '||',
        isLambda = n => t.isArrowFunctionExpression(n),
        isConstructor = n => t.isCallExpression(n) && isCaps(n.callee.name[0]),
        getConstructor = n => t.memberExpression(t.memberExpression(n, t.identifier('constructor')), t.identifier('name')),
        objVals = n => t.callExpression(t.memberExpression(t.identifier('Object'), t.identifier('values')), [n]),
        index = (n, i) => t.memberExpression(n, t.numericLiteral(i), true),
        makeLet = p => t.variableDeclaration("let", [t.variableDeclarator(p[0], p[1])]),
        makeAnd = (x, y) => t.logicalExpression('&&', x, y),
        makeOr = (x, y) => t.logicalExpression('||', x, y),
        makeEq = (x, y) => t.binaryExpression('===', x, y),
        pLength = p => t.isArrayExpression(p) ? p.elements.length : p.arguments.length,
        thunk = x => t.arrowFunctionExpression([], Array.isArray(x) ? t.blockStatement(x) : x),
        call = (f, x) => t.callExpression(f, Array.isArray(x) ? x : [x]),
        makeIf = (x, y) => t.ifStatement(x, Array.isArray(y) ? t.blockStatement(y) : y),
        bool = x => t.booleanLiteral(x),
        str = x => t.stringLiteral(x),
        num = x => t.numericLiteral(x),
        ident = x => t.identifier(x),
        method = (x,y) => t.memberExpression(x,y),
        ret = x => t.returnStatement(x);

  function makeCondition(a, p, l) {
    // wildcard
    if (isWC(p))
      return bool(true);
    // variable
    if (isVar(p)) {
      if (pair = l.find(arr => arr[0].name === p.name)) {
        return makeEq(pair[1], a)
      } else {
        l.push([p, a]);
        return bool(true);
      }
    }
    // function
    if (isLambda(p)) {
      l.push([p.params[0], a]);
      return call(p, a);
    }
    // constructor
    if (isConstructor(p)) {
      let conditions = [];
      conditions.push(a);
      conditions.push(makeEq(getConstructor(a), str(p.callee.name)));
      conditions.push(makeEq(num(pLength(p)),
                      method(objVals(a), ident('length'))));
      conditions = conditions.concat(p.arguments.map((e, i) => makeCondition(index(objVals(a), i), e, l)));
      return conditions.reduce(makeAnd);
    }
    // array
    if (isArr(p)) {
      let conditions = [];
      conditions.push(makeEq(num(pLength(p)),
                      method(objVals(a), ident('length'))));
      conditions = conditions.concat(p.elements.map((e, i) => makeCondition(index(objVals(a), i), e, l)));
      return conditions.reduce(makeAnd);
    }
    return makeEq(a, p);
  }

  function convertPairToConditional(arg) {
    // return a function of one argument so it can be used to map over patExprPairs
    return (pair) => {
      let locals = [];
      let condition = makeCondition(arg, pair.elements[0], locals);
      let consequent = locals.map(makeLet).concat(ret(pair.elements[1]));

      return makeIf(condition, consequent);
    };
  }

  return {
    name: "ast-transform",
    visitor: {
      CallExpression(path) {
        // check if the function being called is 'match'
        if (path.node.callee.name === 'match') {

          // break up the arguments to 'match'
          let argToMatch = path.node.arguments[0];
          let patExprPairs = path.node.arguments.slice(1);

          // replace the 'match' function with a series of conditionals
          // the conditionals are wrapped in a thunk that's immediately called
          // this allows 'match' to be used as an expression (you can use its return value)
          path.replaceWith(call(thunk(patExprPairs.map(convertPairToConditional(argToMatch))), []));
        }
      }
    }
  };
}
