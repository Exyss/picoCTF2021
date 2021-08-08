# ARMssembly 2

## Overview

* Points: 90
* Category: Reverse Engineering
* Author: Dylan McGuire

## Description
> What integer does this program print with argument `1748687564`? File: [chall_2.S](https://mercury.picoctf.net/static/225b8846edf2234e9ce85aaab176b062/chall_2.S) Flag format: picoCTF{XXXXXXXX} -> (hex, lowercase, no 0x, and 32 bits. ex. 5614267 would be picoCTF{0055aabb})

## Hints

1. Loops

## Approach

1. As for [ARMssembly 0](./ARMssembly%200) and [ARMssembly 1](./ARMssembly%201), the main procedure starts with a register setup, then calls another procedure and in the end prints out the result:
```assembly
.LC0:
	.string	"Result: %ld\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!			;
	add	x29, sp, 0				;
	str	w0, [x29, 28]				;
	str	x1, [x29, 16]				;setup stuff
	ldr	x0, [x29, 16]				;
	add	x0, x0, 8				;
	ldr	x0, [x0]				;
	bl	atoi					;

	bl	func1					;branch 

	str	w0, [x29, 44]				;w0 -> [x29 - 44]

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0

	ldr	w1, [x29, 44]				;w1 <- [x29 - 44]

	bl	printf

	nop
	ldp	x29, x30, [sp], 48

	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
```

2. As always, we have to understand what the `func` procedure does, commenting what we discovered in order to make the program more comprehensible:
```assembly
func1:
	sub	sp, sp, #32				;sp <- [sp - #32]

	str	w0, [sp, 12]				;w0 -> [sp - 12]	(1748687564)

	;wzr is a register that contains only zeros
	str	wzr, [sp, 24]				;wzr -> [sp - 24]	(0)
	str	wzr, [sp, 28]				;wzr -> [sp - 28]	(0)

	b	.L2
.L3:
	ldr	w0, [sp, 24]				;w0 <- [sp - 24]	( )	(0)	(3)	(...)
	add	w0, w0, 3				;w0 <- w0 + 3		( )	(3)	(6)	(...)

	str	w0, [sp, 24]				;w0 -> [sp - 24]	( )	(3)	(6)	(...)
	ldr	w0, [sp, 28]				;w0 <- [sp - 28]	( )	(0)	(1)	(...)
	add	w0, w0, 1				;w0 <- w0 + 1		( )	(1)	(2)	(...)

	str	w0, [sp, 28]				;w0 -> [sp - 28]	( )	(1)	(2)	(...)
.L2:
	ldr	w1, [sp, 28]				;w1 <- [sp - 28]	(0)	(1)	(2)	(...)
	ldr	w0, [sp, 12]				;w0 <- [sp - 12]	(1748687564)	(...)

	cmp	w1, w0					;cmp w1 & w0
	bcc	.L3					;branch if carry flag is empty

	;The carry flag gets set when an occurring operation would need more bits than the avaible ones.
	;For example: ADD ah, 255, 255		|	The result would need 9 bits, but the ah register has 
	;					|	only 8 bits, so the first bit gets stored in the carry flag.
	;In this case the program will jump only if w1 < w0


	ldr	w0, [sp, 24]				;w0 <- [sp - 24]
	add	sp, sp, 32				;sp <- sp + 32

	ret						;return
	.size	func1, .-func1
	.section	.rodata
	.align	3
```

3. As the given hint suggest, this program is all about loops. The `func` procedure starts by setting up the  3 memory addresses that will be essential in this program, `[sp - 12]`, `[sp - 24]` and `[sp - 28]`, setting the first one with the argument given by the user, while the other two get stored with 0.

4. The program then jumps right to `L2`, loading `w1` with the value stored in `[sp - 28]` and w0 with the one in `[sp - 12]`, comparing the two registers and branching in case the carry flag is set to 0.
Every time we execute an calculation, the carry flag will get set in case the operation would need __more bits__ than the avaible ones. In our situation, this means that the program will jump to `L3` only if `w1 < w0`.

5. After branching to `L3`, the program will increase the value in `[sp - 24]` by `3` and the value in `[sp - 24]` by `1`. Due to the lack of a `ret` statement, the program will continue executing downwards, repeating the `L2` procedure and looping back to `L3` in case the condition `w1 < w0`is still true.
We can convert this loop into python code and run it to find the answer:
```python
w0 = 1748687564
sp_12 = w0
sp_24 = 0
sp_28 = 0
w1 = sp_28

while(w1 < w0):
    sp_24 += 3
    sp_28 += 1

    w1 = sp_28
    w0 = sp_12

    print(f"w0: {w0}\tw1: {w1}\tsp_12: {sp_12}\tsp_24: {sp_24}\tsp_28: {sp_28}")

w0 = sp_24
print(f"The value is: {w0}")
```
However, running this code would take __way to long__ since the looping will run `1748687564 times` due to w1 getting increased by only 1 every time. But don't worry! We can use the secret power of math to find the answer!

6. Since the code will be executed 1748687564 times and every time it executes the memory address `[sp - 24]` gets increased by 3, we have to just calculate `1748687564 * 3 = 5246062692` in order to find the value.
Then, we have to convert the value in the usual hex format by running the python line `print("{:x}".format(5246062692))`, getting the hex number `138b09064`, which uses 36 bits (remember that the format requires __32 bits!!__), meaning that we have to cut off the first digit to get the flag.

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{38b09064}__
</details>
