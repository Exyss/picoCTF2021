# ARMssembly 0

## Overview

* Points: 40
* Category: Reverse Engineering
* Author: Dylan McGuire

## Description
> What integer does this program print with arguments `3854998744` and `915131509`? File: [chall.S](https://mercury.picoctf.net/static/b3b17204c7ce77f184a397c4fae4a35b/chall.S) Flag format: picoCTF{XXXXXXXX} -> (hex, lowercase, no 0x, and 32 bits. ex. 5614267 would be picoCTF{0055aabb})

## Hints

1. Simple compare.

## Approach

1. To solve this challenge, you first need some knowledge of ARM assembly and it's registers.

2. The `main` procedure runs the following instruction scheme:
```assembly
main:
    ;register setups in order to get the two passed arguments
    
    mov	w1, w0		;w1 = first func1 argument (3854998744)
    mov	w0, w19		;w0 = second func1 argument (915131509)
	bl	func1		;jump to func1

	mov	w1, w0		;w1 <- w0

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0

	bl	printf		;print w1
```
This means that the program consists in printing out the value contained in the w1 register __after__ running the `func1` procedure

3. The `func1` procedure runs the following instructions:
```
func1:
	sub	sp, sp, #16		;sp <- sp - #16     (this just makes space in the stack pointer)

	;These instructions basically store the two register's values on memory
	;and invert the invert the two register values
	str	w0, [sp, 12]	;w0 -> [sp - 12]
	str	w1, [sp, 8]		;w1 -> [sp - 8]
	ldr	w1, [sp, 12]	;w1 <- [sp - 12]	(the memory value of w0)
	ldr	w0, [sp, 8]		;w0 <- [sp - 8] 	(the memory value of w1)

	cmp	w1, w0			;compare w1 with w0

	bls	.L2				;bls = branch if lower or same (branch if w1 <= w0)
	ldr	w0, [sp, 12] 	;w0 <- [sp - 12]	(the memory value of w0)

	b	.L3				;unconditional branch
.L2:
	ldr	w0, [sp, 8]		;w0 <- [sp - 8] (the memory value of w1)

	;This procedure doesn't return, meaning that the code execution
	;will continue with the next following instruction (add	sp, sp, 16)
.L3:
	add	sp, sp, 16		;sp <- sp + 16  (fills up the stack pointer again)
	ret					;return
	.size	func1, .-func1
	.section	.rodata
	.align	3
```
As we can see from the comments that I added, the func1 procedure stores the two register values in the memory using the stack pointer as an address, swaps the two register values and then compares the two registers, branching to `L2` in case `w1 <= w0` or to `L3` if the last branch didn't happen.

3. In the `L2` procedure, `w0` gets loaded with the memory value stored at the address `sp - 8`, which was the address used to store the starting value of `w1`. Due to the absence of the `ret` instruction, the `L2` procedure doesnt return, meaning that the code execution will continue downwards (just like in a modern switch statemeny) untill reaching the next `ret` statement found in `L3`, closing the `func1` procedure and returning to the `main` execution.
In case the `L2` branching didn't happen, `w0` will be loaded with the memory value stored at the address `sp - 12`, which was the address used to store the starting value of `w0`. Once the registed got loaded, the program will branch to the `L3` procedure, executing the `ret` instruction, closing the `func1` procedure and returning to the `main` execution.

4. We can convert the `func1` procedure to simple python code to understand how it works:
```python
def func1(w1, w0):
    w0_mem = w0
    w1_mem = w1
    w0 = w1_mem
    w1 = w0_mem

    if(w0 <= w1):
        w0 = w1_mem
    else:
        w0 = w0_mem
    
    return w0
```
As we can see, this means that the procedure will always return the __biggest__ value

5. Once resuming the execution of the `main` procedure, `w1` gets loaded with the value in `w0` (which just got modified in `func1`), followed by a printf statement using the last loaded register (`w1`), meaning that this program simply prints out the biggest argument (in this case __3854998744__).

6. We now have to convert this number and format the flag by running this python instruction:
```python
"picoCTF{" + "{:x}".format(3854998744) + "}"
```

## Flag

<details>
<summary>Click to view the flag</summary>

__picoCTF{e5c69cd8}__
</details>