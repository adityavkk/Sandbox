const log = console.log;

class Node {
	constructor(c, l, v, r) {
		this.c = c;
		this.l = l;
		this.v = v;
		this.r = r;
	}
}

const node = (c, l, v, r) => new Node(c, l, v, r);

function insert(v, n) {
	function helper(n) {
		return match(n,
			[Node(c, l, x => x > v, r), bal(node(c, helper(l), x, r))],
			[Node(c, l, x => x < v, r), bal(node(c, l, x, helper(r)))],
			[Node(_, _, x => x === v, _), n],
			[null, node(0, null, v, null)]
		)
	}
	const root = helper(n);
	return node(1, root.l, root.v, root.r);
}

function bal(n) {
	return match(n,
		[Node(2, Node(-1, Node(_, a, w, b), x, Node(_, c, y, d)), z, e), 
 		 	node(1, node(1, Node(0, a, w, b), x, c), y, node(1, d, z, e))],
 		[Node(2, a, w, Node(-1, Node(_, b, x, c), y, Node(_, d, z, e))), 
 		 	node(1, node(1, node(0, a, w, b), x, c), y, node(1, d, z, e))],
 		[Node(col => [1,2].includes(col), Node(0, Node(0, a, x, b), y, c), z, d),
 		 	node(col - 1, node(1, a, x, b), y, node(1, c, z, d))],
 		[Node(col => [1,2].includes(col), a, x, Node(0, b, y, Node(0, c, z, d))),
 		 	node(col - 1, node(1, a, x, b), y, node(1, c, z, d))],
 		[Node(col => [1,2].includes(col), a, x, Node(0, Node(0, b, y, c), z, d)),
 		 	node(col - 1, node(1, a, x, b), y, node(1, c, z, d))],
 		[Node(col => [1,2].includes(col), Node(0, a, x, Node(0, b, y, c)), z, d),
 		 	node(col - 1, node(1, a, x, b), y, node(1, c, z, d))],
		[_, n]
	)
}

function del(v, n) {
	function helper(v, n) {
		return match(n,
			[null, null],
			[Node(0, null, x => x === v, null), null],
			[Node(c, Node(_, bl, bv, br), x => x === v, null), node(c, bl, bv, br)],
			[Node(c, null, x => x === v, Node(_, bl, bv, br)), node(c, bl, bv, br)],
			[Node(c, Node(_,_,_,_), x => x === v, Node(_,_,_,_)), 
				bubble(node(c, n.l, min(n.r), helper(min(n.r), n.r)))],
			[Node(c, Node(1, null, x => x === v, null), v, Node(_, rl, rv, rr)),
				bubble(node(c + 1, null, v, Node(0, rl, rv, rr)))],
			[Node(c, Node(_,ll,lv,lr), v, Node(1,null, x => x === v), null),
				bubble(node(c + 1, Node(0,ll,lv,lr), v, null))],
			[Node(c, l, x => x < v, r), bubble(node(c, l, x, helper(v, r)))],
			[Node(c, l, x => x > v, r), bubble(node(c, helper(v, l), x, r))],
			[Node(_, null, x => x === v, null), null]
		)
	}
	const root = helper(v, n);
	return root ? node(1, root.l, root.v, root.r) : null;
}

function bubble(n) {
	return match(n,
		[Node(col=>[1,0].includes(col), Node(2, ll, lv, lr), v, Node(rc, rl, rv, rr)),
		 bal(node(col + 1, Node(1, ll, lv, lr), v, Node(rc - 1, rl, rv, rr)))],
		[Node(col=>[1,0].includes(col), Node(lc, ll, lv, lr), v, Node(2, rl, rv, rr)),
		 bal(node(col + 1, Node(lc - 1, ll, lv, lr), v, Node(1, rl, rv, rr)))],
		[_, n]
	)
}

function min(n) {
	if (!n.l) { 
		return n.v;
	}	else {
		return min(n.l);
	}
}

function printNode(n) {
	if (!n) return '';
	const color = c => { 
		let col = null;
		switch (c) {
		case 1:
			 col = 'black';
			 break;
		case 0:
			 col = 'red';
			 break;
		case 2:
			 col = 'double black';
			 break;
		case -1:
			 col = 'negative black';
			 break;
		}
	return col
	}
	return [n.v + ' ' + color(n.c), printNode(n.l), printNode(n.r)];
}

const t = [5,2,9,8,6,11].reduce((acc, curr) => insert(curr, acc), null)
const t1 = del(8,t);
log(JSON.stringify(t1, null, 4));
