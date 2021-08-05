# New Caesar

## Overview

* Points: 60
* Category: Cryptography
* Author: Madstocks

## Description
> We found a brand new type of encryption, can you break the secret code? (Wrap with picoCTF{}) `ihjghbjgjhfbhbfcfjflfjiifdfgffihfeigidfligigffihfjfhfhfhigfjfffjfeihihfdieieih` [new_caesar.py](https://mercury.picoctf.net/static/2fc43dd1a3718df7debf367b0e092831/new_caesar.py)

## Hints

1. How does the cipher work if the alphabet isn't 26 letters?
2. Even though the letters are split up, the same paradigms still apply

## Approach

1. Looking through the code, we can see that the encryption used is made up of an encoding in base16 followed by a character shifting using a defined key. The program contains two assert keyworks, which throw an AssertError in case the condition given is false (this is usually used for debugging):
```python
assert all([k in ALPHABET for k in key])	#assert throws an error if the condition is false so the key
assert len(key) == 1						#must be of length 1 and must use chars avaible in ALPHABET
```
These two asserts define the two "rules" that the key must follow: it must contain only characters contained in the declared string ALPHABET and it must be of length 1

2. First of all, we have to invert the two functions that can invert the encoding and shifting operations:
```python
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
```

3. Then, we have to apply this two functions to the given encrypted string, testing every possible key used in the shifting by bruteforcing the whole defined alphabet:
```python
enc = "ihjghbjgjhfbhbfcfjflfjiifdfgffihfeigidfligigffihfjfhfhfhigfjfffjfeihihfdieieih"

for key in ALPHABET:
    unshifted = ""
    for i, c in enumerate(enc):
	    unshifted += unshift(c, key[i % len(key)])

    plain = b16_decode(unshifted)
    print("Testing with %s: picoCTF{%s}" % (key, plain))
```
The full code implementation can be found [here](solve.py)

4. By looking at the program output, we can see that using "c" as the key gives out the right flag

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{et\_tu?\_0797f143e2da9dd3e7555d7372ee1bbe}__

Looks like a very clever reference to Caesar's famous death-quote "Et tu, Brute?" (Also Brute = bruteforce!)
</details>