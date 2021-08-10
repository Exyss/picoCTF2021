	.arch armv8-a
	.file	"chall_3.c"
	.text
	.align	2
	.global	func1
	.type	func1, %function
func1:
	stp	x29, x30, [sp, -48]!		
	add	x29, sp, 0

	str	w0, [x29, 28]				;w0 -> [x29 + 28]	(597130609)
	str	wzr, [x29, 44]				;w0 -> [x29 + 44]	(0)

	b	.L2
.L4:
	ldr	w0, [x29, 28]				;w0 <- [x29 + 28]	(597130609)	(298565304)	(149282652)

	and	w0, w0, 1					;w0 <- w0 & 1		(1)	(0)	(0)
	;Since the bitwise AND is applied on w0 and 1, the
	;result will be 0 if w0 is pair or 1 if w0 is odd	

	cmp	w0, 0						;compare w0 with 0	(!=)	(==)	(==)
	beq	.L3							;branch if w0 == 0

	ldr	w0, [x29, 44]				;w0 <- [x29 + 44] 	(0)

	bl	func2

	str	w0, [x29, 44]				;w0 -> [x29 + 44]	(4)
.L3:
	ldr	w0, [x29, 28]				;w0 <- [x29 + 28]	(597130609)	(298565304)

	lsr	w0, w0, 1					;w0 <- w0 >> 1		(298565304)	(149282652)

	str	w0, [x29, 28]				;w0 -> [x29 + 28]	(298565304) (149282652)
.L2:
	ldr	w0, [x29, 28]				;w0 <- [x29 + 28]	(597130609)	(298565304)	(149282652)

	cmp	w0, 0						;compare w0 with 0	(!=)	(!=)
	bne	.L4							;branch if w0 != 0

	ldr	w0, [x29, 44]				;w0 <- [x29 + 44]	(0)

	ldp	x29, x30, [sp], 48
	ret
	.size	func1, .-func1
	.align	2
	.global	func2
	.type	func2, %function
func2:
	sub	sp, sp, #16

	str	w0, [sp, 12]				;w0 -> [sp - 12]	(1)
	ldr	w0, [sp, 12]				;w0 <- [sp - 12]

	add	w0, w0, 3					;w0 <- w0 + 3		(4)

	add	sp, sp, 16					
	ret
	.size	func2, .-func2
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
	str	x1, [x29, 16]				;
	ldr	x0, [x29, 16]				;setup stuff
	add	x0, x0, 8					;
	ldr	x0, [x0]					;
	bl	atoi						;

	bl	func1						;branch

	str	w0, [x29, 44]				;w0 -> [x29 + 44]

	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	ldr	w1, [x29, 44]				;w1 <- [x29 + 44]
	bl	printf						;print w1

	nop
	ldp	x29, x30, [sp], 48
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
