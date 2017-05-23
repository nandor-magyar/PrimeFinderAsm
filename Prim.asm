; Name: Nandor Magyar
; EHA: MANUABT.SZE
; Code: IB414g-11
;
; Application:  Prime number finder
;
; Spefication:
; ~~~~~~~~~~~~
; Find and print all the primes between 1 and 100 000.
;
;
; Usage:
; ~~~~~~
; Compile & Run (MASM, Irvince32 library required)
; Line 22: "n = 100000" is the upper limit  
; Line 23: "n = 316" is the isqrt(n)
; 
; Hint: Pipe output text into a file (with shell) to keep all the data.
;

Include Irvine32.inc
n=100000
n_limit=316
    ; The solution based on Sieve of Eratosthenes algorithm
	; n is the upper limit
	; n_limit is the iteration number: isqrt(n) - greatest, less or equal int square root

.data
primes BYTE n DUP(?)

.code
main PROC
    ; fill the array with "1"
	; all numbers flagged as prime initially
    ; from primes[2]
	mov   edi,OFFSET primes+2
    ; n-2 times
	mov   ecx,n-2
	; fill with value "1"
    mov   eax,1
    ; exec based on the parameters above
	; !processor efficient!
	rep stosb
	; the first 2 values skipped & filled manually - expection avoidance  
	; ah = 0; al = 1
    ; set primes[0] = 0, primes[1] = 0 - both handled as 'primes'
    mov   primes[0],0  
	mov	  primes[1],0
    mov   esi,eax
	; eax = 1 
sieve:
    inc   esi           ; next number to test
    cmp   esi,n_limit
	ja    sieve_end
		cmp   primes[esi],al ; al = 0
		jne   sieve    ; not prime
			; prime
			mov   edi,esi
			imul  edi,edi       ; next possible prime, multiplication of esi
flip:
    cmp   edi,n
		jae   sieve   ; edi < n => end flip
		mov   primes[edi],ah ; primes[edi] = 0, not prime anymore
		add   edi,esi       ; next multiplication
	jmp   flip

sieve_end:
    ; print valid primes starting from 2
    mov   esi,eax       ; esi = 1
print:
    inc   esi
    cmp   esi,n
	jae   end_print
		cmp   primes[esi],1
		jne   print   ; not prime, re-loop
		; prime, print to console
			mov   eax,esi
			call  WriteDec
			call  Crlf
		jmp   print

end_print:
    exit

main ENDP
END main
