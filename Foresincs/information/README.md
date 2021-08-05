# Information   

## Overview

* Points: 10
* Category: Foresincs
* Author: Susie

## Description
> Files can always be changed in a secret way. Can you find the flag? [cat.jpg](https://mercury.picoctf.net/static/d1375e383810d8d957c04eef9e345732/cat.jpg)

## Hints

1. Look at the details of the file
2. Make sure to submit the flag as picoCTF{XXXXX}

## Approach

1. Cute kittie!!
2. The first hints pretty much gives out the answer. If you are using a desktop environment, just right click on the image and check for it's details/informations. You can also get the file details using the command line by downloading __exiftool__ through GitHub (`git clone https://github.com/exiftool/exiftool.git`). Move the image file into the downloaded folder and execute `./exiftool cat.jpg` to get the file details.
3. Looking through the file details, we can see some details looking like gibberish words, kinda as if they were encryped strings. Particularly, the value under the "Licence" property (cGljb0NURnt0aGVfbTN0YWRhdGFfMXNfbW9kaWZpZWR9) looks like a common base64 encrypted string.
4. We can run the command `echo cGljb0NURnt0aGVfbTN0YWRhdGFfMXNfbW9kaWZpZWR9 | base64 -d` to get the decrypted flag

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{the_m3tadata_1s_modified}__
</details>