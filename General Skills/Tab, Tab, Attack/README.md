# Tab, Tab, Attack

## Overview

* Points: 20
* Category: General Skills
* Author: Syreal

## Description
Using tabcomplete in the Terminal will add years to your life, esp. when dealing with long rambling directory structures and filenames: [Addadshashanammu.zip](https://mercury.picoctf.net/static/72712e82413e78cc8aa8d553ffea42b0/Addadshashanammu.zip)

## Hints

1. After `unzip`ing, this problem can be solved with 11 button-presses...(mostly Tab)...

## Approach

1. As the hint suggests, just unzip the given file using `unzip {file_name}`. After that start typing `cd ` and then keep pressing tab until you get to the last directory. Use `ls` to list the files.
2. The file contained in the last directory is an ELF executable. Use `strings` on the file to get the flag, or just run `strings fang-of-haynekhtnamet | grep picoCTF`

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{l3v3l_up!_t4k3_4_r35t!_6f332f10}__
</details>