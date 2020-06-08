
.thumb

.include "../CommonDefinitions.inc"

MMBDrawEquippedWeaponNameCentered:

	.global	MMBDrawEquippedWeaponNameCentered
	.type	MMBDrawEquippedWeaponNameCentered, %function

	.set MMBInventoryTileIndex,	EALiterals + 0
	.set MMBTextAltColor,		EALiterals + 2
	.set MMBItemNamePosition,	EALiterals + 4
	.set MMBAltTextWidth,		EALiterals + 8

	@ Inputs:
	@ r0: pointer to proc state
	@ r1: pointer to unit in RAM

	push	{r4-r7, lr}

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

	mov		r6, r0

	@ get icon

	ldrb	r0, [r0, #0x1D]

	@ get tile index to draw to

	mov		r5, r4

	add		r4, #OAMCount
	ldrb	r2, [r4]
	add		r3, r2, #0x01
	strb	r3, [r4] @ increment icon count
	lsl		r2, r2, #0x01
	ldr		r1, =MMBInventoryTileIndex
	ldrh	r1, [r1]
	add		r1, r1, r2

	ldr		r2, =RegisterIconOBJ
	mov		lr, r2
	bllr

	mov		r4, r5

	@ Draw the item icon palette to oam palette 4

	ldr		r0, =0x085996F4
	mov		r1, #0x14
	lsl		r1, r1, #0x05
	mov		r2, #0x20
	ldr		r3, =CopyToPaletteBuffer
	mov		lr, r3
	bllr

	@ get item name

	mov		r0, r6
	ldrh	r0, [r0]

	ldr		r1, =TextBufferWriter
	mov		lr, r1
	bllr

	@ save pointer to text

	mov		r6, r0

	mov		r1, r0

	ldr		r0, MMBAltTextWidth @ multiplied by 8 in EA
	ldr		r2, =GetStringTextCenteredPos
	mov		lr, r2
	bllr

	mov		r7, r0

	@ write item name

	add		r4, #AltTextStructStart
	mov		r0, r4
	ldr		r1, =TextClear
	mov		lr, r1
	bllr

	@ we write the text info to the proc state

	mov		r0, r4
	mov		r1, r7
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

	pop		{r4-r7}
	pop		{r0}
	bx		r0

.ltorg

EALiterals:
	@ MMBInventoryTileIndex
	@ MMBTextAltColor
	@ MMBItemNamePosition
	@ MMBAltTextWidth
