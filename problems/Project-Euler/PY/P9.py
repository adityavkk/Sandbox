
def triplet_gen ():
    one_thousand = range(1, 1000)

    return [(a, b) for a in range(100) for b in range(100)]

print(triplet_gen())
