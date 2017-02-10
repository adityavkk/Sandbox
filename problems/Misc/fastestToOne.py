def even(n):
    return n % 2 == 0

def f(n):
    s = 1
    while(n != 1):
        s += 1
        if(even(n)):
            n = n / 2
        elif(even((n + 1)/2)):
            n += 1
        else:
            n -= 1
    return s
