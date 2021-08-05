# MacroHard WeakEdge   

## Overview

* Points: 60
* Category: Foresincs
* Author: Madstacks

## Description
I've hidden a flag in this file. Can you find it? [Forensics is fun.pptm](https://mercury.picoctf.net/static/d3dd8cd51524d9fafcccd1b7d55f85e7/Forensics%20is%20fun.pptm)

## Hints

1. None!

## Approach

1. The file can be opened as a PowerPoint presentation. It looks very bland with a simple distraction made of empty slides. The flag doesn't seem to be hidden in some slide details.
2. As the title suggests, this file probably has some macros added to it. Looking through macros, we find a module Module1 macro that contains the variable `not_flag = "sorry_but_this_isn't_it"`. If we try to format a flag adding picoCTF at the start, we get a fake flag. Looks like the title itself was a distraction.
3. If we try to run `binwalk -e` on the given file, we get a very long and complex directory structure. To easily display this structure, we can run tree, finding out that there is a suspicious file named `hidden` in the directory `ppt/slideMasters/`. This file contains a series of characters `Z m x h Z z o g c G l j b 0 N U R n t E M W R f d V 9 r b j B 3 X 3 B w d H N f c l 9 6 M X A 1 f Q`, which, after removing the white spaces and decoding the result from base64, gives out the flag. 

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{D1d_u_kn0w_ppts_r_z1p5}__

Nope, I didn't know
</details>