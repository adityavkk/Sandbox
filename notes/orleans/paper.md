# Abstract

The actor model makes it natural to build a stateful middle tier and achieve the required performance. However, the popular actor model platforms still pass many distributed systems problems to developers.

Erlang is a dynamically-typed, functional, single-assignment, GCd, language with eager eval. Erlang has an actor model and concurrency is supported by lightweight processes that communicate through shared-nothing asynchronous message passing

Orlens implements a novel abstraction called the *virtual actor*; this abstraction can be seen as an abstraction over the *simple one for one* supervisor model where actors are created to perform a task with one main difference; in Orleans actors are instantiated on demand and estroyed when they are not in use.

# Introduction
The traditional three-tiered architecture with stateless middle and front-ends, with a storage layer has limited scalability due to the limits of the storage layer that has to be consulted for every request.

Usually a cache is added at this layer to improve performance. However, a cache looses most of the concurrency and semantic guarantees of the underlying storage layer. To pervent inconsistencies caused by the concurrent updates to a cached item, the application or the cache has to implement a concurrency control protocol.

Instead of the data shipping paradigm where each request corresponds to data being sent from the cache or the storage layer to the middle tier, the actor model offers a function shipping paradigm.

- Function Shipping
    This allows for a stateful middle tier that has the performance benefits of a cache with data locality and the semantic and consistency benefits of encapsulated entities via application-specific operations.

- Data Shipping
    Every request corresponds to data being sent from the cache or the storage layer to the middle tier



