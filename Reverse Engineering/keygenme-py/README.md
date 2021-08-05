# crackme-py

## Overview

* Points: 30
* Category: Reverse Engineering
* Author: Syreal

## Description
> [keygenme-trial.py](https://mercury.picoctf.net/static/9cc50abd5b012891d5a1132e05f15a07/keygenme-trial.py)

## Hints

1. None!

## Approach

1. The Arcane Calculator (the given .py file) is only a trial version and we need an user key (the flag) to fully unlock it.
2. By looking inside the code, we can see that the only things that we really care about are the initial part of the program where all the global variables are defined and the `check_key` function (around line 140).
3. We must find the missing part of the key in order to get the flag:
```python
key_part_static1_trial = "picoCTF{1n_7h3_|<3y_of_"
key_part_dynamic1_trial = "xxxxxxxx"
key_part_static2_trial = "}"
key_full_template_trial = key_part_static1_trial + key_part_dynamic1_trial + key_part_static2_trial
```
4. By looking inside the `check_key` function, we can see that the code verifies the input given by the user (which in this case a test flag).
This code hashes the byte encoding of the trial username `SCHOFIELD` with a sha256 algorithm, then takes the 4th, 5th, 3rd, 6th, 2nd, 7th, 1st and 8th characters of the hash and compares them to the dynamic part of the key given by the user.
5. We can find these seven characters simply by writing this quick script, then add them to the other two static parts of the key:
```python
import hashlib

bUsername_trial = b"SCHOFIELD"
key_part1 = "picoCTF{1n_7h3_|<3y_of_"
key_part2 = "}"

h = hashlib.sha256(bUsername_trial).hexdigest()
missing_key_part = "" + h[4] + h[5] + h[3] + h[6] + h[2] + h[7] + h[1] + h[8]
print("Missing part: "+missing_key_part)

key = key_part1 + missing_key_part + key_part2
print("Full key: "+key)
```

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{1n_7h3_|<3y_of_e584b363}__
</details>