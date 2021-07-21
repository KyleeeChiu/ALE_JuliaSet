		.data
first:	.asciz	"*****Input ID*****\n"
ask1:	.asciz	"** Please Enter Member 1 ID:**\n"
ask2:	.asciz	"** Please Enter Member 2 ID:**\n"
ask3:	.asciz	"** Please Enter Member 3 ID:**\n"
num:	.asciz	"%d"
askc:	.asciz	"** Please Enter Command **\n"
cmd:	.asciz	"%c"
pri:	.word	'\0'
p:		.word	'p'
pid:	.asciz	"*****Print Team Member ID and ID Summation*****\n"
pidn:	.asciz	"%d\n%d\n%d\n"
ids:	.asciz	"\n\nID Summation = %d\n"
last:	.asciz	"*****End Print*****\n"
id1:	.word	0
id2:	.word	0
id3:	.word	0
sid:	.word	0

		.text
		.globl	id
id:		stmfd	sp!, {r4-r6, lr}
		ldr		r0, =first
		bl		printf
		mov     r4, #0
		cmp     r4, #3
		ldrlt	r0, =ask1
		bl		printf
		ldr		r0,	=num
		ldr		r1, =id1
		bl		scanf
		add     r4, r4, #1
		cmp     r4, #3
		ldrlt	r0, =ask2
		bl		printf
		ldr		r0, =num
		ldr		r1, =id2
		bl		scanf
		add     r4, r4, #1
		cmp     r4, #3
		ldrlt	r0, =ask3
		bl		printf
		ldr		r0,	=num
		ldr		r1, =id3
		bl		scanf
		add     r4, r4, #1
		cmp     r4, #3
		bge     loop
loop:	ldr		r0, =askc
		bl		printf
		ldr		r0, =cmd
		ldr		r1, =pri
		bl		scanf
		ldr		r0, =cmd
		ldr		r1, =pri
		bl		scanf
		ldr		r0, =p
		ldr		r0, [r0]
		ldr		r1, =pri
		ldr		r1, [r1]
		cmp		r0, r1
		beq     final
		bne		loop
final:	ldr		r0, =pid
		bl		printf
		ldr		r0, =pidn
		ldr		r1, =id1
		ldr		r1, [r1]
		ldr		r2, =id2
		ldr		r2, [r2]
		ldr		r3, =id3
		ldr		r3, [r3]
		bl		printf
		ldr		r0, =sid
		ldr		r0, [r0]
		ldr		r1, =id1
		ldr		r1, [r1]
		ldr		r2, =id2
		ldr		r2, [r2]
		add     r0, r1, r2
		ldr		r3, =id3
		ldr		r3, [r3]
		add		r0, r0, r3
		ldr		r4, =sid
		str		r0, [r4]
		ldr		r0, =ids
		ldr		r1, =sid
		ldr		r1, [r1]
		bl		printf
		ldr		r0, =last
		bl		printf
		ldr		r1, =sid
		ldr		r1, [r1]
		mov		r0, r1
		ldr		r4, =id1
		ldr     r4, [r4]
		str     r4, [r11,#-48]
		ldr		r5, =id2
		ldr     r5, [r5]
		str     r5, [r11, #-52]
		ldr		r6, =id3
		ldr     r6, [r6]
		str     r6, [r11, #-56]
		ldmfd	sp!, {r4-r6, lr}
		mov		pc, lr

