		.text
		.globl	drawJuliaSet
drawJuliaSet:
		@ tmp store in r7
		@ x store in r8
		@ y store in r9
		@ i store in r10
		@ zx store in sp
		@ zy store in sp+4
		@ cX store in sp+8
		@ cY store in sp+12
		@ width store in sp+16
		@ height store in sp+20
		@ color store in sp+24( hword )
		stmfd	sp!, {r4-r10, lr}	@ push lr and r4-r10 onto stack
		adds	r14, r0, r1			@ project required
		ldr		lr, [sp, #28]		@ get lr from stack
		sub		sp, sp, #28			@ Allocate local variable on stack
		str		r0, [sp, #8]		@ store cX in sp+8
		str		r1, [sp, #12]		@ store cY in sp+12
		str		r2, [sp, #16]		@ int width
		str		r3, [sp, #20]		@ int height
		mov		r8, #0				@ x = 0
loopX:	mov		r0, r8				@ use r0 as x
		ldr		r1, [sp, #16]		@ load width to r1
		cmp		r0, r1				@ if x >= width
		bge		final				@ then jump to final
		mov		r9, #0				@ y = 0
loopY:	mov		r0, r9				@ use r0 as y
		ldr		r1, [sp, #20]		@ load height to r1
		cmp		r0, r1				@ if y < height
		blt		set					@ then jump to set
		bge		endX				@ else jump to endx
set:	ldr		r3, [sp, #16]		@ load width to r3
		mov		r3, r3, lsr #1		@ r3 = width >> 1
		mov		r2, r8				@ use r2 as x
		sub		r2, r2, r3			@ r2 = x - ( width >> 1 )
		ldr		r1, cons			@ r1 = 1500
		mul		r0, r1, r2			@ r0 = 1500 * (x - ( width >> 1 ))
		mov		r1, r3				@ r1 = width >> 1
		bl		__aeabi_idiv		@ divide and get value of zx at r0
		str		r0, [sp]			@ store zx in sp
		ldr		r3, [sp, #20]		@ load height to r3
		mov		r3, r3, lsr #1		@ r3 = height >> 1
		mov		r2, r9				@ use r2 as y
		rsb		r2, r3, r2			@ r2 = y - ( height >> 1 )
		ldr		r1, cons+4			@ r1 = 1000
		mul		r0, r1, r2			@ r2 = 1000 * (x - ( height >> 1 ))
		mov		r1, r3				@ r1 = height >> 1
		bl		__aeabi_idiv		@ divide and get value of zy at r0
		str		r0, [sp, #4]		@ store zy in sp+4
		mov		r10, #255			@ i = maxIter = 255
loop:	ldr		r2, [sp]			@ load zx to r2
		mov		r3, r2				@ r3 = r2 = zx
		mul		r4, r2, r3			@ r4 = zx * zx
		ldr		r2, [sp, #4]		@ load zy to r2
		mov		r3, r2				@ r3 = r2 = zy
		mul		r5, r2, r3			@ r5 = zy * zy
		add		r0, r4, r5			@ r0 = zy * zy + zx * zx
		ldr		r1, cons+8			@ r1 = 4000000
		cmp		r0, r1				@ if r0 >= 4000000
		bge		setf				@ then jump to setf
		cmp		r10, #0				@ if i <= 0 
		ble		setf				@ then jump to setf
		rsb		r0, r5, r4			@ r0 = zx * zx - zy * zy
		ldr		r1, cons+4			@ r1 = 1000
		bl		__aeabi_idiv		@ divide and get value in r0
		ldr		r3, [sp, #8]		@ load cX to r3
		add		r7, r0, r3			@ tmp = r0 + cX
		ldr		r3, [sp]			@ load zx ro r3
		mov		r3, r3, lsl #1		@ r3 = zx *2
		ldr		r2, [sp, #4]		@ load zy to r2
		mul		r0, r2, r3			@ r0 = 2 * zx * zy
		ldr		r1, cons+4			@ r1 = 1000
		bl		__aeabi_idiv		@ divide
		ldr		r3, [sp, #12]		@ load cY to r3
		add		r3, r0, r3			@ r3 = r0 + cY
		str		r3, [sp, #4]		@ store zy in sp+4
		str		r7, [sp]			@ store tmp in sp(zx)
		sub		r10, r10, #1		@ i--
		b		loop				@ jump to loop
setf:	mov		r3, r10				@ r3 = i
		ldr		r4, cons+12			@ r4 = 0xFF
		and		r5, r3, r4			@ r5 = i & 0xFF
		mov		r3, r5, lsl #8		@ r3 = r5 << 8
		orr		r3, r3, r5			@ r3 = r3 | r5
		strh	r3, [sp, #24]		@ store color in sp+24
		ldrh	r3, [sp, #24]		@ load color to r3
		mvn		r3, r3				@ r3 = ~color
		ldr		r5, cons+16			@ r5 = 0xFFFF
		and		r3, r3, r5			@ color = ~color & 0xFFFF
		strh	r3, [sp, #24]		@ store color in sp+24
		mov		r2, r9				@ use y as r2
		ldr		r3, [sp, #16]		@ load width to r3
		mul		r3, r2, r3			@ r3 = y * width 
		mov		r1, r8				@ use x as r1
		add		r3, r1, r3			@ r3 = y * width + x
		mov		r3, r3, lsl #1		@ r3 * 2, halfword
		ldr		r0, [sp, #60]		@ load pointer of frame
		add		r0, r0, r3			@ add pointer to target
		ldrh	r2, [sp, #24]		@ load color to r2
		strh	r2, [r0]			@ move color to frame[y][x]
endY:	add		r9, r9, #1			@ y++
		b		loopY				@ jump to loopy
endX:	add		r8, r8, #1			@ x++
		b		loopX				@ jump to loopx
final:	add		sp, sp, #28			@ destroy automatic variable
		ldmfd	sp!, {r4-r10, lr}	@ pop lr and r4-r10 from stack
		mov		pc, lr				@ return from drawJuliaSet

cons:	.word	1500
		.word	1000
		.word	4000000
		.word	0xFF
		.word	0xFFFF
