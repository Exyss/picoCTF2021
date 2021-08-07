	.arch armv8-a
	.file	"chall.c"
	.text
	.align	2
	.global	func1
	.type	func1, %function
func1:
	sub	sp, sp, #16		;sp <- sp - #16	

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
	add	sp, sp, 16		;sp <- sp + 16
	ret					;return
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
	stp	x29, x30, [sp, -48]!
	add	x29, sp, 0
	str	x19, [sp, 16]
	str	w0, [x29, 44]
	str	x1, [x29, 32]
	ldr	x0, [x29, 32]
	add	x0, x0, 8
	ldr	x0, [x0]
	bl	atoi
	mov	w19, w0
	ldr	x0, [x29, 32]
	add	x0, x0, 16
	ldr	x0, [x0]
	bl	atoi

	mov	w1, w0		;w1 = first func1 argument (3854998744)
	mov	w0, w19		;w0 = second func1 argument (915131509)
	bl	func1		;jump to func1

	mov	w1, w0		;w1 <- w0

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0

	bl	printf		;print w1
	mov	w0, 0
	ldr	x19, [sp, 16]
	ldp	x29, x30, [sp], 48
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
