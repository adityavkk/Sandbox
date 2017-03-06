## Introduction
- Fundamental operation in functional programming is the application of
    functions to arguments
- A main program itself is written as a function that receives the
    program's input as its argument and delivers the program's output as
    its result.
- Functional programs contain no assignment statements, so variables,
    once given a value, never change.
    - More generally, functions contain no side-effects at all.
- This eliminaates a major source of bugs, and also makes the order of
    execution irrelevant -- since no side-effect can change an
    expression's value, it can be evaluated at any time.
- Notion of equality -- Since expressions can be evaluated at any time,
    one can freely replace variables by their values and vice versa
    - programs are _"referentially transparent"_

## Glueing Functions Together

### On Lists
- A simple list processing problem -- adding the elements of a list.

  ```haskell
  listof * ::= Nil | Cons * (listof *)

  sum Nil           = 0
  sum (Cons n list) = num + sum list
  ```
- Examining the above definiton of `sum`, we see that only the initial
    value `0` and `+` are specific to computing a sum.
- This means that the computation of a sum can be modularized by gluing
    together a general recursive pattern and the specific parts. This
    recursive pattern is conventionally called `foldr` and so `sum` can
    be expressed as

    ```haskell
    sum = foldr (+) 0
    ```
- The very definition of `foldr` can be derived by just parametrizing
    the definition of `sum`, giving

    ```haskell
    foldr f z Nil           = z
    foldr f z (Cons n list) = f n (foldr f z list)
    ```
- Having modularized `sum` in this way, we can reap benefits by reusing
    the parts. The most interesting part is `foldr`, which can be used
    to write down a function for multiplying together the elements of a
    list with no further programming

      ```haskell
      product = foldr (*) 1
      ```

    - It can also be used to test whether any or all of a list of booleans is
        true

      ```haskell
      anytrue = foldr (or) False
      alltrue = foldr (and) True
      ```

    - It can be used to compute the number of elements in a list

      ```haskell
      length    = foldr count 0
      count x c = c + 1
      ```

- One way to understand `foldr f z` is as a function that replaces all
    occurrences of `Cons` in a list by `f`, and all occurrences of `Nil`
    by `z`.
    - Now it's obvious that `foldr Cons Nil` just copies a list. Since
        once list can be appended to another by `Cons`ing its elements
        onto the front, we find

        ```haskell
        append a b = foldr Cons b a
        ```

- Map as a fold: Let's write a function that doubles all the elements of
    a list

    ```haskell
    doubleall = foldr doubleandcons Nil

    doubleandcons n list = Cons (2 * n) list

    -- doubleandcons can be modularized further by abstracting out the
    -- doubling function

    doubleandcons = fandcons double
    fandcons f el list = Cons (f el) list
    
    -- we can refactor fandcons
    fandcons f = Cons . f

    -- Combining, we get:
    doubleall = foldr (Cons . double) Nil

    -- With one further modularization -- abstracting out double, we get
    doubleall = map double
    map f = foldr (Cons . f) Nil
    ```

### On Trees
- Consider the datatype of ordered labeled trees

  ```haskell
  treeof * ::= Node * (listof (treeof *))
  ```

- Let's see how we can define `foldtree` the analog for `foldr`
  - Since `foldr` needed something to replace `Cons` and `Nil`, it took
      2 arguments. Likewise, since trees are constructed with 3 things,
      namely, `Node`, `Cons` and `Nil`, `foldtree` needs 3 arguments,
      something to replace each of these things with.

  ```haskell
  foldtree f g a (Node label subtrees) = 
    f label (foldtree f g a subtrees)
  foldtree f g a (Cons subtree rest)   =
    g (foldtree f g a subtree) (foldtree f g a rest)
  foldtree f g a Nil = a
  ```
  - Note: I don' think that this will typecheck in Haskell because it
      the above function is pattern matching on `treeof` and on
      `listof`. It might have to get wrapped into another type
      `treeOrListOfTree` or something

- With the above `foldtree` defined, we can now define many interesting
    functions by gluing `foldtree` and other functions together.

    - Sum of all labels in a tree and a list of all labels in a tree

    ```haskell
    sumtree = foldtree (+) (+) 0
    labels  = foldtree Cons append Nil
    ```

- Finally, one can define a function analogous to `map` which applies a
    function `f` to all the labels in a tree

    ```haskell
    maptree f = foldtree (Node . f) Cons Nil
    ```

- All this can be achieved because functional languages allow functions
    that are indivisible in conventional programming languages to be
    expressed as combinations of parts -- a general higher-order
    function and some particular specilizing functions.
- Once defined, such higher-order functions allow many operations to be
    programmed very easily.
- The best analogy with conventional programming is with extensible
    languages -- in effect, the programming language can be extended
    with new control structures whenever desired.

## Gluing Programms Together
- Recall that a complete functional program is just a function from its
    input to its output.
    - if `f` and `g` are such programs, then `(g . f)` is a program
        that, when applied to its input, computes `g (f input)`
    - The program `f` computes its output, which is used as the input to
        program `g`.
    - In functional programming the two programs `f` and `g` are run
        together in strict synchronization. Program `f` is started only
        when `g` tries to read some input, and runs only for long enough
        to deliver the output `g` is trying to read.
    - Then `f` is suspended and `g` is run until it tries to read
        another input. As an added bonus, if `g` terminates without
        reading all of `f`'s output, then `f` is aborted.
    - `f` can even be a nonterminating program, producing an infinite
        amount of output, since it will be terminated forcibly as soon
        as g is finished. This allows termination conditions to be
        seperated from lGlueingoop bodies -- a powerful modularization.
