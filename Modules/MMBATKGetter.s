
.thumb

.include "../CommonDefinitions.inc"

MMBATKGetter:

	.global	MMBATKGetter
	.type	MMBATKGetter, %function

	ldr		r0, =BattleBufAttacker
	mov		r1, #0x5A
	ldsh	r0, [r0, r1]

	bx		lr

.ltorg
