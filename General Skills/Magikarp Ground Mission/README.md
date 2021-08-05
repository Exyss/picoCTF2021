# Magikarp Ground Mission

## Overview

* Points: 30
* Category: General Skills
* Author: Syreal

## Description
> Do you know how to move between directories and read files in the shell? Start the container, `ssh` to it, and then `ls` once connected to begin. Login via `ssh` as `ctf-player` with the password, `ee388b88`

ALERT: This challenge launches an instance on demand. You can start it [here](https://play.picoctf.org/practice/challenge/189?originalEvent=34&page=1&search=&solved=1)

## Hints

1. Finding a cheatsheet for bash would be really helpful!

## Approach

1. The challenge is pretty much hand-guided. Just follow the instructions in the description and in the files stored on the container

```bash
ctf-player@pico-chall$ cat *
picoCTF{xxsh_
Next, go to the root of all things, more succinctly `/`

ctf-player@pico-chall$ cd /

ctf-player@pico-chall$ ls
2of3.flag.txt  boot  etc   instructions-to-3of3.txt  lib64  mnt  proc  run   srv  tmp  var
bin            dev   home  lib                       media  opt  root  sbin  sys  usr

ctf-player@pico-chall$ cat 2of3.flag.txt 
0ut_0f_\/\/4t3r_

ctf-player@pico-chall$ cat instructions-to-3of3.txt 
Lastly, ctf-player, go home... more succinctly `~`

ctf-player@pico-chall$ cd ~

ctf-player@pico-chall$ ls
3of3.flag.txt  drop-in

ctf-player@pico-chall$ cat 3of3.flag.txt 
3ca613a1}
```

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{xxsh_0ut_0f_\\/\\/4t3r_3ca613a1}__
</details>