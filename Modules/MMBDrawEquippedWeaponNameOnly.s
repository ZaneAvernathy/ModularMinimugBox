
.thumb

.include "../CommonDefinitions.inc"

MMBDrawEquippedWeaponNameOnly:

	.global	MMBDrawEquippedWeaponNameOnly
	.type	MMBDrawEquippedWeaponNameOnly, %function

	.set MMBTextAltColor,		EALiterals + 0
	.set MMBItemNamePosition,	EALiterals + 4

	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit in RAM

	push	{r4-r6, lr}

	mov		r4, r0

	@ Check if unit has an equipped weapon

	mov		r0, r1
	ldr		r1, =GetEquippedWeapon
	mov		lr, r1
	bllr

	@ if not, end

	cmp		r0, #0x00
	beq		End

	mov		r1, #0xFF
	and		r0, r1

	ldr		r1, =GetROMItemStructPtr
	mov		lr, r1
	bllr

	@ get item name

	ldrh	r0, [r0]

	ldr		r1, =TextBufferWriter
	mov		lr, r1
	bllr

	@ save pointer to text

	mov		r6, r0

	@ write item name

	add		r4, #AltTextStructStart
	mov		r0, r4
	ldr		r1, =TextClear
	mov		lr, r1
	bllr

	@ we write the text info to the proc state

	mov		r0, r4
	mov		r1, #0x00
	ldr		r2, =MMBTextAltColor
	ldrh	r2, [r2]

	ldr		r3, =TextSetParameters
	mov		lr, r3
	bllr

	@ Write name

	mov		r0, r4
	mov		r1, r6

	ldr		r2, =TextAppendString
	mov		lr, r2
	bllr

	@ write tilemap

	mov		r0, r4
	ldr		r1, =WindowBuffer
	ldr		r2, MMBItemNamePosition
	add		r1, r1, r2

	ldr		r2, =TextDraw
	mov		lr, r2
	bllr

End:

	pop		{r4-r6}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:
	@ MMBTextAltColor
	@ MMBItemNamePosition
