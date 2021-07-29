# Nice netcat... 

## Overview

* Points: 15
* Category: General Skills
* Author: Syreal

## Description
There is a nice program that you can talk to by using this command in a shell: `$ nc mercury.picoctf.net 7449`, but it doesn't speak English...

## Hints

1. You can practice using netcat with this picoGym problem: [what's a netcat?](https://play.picoctf.org/practice/challenge/34)
2. You can practice reading and writing ASCII with this picoGym problem: [Let's Warm Up](https://play.picoctf.org/practice/challenge/22)

## Approach

1. Executing Netcat with the given address and port gives out a series of decimal numbers
2. Simply convert these numbers to ASCII characters either by hand, by using CyberChef or by writing a quick python script in order to get the flag.
3. You can use my example script by running `python read.py nc mercury.picoctf.net 7449`

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{g00d_k1tty!_n1c3_k1tty!_f2d7cafa}__
</details>