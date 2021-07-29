# Mod 26

## Overview

* Points: 10
* Category: Cryptography
* Author: Pandu

## Description
Cryptography can be easy, do you know what ROT13 is?

__cvpbPGS{arkg_gvzr_V'yy_gel_2_ebhaqf_bs_ebg13_jdJBFOXJ}__

## Hints

1. This can be solved online if you don't want to do it by hand!

## Approach

1. ROT13 (or "Rotate by 13 places") is one of the most common and simplest cyphers available to achieve cryptography.
2. The algorithm consists in replacing every character of a text message with the character 13 places ahead in the alphabet, wrapping back to the beginning in case of excess. For example, the character A becomes N, the character B becomes O and so on.
3. To achieve the flag we have to simply apply the rotation to each character or the given string, either by hand, by writing a small program or by using an [online tool](https://rot13.com/).

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{next_time_I'll_try_2_rounds_of_rot13_wqWOSBKW}__
</details>