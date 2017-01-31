## Using Typeclasses 
- Typeclasses allow us to define generic interfaces that provide a common feature
set over a wide variety of types.

- Without Typeclasses, overloading functions wouldn't be possible.

### What are Typeclasses? 
- They define a set of functions that can have different implementations depending 
on the type of data they are given. 
- Typeclasses may look like the objects of object-oriented programming, but 
they are truly quite different. 

```haskell
class BasicEq a where
  isEqual    :: a -> a -> Bool
  isNotEqual :: a -> a -> Bool
```

- On the first line, the name of the parameter a was chosen arbitrarily.
- You can read the definition the following way: For all types a, so
long as a is an instance of BasicEq, isEqual takes two parameters
of type a and returns a Bool

```haskell
-- instances can be defined in the following way
instance BasicEq Bool where
  isEqual True True   = True
  isEqual False False = True
  isEqual _ _         = False
```

- We're making users of our code implement 2 methods, `isEqual` and
`isNotEqual` when we know that one depends on the other.
- We can provide default implementations for them.

```haskell
class BasicEq a where
   isEqual :: a -> a -> Bool
   isEqual x y = not (isNotEqual x y)

   isNotEqual :: a -> a -> Bool
   isNotEqual x y = not (isEqual x y)
```

- Now, since we've provided function definitions in the class
definition, ghc will treat them as default implementations of the
function unless the user implementing the instance explitly definies the
function themselves
- However, in this case, since each function depends on the other, if
the user doesn't provide at least one, the functions will loop
infinitely.
- The above implementation is in fact, how the Haskell spec itself
defines (==) and (/=)

```haskell
class Eq a where
  (==), (/=) :: a -> a -> Bool

  z /= y = not (x == y)
  x == y = not (x /= y)
```

### Automatic Derivation
- For many simple data types, the Haskell compiler can automatically
derive instances of `Read`, `Show`, `Bounded`, `Enum`, `Eq` and `Ord` for us

```haskell
data Color = Red | Green | Blue
  deriving (Read, Show, Eq, Ord)
```

- Note that the sort order for `Color` will be based on the order in
which the constructors were defined.
- Automatic derivation is not always possible. For instance, if you
defined a type of: 
```haskell
data MyType = MyType (Int -> Bool)
```
- The compiler wouldn't be able to derive an instance of `Show` because
it doesn't know how to render a function.

