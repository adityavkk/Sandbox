
class Node:
    def __init__(self, state, parent, action, path_cost):
        self.state = state # the state in the state space to which the node corresponds;
        self.parent = parent # the node in the search tree that generated this node;
        self.action = action # the action that was applied to the parent to generate the node;
        self.path-cost = path-cost # the cost, traditionally denoted by g(n), of the path from the initial state to the node, as indicated by the parent pointers

def child_node(parent, problem, action):
    state = action(parent, problem)
    path_cost = parent.path_cost + problem.step_cost(parent.state, action)
    return Node(state, parent, action, path_cost)

