# ARMssembly 4

## Overview

* Points: 130
* Category: Reverse Engineering
* Author: Dylan McGuire

## Description
> What integer does this program print with argument `1151828495`? File: [chall_4.S](https://mercury.picoctf.net/static/0a6c557375c9131dd67cb19beabd7d0c/chall_4.S) Flag format: picoCTF{XXXXXXXX} -> (hex, lowercase, no 0x, and 32 bits. ex. 5614267 would be picoCTF{0055aabb})

## Hints

1. Switching things up

## Approach

1. This program has a __lot__ of branches, meaning that it's flow is really hard to follow. You could try to make a flow diagram just like in the [previous challenge](../ARMssembly%203), but you would just end up making a mess (quick tip in case you want to try this: this program probably involves a switch or a multiple-case if statement)
2. The easiest way to solve this is to write a [python script](solve.py) that replicates the assembly program __line by line__, feed it the given value (1151828495), get the hex value and format the flag.

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{44a78282}__
</details>
