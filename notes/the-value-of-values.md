# The Value of Values
## Plop
- PLace-Oriented Programming
- New information replaces old
- Born of limitations of early computers
- These limitations are long gone
- There's one thing that keeps being brought up that is the efficiences of place
  - Ok when 'birthing' new values i.e prior to becoming a fact
  - Ofcourse we have to use places right - but its an implementation detail
  - It's not ABOUT places

## Memory and Records
- Think about the abstraction our brains have built up around memory
- Imagine when your friend changes his phone number - you dont go and change the place where you stored his old phone number
- We deal with memory in too low a level of detail in writing programs

- Is the history of programming languages a history of abstracting over place?

- PLACE has no role in an information model

# Programming Values
- Don't need methods
  - They are not operationaly defined
- Are semantically transparent
  - Your ability to do equality on it?
- They should be able to be shared freely
  - Aliases are free
- You don't have to reproduce state
- With places you have to emulate an operational interface
- The problem with places is that they FORCE you to write imperatively
- Pure values are language independend
- Places are defined by language constructs because they are idiosyncratic abstractions by a particular implementation

- If I take 5 values and put it together in a value list, that resulting thing is also a value
  - All the benefits of a value accrue to compositions of values

### Values offer Reduced Coordination
- In the small : Values - no locks, Places: Lock policies don't aggregate


- There will be garbage
  - Maybe need an analogy to GC in storage just like we have in code


