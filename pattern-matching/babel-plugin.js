// doesn't test nested constructor values
module.exports = function(babel) {
  const t = babel.types;
  // export default function (babel) {
  //  const { types: t } = babel;

  return {
    name: "ast-transform", // not required
    visitor: {
      CallExpression(path) {
        if (path.node.callee.name === 'match') {
          let arg = path.node.arguments[0];
          let pairs = path.node.arguments.slice(1);
          let conditionalBranches = [];

          const isIdent = n => t.isIdentifier(n),
            isWC = n => isIdent(n) && n.name === '_',
            isCaps = s => s.toUpperCase() === s,
            isVar = n => isIdent(n) && !isCaps(n.name[0]),
            isConstructor = n => t.isCallExpression(n) && isCaps(n.callee.name[0]),
            getConstructor = n => t.memberExpression(t.memberExpression(n, t.identifier('constructor')), t.identifier('name')),
            objVals = n => t.callExpression(t.memberExpression(t.identifier('Object'), t.identifier('values')), [n]),
            index = (n, i) => t.memberExpression(n, t.numericLiteral(i), true),
            makeLet = p => t.variableDeclaration("let", [t.variableDeclarator(p[0], p[1])]),
            makeAnd = (a, b) => t.logicalExpression('&&', a, b),
            makeEq = (a, b) => t.binaryExpression('===', a, b),
            pLength = p => t.isArrayExpression(p) ? p.elements.length : p.arguments.length;

          function makeCondition(a, p, l) {
            if (isWC(p))
              return t.booleanLiteral(true);
            if (isVar(p)) {
              l.push([p, a])
              return t.booleanLiteral(true);
            }
            if (isConstructor(p)) {
              let conditions = [];
              conditions.push(a);
              conditions.push(makeEq(getConstructor(a), t.stringLiteral(p.callee.name)));
              conditions.push(makeEq(t.numericLiteral(pLength(p)),
                t.memberExpression(objVals(a), t.identifier('length'))));
              conditions = conditions.concat(p.arguments.map((e, i) => makeCondition(index(objVals(a), i), e, l)));
              return conditions.reduce(makeAnd);
            }
            if (t.isArrayExpression(p)) {
              let conditions = [];
              conditions.push(makeEq(t.numericLiteral(pLength(p)),
                t.memberExpression(objVals(a), t.identifier('length'))));
              conditions = conditions.concat(p.elements.map((e, i) => makeCondition(index(objVals(a), i), e, l)));
              return conditions.reduce(makeAnd);
            }
            return makeEq(a, p);
          }

          pairs.forEach(function(x) {
            let locals = [];
            let condition = makeCondition(arg, x.elements[0], locals);
            let consequent = t.blockStatement(locals.map(makeLet)
              .concat(t.returnStatement(x.elements[1])));

            conditionalBranches.push(t.ifStatement(condition, consequent));
          })
          path.replaceWith(t.callExpression(t.arrowFunctionExpression([], t.blockStatement(conditionalBranches)), []));
        }
      }
    }
  };
}

