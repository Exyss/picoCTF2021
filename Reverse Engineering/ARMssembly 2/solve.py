w0 = 1748687564
sp_12 = w0
sp_24 = 0
sp_28 = 0
w1 = sp_28

while(w1 < w0):
    sp_24 += 3
    sp_28 += 1

    w1 = sp_28
    w0 = sp_12

    print(f"w0: {w0}\tw1: {w1}\tsp_12: {sp_12}\tsp_24: {sp_24}\tsp_28: {sp_28}")

w0 = sp_24
print(f"The value is: {w0}")