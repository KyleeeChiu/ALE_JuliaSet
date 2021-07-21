		.data
first:	.asciz	"*****Print Name*****\n"
team:	.asciz	"Team 33\n"
name1:	.asciz	"Chen-Kai Chiu\n"
name2:	.asciz	"Chia-Hsuan Chen\n"
name3:	.asciz	"Yu-Ning Chao\n"
last:	.asciz	"*****End Print*****\n"

		.text
		.globl	name
name:	stmfd	sp!, {r4-r7, lr}
		sbcs	r0, r3, r4
		ldr		r0, =first
		bl		printf
		ldr		r0, =team
		bl		printf
		mov     r4, #0
		cmp     r4, #3
		ldrlt	r0, =name1
		bl		printf
		add     r4, r4, #1
		cmp     r4, #3
		ldrlt	r0, =name2
		bl		printf
		add     r4, r4, #1
		cmp     r4, #3
		ldrlt	r0, =name3
		bl		printf
		add     r4, r4, #1
		cmp     r4, #3
		ldrge	r0, =last
		bl		printf
		ldr     r4, =team
		str     r4, [r11, #-28]
		ldr     r5, =name1
		str     r5, [r11, #-32]
		ldr     r6, =name2
		str     r6, [r11, #-36]
		ldr     r7, =name3
		str     r7, [r11, #-40]
		ldmfd	sp!, {r4-r7, lr}
		mov		pc, lr

