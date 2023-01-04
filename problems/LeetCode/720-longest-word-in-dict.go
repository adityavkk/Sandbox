package main

import "fmt"

type trie_Node struct {
	//assigning limit of 26 for child nodes
	childrens [26]*trie_Node
	//declaring a bool variable to check the word end.
	wordEnds bool
}

func main() {
	fmt.Print("hello")
}
