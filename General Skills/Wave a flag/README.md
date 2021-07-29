# Wave a flag   

## Overview

* Points: 10
* Category: General Skills
* Author: Syreal

## Description
Can you invoke help flags for a tool or binary? [This program](https://mercury.picoctf.net/static/beec4f433e5ee5bfcd71bba8d5863faf/warm) has extraordinarily helpful information...

## Hints

1. This program will only work in the webshell or another Linux computer.
2. To get the file accessible in your shell, enter the following in the Terminal prompt: `$ wget https://mercury.picoctf.net/static/beec4f433e5ee5bfcd71bba8d5863faf/warm`
3. Run this program by entering the following in the Terminal prompt: `$ ./warm`, but you'll first have to make it executable with `$ chmod +x warm`
4. -h and --help are the most common arguments to give to programs to get more information from them!
5. Not every program implements help features like -h and --help.

## Approach

1. Using the command `file warm` we get a description with the file metadata, indicating that the downloaded file is an ELF executable (also given out by the hints of the challenge)
2. We can make this file an executable using the command `chmod +x warm`. After this, we can run the file using `./warm`, telling us that we can add the argument `-h` to learn more about the program's functionalities.
3. Executing the full command prints out the solution 

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{b1scu1ts_4nd_gr4vy_616f7182}__
</details>