# Information   

## Overview

* Points: 30
* Category: Foresincs
* Author: Susie & Pandu

## Description
Matryoshka dolls are a set of wooden dolls of decreasing size placed one inside another. What's the final one? Image: [this](https://mercury.picoctf.net/static/2978e1270538613cd8181c7b0dabe9bd/dolls.jpg)

## Hints

1. Wait, you can hide files inside files? But how do you find them?
2. Make sure to submit the flag as picoCTF{XXXXX}

## Approach

1. Everyone knows Matryoshkas, so I dont need to explain. In this case, we have a file that contains a file, which also contains a file and so on.
2. To analyze the file and it's inner hidden content we can use `binwalk dolls.jpeg`, which displays the following output:
```bash
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 594 x 1104, 8-bit/color RGBA, non-interlaced
3226          0xC9A           TIFF image data, big-endian, offset of first image directory: 8
272492        0x4286C         Zip archive data, at least v2.0 to extract, compressed size: 378942, uncompressed size: 383937, name: base_images/2_c.jpg
651600        0x9F150         End of Zip archive, footer length: 22
```
The end of the third output line indicates the precence of an hidden Zip archive containing a folder named `base_images` which also contains an image named `2_c.jpg`.
3. To extract the inner files, we have to add the -e flag to the command: `binwalk -e dolls.jpeg`.
4. Since we have a Matryoskha situation, repeat the process on each inner image untill you find the .txt file containing the flag

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{4cf7ac000c3fb0fa96fb92722ffb2a32}__
</details>