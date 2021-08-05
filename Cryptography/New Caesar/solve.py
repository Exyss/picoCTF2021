import string

LOWERCASE_OFFSET = ord("a")		#97
ALPHABET = string.ascii_lowercase[:16]	#abcdefghijklmnop

def b16_encode(plain):
	enc = ""
	for c in plain:
		binary = "{0:08b}".format(ord(c))   #the char gets converted to a byte
        
		enc += ALPHABET[int(binary[:4], 2)]     #the byte gets splitted in two parts
		enc += ALPHABET[int(binary[4:], 2)]     #then they both get converted to a new char
	return enc 

def shift(c, k):
	t1 = ord(c) - LOWERCASE_OFFSET
	t2 = ord(k) - LOWERCASE_OFFSET
	return ALPHABET[(t1 + t2) % len(ALPHABET)]

# -------------------------------------- REVERSED FUNCTIONS

def b16_decode(enc):
    plain = ""
    for i in range(0, len(enc), 2):
        fst_part = ALPHABET.index(enc[i])
        fst_4bits = "{0:04b}".format(fst_part)  #re-convert the first char to the fist part of the byte

        snd_part = ALPHABET.index(enc[i+1])
        snd_4bits = "{0:04b}".format(snd_part)  #do the same for the second part

        byte = fst_4bits + snd_4bits
        plain += chr(int(byte, 2))  #reconvert the full byte to a char
    return plain

def unshift(c, k):
    in_alphabet = ALPHABET.index(c)
    t2 = ord(k) - LOWERCASE_OFFSET

    #bruteforce to find original t1
    for i in range(16):
        if (i + t2) % 16 == in_alphabet:
            t1 = i

    return chr(t1 + LOWERCASE_OFFSET)

def inv_modulo(a, p):
    for d in range(1, p):
        r = (d * a) % p
        if r == 1:
            break
    else:
        raise ValueError('%d has no inverse mod %d' % (a, p))
    return d

# -------------------------------------- SOLUTION

enc = "ihjghbjgjhfbhbfcfjflfjiifdfgffihfeigidfligigffihfjfhfhfhigfjfffjfeihihfdieieih"

for key in ALPHABET:
    unshifted = ""
    for i, c in enumerate(enc):
	    unshifted += unshift(c, key[i % len(key)])

    plain = b16_decode(unshifted)
    print("Testing with %s: picoCTF{%s}" % (key, plain))