	.arch armv8-a
	.file	"chall_1.c"
	.text
	.align	2
	.global	func
	.type	func, %function
func:
	sub	sp, sp, #32				;make space in sp

	str	w0, [sp, 12]			;w0 -> [sp - 12]	(arg1)

	mov	w0, 58					;w0 <- 58
	str	w0, [sp, 16]			;w0 -> [sp - 16]	(58)

	mov	w0, 2					;w0 <- 2
	str	w0, [sp, 20]			;w0 -> [sp - 20]	(2)

	mov	w0, 3					;w0 <- 3
	str	w0, [sp, 24]			;w0 -> [sp - 24]	(3)

	ldr	w0, [sp, 20]			;w0 <- [sp - 20]	(2)
	ldr	w1, [sp, 16]			;w1 <- [sp - 16]	(58)

	lsl	w0, w1, w0				;w0 <- w1 << w0		(58 << 2 = 232)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w1, [sp, 28]			;w1 <- [sp - 28]	(232)
	ldr	w0, [sp, 24]			;w0 <- [sp - 24]	(3)

	sdiv w0, w1, w0				;w0 <- w1 / w0		(232 / 3 = 77)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w1, [sp, 28]			;w1 <- [sp - 28]	(77)
	ldr	w0, [sp, 12]			;w0 <- [sp - 12]	(arg1)

	sub	w0, w1, w0				;w0 <- w1 - w0		(77 - arg1 = ?)
	str	w0, [sp, 28]			;w0 -> [sp - 28]

	ldr	w0, [sp, 28]			;w0 <- [sp - 28]

	add	sp, sp, 32				;fill up sp again
	ret							;return
	.size	func, .-func
	.section	.rodata
	.align	3
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
	stp	x29, x30, [sp, -48]!	;
	add	x29, sp, 0				;
	str	w0, [x29, 28]			;
	str	x1, [x29, 16]			;setup stuff
	ldr	x0, [x29, 16]			;
	add	x0, x0, 8				;
	ldr	x0, [x0]				;
	bl	atoi					;

	str	w0, [x29, 44]			;w0 -> [x29 + 44]
	ldr	w0, [x29, 44]			;w0 <- [x29 + 44]	(arg1)

	bl	func					;branch

	cmp	w0, 0					;compare w0 and 0
	bne	.L4						;branch if w0 != 0

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	puts					;print "You win!"

	b	.L6						;branch
.L4:
	adrp	x0, .LC1
	add	x0, x0, :lo12:.LC1
	bl	puts					;print "You lose!"
.L6:
	nop
	ldp	x29, x30, [sp], 48
	ret							;return
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
