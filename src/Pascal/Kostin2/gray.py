def gray(m):
    if m == -1:
        print S
    else:
        gray(m-1)
        S[m] = 1 - S[m]
        gray(m-1)

N = 3
S = [0 for _ in range(N)]
gray(N-1)
