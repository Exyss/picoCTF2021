	.arch armv8-a
	.file	"chall_2.c"
	.text
	.align	2
	.global	func1
	.type	func1, %function
func1:
	sub	sp, sp, #32					;sp <- [sp - #32]

	str	w0, [sp, 12]				;w0 -> [sp - 12]	(1748687564)

	;wzr is a register that contains only zeros
	str	wzr, [sp, 24]				;wzr -> [sp - 24]	(0)
	str	wzr, [sp, 28]				;wzr -> [sp - 28]	(0)

	b	.L2
.L3:
	ldr	w0, [sp, 24]				;w0 <- [sp - 24]	( )	(0)	(3)	 (..)
	add	w0, w0, 3					;w0 <- w0 + 3		( )	(3)	(6)	 (..)

	str	w0, [sp, 24]				;w0 -> [sp - 24]	( )	(3)	(6)	 (..)
	ldr	w0, [sp, 28]				;w0 <- [sp - 28]	( )	(0)	(1)	 (..)
	add	w0, w0, 1					;w0 <- w0 + 1		( )	(1)	(2)	 (..)

	str	w0, [sp, 28]				;w0 -> [sp - 28]	( )	(1)	(2)	 (..)
.L2:
	ldr	w1, [sp, 28]				;w1 <- [sp - 28]	(0)	(1) (2)	 (..)
	ldr	w0, [sp, 12]				;w0 <- [sp - 12]	(1748687564) (..)

	cmp	w1, w0						;cmp w1 & w0
	bcc	.L3							;branch if carry flag is empty

	;The carry flag gets set when an occurring operation would need more bits than the avaible ones.
	;For example: ADD ah, 255, 255		|	The result would need 9 bits, but the ah register has 
	;									|	only 8 bits, so the first bit gets stored in the carry flag.
	;In this case the program will jump only if w1 < w0


	ldr	w0, [sp, 24]				;w0 <- [sp - 24]
	add	sp, sp, 32					;sp <- sp + 32

	ret								;return
	.size	func1, .-func1
	.section	.rodata
	.align	3
.LC0:
	.string	"Result: %ld\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	stp	x29, x30, [sp, -48]!		;
	add	x29, sp, 0					;
	str	w0, [x29, 28]				;
	str	x1, [x29, 16]				;setup stuff
	ldr	x0, [x29, 16]				;
	add	x0, x0, 8					;
	ldr	x0, [x0]					;
	bl	atoi						;

	bl	func1						;branch 

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
