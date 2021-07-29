# Static ain't always the noise

## Overview

* Points: 20
* Category: General Skills
* Author: Syreal

## Description
Can you look at the data in this binary: [static](https://mercury.picoctf.net/static/66932732825076cad4ba43e463dae82f/static)? This [BASH script](https://mercury.picoctf.net/static/66932732825076cad4ba43e463dae82f/ltdis.sh) might help!

## Hints

1. None!

## Approach

1. The first file given by the challenge is an ELF executable, while the second is a bash script. By running `cat ltdis.sh` you can see the contents of this script: it runs `objdump` and `strings` on a file given as an argument, then saves the results on two files.
2. Run `chmod +x ltdis.sh` to make the script an executable and then run `ltdis.sh static` to get the two files. The flag is in the `static.ltdis.strings.txt` file.
3. You can easily get the flag output by running `cat statis.ltdis.strings.txt | grep picoCTF`

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{d15a5m_t34s3r_f5aeda17}__
</details>