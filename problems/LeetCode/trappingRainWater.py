# 42: Trapping Rain Water
# Given Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
# Example: Input: [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6

def find_peaks(es):
    def is_peak(i, x):
        if (i == len(es) - 1): return es[i - 1] < x
        if (i == 0): return es[i + 1] < x
        return es[i + 1] < x and es[i - 1] < x

    return [(x, i) for (i, x) in enumerate(es) if is_peak(i, x)]

def f(elevations):
    peaks = find_peaks(elevations)
    e_peaks = list(enumerate(peaks))
    water = 0
    def get_water(p, i, j):
        return sum([p - x for x in elevations[i:j]])
    for (pi, (p, i)) in e_peaks:
        if pi == len(peaks) - 1:
            continue
        else:
            (pj, (next_peak, j)) = e_peaks[pi + 1]
            if next_peak > p:
                water += get_water(p, i + 1, j)
            else:
                water += get_water(next_peak, i + 1, j)
    return water

elevations = [0,1,0,2,1,0,1,3,2,1,2,1]
res = f(elevations)
print(find_peaks(elevations))
print(res)


