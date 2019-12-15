;
;NAME: Emre KAYDU
;ID  : 150160552
;


;Allocate space from memory				
index      EQU      9					;Declare array size
                AREA     NEW_ARRAY,DATA, READWRITE	;Define this part will write in data area
				ALIGN	
__Array_Start
fib_array       SPACE    index					;Allocate space from memory 
__Array_End


;Our code
		AREA test_array, code, readonly				;Define this part will write as code
		ENTRY
		THUMB
		ALIGN 
__main	FUNCTION
		EXPORT __main
		LDR r0, =fib_array							;Store start address of the allocated space
		LDR r5, =__Array_End						;Store end address of the allocated space
		LDR r1, =index								;store index value
		PUSH {r0, r1}								;push starting array adres and index as parameter
		BL	fib										;go to fib functions
		
		
fib		POP {r0, r1}								;starting array in r6 and index in r7
		MOVS r2, #1									;counter
		MOVS r3, #2									;for less than 3
again	CMP r2, r1									;compare r2 < r7,yes enter loop, no go to stop
		BGE stop									;go to stop subrutune
		CMP r3, r2									;compare r2 < r3
		BGE	store1									;in index 1 and 2, store 1, go to store1 subrutine
		SUBS r2, r2,#1								;r2=r2-1
		LDRB r6, [r0, r2]							;temp r6 = fib_array[r2 -1]
		SUBS r2, r2,#1								;r2=r2-1
		LDRB r7, [r0, r2]							;temp r7 = fib_array[r2 -2]
		ADDS r6,r6,r7								;r6 = r6 +r7
		ADDS r2,r2,#2								;r2=r2+2
		STRB r6, [r0, r2]
		ADDS r2, r2, #1								;increment r2 counter
		BL	again									;go to again subrutine	
		;STRB r1, [r0]								;Store this value to allocated space

store1	MOVS r4, #1									;store 1 in r2 index
		STRB  r4, [r0, r2]							;store 1 to allocated space
		ADDS r2, r2, #1								;increment r2 1
		BL again									;go to again subrutine 
		
stop	B stop										;Infinite loop
		ENDFUNC
		END
			
