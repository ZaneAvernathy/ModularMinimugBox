
.thumb

.include "../CommonDefinitions.inc"

MMBDEFGetter:

	.global	MMBDEFGetter
	.type	MMBDEFGetter, %function

	push	{r14}

	ldr		r3, =GetDef
	mov		r14, r3
	bllr

	pop		{r1}
	bx		r1

.ltorg
