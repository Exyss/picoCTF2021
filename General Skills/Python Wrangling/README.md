# Python Wrangling

## Overview

* Points: 10
* Category: General Skills
* Author: Syreal

## Description
Python scripts are invoked kind of like programs in the Terminal... Can you run [this Python script](https://mercury.picoctf.net/static/5c4c0cbfbc149f3b0fc55c26f36ee707/ende.py) using [this password](https://mercury.picoctf.net/static/5c4c0cbfbc149f3b0fc55c26f36ee707/pw.txt) to get [the flag](https://mercury.picoctf.net/static/5c4c0cbfbc149f3b0fc55c26f36ee707/flag.txt.en?)

## Hints

1. Get the Python script accessible in your shell by entering the following command in the Terminal prompt: `$ wget https://mercury.picoctf.net/static/5c4c0cbfbc149f3b0fc55c26f36ee707/ende.py`
2. `$ man python`

## Approach

1. By looking at the contents of the script `ende.py` we can see that it's a simple base64 encoder/decoder 
2. In order to execute the program, make sure Python is installed
3. Trying to execute the program with `python ende.py` gives out this result `Usage: ende.py (-e/-d) [file]`, giving to the user the correct usage.
4. Executing the command `python ende.py -d flag.txt.en\?` gives out an input prompt, asking the user to enter the password to use to decript the given file. The password can be found in the `pw.txt` file.
5. To enter the password without copying and pasting it, simply execute `cat pw.txt | python ende.py -d flag.txt.en\? ` to get the flag.

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{4p0110_1n_7h3_h0us3_192ee2db}__
</details>