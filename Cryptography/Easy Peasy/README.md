# Easy Peasy

## Overview

* Points: 40
* Category: Cryptography
* Author: Madstacks

## Description
> A one-time pad is unbreakable, but can you manage to recover the flag? (Wrap with picoCTF{}) `nc mercury.picoctf.net 41934` [otp.py](https://mercury.picoctf.net/static/1f148e5cdf8bd2c9f752b14d46a3f2f2/otp.py)

## Hints

1. Maybe there's a way to make this a 2x pad.

## Approach

1. Every time we connect to the hosted service, we get the following prompt:
```bash
******************Welcome to our OTP implementation!******************
This is the encrypted flag!
0345376e1e5406691d5c076c4050046e4000036a1a005c6b1904531d3941055d

What data would you like to encrypt?
```
If we try to input some characters, in example AAAAAA, we get an encrypted result:
```bash
What data would you like to encrypt? AAAAAA
Here ya go!
1d3925701d39

What data would you like to encrypt? AAAAAA
Here ya go!
c0201d39702021
```
As we can see, every time we try to input something, the encryption changes. However, if we __restart the connection__, we get the same results. This means that the key gets resetted every time we connect to the service.

2. By looking into the given code, we can see that the main program cycle consists in an `XOR encryption software` that uses a "rotating" one-time pad: the key is a range of characters obtained from a string (which we'll call `key_string`) with a fixed lenght of 50000 character. Every time we use the encryption mechanism, the range gets shifted.
3. By analyzing the main mechanism of the program, we can see that the startup mechanism takes the characters in the range [0 -> flag_lenght] from the key_string. Once the flag gets encrypted, the `key_location` value  (indicating where the next range should start) gets updated with the flag_length value: the next time the encryption gets used the character range will start from the flag_length!

4. Every other encryption will set the key_location variable to the end of the last character range. When the program starts, the key_location variable gets set to the flag_lenght (end of the __first encryption__), then to the end of the __second encryption__, then to the end of the __third encryption__ and so on, with the ending part always being the lenght of the to-be-encrypted string given by the user

```
SCHEMATIC:

first_encryption = [0 -> flag_length]
second encryption = [first_encryption -> input_length]
third encryption = [second_encryption -> input_length]
....
```
5. Due to the nature of the XOR encryption, we have to "reset" the key_location variable to 0 by "feeding" the program `49968 characters`, then input the encrypted flag (if you XOR an already XORed string you get the original string).
You can see my script [here](solve.py)

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{abf2f7d5edf082028076bfd7a4cfe9a9}__
</details>