# Wireshark doo dooo do doo...

## Overview

* Points: 50
* Category: Foresincs
* Author: Dylan

## Description
Can you find the flag? [shark1.pcapng](https://mercury.picoctf.net/static/ae5b2bc07928fca272ff3900dc9a6cef/shark1.pcapng)

## Hints

1. None!

## Approach

1. As the title suggests, you need Wireshark for this. After opening the given file, we can see that it contains a long communication through HTTP, using some GET and POST methods. Since any HTTP communication is the result of a series of requests and responses, we have to analyze the long series of TCP streams that make up this communication.
2. To achieve this, we enter `tcp.stream == 1` as a filter, then right click on any of the displayed packets, go on Follow and then on TCP stream. Mhh... looks like we found nothing suspicious. Let's keep repeating this procedure for the following streams (== 2, == 3, ...).
3. At the end of the fifth stream we see a weird string `"Gur synt vf cvpbPGS{c33xno00_1_f33_h_qrnqorrs}"` given as a result from a GET request. Since the string starts with 4 lowercase and 3 uppercase letters, this looks like a very simple ROT encryption. Applying ROT13 to the string gives out the flag.

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{p33kab00_1_s33_u_deadbeef}__
</details>