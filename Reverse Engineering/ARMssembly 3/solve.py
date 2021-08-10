def func1(w0):

    x29_28 = w0
    x29_44 = 0
    w0 = x29_28

    print("w0: {:10} | [x29 + 28]: {:10} | [x29 + 44]: {:10}".format(w0, x29_28, x29_44))

    while w0 != 0:
        w0 = x29_28

        w0 = w0 & 1

        if w0 != 0:
            #run func2
            w0 = x29_44
            w0 = w0 + 3
            x29_44 = w0

        #else jump straight to L3
        w0 = x29_28
        w0 = w0 >> 1
        x29_28 = w0

        print("w0: {:10} | [x29 + 28]: {:10} | [x29 + 44]: {:10}".format(w0, x29_28, x29_44))

    w0 = x29_44
    return w0

#--------- MAIN

w1 = func1(597130609)
print("The final value is: {} (hex: {:x})".format(w1, w1))