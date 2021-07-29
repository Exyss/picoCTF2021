# Transformation 

## Overview

* Points: 20
* Category: Reverse Engineering
* Author: Madstacks

## Description
I wonder what this really is... [enc](https://mercury.picoctf.net/static/77a2b202236aa741e988581e78d277a6/enc) `''.join([chr((ord(flag[i]) << 8) + ord(flag[i + 1])) for i in range(0, len(flag), 2)])`

## Hints

1. You may find some decoders online

## Approach

1. The given code string is the Python program with which the flag was encrypted. Since we know that the flag must be formatted as picoCTF{XXXX}, you can test the encryption by trying to execute that line of code using "pico" as a test
2. The code executes a one byte shift on every character of the flag (with an interval of 2), adding it up to his directily next character.
3. The solution can be achieved by [reversing the operations](decrypt.py) executed by the encryption script

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{16_bits_inst34d_of_8_75d4898b}__
</details>