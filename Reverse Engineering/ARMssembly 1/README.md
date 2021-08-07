# ARMssembly 1

## Overview

* Points: 70
* Category: Reverse Engineering
* Author: Pranay Garg

## Description
> For what argument does this program print `win` with variables `58`, `2` and `3`? File: [chall_1.S](https://mercury.picoctf.net/static/1c8d50e39cf00d144e6a72119f68c16c/chall_1.S) Flag format: picoCTF{XXXXXXXX} -> (hex, lowercase, no 0x, and 32 bits. ex. 5614267 would be picoCTF{0055aabb})

## Hints

1. Shifts

## Approach

1. To solve this challenge you must first understand how to solve the [previous one](../ARMssembly%200/)

2. The main part of the program (with my personal added comments) states the following:
```assembly
.LC0:
	.string	"You win!"
	.align	3
.LC1:
	.string	"You Lose :("
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!		;
	add	x29, sp, 0			;
	str	w0, [x29, 28]			;
	str	x1, [x29, 16]			;setup stuff
	ldr	x0, [x29, 16]			;
	add	x0, x0, 8			;
	ldr	x0, [x0]			;
	bl	atoi				;

	str	w0, [x29, 44]			;w0 -> [x29 + 44]
	ldr	w0, [x29, 44]			;w0 <- [x29 + 44]	(arg1)

	bl	func				;branch

	cmp	w0, 0				;compare w0 and 0
	bne	.L4				;branch if w0 != 0

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts				;print "You win!"

	b	.L6				;branch
.L4:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	puts				;print "You lose!"
.L6:
	nop
	ldp	x29, x30, [sp], 48
	ret					;return
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
```
As we can see, the `main` procedure stores on the memory the argument passed by the user, then branches to func. Right after that, it runs a compare between the `w0` register and `0`, branching again to `L4` in case they are not equal (`bne = branch on not equal`) or else branching to `L6`.

2. After breaking down the `func` procedure (and adding comments with what we found), we can see that it executes simple instructions on the `w0` register (the argument passed by the user) :
```assembly
func:
	sub	sp, sp, #32			;make space in sp

	str	w0, [sp, 12]			;w0 -> [sp - 12]	(arg1)

	mov	w0, 58				;w0 <- 58
	str	w0, [sp, 16]			;w0 -> [sp - 16]	(58)

	mov	w0, 2				;w0 <- 2
	str	w0, [sp, 20]			;w0 -> [sp - 20]	(2)

	mov	w0, 3				;w0 <- 3
	str	w0, [sp, 24]			;w0 -> [sp - 24]	(3)

	ldr	w0, [sp, 20]			;w0 <- [sp - 20]	(2)
	ldr	w1, [sp, 16]			;w1 <- [sp - 16]	(58)

	lsl	w0, w1, w0			;w0 <- w1 << w0		(58 << 2 = 232)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w1, [sp, 28]			;w1 <- [sp - 28]	(232)
	ldr	w0, [sp, 24]			;w0 <- [sp - 24]	(3)

	sdiv	w0, w1, w0			;w0 <- w1 // w0		(232 // 3 = 77)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w1, [sp, 28]			;w1 <- [sp - 28]	(77)
	ldr	w0, [sp, 12]			;w0 <- [sp - 12]	(arg1)

	sub	w0, w1, w0			;w0 <- w1 - w0		(77 - arg1 = ?)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w0, [sp, 28]			;w0 <- [sp - 28]

	add	sp, sp, 32			;fill up sp again
	ret					;return
	.size	func, .-func
	.section	.rodata
	.align	3
```
The procedure first stores in memory the passed argument (`w0`) along with 3 numbers: `58`, `2` and `3`. Then it runs a left shift of 2 bytes on 58, thus obtaining 232, followed by dividing the previously calculated value by 3, thus obtaining 77. In the final steps, __77 gets subtracted by our passed argument__, storing the result in the w0 register.

4. Now we can go back to the following block:
```assembly
	bl	func				;branch

	cmp	w0, 0				;compare w0 and 0
	bne	.L4				;branch if w0 != 0

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts				;print "You win!"

	b	.L6				;branch
```
Since the objective of the challenge is printing out "You win!", we have skip the branching to `L4` in order to reach the `puts call`, which will print out the string by calling `.LC0`.

5. To achieve this, the `cmp` statement must return `0`, making the `bne` fail, meaning that `w0` must also be `0`.
Looking back to the `func` procedure, we can see that the final value of 77 gets subtracted by our argument, storing the result in `w0`. This can only mean that our own argument must be `77` as well in order to store `0` in `w0`.

6. Once we found the argument, we have to convert 77 to the required hexadecimal format (0000004d), achieving the flag

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{0000004d}__
</details>
