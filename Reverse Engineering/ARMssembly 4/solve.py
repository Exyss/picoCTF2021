w0 = w1 = w2 = 0
x29_16 = x29_28 = x29_44 = 0
sp_12 = sp_24 = sp_20 = sp_28 = 0

def func1():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    x29_28 = w0
    w0 = x29_28

    if w0 <= 100:
        L2()

    else:
        w0 = x29_28
        w0 = w0 + 100
        func2()
        return      #run L3

def L2():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20
    
    w0 = x29_28
    func3()
    return      #run L3

def func2():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20
    
    x29_28 = w0
    w0 = x29_28

    if w0 > 499:
        L5()

    else:
        w0 = x29_28
        w0 = w0 - 86
        func4()
        return      #run L6

def L5():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20
    
    w0 = x29_28
    w0 = w0 + 13
    func5()
    return      #run L6

def func3():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20
    
    x29_28 = w0
    w0 = x29_28
    func7()
    return

def func4():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    x29_28 = w0
    w0 = 17
    x29_44 = w0
    w0 = x29_44

    func1()

    x29_44 = w0
    w0 = x29_28
    return

def func5():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    x29_28 = w0
    w0 = x29_28

    func8()

    x29_28 = w0
    w0 = x29_28
    return

def func6():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    sp_12 = w0
    sp_24 = 314
    w0 = 1932
    sp_28 = w0
    sp_20 = 0

    L14()

def L15():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    w1 = sp_28
    w0 = 800

    w0 = w1 * w0
    w1 = sp_24

    w2 = w0 // w1
    w1 = sp_24

    w1 = w2 * w1
    w0 = w0 - w1
    sp_12 = w0
    w0 = sp_20

    w0 = w0 + 1
    sp_20 = w0
    L14()

def L14():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    w0 = sp_20
    if w0 <= 899:
        L15()
    else:
        w0 = sp_12
    
    return

def func7():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    sp_12 = w0
    w0 = sp_12

    if w0 <= 100:
        L18()
    else:
        w0 = sp_12
        return      #run L19

def L18():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    w0 = 7
    return      #run L19

def func8():
    global w0, w1, w2, x29_28, x29_44, x29_16, sp_12, sp_24, sp_28, sp_20

    sp_12 = w0
    w0 = sp_12
    w0 = w0 + 2
    return

# ------------------------------ MAIN

w0 = 1151828495
x29_44 = w0
w0 = x29_44
func1()
w1 = w0
print("The final value is: {} (hex: {:x})".format(w1, w1))