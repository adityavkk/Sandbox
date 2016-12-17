// Say you have an array for which the ith element is the price of a given 
// stock on day i. Design an algorithm to find the maximum profit. You may 
// complete at most two transactions. Each transaction is a buy and sell.

// Note:
// You may not engage in multiple transactions at the same time
// (ie, you must sell the stock before you buy again).

const
  mt = xs => !xs.length,
  passTransform = (bPrice, comp, currP, i, sps) => [bPrice, comp, currP, i + 1, sps],
  buyTransform = (bPrice, comp, currP, i, sps) => [sps[i], comp, currP, i + 1, sps],
  sellTransform = (bPrice, comp, currP, i, sps) => {
    return [0, comp + 1, currP + sps[i] - bPrice, i + 1, sps]
  },
  canBuy = (bPrice, comp) => bPrice === 0 && comp < 2,
  canSell = (bPrice, comp, currP, i, sps) => bPrice > 0 && i < sps.length,
  memo = {};

function maxProfitIter(boughtAt, completed, currProfit = 0, i, sps) {
  const key = [boughtAt, completed, currProfit, i].toString(),
    currPrice = sps[i],
    passArgs = passTransform(...arguments)
  let v = memo[key]
  if (v) return v
  if (i > sps.length - 1 || completed >= 2 || currProfit < 0) v = currProfit
  else if (canBuy(...arguments)) {
    const buyArgs = buyTransform(...arguments)
    v = Math.max(maxProfitIter(...buyArgs), maxProfitIter(...passArgs))
  } else if (canSell(...arguments)) {
    const sellArgs = sellTransform(...arguments)
    v = Math.max(maxProfitIter(...sellArgs), maxProfitIter(...passArgs))
  } else v = maxProfitIter(...passArgs)
  memo[key] = v
  return v
}

const maxProfit = sps => maxProfitIter(0, 0, 0, 0, sps)

console.log(maxProfit([1])) // => 11 :-)
