/*
Approach: 
  - for d in dirs:
    if next d = inverse d:
      
  


*/


func DirReduc(arr []string) []string {
    
}

var a = []string{"NORTH", "SOUTH", "EAST", "WEST"}
dotest(a, []string{})
a = []string{"NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"}
dotest(a, []string{"WEST"})
a = []string{"NORTH", "WEST", "SOUTH", "EAST"}
dotest(a, []string{"NORTH", "WEST", "SOUTH", "EAST"})
a = []string{"NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "NORTH"}
dotest(a, []string{"NORTH"})
