;
; Main loop
;

init:
		bic.	#0001h, &PM5CTL0 ; Disable GPIO power-on default high-z mode
		bis.b   #01h,  &P1DIR    ; Set P1.0 as an output.  P1.0 is LED1
main:
		xor.b	#01h, &P1OUT	  ; Toggle p1.0 (LED1)
		mov.w	#0FFFFh, R4		  ; Put a big number into R4
delay:

		dec.w		R4				; Decrement R4
		jnz			delay			; Reapeat until R4 is 0
		jmp			main			; Reapeat main loop forever
		nop							; Should proceed a JMP instruction, optional