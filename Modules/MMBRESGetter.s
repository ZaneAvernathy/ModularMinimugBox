
.thumb

.include "../CommonDefinitions.inc"

MMBRESGetter:

	.global	MMBRESGetter
	.type	MMBRESGetter, %function

	push	{r14}

	ldr		r3, =GetRes
	mov		r14, r3
	bllr

	pop		{r1}
	bx		r1

.ltorg
